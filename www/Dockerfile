FROM howtoadhd/base-images:latest-php-cli

USER root

ENV WP_CLI_URL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

ENV COMPOSER_URL https://getcomposer.org/composer.phar
ENV COMPOSER_ALLOW_SUPERUSER 1

COPY . /app/www


RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
		curl \
		git \
	&& curl -L -o /usr/bin/wp "${WP_CLI_URL}" \
    && chmod +x /usr/bin/wp \
	&& curl -L -o /usr/bin/composer "${COMPOSER_URL}" \
    && chmod +x /usr/bin/composer \
    && chown -R app:app /app \
    && chmod -R +rw /app

USER app

RUN cd /app/www \
    && composer install \
        --no-ansi \
        --no-dev \
        --no-interaction \
        --no-progress \
        --no-scripts
