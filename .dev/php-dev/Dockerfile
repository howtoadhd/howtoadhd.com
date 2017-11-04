FROM howtoadhd/howtoadhd.com:php

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            php7-xdebug \
    && rm -f /etc/php7/conf.d/xdebug.ini

COPY ./php-custom.ini /etc/php7/conf.d/99-custom.ini
