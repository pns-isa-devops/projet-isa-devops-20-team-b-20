#!/bin/bash

# step #1: configure the bank.propoerties file
mkdir -p ./WEB-INF/classes/
touch ./WEB-INF/classes/dronepark.properties
touch ./WEB-INF/classes/carrier.properties

#drone park properties 
echo "droneparkHostName=$dronepark_host" >> ./WEB-INF/classes/dronepark.properties
echo "droneparkPortNumber=$dronepark_port" >> ./WEB-INF/classes/dronepark.properties

#carrier properties
echo "carrierHostName=$carrier_host" >> ./WEB-INF/classes/carrier.properties
echo "carrierPortNumber=$carrier_port" >> ./WEB-INF/classes/carrier.properties

# step #2: update the webapp to load the right properties
jar uvf ./webapps/drone-delivery-backend.war ./WEB-INF/classes/dronepark.properties
jar uvf ./webapps/drone-delivery-backend.war ./WEB-INF/classes/carrier.properties

# step #3: start the TomEE engine
catalina.sh run
