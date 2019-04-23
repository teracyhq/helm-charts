# duplicity

Helm chart for backing up/ restoring with duplicity.

## Installation

Follow https://github.com/teracyhq/helm-charts#how-do-i-enable-the-incubator-repository


## How to restore

- Create a configuration file (`bak-rst.yaml`) similar to the following example:

```yaml
configMap:
  GS_PROJECT_ID: teracy
  TARGET_URL: gs://ds-teracy/develop/
  OPERATION: restore
  INCLUDE_OPTS: >-
    --include=/xtrabackup_backupfiles
    --include=/mnt/storage

secret:
  PASSPHRASE: secret
  GS_ACCESS_KEY_ID: GOOG67MUCQFGITRPAAA
  GS_SECRET_ACCESS_KEY: Ts2eJTFCSkbfntVL8Z/0aDlHocedlfTSNre3udh

volumeMounts:
  - name: xtrabackup
    mountPath: /xtrabackup_backupfiles
  - name: storage
    mountPath: /mnt/storage/

volumes:
  - name: xtrabackup
    persistentVolumeClaim:
      claimName: xtrabackup
      existing: false
  - name: storage
    persistentVolumeClaim:
      claimName: storage
      existing: false

pvcs:
  xtrabackup:
    enabled: true
    accessModes:
      - ReadWriteOnce
    size: 4Gi
  storage:
    enabled: true
    accessModes:
      - ReadWriteOnce
    size: 4Gi
```

- In the example above, we're going to create 2 PVCs dynamically and restore the backup to these PVCS.

- Run the following command to restore the backup with the duplicity chart from the repo:

```bash
$ helm upgrade --install teracy-bak-rst -f bak-rst.yaml --namespace=teracy teracy-incubator/duplicity
```

- Or run the following command to restore the backup with the local duplicity chart:

```bash
$ helm upgrade --install teracy-bak-rst -f bak-rst.yaml --namespace=teracy duplicity/
```

## How to back up

We defined the configuration for both backing up and restoring within the `bak-rst.yaml` above.

- Run the following command to back up the data from the defined PVCs to the defined remote storage:

```bash
$ helm upgrade --install teracy-bak-rst -f bak-rst.yaml --set configMap.OPERATION=backup --namespace=teracy teracy-incubator/duplicity
```

- Or run the following command to back up the data with the local duplicity chart:

```bash
$ helm upgrade --install teracy-bak-rst -f bak-rst.yaml --set configMap.OPERATION=backup --namespace=teracy duplicity/
```


## Configuration

The following table lists the configurable parameters of the duplicity chart and their default values.

| Parameter                    | Description                         | Default                                |
| ---------------------------- | ----------------------------------- | -------------------------------------- |
| `repository`                 | image repository                    | `teracy/duplicity`                     |
| `tag`                        | image tag                           | `latest`                               |
| `pullPolicy`                 | image pull policy                   | `IfNotPresent`                         |
| `nameOverride`               | override the chart's name           | `""`                                   |
| `fullnameOverride`           | override the chart's fullname       | `""`                                   |
| `configMap`                  | define the env vars via configmap   | See below                              |
| `configMap.GS_PROJECT_ID`    | google storage project id           | `""`                                   |
| `configMap.TARGET_URL`       | duplicity remote url                | `""`                                   |
| `configMap.TIME`             | duplicity restore time              | `now`                                  |
| `configMap.OPTS`             | duplicity more options if any       | `""`                                   |
| `configMap.INCLUDE_OPTS`     | duplicity include options for backup| `""`                                   |
| `configMap.ACTION`           | duplicity action for backup         | `full`                                 |
| `configMap.OPERATION`        | define the backup or restore        | `""`                                   |
| `secret`                     | define the env vars via secret      | See below                              |
| `secret.PASSPHRASE`          | duplicity pass phrase               | `""`                                   |
| `secret.GS_ACCESS_KEY_ID`    | google storage access key id        | `""`                                   |
| `secret.GS_SECRET_ACCESS_KEY`| google storage secret access key id | `""`                                   |
| `volumeMounts`               | volume mounts for the job           | `""`                                   |
| `volumes`                    | volumes for the job                 | `""`                                   |
| `pvcs`                       | define PVCs to be created           | `""`                                   |
| `resources`                  | define the job's resources          | `""`                                   |
| `nodeSelector`               | define the job's nodeSelector       | `""`                                   |
| `affinity`                   | define the job's affinity           | `""`                                   |
| `tolerations`                | define the job's tolerations        | `""`                                   |
| `imagePullSecrets`           | define the job's imagePullSecrets   | `""`                                   |


## Remote backend support

- Google storage bucket is supported
- Other remote backends can work, however, they're not tested yet
