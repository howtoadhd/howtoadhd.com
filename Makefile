SHELL := /bin/bash
DOCKER := make -C .docker
.DEFAULT_GOAL := help

help: ## Print this message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

##################################    Development Environment    ##################################

dev: build start # Build & start the development environment

build: ## Build the development endironment
	$(DOCKER) common dev

	composer install \
    		--no-ansi \
    		--dev \
    		--no-interaction \
    		--no-progress

start: ## Start the development environment
	cd .dev; \
	docker-compose \
		--project-name howtoadhd \
		up \
		--remove-orphans \
		--force-recreate

stop: ## Stop the development environment
	cd .dev; \
	docker-compose \
		--project-name howtoadhd \
		down \
		--remove-orphans





#########################################    Travis CI    #########################################

TRAVIS_COMMIT?='local'
TEMP_IMAGE_REPO?='howtoadhd/travis-dump'
TEMP_IMAGE_TAG_BASE?='howtoadhd_howtoadhd.com'

TEMP_IMAGE_BASE="${TEMP_IMAGE_REPO}:${TEMP_IMAGE_TAG_BASE}__${TRAVIS_COMMIT}"

############################################    App    ############################################

export TEMP_IMAGE_APP="${TEMP_IMAGE_BASE}__app"

travis-app-before_script:
	$(DOCKER) app-pull-base

travis-app-script:
	$(DOCKER) app-build

travis-app-after_success:
	docker tag builder:app ${TEMP_IMAGE_APP}
	docker push ${TEMP_IMAGE_APP}

_travis-app-pull:
	docker pull ${TEMP_IMAGE_APP}
	docker tag ${TEMP_IMAGE_APP} builder:app

###########################################    Nginx    ###########################################

export TEMP_IMAGE_NGINX="${TEMP_IMAGE_BASE}__nginx"

travis-nginx-before_script: _travis-app-pull
	$(DOCKER) nginx-pull-base

travis-nginx-script:
	$(DOCKER) nginx-build

travis-nginx-after_success:
	docker tag builder:nginx ${TEMP_IMAGE_NGINX}
	docker push ${TEMP_IMAGE_NGINX}

_travis-nginx-pull:
	docker pull ${TEMP_IMAGE_NGINX}
	docker tag ${TEMP_IMAGE_NGINX} builder:nginx

############################################    PHP    ############################################

export TEMP_IMAGE_PHP="${TEMP_IMAGE_BASE}__php"

travis-php-before_script: _travis-app-pull
	$(DOCKER) php-pull-base

travis-php-script:
	$(DOCKER) php-build

travis-php-after_success:
	docker tag builder:php ${TEMP_IMAGE_PHP}
	docker push ${TEMP_IMAGE_PHP}

_travis-php-pull:
	docker pull ${TEMP_IMAGE_PHP}
	docker tag ${TEMP_IMAGE_PHP} builder:php

##########################################    PHP Dev    ##########################################

export TEMP_IMAGE_PHP_DEV="${TEMP_IMAGE_BASE}__php-dev"

travis-php-dev-before_script: _travis-app-pull
	$(DOCKER) php-dev-pull-base

travis-php-dev-script:
	$(DOCKER) php-dev-build

travis-php-dev-after_success:
	docker tag builder:php-dev ${TEMP_IMAGE_PHP_DEV}
	docker push ${TEMP_IMAGE_PHP_DEV}

_travis-php-dev-pull:
	docker pull ${TEMP_IMAGE_PHP_DEV}
	docker tag ${TEMP_IMAGE_PHP_DEV} builder:php-dev

###########################################    Queue    ###########################################

export TEMP_IMAGE_QUEUE="${TEMP_IMAGE_BASE}__queue"

travis-queue-before_script: _travis-app-pull
	$(DOCKER) queue-pull-base

travis-queue-script:
	$(DOCKER) queue-build

travis-queue-after_success:
	docker tag builder:queue ${TEMP_IMAGE_QUEUE}
	docker push ${TEMP_IMAGE_QUEUE}

_travis-queue-pull:
	docker pull ${TEMP_IMAGE_QUEUE}
	docker tag ${TEMP_IMAGE_QUEUE} builder:queue

#########################################    Queue Dev    #########################################

export TEMP_IMAGE_QUEUE_DEV="${TEMP_IMAGE_BASE}__queue-dev"

travis-queue-dev-before_script: _travis-app-pull
	$(DOCKER) queue-dev-pull-base

travis-queue-dev-script:
	$(DOCKER) queue-dev-build

travis-queue-dev-after_success:
	docker tag builder:queue-dev ${TEMP_IMAGE_QUEUE_DEV}
	docker push ${TEMP_IMAGE_QUEUE_DEV}

_travis-queue-dev-pull:
	docker pull ${TEMP_IMAGE_QUEUE_DEV}
	docker tag ${TEMP_IMAGE_QUEUE_DEV} builder:queue-dev

##########################################    Promote    ##########################################

travis-promote-before_script: _travis-${SERVICE}-pull

travis-promote-script:
	if [ $$TRAVIS_PULL_REQUEST == 'false' ]; then \
		docker tag builder:${SERVICE} howtoadhd/howtoadhd.com:$${TRAVIS_BRANCH//\//__}-${SERVICE}; \
		docker push howtoadhd/howtoadhd.com:$${TRAVIS_BRANCH//\//__}-${SERVICE}; \
	fi
	if [ $$TRAVIS_PULL_REQUEST == 'false' ] && [ $$TRAVIS_BRANCH == 'master' ]; then \
		docker tag builder:${SERVICE} howtoadhd/howtoadhd.com:latest-${SERVICE}; \
		docker push howtoadhd/howtoadhd.com:latest-${SERVICE}; \
	fi
