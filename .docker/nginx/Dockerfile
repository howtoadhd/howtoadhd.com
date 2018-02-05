FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM howtoadhd/base-images:latest-nginx

COPY ./fs /

COPY --from=0 /app /app

RUN rm -rf /app/www \
	&& chown -R app:app /app \
	&& find /app -type d -exec chmod 550 {} \; \
    && find /app -type f -exec chmod 440 {} \;
