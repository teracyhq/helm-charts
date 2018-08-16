This build use /usr/share/maven/ref/repository is a local repo.
Because:

The $MAVEN_CONFIG dir (default to /root/.m2) could be configured as a volume so anything copied there in a Dockerfile at build time is lost. For that reason the dir /usr/share/maven/ref/ exists.

use in hub : hieptranquoc/teracy-e2e:maven-3.5.4-jdk8