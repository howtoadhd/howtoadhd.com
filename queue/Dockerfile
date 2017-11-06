FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM loreleiaurora/php-base:cli

WORKDIR /var/www

COPY --from=0 /var/www /var/www

RUN addgroup -S app \
    && adduser -D -S -s /sbin/nologin -G app app \
    && chown -R root:app /var/www \
    && find /var/www -type d -exec chmod 550 {} \; \
    && find /var/www -type f -exec chmod 440 {} \; \
\
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            php7-pcntl \
\
    && composer create-project \
            --stability=dev \
            --prefer-dist \
            --no-dev \
            humanmade/cavalcade-runner \
            /opt/cavalcade \
            dev-master \
    && ln -s /opt/cavalcade/bin/cavalcade /usr/bin/cavalcade

USER app

COPY ./start-container.sh /start-container

CMD ["/start-container"]
