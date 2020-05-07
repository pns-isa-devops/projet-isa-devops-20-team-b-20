#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

#Preparing environment
cd ../../projet-isa-devops-20-team-b-20-drone-api
./compile.sh
cp ./server.exe ../docker/api-drone/.

# building the docker image
cd ../docker/api-drone/
docker build -t isa-devops/dd-api-drone .

# cleaning up the environment
rm -rf server.exe
