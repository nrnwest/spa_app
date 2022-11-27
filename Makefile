####
# Docker
####
dc_build:
		docker-compose up -d --build

dc_down:
		docker-compose down --volumes

dc_chmod:
		docker-compose exec app chown -R www-data:www-data /application/public /application/storage


##################
# App
##################

app_bash:
		docker exec -it dzen_app bash


