# Teracy's Helm Charts

Teracy's helm charts to deploy applications to Kubernetes using Helm.

## How to use

```bash
$ helm repo add teracy https://charts.teracy.com
$ helm install teracy/<chart-name>
```


## How to develop


### Fork this repo

- With the name `teracy-helm-charts`

- Clone your forked repo:

  ```bash
  $ cd ~/teracy-dev/workspace
  $ git clone git@github.com:<your_github_account>/teracy-helm-charts.git
  $ cd teracy-helm-charts
  $ git remote add upstream git@github.com:teracyhq/helm-charts.git # to track and sync with the upstream repo
  ````


### gh-pages deployment

- Create a branch called `gh-pages` to store the `index.yaml` file of published charts:

```bash
$ git switch --orphan gh-pages
$ git commit --allow-empty -m "initial setup"
$ git push origin gh-pages
```

- Make sure `gh-pages` works by checking your github repo's page settings


- Make sure github actions is enabled for your repository

- You should see the generated `index.yaml` file at:
https://<your_github_account>.github.io/teracy-helm-charts/index.yaml


### Update helm charts

- When any changes are made and pushed to the `main` branch, we need to update the chart's version and
it will be released and updated to the helm chart repository.

- We follow the semantic versioning, starting from `0.1.0-alpha.1` to `0.1.0-beta.x`, `0.1.0-rc.x` and
`0.1.0` and then to finally to reach `1.0.0` as the first production version.

- Whenever a helm chart reaches a major version release, create a new chart named
`chart-name-v<major_version>`, for example: `example-v1`, `example-v2`, etc to keep charts easily
updated.


## Contributing a Chart

We'd love for you to contribute a Chart that provides a useful application or service for Kubernetes and TeracyHQ. 

Please read our [Workflow Guide](http://dev.teracy.org/docs/workflow.html) for more information on how you can contribute Charts.

Note: [License](LICENSE)
