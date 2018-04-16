#!/bin/bash


CLIENT_IP_ADDRESS=$(curl http://169.254.169.254/latest/meta-data/hostname)
HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/instance-id)

cat /tmp/config.json \
	| sed s/SENSU_SERVER/${SENSU_SERVER}/g \
	| sed s/SENSU_USER/${SENSU_USER}/g \
	| sed s/SENSU_PASSWORD/${SENSU_PASSWORD}/g > /etc/sensu/config.json

cat /tmp/client.json \
	| sed s/CLIENT_NAME/${HOSTNAME}/g \
	| sed s/CLIENT_IP_ADDRESS/${CLIENT_IP_ADDRESS}/g > /etc/sensu/conf.d/client.json

for file in $(ls /tmp/checks)
do



cat /tmp/checks/$file \
| sed s/SERVICE_PORT/${SERVICE_PORT}/g \
| sed s/SERVICE_NAME/${SERVICE_NAME}/g > /etc/sensu/conf.d/$file
done

/opt/sensu/bin/sensu-client
