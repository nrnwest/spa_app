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
test:
	${DOCKER_COMPOSE} exec -u www-data php-fpm php bin/phpunit
jwt:
	${DOCKER_COMPOSE} exec -u www-data php-fpm php bin/console lexik:jwt:generate-keypair
cache:
	docker-compose -f ./_docker/docker-compose.yml exec -u www-data php-fpm bin/console cache:clear
	docker-compose -f ./_docker/docker-compose.yml exec -u www-data php-fpm bin/console cache:clear --env=test
nodejs:
	${DOCKER_COMPOSE} exec -u www-data php-fpm curl -sL https://deb.nodesource.com/setup_18.x | bash

##################
# Database
##################

db_migrate:
	${DOCKER_COMPOSE} exec -u www-data php-fpm bin/console doctrine:migrations:migrate --no-interaction
db_diff:
	${DOCKER_COMPOSE} exec -u www-data php-fpm bin/console doctrine:migrations:diff --no-interaction
db_drop:
	docker-compose -f ./_docker/docker-compose.yml exec -u www-data php-fpm bin/console doctrine:schema:drop --force


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