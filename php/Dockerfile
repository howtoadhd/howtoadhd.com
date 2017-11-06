FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM loreleiaurora/php-base:fpm

WORKDIR /var/www

COPY --from=0 /var/www /var/www

COPY ./start-container.sh /start-container

CMD ["/start-container"]
