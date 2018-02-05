FROM howtoadhd/howtoadhd.com:app

USER root

RUN chown -R app:app /app \
    && chmod -R +rw /app

FROM howtoadhd/base-images:latest-php-cli

USER root

COPY --from=0 /app /app
COPY --from=0 /usr/bin/wp /usr/bin/wp

RUN chmod +x /usr/bin/wp \
	&& chown -R app:app /app \
	&& chmod 550 /app \
    && find /app -type d -exec chmod 550 {} \; \
    && find /app -type f -exec chmod 440 {} \; \
    && chmod 550 \
    	/app/cavalcade/bin/cavalcade \
    	/app/cavalcade/vendor/bin/cavalcade

USER app

CMD ["/app/cavalcade/bin/cavalcade"]
