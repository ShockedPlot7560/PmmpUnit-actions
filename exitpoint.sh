#!/bin/bash

POCKETMINE_NAME=$1

docker cp $POCKETMINE_NAME:/data/plugin_data/PmmpUnit/results.txt /tmp/failed.txt

echo "failed-tests=$(cat /tmp/failed.txt)" >> $GITHUB_OUTPUT

if [ `cat /tmp/failed.txt` -eq 0 ]; then echo "All test passed"; else echo "Some test failed"; exit 1; fi