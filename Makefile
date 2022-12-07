##################
# Variables
##################

DOCKER_COMPOSE = docker-compose -f ./_docker/docker-compose.yml --env-file ./_docker/.env
DOCKER_COMPOSE_EXEC = exec -u www-data php-fpm

PRINT_SEPARATOR = "\n\n"
PRINT_WELCOME = Welcome: http://localhost:8888
PRINT_PHPMYADMIN = phpMyAdmin: http://localhost:4444

##################
# Docker compose
##################

build:
	${DOCKER_COMPOSE} build

start:
	${DOCKER_COMPOSE} start

stop:
	${DOCKER_COMPOSE} stop

up:
	${DOCKER_COMPOSE} up -d --remove-orphans

ps:
	${DOCKER_COMPOSE} ps

logs:
	${DOCKER_COMPOSE} logs -f

down:
	${DOCKER_COMPOSE} down -v --rmi=all --remove-orphans

restart:
	make dc_stop dc_start


##################
# App здесь после php-fpm нужно указать php
##################

php:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_EXEC} bash

#################
# Test
#################

# all tests
test:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_EXEC} php vendor/bin/phpunit

# Unit test
test_u:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_EXEC} php vendor/bin/phpunit ./tests/Unit

composer:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_EXEC} composer install


#################
# NodeJs npm
#################
npm:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_EXEC}  npm install
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_EXEC}  npm run build

npmd:
	npm run dev

# Installing the local version to be developed once on a laconic machine
npm_local:
	sudo curl -s https://deb.nodesource.com/setup_16.x | sudo bash
	sudo apt-get install -y nodejs
	sudo npm install -g npm@9.1.3

##################
# Database
##################

db_migrate:
	${DOCKER_COMPOSE} ${DOCKER_COMPOSE_EXEC} php artisan migrate

#################
#  Deployment
#################
dep:
	make build up composer npm pause10 db_migrate print

#################
# pause
#################

pause10:
	sleep 10

print:
	@echo ${PRINT_SEPARATOR}
	@echo ${PRINT_WELCOME}
	@echo ${PRINT_PHPMYADMIN}
	@echo ${PRINT_SEPARATOR}
