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

export TEMP_IMAGE_PHP_BASE="${TEMP_IMAGE_BASE}__app"

travis-app-before_script:
	$(DOCKER) app-pull-base

travis-app-script:
	$(DOCKER) app-build

travis-app-after_success:
	docker tag builder:app ${TEMP_IMAGE_PHP_BASE}
	docker push ${TEMP_IMAGE_PHP_BASE}
