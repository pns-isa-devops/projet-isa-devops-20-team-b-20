#!/bin/sh

if [ $# -eq 0 ]
then
  echo "No project selected"
  echo "$0 help : display help"
  exit
fi

if [ $1 = "help" ]
then
  echo "----- Help command -----"
  echo "help : Print this help"
  echo "all : Compile all project"
  echo "clean : Removing all executable"
  echo "mr-proper : Removing all configurable files"

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
  echo "  $0 cli-office clean run"
  echo "  $0 cli-office clean"
  echo "  $0 cli-office run"
  echo "  $0 cli-office"
  exit
fi

if [ $1 = "clear" ]
then
  rm -rf projet-isa-devops-20-team-b-20-client-office/target
  rm -rf projet-isa-devops-20-team-b-20-client-warehouse/target
  rm -rf projet-isa-devops-20-team-b-20-drone-delivery/target
  rm -rf projet-isa-devops-20-team-b-20-drone-api/server.exe
  exit
fi

if [ $1 = "mr-proper" ]
then
  rm -rf projet-isa-devops-20-team-b-20-client-office/target
  rm -rf projet-isa-devops-20-team-b-20-client-warehouse/target
  rm -rf projet-isa-devops-20-team-b-20-drone-delivery/target
  rm -rf projet-isa-devops-20-team-b-20-drone-api/server.exe
  rm -rf .vscode/
  rm -rf .idea/
  rm -rf projet-isa-devops-20-team-b-20-client-office/*.iml
  rm -rf projet-isa-devops-20-team-b-20-client-warehouse/*.iml
  rm -rf projet-isa-devops-20-team-b-20-drone-delivery/*/*.iml
  rm -rf projet-isa-devops-20-team-b-20-drone-delivery/*.iml
  exit
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
  exit
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

$SHELL