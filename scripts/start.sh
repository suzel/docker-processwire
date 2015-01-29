#!/bin/sh

# MySQL
/usr/bin/mysqld_safe &
sleep 10s
MYSQL_PASSWORD=`pwgen -c -n -1 12`
echo $MYSQL_PASSWORD > /mysql-root-pw.txt
mysqladmin -u root password $MYSQL_PASSWORD
mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE processwire; GRANT ALL PRIVILEGES ON processwire.* TO 'processwire'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"

# Supervisor
/usr/local/bin/supervisord -n