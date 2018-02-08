default: dev

dev: pull-dev build run

pull:
	docker pull howtoadhd/base-images:latest-php-cli
	docker pull howtoadhd/base-images:latest-php-fpm
	docker pull howtoadhd/base-images:latest-nginx

pull-dev:
	docker pull howtoadhd/base-images:latest-php-cli-dev
	docker tag howtoadhd/base-images:latest-php-cli-dev howtoadhd/base-images:latest-php-cli

	docker pull howtoadhd/base-images:latest-php-fpm-dev
	docker tag howtoadhd/base-images:latest-php-fpm-dev howtoadhd/base-images:latest-php-fpm

	docker pull howtoadhd/base-images:latest-nginx
	docker pull howtoadhd/dev-services:latest

build:
	docker build --no-cache -t howtoadhd/howtoadhd.com:app .
	docker build --no-cache -t howtoadhd/howtoadhd.com:php .docker/php
	docker build --no-cache -t howtoadhd/howtoadhd.com:nginx .docker/nginx
	docker build --no-cache -t howtoadhd/howtoadhd.com:queue .docker/queue

run:
	composer install \
		--no-ansi \
		--dev \
		--no-interaction \
		--no-progress

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
