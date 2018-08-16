#!/bin/bash

set -e

helm version

ws

envsubst <$ZALENIUM_HELM_CHART_PATH/override-gke.tpl.yaml >$ZALENIUM_HELM_CHART_PATH/override-gke.yaml

echo "helm upgrade --install $ZALENIUM_RELEASE_NAME $ZALENIUM_HELM_CHART_PATH -f $ZALENIUM_HELM_CHART_PATH/values.yaml -f $ZALENIUM_HELM_CHART_PATH/override-gke.yaml --namespace=$ZALENIUM_K8S_NAMESPACE --wait --timeout=1000"

# helm upgrade --install $ZALENIUM_RELEASE_NAME $ZALENIUM_HELM_CHART_PATH -f $ZALENIUM_HELM_CHART_PATH/values.yaml -f $ZALENIUM_HELM_CHART_PATH/override-gke.yaml --dry-run --debug --namespace=$ZALENIUM_K8S_NAMESPACE

helm upgrade --install $ZALENIUM_RELEASE_NAME $ZALENIUM_HELM_CHART_PATH -f $ZALENIUM_HELM_CHART_PATH/values.yaml -f $ZALENIUM_HELM_CHART_PATH/override-gke.yaml --namespace=$ZALENIUM_K8S_NAMESPACE --wait --timeout=2000
