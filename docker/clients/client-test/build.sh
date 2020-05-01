#!/bin/bash

cd ../../../projet-isa-devops-20-team-b-20-client/integration-tests
echo "Compiling the DD client test"

mvn clean

cp -r src ../../docker/clients/client-test/.
cp pom.xml ../../docker/clients/client-test/.
cp C:/Users/haenl/.m2/settings.xml ../../docker/clients/client-test/.

cd ../../docker/clients/client-test/

docker build -t isa-devops/integration-tests .

rm -rf src
rm -f pom.xml
rm -f settings.xml
