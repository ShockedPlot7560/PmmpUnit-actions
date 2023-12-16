#!/bin/bash

CONTAINER_PREFIX="pmmpunit-tests"
PHP_VERSION=$1
TESTS_PATH=$2
SUITE_TEST=$3
ENV_FILE=$4
DOCKER_IMAGE="ghcr.io/shockedplot7560/pmmpunit/tests-runner-php${PHP_VERSION}:latest"
NETWORK_NAME=$CONTAINER_PREFIX-network
POCKETMINE_NAME=$CONTAINER_PREFIX-pocketmine

docker network create $NETWORK_NAME || true
docker rm $POCKETMINE_NAME || true

docker pull $DOCKER_IMAGE
docker create --name $POCKETMINE_NAME \
	--network $NETWORK_NAME \
	--env-file=$ENV_FILE \
	$DOCKER_IMAGE

docker cp $TESTS_PATH/shared/data $POCKETMINE_NAME:/data/plugin_data
docker cp $TESTS_PATH/suitetest/$SUITE_TEST/config $POCKETMINE_NAME:/data/plugin_data
docker cp $TESTS_PATH/suitetest/$SUITE_TEST/plugins $POCKETMINE_NAME:/

echo "pocketmine-name=$POCKETMINE_NAME" >> $GITHUB_OUTPUT