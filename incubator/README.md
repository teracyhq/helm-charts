TEST-HELM-CHART
===========================

ZALENIUM & E2E HELM CHART FOR TEST !!!


ZALENIUM
---------------

Getting Started

- Go to project
```bash
$ ws
$ cd Test-Helm-Chart # Or your path
```

- Set your env in `. /scripts/zalenium/local/..` file or `. /scripts/zalenium/gke/..` file.

- Run `. /scripts/zalenium/local/export-zalenium-env-local.sh ` or `. /scripts/zalenium/gke/export-zalenium-env-gke.sh`

- Run `deploy-zalenium-local.sh` file or `deploy-zalenium-gke.sh` file.

```bash
$ . /scripts/zalenium/local/deploy-zalenium-local.sh
```

Or

```bash
$ . /scripts/zalenium/local/deploy-zalenium-gke.sh
```

* Should use with gke because it tested many many times.


E2E-TEST
---------------

Getting Started

- Set your env in `. /scripts/e2e-test/local/..` file or `. /scripts/e2e-test/gke/..` file.

- Run `deploy-e2e-local.sh` or `deploy-e2e-gke.sh`.

* Should use with gke because it tested many many times.

RUN E2E-TEST WITH YOUR SCRIPTS TEST
---------------------------------------------

Coppy source test and scripts test to kubernetes container to run e2e (must have POM file)

You can choose 2 ways below:

- Use `kubectl cp` command:

```bash
$ kubectl cp <coppy path> <namespace/podname:target-path -c container-name>
```

Example:

```bash
$ kubectl cp $(pwd) hieptq/teracy-e2e-abs123123wfasdg234:/opt -c teracy-e2e
```

OR

- Use ksync https://github.com/vapor-ware/ksync:

  Install and init ksync by following https://github.com/vapor-ware/ksync#getting-started.


  ```bash
  $ ksync watch &
  $ ksync create --name <some-ksync-name> --selector=app=<app-label-name> --container=<container-label-name> --namespace=<namespace-name> --local-read-only --reload=false <path-local> <path-target>
  ```

  Example:

  ```bash
  $ ksync watch &
  $ ksync create --name teracy-e2e --selector=app=teracy-e2e --container=teracy-e2e --namespace=hieptq --local-read-only --reload=false $(pwd) /opt/app
  ```

  Trouble:

  - After test, you must run ksync again. Delete ksync has created.
  - If has problem about listening port, you can kill port, which another in use.



NOTE
--------

- If deploy is failed, run: `helm delete <chart-release-name> --purge.
- Should use `kubectl cp` command to coppy source to kubernetes container.
