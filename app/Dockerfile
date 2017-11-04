FROM loreleiaurora/php-base:cli

COPY . /var/www

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            git

RUN cd /var/www \
    && composer install \
        --no-ansi \
        --no-dev \
        --no-interaction \
        --no-progress \
        --no-scripts
