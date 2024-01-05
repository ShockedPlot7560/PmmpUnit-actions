CONTAINER_PREFIX=$1

docker rm -fv $CONTAINER_PREFIX-pocketmine || true
docker rm -fv $CONTAINER_PREFIX-mysql || true
docker network rm $CONTAINER_PREFIX-network || true