#!/usr/bin/env bash

if [ $# -eq 0 ]
then
  echo "No project selected"
  exit
fi

if [ $1 = "help" ]
then
  echo "Help command"
  echo "all : Compile all project"
  
  echo "cli-office : Compile clien office project"
  echo "    clean : Clean project"
  echo "    run : Run project"

  echo "cli-warehouse : Compile client warehouse project"
  echo "    clean : Clean project"
  echo "    run : Run project"

  echo "drone-delivery : Compile drone-delivery project"
  echo "    clean : Clean project"
  echo "    run : Run project"

  echo "api-drone : Compile API drone project"
  echo "    run : Run project"

  echo "examples to use"
  echo "  ./run cli-office clean run"
  echo "  ./run cli-office clean"
  echo "  ./run cli-office run"
  echo "  ./run cli-office"
fi

if [ $1 = "all" ]
then
  cd projet-isa-devops-20-team-b-20-client-office || exit;
  mvn clean package
  cd ..
  cd projet-isa-devops-20-team-b-20-client-warehouse || exit;
  mvn clean package
  cd ..
  cd projet-isa-devops-20-team-b-20-drone-delivery || exit
  mvn clean package
  cd ..
  cd projet-isa-devops-20-team-b-20-drone-api || exit
   ./compile.sh
   echo "All projects compiled"
fi

if [ $1 = "cli-office" ]
then
  cd projet-isa-devops-20-team-b-20-client-office || exit;
  if [ $# -gt 1 ] && [ $2 = 'clean' ]
  then
    mvn clean package
  fi
  mvn install
  if [ $# -gt 1 ] && [ $2 = 'run' ] || [ $# -gt 2 ] && [ $3 = 'run' ]
  then
    mvn exec:java
  fi
fi

if [ $1 = "cli-warehouse" ]
then
  cd projet-isa-devops-20-team-b-20-client-warehouse || exit;
  if [ $# -gt 1 ] && [ $2 = 'clean' ]
  then
    mvn clean package
  fi
  mvn install
  if [ $# -gt 1 ] && [ $2 = 'run' ] || [ $# -gt 2 ] && [ $3 = 'run' ]
  then
    mvn exec:java
  fi
fi

if [ $1 = "drone-delivery" ]
then
  cd projet-isa-devops-20-team-b-20-drone-delivery || exit
  if [ $# -gt 1 ] && [ $2 = 'clean' ]
  then
    mvn clean install
  else
    mvn install
  fi
  if [ $# -gt 1 ] && [ $2 = 'run' ]  || [ $# -gt 2 ] && [ $3 = 'run' ]
  then
    cd web-services || exit
    mvn tomee:run
  fi
fi

if [ $1 = "api-drone" ]
then
  cd projet-isa-devops-20-team-b-20-drone-api || exit
  ./compile.sh
  if [ $# -gt 1 ] && [ $2 = 'run' ]
  then
    mono server.exe
  fi
fi