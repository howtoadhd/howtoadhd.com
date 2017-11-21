FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM howtoadhd/php-base:latest-fpm

COPY --from=0 /var/www /var/www

RUN chown -R root:app /var/www \
    && find /var/www -type d -exec chmod 550 {} \; \
    && find /var/www -type f -exec chmod 440 {} \;

COPY ./start-container.sh /start-container

CMD ["/start-container"]
