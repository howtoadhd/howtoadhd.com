FROM howtoadhd/php-base:latest-cli

ENV COMPOSER_URL https://getcomposer.org/download/1.5.1/composer.phar
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -L -o /usr/bin/composer "${COMPOSER_URL}" \
    && chmod +x /usr/bin/composer

COPY . /app/www

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            git

RUN cd /app/www \
    && composer install \
        --no-ansi \
        --no-dev \
        --no-interaction \
        --no-progress \
        --no-scripts
