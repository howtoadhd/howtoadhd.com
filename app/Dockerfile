FROM loreleiaurora/php-base:cli

COPY . /var/www

RUN cd /var/www \
    && composer install \
        --no-ansi \
        --no-dev \
        --no-interaction \
        --no-progress \
        --no-scripts
