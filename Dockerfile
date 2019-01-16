FROM maven:3-alpine

COPY pom.xml pipeline/

COPY src/ pipeline/src/

WORKDIR pipeline/

RUN mvn clean install

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

EXPOSE 8090

ENTRYPOINT [ "java", "-jar", "/pipeline/target/jenkins-pipeline.jar"]
