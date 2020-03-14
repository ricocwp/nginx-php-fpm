FROM alpine:3.4
LABEL Maintainer="Tim de Pater <code@trafex.nl>" \
      Description="Lightweight container with Nginx 1.16 & PHP-FPM 5.6 based on Alpine Linux."

# Install packages
RUN apk update \
    && apk --no-cache add php5 php5-fpm php5-mcrypt php5-soap php5-openssl \
    php5-gmp php5-pdo_odbc php5-json php5-dom php5-pdo php5-zip \
    php5-mysql php5-mysqli php5-sqlite3 php5-apcu php5-pdo_pgsql \
    php5-bcmath php5-gd php5-xcache php5-odbc php5-pdo_mysql \
    php5-pdo_sqlite php5-gettext php5-xmlreader php5-xmlrpc php5-bz2 \
    php5-memcache php5-mssql php5-iconv php5-pdo_dblib php5-curl php5-ctype \
    nginx curl bash

RUN echo "$(echo 'pid /run/nginx.pid;' | cat - /etc/nginx/nginx.conf)" > /etc/nginx/nginx.conf

RUN mkdir /app

RUN rm -rf /etc/nginx/conf.d/

COPY simabes.conf /etc/nginx/conf.d/

COPY simabes /app

RUN echo -e '[Date]\ndate.timezone="Asia/Jakarta"' >> /etc/php5/php.ini

COPY start.sh /

RUN chmod +x /start.sh

EXPOSE 80

ENTRYPOINT ["/start.sh"]
