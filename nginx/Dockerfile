FROM howtoadhd/howtoadhd:app
# This exists to allow copying between images

FROM nginx:mainline-alpine

COPY --from=0 /var/www /var/www

COPY server.nginx /etc/nginx/conf.d/default.conf

COPY ./start-container.sh /start-container

CMD ["/start-container"]