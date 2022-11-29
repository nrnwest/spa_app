##################
# Variables
##################

DOCKER_COMPOSE = docker-compose -f ./_docker/docker-compose.yml --env-file ./_docker/.env
DOCKER_COMPOSE_PHP_FPM_EXEC = ${DOCKER_COMPOSE} exec -u www-data php-fpm

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
	${DOCKER_COMPOSE} exec -u www-data php-fpm bash

# all tests
test:
	${DOCKER_COMPOSE} exec -u www-data php-fpm php vendor/bin/phpunit

# Unit test
test_u:
	${DOCKER_COMPOSE} exec -u www-data php-fpm php vendor/bin/phpunit ./tests/Unit

node:
	${DOCKER_COMPOSE} exec -u www-data php-fpm curl -sL https://deb.nodesource.com/setup_18.x | bash

composer:
	${DOCKER_COMPOSE} exec -u www-data php-fpm composer install

npm:
	${DOCKER_COMPOSE} exec -u www-data php-fpm npm install
	${DOCKER_COMPOSE} exec -u www-data php-fpm npm run build

##################
# Database
##################

db_migrate:
	${DOCKER_COMPOSE_PHP_FPM_EXEC} php artisan migrate

##################
# Static code analysis
##################

phpstan:
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/phpstan analyse src tests -c phpstan.neon

deptrac:
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/deptrac analyze deptrac-layers.yaml
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/deptrac analyze deptrac-modules.yaml

cs_fix:
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/php-cs-fixer fix

cs_fix_diff:
	${DOCKER_COMPOSE_PHP_FPM_EXEC} vendor/bin/php-cs-fixer fix --dry-run --diff

#################
#  Deployment
#################
dep:
	make build pause5 up pause4 composer npm pause60 db_migrate

#################
# pause
#################

pause60:
	sleep 60

pause5:
	sleep 5

pause4:
	sleep 4
