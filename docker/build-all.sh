#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

echo "Building and Dockerizing the Drone API (DotNet)"
cd ./api-drone/
./build.sh
echo "Building and Dockerizing the Carrier API (DotNet)"
cd ../api-carrier/
./build.sh
echo "Building and Dockerizing the Client Office (Java)"
cd ../clients/client-office/
./build.sh
echo "Building and Dockerizing the Client Warehouse (Java)"
cd ../client-warehouse/
./build.sh
echo "Building and Dockerizing the drone delivery web services (Java EE)"
cd ../../dd/
./build.sh
cd ../../
echo "Done building everything"
