#!/usr/bin/env bash

export E2E_K8S_NAMESPACE=hieptq
export E2E_HELM_REVISION=1
export E2E_HELM_CHART_PATH=Test-Helm-Chart/e2e-test
export E2E_RELEASE_NAME=teracy-e2e

export E2E_APP_NAME=teracy-e2e

export E2E_IMAGE_REPOSITORY=hieptranquoc/teracy-e2e
export E2E_IMAGE_TAG=maven-3.5.4-jdk8

export E2E_RESOLVE_DEPENDENCY=true
export E2E_MAVEN_DEBUB=true
# env
export E2E_ENV_HUB_STATUS_URL=http://<set-your-domain>/wd/hub/status
export E2E_ENV_TEST_PATH=/opt/app
# args
export E2E_ARG_TEST_PHASE=TestRunner*
export E2E_ARG_HUB_URL=http://<set-your-domain>/wd/hub
export E2E_ARG_BASE_URL=http://<set-your-project-url>
export E2E_ARG_PLATFORM=linux
export E2E_ARG_BROWSER=chrome
export E2E_ARG_THREAD_NUMBER=2
export E2E_ARG_FAIL_IF_NO_TEST=false
export E2E_FAIL_FAST=true
