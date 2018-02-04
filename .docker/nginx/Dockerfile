FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM howtoadhd/base-images:latest-nginx

COPY ./fs /

COPY --from=0 /app /app

RUN rm -f /app/www/index.html \
	&& chown -R app:app /app \
	&& chmod 550 /app \
    && find /app/www -type d -exec chmod 550 {} \; \
    && find /app/www -type f -exec chmod 440 {} \;
