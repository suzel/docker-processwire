#!/bin/bash

source /etc/apache2/envvars

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

exec apache2 -D FOREGROUND
