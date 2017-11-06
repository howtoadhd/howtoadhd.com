FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM loreleiaurora/php-base:fpm

WORKDIR /var/www

RUN addgroup -S app \
    && adduser -D -S -s /sbin/nologin -G app app

COPY --from=0 /var/www /var/www

COPY ./start-container.sh /start-container

COPY www.ini /etc/php7/php-fpm.d/www.conf

CMD ["/start-container"]
