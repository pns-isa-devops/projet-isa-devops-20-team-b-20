#!/bin/bash

#Preparing environment
cd ../../projet-isa-devops-20-team-b-20-drone-delivery
echo "Compiling the DD system"
mvn -q -DskipTests clean package
echo "Done"
cd ../docker/dd

cp ../../projet-isa-devops-20-team-b-20-drone-delivery/projet-isa-devops-20-team-b-20-web-service/target/drone-delivery-backend.war .

# building the docker image
docker build -t isa-devops/drone-delivery .

# cleaning up the environment
rm -rf drone-delivery-backend.war
