FROM node:latest

RUN wget -O aws-ses-local.zip https://github.com/camjackson/aws-ses-local/archive/allow-text-or-html.tar.gz \
        && tar -xvzf aws-ses-local.zip \
        && rm -f aws-ses-local.zip \
        && mv aws-ses-local-allow-text-or-html aws-ses-local \
        && cd aws-ses-local\
        && npm install \
        && npm run-script prepublish

WORKDIR /aws-ses-local

CMD [ "node", "build/server.js", "--port", "4568", "--outputDir", "/sesmock_root" ]
