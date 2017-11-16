FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM howtoadhd/nginx-base:latest

COPY --from=0 /var/www /var/www

RUN chown -R root:app /var/www /etc/nginx/html \
    && find /var/www -type d -exec chmod 550 {} \; \
    && find /var/www -type f -exec chmod 440 {} \; \
    && find /etc/nginx/html -type d -exec chmod 550 {} \; \
    && find /etc/nginx/html -type f -exec chmod 440 {} \;
