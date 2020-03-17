FROM alpine
LABEL Maintainer="Tim de Pater <code@trafex.nl>" \
      Description="Lightweight container with Nginx 1.16 & PHP-FPM 7 based on Alpine Linux."

# Install packages
RUN apk update \
    && apk --no-cache add php7 php7-fpm php7-mcrypt php7-soap php7-openssl \
    php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip \
    php7-mysql php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql \
    php7-bcmath php7-gd php7-xcache php7-odbc php7-pdo_mysql \
    php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 \
    php7-memcache php7-mssql php7-iconv php7-pdo_dblib php7-curl php7-ctype \
    nginx curl bash

RUN echo "$(echo 'pid /run/nginx.pid;' | cat - /etc/nginx/nginx.conf)" > /etc/nginx/nginx.conf

RUN mkdir /web

RUN rm /etc/nginx/nginx.conf

COPY . /etc/nginx/nginx.conf

COPY . /web

RUN echo -e '[Date]\ndate.timezone="Asia/Jakarta"' > /etc/php7/php.ini

COPY start.sh /

RUN chmod +x /start.sh

EXPOSE 80

ENTRYPOINT ["/start.sh"]
