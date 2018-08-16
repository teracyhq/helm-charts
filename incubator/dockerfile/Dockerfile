FROM openjdk:8-jdk

LABEL authors="hieptq < hieptq8888@gmail.com >"


ARG HUB_STATUS_URL
ARG DIRPATH=/opt/app

ARG MAVEN_VERSION=3.5.4
ARG SHA=ce50b1c91364cb77efe3776f756a6d92b76d9038b0a0782f7d53acf1e997a14d
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

ENV HUB_STATUS_URL=$HUB_STATUS_URL


RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

COPY pom.xml /pom.xml
COPY wait-for-mount.sh /wait-for-mount.sh
COPY settings-docker.xml ${MAVEN_HOME}/ref/

RUN chmod +x /wait-for-mount.sh

RUN mvn -B -f /pom.xml -s ${MAVEN_HOME}/ref/settings-docker.xml dependency:resolve
RUN mvn -f /pom.xml -s ${MAVEN_HOME}/ref/settings-docker.xml verify

RUN apt-get update && \
	apt-get install -y inotify-tools


RUN mkdir -p ${DIRPATH}
RUN chmod 755 ${DIRPATH}

WORKDIR ${DIRPATH}

CMD ["/wait-for-mount.sh"]
