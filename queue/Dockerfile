FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM loreleiaurora/php-base:cli

WORKDIR /var/www

COPY --from=0 /var/www /var/www

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            php7-pcntl \
\
    && adduser cavalcade -S \
    && composer create-project \
            --stability=dev \
            --prefer-dist \
            --no-dev \
            humanmade/cavalcade-runner \
            /opt/cavalcade \
            dev-master \
    && ln -s /opt/cavalcade/bin/cavalcade /usr/bin/cavalcade

USER cavalcade

COPY ./start-container.sh /start-container

CMD ["/start-container"]
