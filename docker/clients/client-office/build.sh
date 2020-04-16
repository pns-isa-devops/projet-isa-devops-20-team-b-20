#!/bin/bash

#Preparing environment
cd ../../../projet-isa-devops-20-team-b-20-client/projet-isa-devops-20-team-b-20-client-office
echo "Compiling the DD client office system"
mvn -q -DskipTests clean package assembly:single
echo "Done"
cp ./target/client-office-1.0-jar-with-dependencies.jar ../../docker/clients/client-office/.

# building the docker image
cd ../../docker/clients/client-office/
docker build -t dd-client-office .

# cleaning up the environment
rm -rf client-office-1.0-jar-with-dependencies.jar