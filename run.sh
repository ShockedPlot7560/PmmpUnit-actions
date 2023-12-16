#!/bin/bash

POCKETMINE_NAME=$1
TIMEOUT=$2

./timeout.sh $POCKETMINE_NAME $TIMEOUT &

docker start -ia $POCKETMINE_NAME