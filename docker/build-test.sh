#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

cd ./api-drone/
./build.sh
cd ../api-carrier/
./build.sh
cd ../clients/client-test/
./build.sh
cd ../../dd/
./build.sh
cd ../../
