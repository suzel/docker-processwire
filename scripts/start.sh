#!/bin/sh

if [ -d /ProcessWire ]; then

	MYSQL_PASSWORD=`pwgen -c -n -1 12`

	# ProcessWire
	rm -rf /usr/share/nginx/www
	echo $MYSQL_PASSWORD > /ProcessWire/mysql-root-password.txt
	mv /ProcessWire /usr/share/nginx/www
	chown -R www-data:www-data /usr/share/nginx/www

	# MySQL
	/usr/bin/mysqld_safe &
	sleep 10s
	service mysql start
	mysqladmin -u root password $MYSQL_PASSWORD
	mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
	mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE processwire; GRANT ALL PRIVILEGES ON processwire.* TO 'processwire'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"

fi

# Supervisor
/usr/local/bin/supervisord -n