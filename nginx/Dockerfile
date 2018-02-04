FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM howtoadhd/nginx-base:latest

COPY --from=0 /app/www /app/www

RUN chown -R root:app /app/www /etc/nginx/html \
    && find /app/www -type d -exec chmod 550 {} \; \
    && find /app/www -type f -exec chmod 440 {} \; \
    && find /etc/nginx/ -type f -exec sed -i -e "s#/var/www#/app/www#" {} \; \
    && find /etc/nginx/html -type d -exec chmod 550 {} \; \
    && find /etc/nginx/html -type f -exec chmod 440 {} \;
