#!/bin/bash

echo "Docker compose up"
docker-compose -f ./docker/env/deploy/docker-compose.yml up -d --build
echo ""
echo "Run"
echo "> client-office.sh"
echo "And"
echo "> client-warehouse.sh"
echo "to attach the clients and start executing commands"
echo ""
echo "You can found a scenario in scenarios.md"
echo ""
echo "Run the following command to shutdown everything"
echo "> docker-compose -f ./docker/env/deploy/docker-compose.yml down"
echo ""
