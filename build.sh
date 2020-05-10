#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

echo "Building the whole project..."
echo ""
cd ./docker/
./build-all.sh
cd ..
echo "Finished"
