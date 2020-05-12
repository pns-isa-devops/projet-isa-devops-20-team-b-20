#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

cd ../docker/
./build-all.sh
cd ./clients/client-test/
./build.sh
cd ../../../demo/
