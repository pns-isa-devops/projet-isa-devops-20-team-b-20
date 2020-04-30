FROM maven:3.3-jdk-8-alpine
LABEL authors="Team B"

COPY . /usr/src/maven

VOLUME /host

WORKDIR /usr/src/maven

ENTRYPOINT mvn -s settings.xml integration-test -Dcucumber.options=src/test/resources/features/$TEST_NAME.feature
