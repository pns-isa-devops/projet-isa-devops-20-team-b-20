#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

#Preparing environment
cd ../../../projet-isa-devops-20-team-b-20-client/projet-isa-devops-20-team-b-20-client-office
echo "Compiling the DD client office system"
mvn -s "$parent_path"/../../resources/settings.xml clean package assembly:single
echo "Done"
cp ./target/client-office-jar-with-dependencies.jar ../../docker/clients/client-office/.

# building the docker image
cd ../../docker/clients/client-office/
docker build -t isa-devops/dd-client-office .

# cleaning up the environment
rm -rf client-office-jar-with-dependencies.jar
