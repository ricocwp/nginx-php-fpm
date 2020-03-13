FROM alpine:latest
LABEL Maintainer="Tim de Pater <code@trafex.nl>" \
      Description="Lightweight container with Nginx 1.16 & PHP-FPM 7.3 based on Alpine Linux."

# Install packages
RUN apk --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session \
    php7-mbstring php7-gd nginx curl bash

RUN echo "$(echo 'pid /run/nginx.pid;' | cat - /etc/nginx/nginx.conf)" > /etc/nginx/nginx.conf

RUN mkdir /app

RUN rm /etc/nginx/conf.d/default.conf

COPY simabes.conf /etc/nginx/conf.d/

COPY simabes /app

RUN echo -e '[Date]\ndate.timezone="Asia/Jakarta"' > /etc/php7/php.ini

COPY start.sh /

RUN chmod +x /start.sh

EXPOSE 80

ENTRYPOINT ["/start.sh"]
