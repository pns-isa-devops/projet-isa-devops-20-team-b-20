#!/bin/bash

#Preparing environment
cd ../../projet-isa-devops-20-team-b-20-drone-api
./compile.sh
cp ./server.exe ../docker/api-drone/.

# building the docker image
cd ../docker/api-drone/
docker build -t dd-api-drone .

# cleaning up the environment
rm -rf server.exe
