# Introduction

This chart bootstraps a zalenium deployment on a kubernetes cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Fork repo https://github.com/teracyhq/dev and its extensions in https://github.com/teracyhq-incubator to set up `teracy-dev`.
- `helm` and `kubectl` must be installed.
- Follow the docs on https://github.com/teracyhq-incubator/teracy-dev-entry-k8s to set up a local k8s cluster.

## Install

- Install `zalenium` repo:

```bash
$ helm repo add zalenium https://raw.githubusercontent.com/zalando/zalenium/master/charts/zalenium
```

- Install `zalenium` chart:

```bash
$ helm install --name zalenium --namespace hieptq zalenium/zalenium --tiller-namespace=hieptq
```

## Uninstall

- To uninstall/delete the `zalenium` deployment:

```bash
$ helm delete zalenium --tiller-namespace=hieptq --namepace=hieptq
```

- To remove the release name from the Helm store (so you may use it again), issue the following command:

```bash
$ helm delete zalenium --purge --tiller-namespace=hieptq --namespace=hieptq
```

## Configuration

See more at https://github.com/zalando/zalenium/tree/master/charts/zalenium#configuration

## How to run

See more at https://opensource.zalando.com/zalenium/#usage
