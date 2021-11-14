# pv-join Helm Chart


## Introduction

This `pv-join` helm chart can be used to attach any number of persistent volumes to do tasks such as
inspecting, manipulating the data, etc.


## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release teracy-incubator/pv-join
```

The command deploys a pod on the Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.


### Uninstall

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

## Configuration

The following table lists the configurable parameters of the MySQL chart and their default values.

| Parameter                          | Description                         | Default                                |
| ---------------------------------- | ----------------------------------- | -------------------------------------- |
| `replicaCount`                     | Number of replica                   | 1                                      |
| `image.repository`                 | Image repository                    | busybox                                |
| `image.tag`                        | Image tag                           | latest                                 |
| `image.pullPolicy`                 | Image pull policy                   | IfNotPresent                           |
| `nameOverride`                     | Helm chart name override            | Empty                                  |
| `fullnameOverride`                 | Helm chart fullname override        | Empty                                  |
| `command`                          | Command to run the image            | See values.yaml                        |
| `volumeMounts`                     | volumeMounts specification          | Empty                                  |
| `volumes`                          | volumes specificiation              | Empty                                  |
| `resources`                        | resources specification             | Empty                                  |
| `nodeSelector`                     | nodeSelector specification          | Empty                                  |
| `tolerations`                      | tolerations specification           | Empty                                  |
| `affinity`                         | affinity specification              | Empty                                  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

## Example

- We're going to attach a PVC named "storage" to inspect it.

- First, create the file name `override.yaml` with the following content:

```yaml
volumeMounts:
  - name: storage
    mountPath: /mnt/storage/

volumes:
  - name: storage
    persistentVolumeClaim:
      claimName: storage
```

- Install it:

```bash
$ helm install --name my-release -f override.yaml teracy-incubator/pv-join
```

And now we can exec into the created container to inspect the data within the `/mnt/storage/` path.

