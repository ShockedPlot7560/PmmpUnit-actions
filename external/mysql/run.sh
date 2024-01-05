MYSQL_NAME=$1

echo Waiting for MySQL to start...
while ! docker exec $MYSQL_NAME mysqladmin ping --silent; do
    sleep 1
    echo Waiting for MySQL to start...
done
echo MySQL started