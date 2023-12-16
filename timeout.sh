POCKETMINE_NAME=$1
TIMEOUT_TIME=$2

while true
do
    sleep $TIMEOUT_TIME
    echo "Timeout reached, killing server"
    docker kill $POCKETMINE_NAME
done