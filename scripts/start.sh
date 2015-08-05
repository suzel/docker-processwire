#!/bin/sh

if [ -d /ProcessWire ]; then

	# ProcessWire
	rm -rf /usr/share/nginx/www
	mv /ProcessWire /usr/share/nginx/www
	chown -R www-data:www-data /usr/share/nginx/www
	usermod -u 1000 www-data

	# MySQL
	MYSQL_ROOT_PASS=`pwgen -c -n -1 12`
	/usr/bin/mysqld_safe &
	sleep 10s
	service mysql start
	mysqladmin -u root password $MYSQL_ROOT_PASS
	mysql -uroot -p$MYSQL_ROOT_PASS -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASS' WITH GRANT OPTION; FLUSH PRIVILEGES;"
	mysql -uroot -p$MYSQL_ROOT_PASS -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS' WITH GRANT OPTION; FLUSH PRIVILEGES;"
	mysql -uroot -p$MYSQL_ROOT_PASS -e "CREATE DATABASE processwire; GRANT ALL PRIVILEGES ON processwire.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASS'; FLUSH PRIVILEGES;"

	echo "========================================================================"
	echo ""
	echo "    Access Information for MySQL Server :"
	echo ""
	echo "    MySQL Root Password : $MYSQL_ROOT_PASS"
	echo "    MySQL User : $MYSQL_USER"
	echo "    MySQL Password : $MYSQL_PASS"
	echo ""
	echo "========================================================================"

fi

# Supervisor
/usr/local/bin/supervisord -n