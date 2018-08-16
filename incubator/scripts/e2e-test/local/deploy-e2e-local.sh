#!/bin/bash

set -e

helm version

ws

envsubst <$E2E_HELM_CHART_PATH/override.tpl.yaml >$E2E_HELM_CHART_PATH/override.yaml

echo "helm upgrade --install $E2E_RELEASE_NAME $E2E_HELM_CHART_PATH -f $E2E_HELM_CHART_PATH/values.yaml -f $E2E_HELM_CHART_PATH/override.yaml --namespace=$E2E_K8S_NAMESPACE --wait --timeout=1000"

# helm upgrade --install $E2E_RELEASE_NAME $E2E_HELM_CHART_PATH -f $E2E_HELM_CHART_PATH/values.yaml -f $E2E_HELM_CHART_PATH/override.yaml --dry-run --debug --namespace=$E2E_K8S_NAMESPACE

helm upgrade --install $E2E_RELEASE_NAME $E2E_HELM_CHART_PATH -f $E2E_HELM_CHART_PATH/values.yaml -f $E2E_HELM_CHART_PATH/override.yaml --namespace=$E2E_K8S_NAMESPACE --wait --timeout=1000
