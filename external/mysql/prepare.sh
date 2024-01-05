#!/bin/bash

NETWORK_NAME=$1
CONTAINER_PREFIX=$2
MYSQL_NAME=$CONTAINER_PREFIX-mysql
ENV_FILE=$3
MYSQL_VERSION=$4
MYSQL_ENTRYPOINT=$5

docker rm -f $MYSQL_NAME || true

mkdir -p /tmp/docker-entrypoint-initdb.d
if [ -n "$MYSQL_ENTRYPOINT" ] && [ -f "$MYSQL_ENTRYPOINT" ]; then
    cp $MYSQL_ENTRYPOINT /tmp/docker-entrypoint-initdb.d/entrypoint.sh
else 
    # if mysql entrypoint is not empty and is a directory
    if [ -n "$MYSQL_ENTRYPOINT" ] && [ -d "$MYSQL_ENTRYPOINT" ]; then
        cp $MYSQL_ENTRYPOINT/. /tmp/docker-entrypoint-initdb.d
    fi
fi

echo "Starting MySQL..."
docker run --rm -d \
    --name $MYSQL_NAME \
    --hostname mysql \
    --network $NETWORK_NAME \
    --env-file=$ENV_FILE \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_DATABASE=test \
    -v /tmp/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d \
    mysql:$MYSQL_VERSION

echo "mysql_name=$MYSQL_NAME" >> $GITHUB_OUTPUT