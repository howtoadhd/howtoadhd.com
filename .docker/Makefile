SHELL := /bin/bash
.DEFAULT_GOAL:= help

help: ## Print this message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all:  common dev prod ## Run all builds and tests.

common: app nginx

dev: php-dev queue-dev
prod: php queue


############################################    App    ############################################

app: app-pull-base app-build

app-pull-base:
	$(call pull_image,app-builder)

app-build:
	docker build --no-cache -t "builder:app" ../


###########################################    Nginx    ###########################################

nginx: nginx-pull-base nginx-build

nginx-pull-base:
	$(call pull_image,nginx)

nginx-build:
	$(call build_image,nginx)


############################################    PHP    ############################################

php: php-pull-base php-build

php-pull-base:
	$(call pull_image,php-fpm)

php-build:
	$(call build_image,php)


##########################################    PHP Dev    ##########################################

php-dev: php-dev-pull-base php-dev-build

php-dev-pull-base:
	$(call pull_image,php-fpm-dev)

php-dev-build:
	$(call build_image_dev,php,php-fpm)


###########################################    Queue    ###########################################

queue: queue-pull-base queue-build

queue-pull-base:
	$(call pull_image,php-cli)

queue-build:
	$(call build_image,queue)


#########################################    Queue Dev    #########################################

queue-dev: queue-dev-pull-base queue-dev-build

queue-dev-pull-base:
	$(call pull_image,php-cli)

queue-dev-build:
	$(call build_image_dev,queue,php-cli)





##########################################   Functions   ##########################################

NOW=$(shell date +'%s')

define pull_image
	docker pull howtoadhd/base-images:latest-${1}
endef

define build_image
	docker build --no-cache -t "builder:${1}" "${1}"
endef

define build_image_dev
	cd ${1}; \
	sed -e "s/latest-${2}/latest-${2}-dev/" ./Dockerfile | \
	docker build --no-cache -t "builder:${1}-dev" -f- .
endef
