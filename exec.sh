#!/bin/bash
PARAMS=""
CARG=0
HARG=0
LARG=0
while (("$#")); do
    case "$1" in
    -h | --help)
        HARG=1
        break
        ;;
    -c | --compile)
        CARG=1
        shift 1
        ;;
    -l | --list)
        LARG=1
        break
        ;;
    -p | --project)
        PARG=$2
        shift 2
        ;;
    -m | --module)
        MARG=$2
        shift 2
        ;;
    --) # end argument parsing
        shift
        break
        ;;
    -* | --*=) # unsupported flags
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

if [[ $HARG == 1 ]]; then
    echo ""
    echo "Usage: $0 [options] [action]"
    echo ""
    echo "Options:"
    echo "	-h, --help					print help"
    echo "	-l, --list					print list project and module"
    echo "	-p <project>, --project <project>		select project"
    echo "	-m <module>, --module <module>			select module"
    echo "	-c, --compile					compile before running (only with actions run and docker)"
    echo ""
    echo "Action list:"
    echo "	compile						compile project"
    echo "	run						compile and run"
    echo "	clean						removing executable files"
    echo "  docker          run docker containers"

    echo ""
    echo "Note: if nothing project specified, it will run all projects"
    exit
fi

if [[ $LARG == 1 ]]; then
    echo ""
    echo "Listing:"
    echo "	cli					client"
    echo "		warehouse			client-warehouse"
    echo "		office				client-office"
    echo "		utils				client-utils"
    echo "	drone				drone-delivery"
    echo "		delivery			delivery-component"
    echo "		drone				drone-park-component"
    echo "		entities			entities"
    echo "		invoice				invoice-component"
    echo "		schedule			schedule-component"
    echo "		shipment			shipment-component"
    echo "		statistics			statistics-component"
    echo "		warehouse			warehouse-component"
    echo "		web				    web-service"
    echo "	drone-api			drone-api"
    echo "  carrier-api         carrier-api"

    exit
fi

if [[ -z $PARAMS ]]; then
    echo "No action selected, exiting..."
    exit
fi

printf -v PARAMS '%s' $PARAMS

function compile() {
    PROJECT=$1
    MODULE=$2

    if [[ $PROJECT == "cli" ]]; then
        cd projet-isa-devops-20-team-b-20-client
        if [[ $MODULE == "warehouse" ]]; then
            cd projet-isa-devops-20-team-b-20-client-warehouse
        elif [[ $MODULE == "office" ]]; then
            cd projet-isa-devops-20-team-b-20-client-office
        elif [[ $MODULE == "utils" ]]; then
            cd projet-isa-devops-20-team-b-20-client-utils
        fi

        pwd
        mvn clean install
    elif [[ $PROJECT == "drone" ]]; then
        cd projet-isa-devops-20-team-b-20-drone-delivery

        if [[ $MODULE == "delivery" ]]; then
            cd projet-isa-devops-20-team-b-20-delivery-component
        elif [[ $MODULE == "drone" ]]; then
            cd projet-isa-devops-20-team-b-20-drone-park-component
        elif [[ $MODULE == "entities" ]]; then
            cd projet-isa-devops-20-team-b-20-entities
        elif [[ $MODULE == "invoice" ]]; then
            cd projet-isa-devops-20-team-b-20-invoice-component
        elif [[ $MODULE == "schedule" ]]; then
            cd projet-isa-devops-20-team-b-20-schedule-component
        elif [[ $MODULE == "shipment" ]]; then
            cd projet-isa-devops-20-team-b-20-shipment-component
        elif [[ $MODULE == "statistics" ]]; then
            cd projet-isa-devops-20-team-b-20-statistics-component
        elif [[ $MODULE == "warehouse" ]]; then
            cd projet-isa-devops-20-team-b-20-warehouse-component
        elif [[ $MODULE == "web" ]]; then
            cd projet-isa-devops-20-team-b-20-web-service
        fi

        mvn clean install
    elif [[ $PROJECT == "drone-api" ]]; then
        cd projet-isa-devops-20-team-b-20-drone-api
        ./compile.sh
        
    elif [[ $PROJECT == "carrier-api" ]]; then
        cd projet-isa-devops-20-team-b-20-carrier-api
        ./compile.sh
 
    else
        echo "Project $1 don't exist..."
    fi
}

if [[ $PARAMS == "compile" ]]; then
    if [[ -z $PARG ]]; then
        compile "cli" "nothing"
        cd ..
        compile "drone" "nothing"
        cd ..
        compile "drone-api" "nothing"
        cd ..
        compile "carrier-api" "nothing"
    else
        MODULE="nothing"
        if [[ ! -z $MARG ]]; then
            MODULE=$MARG
        fi
        compile $PARG $MODULE
    fi
    exit
fi

function run() {
    PROJECT=$1
    MODULE=$2

    if [[ $PROJECT == "cli" ]]; then
        cd projet-isa-devops-20-team-b-20-client

        if [[ $MODULE == "warehouse" ]]; then
            cd projet-isa-devops-20-team-b-20-client-warehouse
        elif [[ $MODULE == "office" ]]; then
            cd projet-isa-devops-20-team-b-20-client-office
        else
            echo "Undefined client to run..."
        fi

        if [[ $CARG == 1 ]]; then
            mvn clean install
        fi
        mvn exec:java
    elif [[ $PROJECT == "drone" ]]; then
        cd projet-isa-devops-20-team-b-20-drone-delivery
        if [[ $CARG == 1 ]]; then
            mvn clean install
        fi
        cd projet-isa-devops-20-team-b-20-web-service
        mvn clean package tomee:run
    elif [[ $PROJECT == "drone-api" ]]; then
            cd projet-isa-devops-20-team-b-20-drone-api
        if [[ $CARG == 1 ]]; then
            ./compile.sh
        fi
        mono server.exe
    elif [[ $PROJECT == "carrier-api" ]]; then
            cd projet-isa-devops-20-team-b-20-carrier-api
        if [[ $CARG == 1 ]]; then
            ./compile.sh
        fi
        mono server.exe
    else
        echo "Project $1 not exist..."
    fi
}

if [[ $PARAMS == "run" ]]; then
    if [[ -z $PARG ]]; then
        echo "Undefined project to run"
        exit
    else
        MODULE="nothing"
        if [[ ! -z $MARG ]]; then
            MODULE=$MARG
        fi
        run $PARG $MODULE
    fi
    exit
fi

function clean() {
    PROJECT=$1
    MODULE=$2

    if [[ $PROJECT == "cli" ]]; then
        cd projet-isa-devops-20-team-b-20-client
        if [[ $MODULE == "warehouse" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-client-warehouse/target
        elif [[ $MODULE == "office" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-client-office/target
        elif [[ $MODULE == "utils" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-client-utils/target
        else
            rm -rf projet-isa-devops-20-team-b-20-client-warehouse/target
            rm -rf projet-isa-devops-20-team-b-20-client-office/target
            rm -rf projet-isa-devops-20-team-b-20-client-utils/target
        fi

    elif [[ $PROJECT == "drone" ]]; then
        cd projet-isa-devops-20-team-b-20-drone-delivery

        if [[ $MODULE == "delivery" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-delivery-component/target
        elif [[ $MODULE == "drone" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-drone-park-component/target
        elif [[ $MODULE == "entities" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-entities/target
        elif [[ $MODULE == "invoice" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-invoice-component/target
        elif [[ $MODULE == "schedule" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-schedule-component/target
        elif [[ $MODULE == "shipment" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-shipment-component/target
        elif [[ $MODULE == "statistics" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-statistics-component/target
        elif [[ $MODULE == "warehouse" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-warehouse-component/target
        elif [[ $MODULE == "web" ]]; then
            rm -rf projet-isa-devops-20-team-b-20-web-service/target
        else
            rm -rf projet-isa-devops-20-team-b-20-delivery-component/target
            rm -rf projet-isa-devops-20-team-b-20-drone-park-component/target
            rm -rf projet-isa-devops-20-team-b-20-entities/target
            rm -rf projet-isa-devops-20-team-b-20-invoice-component/target
            rm -rf projet-isa-devops-20-team-b-20-schedule-component/target
            rm -rf projet-isa-devops-20-team-b-20-shipment-component/target
            rm -rf projet-isa-devops-20-team-b-20-statistics-component/target
            rm -rf projet-isa-devops-20-team-b-20-warehouse-component/target
            rm -rf projet-isa-devops-20-team-b-20-web-service/target
        fi
    elif [[ $PROJECT == "drone-api" ]]; then
        cd projet-isa-devops-20-team-b-20-drone-api
        rm -rf server.exe
    elif [[ $PROJECT == "carrier-api" ]]; then
        cd projet-isa-devops-20-team-b-20-carrier-api
        rm -rf server.exe
    else
        echo "Project $1 don't exist..."
    fi
}

if [[ $PARAMS == "clean" ]]; then
    if [[ -z $PARG ]]; then
        clean "cli" "nothing"
        cd ..
        clean "drone" "nothing"
        cd ..
        clean "drone-api" "nothing"
        cd ..
        clean "carrier-api" "nothing"
    else
        MODULE="nothing"
        if [[ ! -z $MARG ]]; then
            MODULE=$MARG
        fi
        clean $PARG $MODULE
    fi
    exit
fi

function docker() {
    PROJECT=$1
    MODULE=$2

    if [[ $PROJECT == "cli" ]]; then
        cd docker/clients

        if [[ $MODULE == "warehouse" ]]; then
            if [[ $CARG == 1 ]]; then
                cd projet-isa-devops-20-team-b-20-client/projet-isa-devops-20-team-b-20-client-warehouse
                mvn clean install
                cd ../..
            fi
            cd client-warehouse
        elif [[ $MODULE == "office" ]]; then
            if [[ $CARG == 1 ]]; then
                cd projet-isa-devops-20-team-b-20-client/projet-isa-devops-20-team-b-20-client-office
                mvn clean install
                cd ../..
            fi
            cd client-office
        else
            echo "Undefined client to run..."
        fi

        ./build.sh
        ./run.sh
    elif [[ $PROJECT == "drone" ]]; then
        if [[ $CARG == 1 ]]; then
            cd projet-isa-devops-20-team-b-20-drone-delivery
            mvn clean install
            cd ..
        fi
        cd docker/dd
        ./build.sh
        ./run.sh
    elif [[ $PROJECT == "api" ]]; then

        if [[ $CARG == 1 ]]; then
            cd projet-isa-devops-20-team-b-20-drone-api
            ./compile.sh
            cd ..
        fi

        cd docker/api-drone
        ./build.sh
        ./run.sh
    else
        echo "Project $1 not exist..."
    fi
}

if [[ $PARAMS == "docker" ]]; then
    if [[ -z $PARG ]]; then
        if [[ $CARG == 1 ]]; then
            compile "cli" "nothing"
            cd ..
            compile "drone" "nothing"
            cd ..
            compile "api" "nothing"
            cd ..
        fi
        cd docker
        docker-compose up
    else
        MODULE="nothing"
        if [[ ! -z $MARG ]]; then
            MODULE=$MARG
        fi
        docker $PARG $MODULE
    fi
    exit
fi
