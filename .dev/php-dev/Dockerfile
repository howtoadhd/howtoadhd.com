FROM howtoadhd/howtoadhd.com:php

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
            php7-xdebug \
    && rm -f /etc/php7/conf.d/xdebug.ini \
    && { \
            echo '[xdebug]'; \
            echo 'zend_extension=xdebug.so'; \
            echo 'xdebug.remote_enable=on'; \
            echo 'xdebug.remote_autostart=on'; \
            echo 'xdebug.remote_connect_back=off'; \
            echo 'xdebug.remote_handler=dbgp'; \
            echo 'xdebug.profiler_enable=0'; \
            echo 'xdebug.profiler_output_dir="/var/www"'; \
            echo 'xdebug.remote_port=9000'; \
        } > /etc/php7/conf.d/xdebug.ini
