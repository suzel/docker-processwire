FROM ubuntu:14.04
MAINTAINER Sukru Uzel <uzelsukru@gmail.com>

# Keep upstart
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Set no tty
ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_USER processwire
ENV MYSQL_PASS processwire

# Update System
RUN apt-get update
RUN apt-get -y upgrade

# Basic Requirements
RUN apt-get install -y pwgen --force-yes python-setuptools curl git unzip \
mysql-server mysql-client \
nginx \
php5-fpm php5-mysql php-apc php5-cli php5-curl php5-gd php5-mcrypt php5-intl  \
php5-imap php5-tidy php5-imagick php5-memcache php5-xmlrpc php5-xsl

# MySQL Config
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Nginx Config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD ./config/nginx-site.conf /etc/nginx/sites-available/default

# PHP Config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php5/fpm/pool.d/www.conf
RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# ProcessWire Install
RUN git clone git://github.com/ryancramerdesign/ProcessWire.git -b master

# Supervisor Config
RUN easy_install supervisor
ADD ./config/supervisord.conf /etc/supervisord.conf

# Volume
# VOLUME /usr/share/nginx/www

# Expose
EXPOSE 80
EXPOSE 3306

# Startup Script
ADD ./scripts/start.sh /scripts/start.sh
RUN chmod 755 /scripts/start.sh
CMD ["/bin/bash", "/scripts/start.sh"]

# Clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*