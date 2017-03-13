#!/usr/bin/env bash

DYNAMODB_USER=vagrant

sudo apt-get install openjdk-9-jre-headless -y

cd /home/${DYNAMODB_USER}/
mkdir -p dynamodb
cd dynamodb

wget https://s3-ap-southeast-1.amazonaws.com/dynamodb-local-singapore/dynamodb_local_latest.tar.gz
tar -xvzf dynamodb_local_latest.tar.gz
rm dynamodb_local_latest.tar.gz

cat >> dynamodb.conf << EOF
description "DynamoDB Local"
#
# http://aws.typepad.com/aws/2013/09/dynamodb-local-for-desktop-development.html
#
start on (local-filesystems and runlevel [2345])
stop on runlevel [016]

chdir /home/${DYNAMODB_USER}/dynamodb

setuid ${DYNAMODB_USER}
setgid ${DYNAMODB_USER}

exec java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb -dbPath /home/${DYNAMODB_USER}/dynamodb --port 3000
EOF
sudo cp /home/${DYNAMODB_USER}/dynamodb/dynamodb.conf /etc/init/dynamodb.conf
