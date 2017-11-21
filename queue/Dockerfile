FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM howtoadhd/cavalcare-runner:latest

COPY --from=0 /var/www /var/www

RUN chown -R root:app /var/www \
    && find /var/www -type d -exec chmod 550 {} \; \
    && find /var/www -type f -exec chmod 440 {} \;

USER app
