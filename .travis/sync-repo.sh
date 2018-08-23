#!/usr/bin/env bash

# Copyright 2018 The Kubernetes Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

main() {
    authenticate

    if ! sync_repo stable "$GCS_BUCKET_STABLE" "$STABLE_REPO_URL"; then
        log_error "Not all stable charts could be packaged and synced!"
    fi
    if ! sync_repo incubator "$GCS_BUCKET_INCUBATOR" "$INCUBATOR_REPO_URL"; then
        log_error "Not all incubator charts could be packaged and synced!"
    fi
}

authenticate() {
    echo "Authenticating with Google Cloud..."
    #gcloud auth activate-service-account --key-file <(base64 --decode <<< "$SYNC_CREDS")
    gcloud auth activate-service-account --key-file credential.json
}

sync_repo() {
    local repo_dir="${1?Specify repo dir}"
    local bucket="${2?Specify repo bucket}"
    local repo_url="${3?Specify repo url}"
    local sync_dir="${repo_dir}-sync"
    local index_dir="${repo_dir}-index"

    echo "Syncing repo '$repo_dir'..."

    mkdir -p "$sync_dir"
    mkdir -p "$index_dir"
    # echo "$ALLOW_OVERWRITE_INDEX_FILE"
    if ([ ! `gsutil cp "$bucket/index.yaml" "$index_dir/index.yaml"` ]) && ([ ! $ALLOW_OVERWRITE_INDEX_FILE ]); then
        log_error "Exiting because unable to copy index locally. Not safe to proceed."
        exit 1
    fi

    local exit_code=0

    for dir in `find ${repo_dir}/ -mindepth 1 -maxdepth 1 -type d`; do
        if helm dependency build "$dir"; then
            helm package --destination "$sync_dir" "$dir"
        else
            log_error "Problem building dependencies. Skipping packaging of '$dir'."
            exit_code=1
        fi
    done

    if helm repo index --url "$repo_url" --merge "$index_dir/index.yaml" "$sync_dir"; then
        # Move updated index.yaml to sync folder so we don't push the old one again
        mv -f "$sync_dir/index.yaml" "$index_dir/index.yaml"

        gsutil -m rsync "$sync_dir" "$bucket"

        # Make sure index.yaml is synced last
        gsutil cp "$index_dir/index.yaml" "$bucket"
    else
        log_error "Exiting because unable to update index. Not safe to push update."
        exit 1
    fi

    ls -l "$sync_dir"

    return "$exit_code"
}

log_error() {
    printf '\e[31mERROR: %s\n\e[39m' "$1" >&2
}

main
