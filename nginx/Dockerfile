FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM nginx:mainline-alpine

WORKDIR /var/www

COPY --from=0 /var/www /var/www

RUN addgroup -S app \
    && adduser -D -S -s /sbin/nologin -G app app \
    && chown -R root:app /var/www \
    && find /var/www -type d -exec chmod 550 {} \; \
    && find /var/www -type f -exec chmod 440 {} \;

COPY conf.nginx /etc/nginx/nginx.conf
COPY server.nginx /etc/nginx/conf.d/default.conf

COPY ./start-container.sh /start-container

CMD ["/start-container"]
