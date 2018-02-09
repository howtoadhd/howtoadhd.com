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
