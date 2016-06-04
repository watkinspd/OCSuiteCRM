#!/bin/sh

set -e

if [ -z "$DB_HOST_NAME" ]; then
	export DB_HOST_NAME=$MYSQL_SERVICE_HOST
fi

if [ -z "$DB_TCP_PORT" ]; then
	export DB_TCP_PORT=$MYSQL_SERVICE_PORT
fi

if [ -z "$DB_USER_NAME" ]; then
	export DB_USER_NAME=$MYSQL_USER
fi

if [ -z "$DB_PASSWORD" ]; then
	export DB_PASSWORD=$MYSQL_PASSWORD
fi

if [ -z "$DATABASE_NAME" ]; then
	export DATABASE_NAME=$MYSQL_DATABASE
fi

if [ -z "$DB_TYPE" ]; then
	export DB_TYPE="mysql"
fi

if [ -z "$DB_MANAGER" ]; then
	export DB_MANAGER="MysqlManager"
fi

/usr/local/bin/envtemplate.py -i /usr/local/src/config_override.php.pyt -o /var/www/html/config_override.php
/usr/sbin/cron

# Remove Apache PID lock file so apache can start next time
rm -f /run/apache2/apache2.pid

# Start Apache
apachectl -DFOREGROUND
