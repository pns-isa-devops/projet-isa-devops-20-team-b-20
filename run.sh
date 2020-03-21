#!/bin/bash
PARAMS=""
CARG=0
HARG=0
LARG=0
while (( "$#" )); do
  case "$1" in
	-h|--help)
	  HARG=1
	  break
      ;;
	-l|--list)
	  LARG=1
	  break
      ;;
    -p|--project)
      PARG=$2
      shift 2
      ;;
	-m|--module)
      MARG=$2
      shift 2
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

if [[ $HARG = 1 ]]
then
	echo ""
	echo "Usage: $0 [options] [action]"
	echo ""
	echo "Options:"
	echo "	-h, --help					print help"
	echo "	-l, --list					print list project and module"
	echo "	-p <project>, --project <project>		select project"
	echo "	-m <module>, --module <module>			select module"
	echo ""
	echo "Action list:"
	echo "	compile						compile project"
	echo "	run						compile and run"
	echo "	clean						removing executable files"
	echo ""
	echo "Note: if nothing project specified, it will run all projects"
	exit;
fi

if [[ $LARG = 1 ]]
then
	echo ""
	echo "Listing:"
	echo "	cli					client"
	echo "		warehouse			client-warehouse"
	echo "		office				client-office"
	echo "		utils				client-utils"
	echo "	drone					drone-delivery"
	echo "		delivery			delivery-component"
	echo "		drone				drone-park-component"
	echo "		entities			entities"
	echo "		invoice				invoice-component"
	echo "		schedule			schedule-component"
	echo "		shipment			shipment-component"
	echo "		statistics			statistics-component"
	echo "		warehouse			warehouse-component"
	echo "		web				web-service"
	echo "	api					drone-api"
	
	exit;
fi

if [[ -zt $PARAMS ]]
then
	echo "No action selected, exiting..."
	exit;
fi

printf -v PARAMS '%s' $PARAMS

function compile() {
	PROJECT=$1
	MODULE=$2

	if [[ $PROJECT == "cli" ]]
	then
		cd projet-isa-devops-20-team-b-20-client;
		if [[ $MODULE == "warehouse" ]]
		then
			cd projet-isa-devops-20-team-b-20-client-warehouse;
		elif [[ $MODULE == "office" ]]
		then
			cd projet-isa-devops-20-team-b-20-client-office;
		elif [[ $MODULE == "utils" ]]
		then
			cd projet-isa-devops-20-team-b-20-client-utils;
		fi

		pwd
		mvn clean install
	elif [[ $PROJECT == "drone" ]]
	then
		cd projet-isa-devops-20-team-b-20-drone-delivery;

		if [[ $MODULE == "delivery" ]]
		then
			cd delivery-component;
		elif [[ $MODULE == "drone" ]]
		then
			cd drone-park-component;
		elif [[ $MODULE == "entities" ]]
		then
			cd entities;
		elif [[ $MODULE == "invoice" ]]
		then
			cd invoice-component;
		elif [[ $MODULE == "schedule" ]]
		then
			cd schedule-component;
		elif [[ $MODULE == "shipment" ]]
		then
			cd shipment-component;
		elif [[ $MODULE == "statistics" ]]
		then
			cd statistics-component;
		elif [[ $MODULE == "warehouse" ]]
		then
			cd warehouse-component;
		elif [[ $MODULE == "web" ]]
		then
			cd web-services;
		fi

		mvn clean install
	elif [[ $PROJECT == "api" ]]
	then
		cd projet-isa-devops-20-team-b-20-drone-api;
		./compile.sh
	else
		echo "Project $1 don't exist..."
	fi
}

if [[ $PARAMS = "compile" ]]
then
	if [[ -zt $PARG ]]
	then
		compile "cli" "nothing"
		cd ..
		compile "drone" "nothing"
		cd ..
		compile "api" "nothing"
	else
		MODULE="nothing"
		if [[ ! -z $MARG ]]
		then
			MODULE=$MARG
		fi
		compile $PARG $MODULE
	fi
	exit;
fi

function execute() {
	PROJECT=$1
	MODULE=$2

	if [[ $PROJECT == "cli" ]]
	then
		cd projet-isa-devops-20-team-b-20-client;

		if [[ $MODULE == "warehouse" ]]
		then
			cd projet-isa-devops-20-team-b-20-client-warehouse;
		elif [[ $MODULE == "office" ]]
		then
			cd projet-isa-devops-20-team-b-20-client-office;
		else
			echo "Undefined client to run..."
		fi

		mvn clean install
		mvn exec:java
	elif [[ $PROJECT == "drone" ]]
	then
		cd projet-isa-devops-20-team-b-20-drone-delivery;
		mvn clean install
		cd web-service;
		mvn tomee:run
	elif [[ $PROJECT == "api" ]]
	then
		cd projet-isa-devops-20-team-b-20-drone-api;
		./compile.sh
		mono server.exe
	else
		echo "Project $1 not exist..."
	fi
}

if [[ $PARAMS = "run" ]]
then
	if [[ -zt $PARG ]]
	then
		run "cli" "nothing"
		cd ..
		run "drone" "nothing"
		cd ..
		run "api" "nothing"
	else
		MODULE="nothing"
		if [[ ! -zt $MARG ]]
		then
			MODULE=$MARG
		fi
		run $PARG $MODULE
	fi
	exit;
fi

function clean() {
	PROJECT=$1
	MODULE=$2

	if [[ $PROJECT == "cli" ]]
	then
		cd projet-isa-devops-20-team-b-20-client;
		if [[ $MODULE == "warehouse" ]]
		then
			rm -rf projet-isa-devops-20-team-b-20-client-warehouse/target;
		elif [[ $MODULE == "office" ]]
		then
			rm -rf projet-isa-devops-20-team-b-20-client-office/target;
		elif [[ $MODULE == "utils" ]]
		then
			rm -rf projet-isa-devops-20-team-b-20-client-utils/target;
		else 
			rm -rf projet-isa-devops-20-team-b-20-client-warehouse/target;
			rm -rf projet-isa-devops-20-team-b-20-client-office/target;
			rm -rf projet-isa-devops-20-team-b-20-client-utils/target;
		fi

	elif [[ $PROJECT == "drone" ]]
	then
		cd projet-isa-devops-20-team-b-20-drone-delivery;

		if [[ $MODULE == "delivery" ]]
		then
			rm -rf delivery-component/target;
		elif [[ $MODULE == "drone" ]]
		then
			rm -rf drone-park-component/target;
		elif [[ $MODULE == "entities" ]]
		then
			rm -rf entities/target;
		elif [[ $MODULE == "invoice" ]]
		then
			rm -rf invoice-component/target;
		elif [[ $MODULE == "schedule" ]]
		then
			rm -rf schedule-component/target;
		elif [[ $MODULE == "shipment" ]]
		then
			rm -rf shipment-component/target;
		elif [[ $MODULE == "statistics" ]]
		then
			rm -rf statistics-component/target;
		elif [[ $MODULE == "warehouse" ]]
		then
			rm -rf warehouse-component/target;
		elif [[ $MODULE == "web" ]]
		then
			rm -rf web-services/target;
		else
			rm -rf delivery-component/target;
			rm -rf drone-park-component/target;
			rm -rf entities/target;
			rm -rf invoice-component/target;
			rm -rf schedule-component/target;
			rm -rf shipment-component/target;
			rm -rf statistics-component/target;
			rm -rf warehouse-component/target;
			rm -rf web-services/target;
		fi
	elif [[ $PROJECT == "api" ]]
	then
		cd projet-isa-devops-20-team-b-20-drone-api;
		rm -rf server.exe
	else
		echo "Project $1 don't exist..."
	fi
}

if [[ $PARAMS = "clean" ]]
then
	if [[ -zt $PARG ]]
	then
		clean "cli" "nothing"
		cd ..
		clean "drone" "nothing"
		cd ..
		clean "api" "nothing"
	else
		MODULE="nothing"
		if [[ ! -z $MARG ]]
		then
			MODULE=$MARG
		fi
		clean $PARG $MODULE
	fi
	exit;
fi