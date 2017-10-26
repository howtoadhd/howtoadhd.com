#!/bin/sh

if [ ! -f /ca/dev.key ]; then
    rm -rf \
        /ca/dev.key \
        /ca/dev.csr \
        /ca/dev.crt \
        /ca/dev.pem

    openssl genrsa \
        -out /ca/dev.key \
        2048
fi

if [ ! -f /ca/dev.csr ]; then
    rm -rf \
        /ca/dev.csr \
        /ca/dev.crt \
        /ca/dev.pem

    openssl req \
        -new \
        -nodes \
        -key /ca/dev.key \
        -out /ca/dev.csr \
        -config /openssl.cnf
fi

if [ ! -f /ca/dev.crt ]; then
    rm -rf \
        /ca/dev.crt \
        /ca/dev.pem

    openssl x509 \
        -req \
        -days 3650 \
        -in /ca/dev.csr \
        -signkey /ca/dev.key \
        -out /ca/dev.crt \
        -extensions v3_req \
        -extfile /openssl.cnf
fi

if [ ! -f /ca/dev.pem ]; then
    rm -rf /ca/dev.pem

    cat /ca/dev.crt /ca/dev.key > /ca/dev.pem
fi
