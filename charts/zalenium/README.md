# Introduction

This chart bootstraps a zalenium deployment on a kubernetes cluster using the [Helm](https://helm.sh) package manager.

# Prerequisites

- `vagrant` https://www.vagrantup.com/docs/installation/.
- `virtualbox` https://www.virtualbox.org/wiki/Downloads.
- `teracy-dev` v0.6.0-a4+. Fork repo https://github.com/teracyhq/dev and its extensions in https://github.com/teracyhq-incubator to set up `teracy-dev`.
- `helm` v2.10.0+. Default installed in teracy-dev.
- Follow the docs on https://github.com/teracyhq-incubator/teracy-dev-entry-k8s to set up a local k8s cluster.

# How to get it works

## Setup `zalenium` from the scratch

- Installing the chart

To install the chart with the release name `example-name`:

```console
$ helm install --name example-name teracy-incubator/zalenium
```

The command deploys Zalenium on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

- Uninstalling the chart

To uninstall/delete the `example-name` deployment:

```console
$ helm delete example-name --purge
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

- Configuration

The following tables lists the configurable parameters of the Selenium chart and their default values.

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `rbac.create` | If your cluster has RBAC enabled, set rbac.create to true | false |
| `rbac.clusterWideAccess` | Set true to use ClusterRole and ClusterRoleBinding instead of Role and RoleBinding | true |
| `serviceAccount.create` | Set serviceAccount.create to true if you want to create an service account for zalenium | true |
| `serviceAccount.name` | Set serviceAccount.name | zalenium |
| `hub.image.repository` | The zalenium hub image | `dosel/zalenium` |
| `hub.image.tag` | The zalenium hub image tag | `3` |
| `hub.image.pullPolicy` | The pull policy for the hub image | `IfNotPresent` |
| `hub.port` | The port the hub listens on | `4444` |
| `hub.livenessProbe.enabled` | Set hub.livenessProbe.enabled to true if you want to use livenessProbe | true |
| `hub.readinessProbe.enabled` | Set hub.readinessProbe.enabled to true if you want to use readinessProbe | true |
| `hub.javaOpts` | The java options for the selenium hub JVM, default sets the maximum heap size to 400 mb | `-Xmx400m -XX:+UseSerialGC` |
| `hub.localVolumesRoot` | The root directory to store HostPath volumes (e.g. if running in minikube) | `/tmp` |
| `hub.resources` | The resources for the hub container, defaults to minimum half a cpu and maximum 512 mb RAM | `{"limits":{"cpu":".5", "memory":"512Mi"}}` |
| `hub.desiredContainers` | How many pods to launch at start | 2 |
| `hub.maxDockerSeleniumContainers` | Maximum number of Selenium containers to run simultaneously | 10 |
| `hub.sauceLabsEnabled` | Enable SauceLabs | false |
| `hub.browserStackEnabled` | Enable BrowserStack | false |
| `hub.testingBotEnabled` | Enable TestingBot | false |
| `hub.videoRecordingEnabled` | Enable video recording | true |
| `hub.cpuRequest` | CPU requested for browser pods.  The hub passes this value to the k8s API | 200m |
| `hub.cpuLimit` | CPU limit for browser pods.  The hub passes this value to the k8s API | 400m |
| `hub.memRequest` | Memory requested for browser pods.  The hub passes this value to the k8s API | 200Mi |
| `hub.screenWidth` | Screen resolution to use | 1440 |
| `hub.screenHeight` | Screen resolution to use | 900 |
| `hub.timeZone` | Time zone | UTC |
| `hub.seleniumImageName` | The Selenium grid image | `elgalu/selenium` |
| `hub.maxTestSessions` | The number of tests to run on each grid container before killing it and starting a new one | 1 |
| `hub.debugEnabled` | 	Enables LogLevel.FINE | false |
| `hub.keepOnlyFailedTests` | Keeps only failed tests on the dashboard (you need to send a cookie with the test result) | false |
| `hub.sendAnonymousUsageInfo` | Allows sending anonymous usage info | true |
| `hub.sauceUserName` | Username to log into saucelabs. Use if hub.sauceLabsEnabled set to true | blank |
| `hub.sauceAccessKey` | Access key to log into saucelabs. Use if hub.sauceLabsEnabled set to true | blank |
| `hub.browserStackUser` | Credentials for browserstack. Use if hub.browserStackEnabled set to true | blank |
| `hub.browserStackKey` | Credentials for browserstack. Use if hub.browserStackEnabled set to true | blank |
| `hub.testingBotKey` | Credentials for testingbot. Use if hub.testingBotEnabled set to true | blank |
| `hub.testingBotSecret` | Credentials for testingbot. Use if hub.testingBotEnabled set to true | blank |
| `ingress.enabled` | Set ingress.enabled to true if you want to create an ingress entry for zalenium | false |
| `ingress.hostname` | Set ingress.hostname to which host you want | `#` |
| `services.type` | Set services.type | `ClusterIP` |
| `mountStorage.videos.enabled` | Whether to use a videos mount volume. Set mountStorage.videos.enabled to true | true |
| `mountStorage.data.enabled` | Whether to use a data mount volume. Set mountStorage.data.enabled to true | true |
| `mountStorage.videos.pvcs.enabled` | Whether to use a persistent volume claim for storage. Set mountStorage.videos.pvcs.enabled to true | false |
| `mountStorage.data.pvcs.enabled` | Whether to use a persistent volume claim for storage. Set mountStorage.data.pvcs.enabled to true | false |

Specify each parameter using the `--set key0=value0,key1=value1,key..n=value..n` argument to `helm install`. For example,

```console
$ helm install --name example-name \
  --set rbac.create=false \
    teracy-incubator/zelenium
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

## How to run

- Live Preview

Displaying the live preview.

Go to http://k8s.local:4444/grid/admin/live.

> **Tip**: You can replace k8s.local for the IP/machine name where Zalenium is running.

Auto-refresh, add ?refresh=numberOfSeconds to refresh the view automatically.

E.g. http://k8s.local:4444/grid/admin/live?refresh=20 will refresh the page every 20 seconds.

- Dashboard

Go to http://k8s.local:4444/grid/dashboard.

> **Tip**: You can replace k8s.local for the IP/machine name where Zalenium is running.

Check all the recorded videos and aggregated logs after your tests completed.

Click on Cleanup to remove all videos and logs from the local drive and the dashboard.

> **Tip**: Also reset the dashboard via http://k8s.local:4444/dashboard/cleanup?action=doReset or cleanup via http://k8s.local:4444/dashboard/cleanup?action=doCleanup.
