# Helm Charts

Use this repository to submit official Helm Charts for Teracy Helm Chart's repo.

## How do I install these charts?

Just do the following:
```
$ helm repo add teracyhq https://teracyhq.storage.googleapis.com/
$ helm install teracyhq/<chart-name>
```

For more information on using Helm, refer to the [Helm's documentation](https://github.com/kubernetes/helm#docs).

## How do I enable the Incubator repository?


Just do the following:
```
$ helm repo add teracyhq-incubator https://teracyhq-incubator.storage.googleapis.com/
$ helm install teracyhq-incubator/<chart-name>
```

## Chart Format

Take a look at the [Example chart](https://docs.helm.sh/developing_charts/#charts) for reference when you're writing your first few charts.

Before contributing a Chart, become familiar with the format. Note that the project is still under active development and the format may still evolve a bit.

## Repository Structure

The Charts in the `stable/` directory in the master branch of this repository match the latest packaged Chart in the Chart Repository of Teracy Helm Chart, though there may be previous versions of a Chart available in that Chart Repository.

The purpose of this repository is to provide a place for maintaining and contributing official Charts of TeracyHQ.

The Charts in this repository are organized into two folders:

* stable
* incubator

Stable Charts meet the criteria in the [technical requirements](https://github.com/helm/charts/blob/master/CONTRIBUTING.md#technical-requirements).

Incubator Charts are those that do not meet these criteria. Having the incubator folder allows charts to be shared and improved on until they are ready to be moved into the stable folder.

In order to get a Chart from incubator to stable, Chart maintainers should open a pull request that moves the chart folder.

## Contributing a Chart

We'd love for you to contribute a Chart that provides a useful application or service for Kubernetes and TeracyHQ. 

Please read our [Workflow Guide](http://dev.teracy.org/docs/workflow.html) for more information on how you can contribute Charts.

Note: [License](LICENSE)

## Owning and Maintaining A Chart

Individual charts can be maintained by one or more members of the TeracyHQ. 

## Review Process

For information related to the review procedure used by the Chart repository maintainers, see [Merge approval and release process](http://dev.teracy.org/docs/workflow.html#official-repository-s-merging-and-releasing).


### Stale Pull Requests and Issues

Pull Requests and Issues that have no activity for 30 days automatically become stale. After 30 days of being stale, without activity, they become rotten. Pull Requests and Issues can rot for 30 days and then they are automatically closed. This is the standard stale process handling for all repositories on the Kubernetes GitHub organization.

## Supported Kubernetes Versions

This chart repository supports the latest and previous minor versions of Kubernetes.

## Status of the Project

This project is still under active development, so you might run into [issues](https://github.com/teracyhq/helm-charts/issues). If you do, please don't be shy about letting us know, or better yet, contribute a fix or feature.
