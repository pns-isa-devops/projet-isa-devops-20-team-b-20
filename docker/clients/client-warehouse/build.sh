#!/bin/bash

#Preparing environment
cd ../../../projet-isa-devops-20-team-b-20-client/projet-isa-devops-20-team-b-20-client-warehouse
echo "Compiling the DD client warehouse system"
mvn clean package assembly:single
echo "Done"
cp ./target/client-warehouse-jar-with-dependencies.jar ../../docker/clients/client-warehouse/.

# building the docker image
cd ../../docker/clients/client-warehouse/
docker build -t isa-devops/dd-client-warehouse .

# cleaning up the environment
rm -rf client-warehouse-jar-with-dependencies.jar
