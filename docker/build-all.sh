#!/bin/bash

cd ./api-drone/
./build.sh
cd ../api-carrier/
./build.sh
cd ../clients/client-office/
./build.sh
cd ../client-warehouse/
./build.sh
cd ../../dd/
./build.sh
cd ../../
