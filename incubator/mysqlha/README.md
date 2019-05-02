# MySQL - Single Master, Multiple Slaves

[MySQL](https://MySQL.org) is one of the most popular database servers in the world. Notable users include Wikipedia, Facebook and Google.

## Introduction

This chart bootstraps a single master and multiple slave MySQL deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager. Largely inspired by this [tutorial](https://kubernetes.io/docs/tutorials/stateful-application/run-replicated-stateful-application/), further work was made to 'production-ize' the example.

## Prerequisites

- Kubernetes 1.6+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release teracy-incubator/mysqlha
```

The command deploys MySQL cluster on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.


## Installing the Chart with MySQL 5.5

Create the `override.yaml` file with the following content:

```yaml
mysqlImage: mysql:5.5
xtraBackupImage: teracy/xtrabackup:2.3

mysqlha:
  mysqlRootPassword: teracy # change it
  mysqlReplicationPassword: secret # change it
  configFiles:
    slave.cnf: |
      # Apply this config only on slaves.
      [mysqld]
      # super-read-only # only available >= 5.7.8
      read-only # uncomment this when mysql < 5.7.8
      skip_name_resolve
```

And install the chart:

```bash
$ helm install --name my-release teracy-incubator/mysqlha -f override.yaml
```


### Uninstall

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

## Configuration

The following table lists the configurable parameters of the MySQL chart and their default values.

| Parameter                          | Description                         | Default                                |
| ---------------------------------- | ----------------------------------- | -------------------------------------- |
| `mysqlImage`                       | `mysql` image and tag.              | `mysql:5.7.13`                         |
| `xtraBackupImage`                  | `xtrabackup` image and tag.         | `gcr.io/google-samples/xtrabackup:1.0` |
| `imagePullPolicy`                  | the image pull policy               | `IfNotPresent`                         |
| `mysqlha.replicaCount`             | Number of MySQL replicas            | 3                                      |
| `mysqlha.mysqlRootPassword`        | Password for the `root` user.       | Randomly generated                     |
| `mysqlha.mysqlUser`                | Username of new user to create.     | `nil`                                  |
| `mysqlha.mysqlPassword`            | Password for the new user.          | Randomly generated                     |
| `mysqlha.mysqlReplicationUser`     | Username for replication user       | `repl`                                 |
| `mysqlha.mysqlReplicationPassword` | Password for replication user.      | Randomly generated                     |
| `mysqlha.mysqlDatabase`            | Name of the new Database to create  | `nil`                                  |
| `configFiles.master.cnf`           | Master configuration file           | See `values.yaml`                      |
| `configFiles.slave.cnf`            | Slave configuration file            | See `values.yaml`                      |
| `persistence.enabled`              | Create a volume to store data       | true                                   |
| `persistence.size`                 | Size of persistent volume claim     | 10Gi                                   |
| `persistence.storageClass`         | Type of persistent volume claim     | `nil`                                  |
| `persistence.accessModes`          | Persistent volume access modes      | `[ReadWriteOnce]`                      |
| `persistence.annotations`          | Persistent volume annotations       | `{}`                                   |
| `resources`                        | CPU/Memory resource requests/limits | Memory: `128Mi`, CPU: `100m`           |
| `extraVolumes`                     | Configure extra volumes             | See README                             |
| `restore`                          | Restore the backup data             | See README                             |
| `backup`                           | Create database backup              | See README                             |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

## Persistence

The [MySQL](https://hub.docker.com/_/mysql/) image stores the MySQL data and configurations at the `/var/lib/mysql` path of the container.

By default persistence is enabled, and a PersistentVolumeClaim is created and mounted in that directory. As a result, a persistent volume will need to be defined:

```
# https://kubernetes.io/docs/user-guide/persistent-volumes/#azure-disk
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: fast
provisioner: kubernetes.io/azure-disk
parameters:
  skuName: Premium_LRS
  location: westus
```

In order to disable this functionality you can change the values.yaml to disable persistence and use an emptyDir instead.


## How to back up

- We need to run the backup process on a new created pod by configuring and scaling the statefulset.

- Create the `pvc.yaml` file to define a PVC specification as follows:

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: xtrabackup
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 4Gi
```

- Run it:

```bash
$ kubectl apply -f pvc.yaml
```

- Create the `backup.yaml` file with the following similar content:

```yaml
# need to fill in the passwords here
# kubectl get secret --namespace default my-release-mysqlha -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo
# kubectl get secret --namespace default my-release-mysqlha -o jsonpath="{.data.mysql-replication-password}" | base64 --decode; echo
mysqlha:
  mysqlRootPassword: NlPWmSWQnXMm
  mysqlReplicationPassword: tIayPORjn3tT

extraVolumes: # your choice
  - name: xtrabackup
    persistentVolumeClaim:
      claimName: xtrabackup

backup:
  enabled: true
  extraVolumeMounts:
    - name: xtrabackup
      mountPath: /xtrabackup_backupfiles
```

- The example configuration above will use `xtrabackup` to back up the data into the specified
  persistent volume.

- Run it:

```bash
$ helm upgrade --install my-release -f backup.yaml --set=mysqlha.replicaCount=4 teracy-incubator/mysqlha
```

Note: We need to increase the current replicaCount by 1 so that we can create the backup pod.

- You should see the following output:

```bash
$ kubectl get pods
NAME                   READY   STATUS    RESTARTS   AGE
my-release-mysqlha-0   2/2     Running   0          4m
my-release-mysqlha-1   2/2     Running   0          4m
my-release-mysqlha-2   2/2     Running   0          4m
my-release-mysqlha-3   3/3     Running   0          42s

$ kubectl logs -f my-release-mysqlha-3 -c backup-mysql
+ rm -rf '/xtrabackup_backupfiles/*'
+ xtrabackup --backup --compress --host=127.0.0.1 --user=repl --password=tIayPORjn3tT
xtrabackup: recognized server arguments: --datadir=/var/lib/mysql --tmpdir=/tmp 
xtrabackup: recognized client arguments: --datadir=/var/lib/mysql --tmpdir=/tmp --port=3306 --socket=/var/run/mysqld/mysqld.sock --backup=1 --compress --host=127.0.0.1 --user=repl --password=* 
encryption: using gcrypt 1.6.3
190425 12:12:50  version_check Connecting to MySQL server with DSN 'dbi:mysql:;mysql_read_default_group=xtrabackup;host=127.0.0.1;port=3306;mysql_socket=/var/run/mysqld/mysqld.sock' as 'repl'  (using password: YES).
190425 12:12:50  version_check Connected to MySQL server
190425 12:12:50  version_check Executing a version check against the server...

# A software update is available:
190425 12:12:52  version_check Done.
190425 12:12:52 Connecting to MySQL server host: 127.0.0.1, user: repl, password: set, port: 3306, socket: /var/run/mysqld/mysqld.sock
Using server version 5.7.13
xtrabackup version 2.4.13 based on MySQL server 5.7.19 Linux (x86_64) (revision id: 3e7ca7c)
...
190425 12:12:56 Executing UNLOCK TABLES
190425 12:12:56 All tables unlocked
190425 12:12:56 [00] Compressing ib_buffer_pool to /xtrabackup_backupfiles/ib_buffer_pool.qp
190425 12:12:56 [00]        ...done
190425 12:12:56 Backup created in directory '/xtrabackup_backupfiles/'
190425 12:12:56 [00] Compressing /xtrabackup_backupfiles/backup-my.cnf.qp
190425 12:12:56 [00]        ...done
190425 12:12:56 [00] Compressing /xtrabackup_backupfiles/xtrabackup_info.qp
190425 12:12:56 [00]        ...done
xtrabackup: Transaction log of lsn (12132411) to (12132420) was copied.
190425 12:12:57 completed OK!
+ tail -f /dev/null
```

- Remove the backup pod:

```
$ helm upgrade --install my-release -f backup.yaml --set=mysqlha.replicaCount=3  --set=extraVolumes="" teracy-incubator/mysqlha
```


## How to restore

- Delete the existing db cluster:

```
$ helm delete my-release --purge
```

- Make sure to have the backup persistent volume created from the backup section above.

- Create the `restore.yaml` file with the following similar content:

```yaml
# need to fill in the passwords here
mysqlha:
  mysqlRootPassword: NlPWmSWQnXMm
  mysqlReplicationPassword: tIayPORjn3tT

extraVolumes: # your choice
  - name: xtrabackup
    persistentVolumeClaim:
      claimName: xtrabackup

restore:
  enabled: true
  extraVolumeMounts:
    - name: xtrabackup
      mountPath: /xtrabackup_backupfiles
```

- The example configuration above will use `xtrabackup` to restore the data.

- Run it:

```bash
$ helm upgrade --install my-release -f restore.yaml --set=mysqlha.replicaCount=1 teracy-incubator/mysqlha
```

- Check the restore logs with:

```bash
$ kubectl logs -f my-release-mysqlha-0 restore-mysql
```

- Clean up the `extraVolumes` from the restoring step above:

```bash
$ helm upgrade --install my-release -f restore.yaml --set=mysqlha.replicaCount=1 --set=restore.enabled=false --set=extraVolumes="" teracy-incubator/mysqlha
$ kubectl delete pod my-release-mysqlha-0
```

- Add slaves:

```bash
$ helm upgrade --install my-release -f restore.yaml --set=mysqlha.replicaCount=3 --set=restore.enabled=false --set=extraVolumes="" teracy-incubator/mysqlha
```

## How to sync the persistent volume to/from the remote storage

- To sync the PV or PVC, use the `duplicity` helm chart: https://github.com/teracyhq/helm-charts/tree/master/incubator/duplicity
