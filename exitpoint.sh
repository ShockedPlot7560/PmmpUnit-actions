#!/bin/bash

POCKETMINE_NAME=$1

docker cp $POCKETMINE_NAME:/data/plugin_data/PmmpUnit/results.txt /tmp/failed.txt
docker rm $POCKETMINE_NAME > /dev/null
docker volume prune -f > /dev/null

echo "failed-tests=$(cat /tmp/failed.txt)" >> $GITHUB_OUTPUT

if [ `cat /tmp/failed.txt` -eq 0 ]; then echo "All test passed"; else echo "Some test failed"; exit 1; fi