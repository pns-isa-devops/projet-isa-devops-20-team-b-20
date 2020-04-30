#!/bin/bash

cd ./api-drone/
./build.sh
cd ../api-carrier/
./build.sh
cd ../clients/client-test/
./build.sh
cd ../../dd/
./build.sh
cd ../../
