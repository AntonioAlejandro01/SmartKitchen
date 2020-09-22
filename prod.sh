#!/bin/bash
# Color Variables
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

function rmJar(){
    sudo rm "./$1/target/$(ls "./$1/target/" | grep ".*\.jar$")"
    if [ -f  "./$1/target/$2.jar" ]; then
        echo -e "File Jar for $1 removed:  $RED ERROR $NOCOLOR"
    else
        echo -e "File Jar for $1 removed:  $LIGHTGREEN OK $NOCOLOR"
    fi
}

function checkJars() {
    FILE=$(ls "./$1/target/" | grep ".*\.jar$")
    if [ "" != "$FILE" ]; then # existe el fichero
       echo -e "Jar File $1 : $LIGHTGREEN EXIST $NOCOLOR";
    else
        cd "./$1"
        echo -e "Jar File $1: $CYAN CREATING $NOCOLOR"
        sudo mvn clean compile install >> /dev/null
        cd ..
        checkJars "$1"
    fi
   
}

EUREKA_DIR="SMKT_Eureka"
GATEWAY_DIR="SMKT_Gateway"
FILES_DIR="SMKT_Files"

detached=""
build=""

if [ $# -ne 3 ]; then
    echo -e "$RED Need 3 arguments$NOCOLOR"
    echo -e "$ORANGE f$WHITE to remove .jar or $ORANGE n$WHITE to ignore $NOCOLOR"
    echo -e "$BLUE d$WHITE to detached console at docker-compose up or$BLUE a$WHITE to attach console $NOCOLOR"
    echo -e "$PURPLE b$WHITE to rebuild images at docker-compose up or$PURPLE c$WHITE to ignore $NOCOLOR"
    exit 1
fi

sudo echo -e "$GREEN Production mode $NOCOLOR"

if [ "$1" == "f" ]; then
    rmJar "$EUREKA_DIR"
    rmJar "$GATEWAY_DIR"
    rmJar "$FILES_DIR"
fi

if [ "$2" == "d" ]; then
    detached=" -d"
else
    detached=""
fi
if [ "$3" == "b" ]; then
    build="--build"
else
    build=""
fi

    

# Eureka File docker
checkJars "$EUREKA_DIR"
# Zuukl File docker
checkJars "$GATEWAY_DIR"
# Files file docker
checkJars "$FILES_DIR"
    
    ################
    #Docker Compose#
    ################
    
docker-compose down --rmi "local" --remove-orphans
docker-compose -f docker-compose.yml up$detached $build