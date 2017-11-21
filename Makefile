default: dev

dev: pull build-dev run

pull:
	docker pull howtoadhd/php-base:latest-cli
	docker pull howtoadhd/php-base:latest-fpm
	docker pull howtoadhd/nginx-base:latest
	docker pull howtoadhd/cavalcare-runner:latest

build:
	docker build --no-cache -t howtoadhd/howtoadhd.com:app app
	docker build --no-cache -t howtoadhd/howtoadhd.com:php php
	docker build --no-cache -t howtoadhd/howtoadhd.com:nginx nginx
	docker build --no-cache -t howtoadhd/howtoadhd.com:queue queue

build-dev: build
	docker build --no-cache -t howtoadhd/howtoadhd.com:php-dev .dev/php-dev

run:
	cd app; \
    ../bin/composer install \
		--no-ansi \
		--dev \
		--no-interaction \
		--no-progress \
		--no-scripts

	cd .dev; \
	docker-compose \
		--project-name howtoadhd \
		up \
		--remove-orphans \
		--force-recreate

stop:
	cd .dev; \
	docker-compose \
		--project-name howtoadhd \
		down \
		--remove-orphans

travis-deploy:
	docker push howtoadhd/howtoadhd.com:php
	docker push howtoadhd/howtoadhd.com:nginx
	docker push howtoadhd/howtoadhd.com:queue
