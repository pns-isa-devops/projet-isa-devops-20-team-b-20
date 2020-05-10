# Etape

## Devops

### docker test env

lancer un module dans un env clean et vérifier que le module compile avec les dépendances.

```sh
docker run -it --rm --name web-services -v C:/Users/haenl/Documents/Polytech/SI4-S8/isa_devops/projet-isa-devops-20-team-b-20/projet-isa-devops-20-team-b-20-drone-delivery:/usr/src/maven -w /usr/src/maven maven:3.3-jdk-8-alpine mvn -s settings.xml clean install -pl web-services
```

dans le projet, clean un module et run le web service

```sh
mvn clean -pl delivery-component
mvn package tomee:run -pl web-services
```

montrer le ci

[demo ci](https://ci.otakedev.com/blue/organizations/jenkins/projet-isa-devops-20-team-b-20-drone-delivery/detail/develop/19/pipeline/)

## isa

démo

```sh
# cli office
scheduledelivery d1 16:30
# cli warehouse
startdelivery d1
# drone api
# RESULTAT dans API ->ReceivedRequest: DroneRequest[ Drone 0 will be launched at 16:30 ]
```
