# Inspired by Makefile example from Kévin Dunglas: https://github.com/dunglas/symfony-docker/blob/main/docs/makefile.md

# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
DRUPAL_CONT = $(DOCKER_COMP) exec drupal

# Executables
PHP      = $(DRUPAL_CONT) php
COMPOSER = $(DRUPAL_CONT) composer
SYMFONY  = $(DRUPAL_CONT) bin/console
DRUPAL   = $(DRUPAL_CONT) php web/core/scripts/drupal

# Environment variables
include .env

# Misc
.DEFAULT_GOAL = help
.PHONY        : help build up start down logs sh composer vendor sf cc

## —— 🎵 🐳 The Symfony Docker Makefile 🐳 🎵 ——————————————————————————————————
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Docker 🐳 ————————————————————————————————————————————————————————————————
build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull --no-cache

build-fast: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up --detach

start: build up ## Build and start the containers

ps: ## Show containers
	@$(DOCKER_COMP) ps

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=0 --follow

sh: ## Connect to the PHP FPM container
	@$(DRUPAL_CONT) sh

## —— Composer 🧙 ——————————————————————————————————————————————————————————————
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --prefer-dist --no-dev --no-progress --no-scripts --no-interaction
vendor: composer

## —— Symfony 🎵 ———————————————————————————————————————————————————————————————
sf: ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
	@$(eval c ?=)
	@$(SYMFONY) $(c)

cc: c=c:c ## Clear the cache
cc: sf

## —— Drupal ——————————————————————————————————————————————————————————————————
## The parameter "p=" to run a given command, example: make drupal-generate-theme p=my_new_theme
drupal-generate-theme:
	@$(eval p ?=)
	@$(DRUPAL) generate-theme $(p)