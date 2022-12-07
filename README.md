### SPA Application Laravel+Vue
Simple spa application, releases crud

The project needs to be pinked on a Linux or Windows (wsl2 Unbuntu 20.04) platform.
Docker, make must be installed
## Deployment

```bash
git clone https://github.com/nrnwest/spa_app.git
```

Rename the two files,
and add your settings if needed, the default settings don't need to be changed.

1. _docker/.env.dist to .env
2. .env.dist to .env

```bash
make dep
````
### Website
<http://localhost:8888>

### phpMyAdmin
user root
password root
<http://localhost:4444>

###  Installing the local version to be developed once on a laconic machine
```bash 
make npm_local
```
