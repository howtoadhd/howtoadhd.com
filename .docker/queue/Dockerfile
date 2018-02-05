FROM howtoadhd/howtoadhd.com:app
# This exists to allow copying between images

FROM howtoadhd/base-images:latest-php-cli

USER root

COPY --from=0 /app /app
COPY --from=0 /usr/bin/wp /usr/bin/wp

RUN chmod +x bin/fix-permissions \
    && ./bin/fix-permissions

USER app

CMD ["/app/cavalcade/bin/cavalcade"]
