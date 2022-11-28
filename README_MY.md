Установка ларевель Vue:
1.  composer create-project laravel/laravel base
потом переносим все с app на уровень выше. app/../

2. Для розработки устанвливаем nodejs на линух вне контера изменения будут видны сразу
   Установка nodejs
   sudo curl -s https://deb.nodesource.com/setup_18.x | sudo bash
   sudo apt-get install -y nodejs
   sudo npm install
   npm run dev
   Запустив это в конселе унбунту и изменяя файлы сразу результат будет видет
   они build сразу автоматом в контейнере нет.



2. Установка nodejs в контейнере:
   apt-get update
   curl -sL https://deb.nodesource.com/setup_18.x | bash
    apt-get install -y nodejs
   (Кода проект выкачан с гита тоесть создан то только запускеам две команды)
    npm install  
    npm run build
5. После запуска dev вискочила ошибка обновляем пакет: npm install -g npm@9.1.2
   И потом выполняем внеся измения в шаблоны vue мы должны запустить команду
   npm run build
в контейнере выполняем (а,б,с нужно в любому случа выполнять):
а) composer require laravel/breeze --dev
б) php artisan breeze:install vue
с) php artisan migrate
Проверяем сайт, все должно работать, и все работает в контейнере
[localhost:4000](http://localhost:4000)

