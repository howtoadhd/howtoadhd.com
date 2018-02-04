FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM howtoadhd/cavalcade-runner:latest

COPY ./fs /

COPY --from=0 /app/www /app/www

RUN chown -R root:app /app/www \
    && find /app/www -type d -exec chmod 550 {} \; \
    && find /app/www -type f -exec chmod 440 {} \;

USER app
