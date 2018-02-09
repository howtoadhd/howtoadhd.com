FROM builder:app
# This exists to allow copying between images

RUN rm -rf /app/cavalcade

FROM howtoadhd/base-images:latest-php-fpm

COPY --from=0 /app /app

RUN chmod +x bin/fix-permissions \
    && ./bin/fix-permissions
