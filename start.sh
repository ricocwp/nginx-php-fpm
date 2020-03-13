#!/usr/bin/env bash
nginx &
php-fpm7 &
touch /var/log/php7/error.log | touch /var/log/nginx/access.log | touch /var/log/nginx/error.log 
tail -f /var/log/php7/error.log  /var/log/nginx/access.log /var/log/nginx/error.log
