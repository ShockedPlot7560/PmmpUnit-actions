#!/bin/bash

POCKETMINE_NAME=$1
TIMEOUT=$2
MYSQL_NAME=$3

# if mysql_name is not empty
if [ -n "$MYSQL_NAME" ]; then
    ./external/mysql/run.sh $MYSQL_NAME
fi

./timeout.sh $POCKETMINE_NAME $TIMEOUT &

docker start -ia $POCKETMINE_NAME