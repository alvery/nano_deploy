# Nano service deployment

1. Склонировать текущий репозиторий и репозиторий самого сервиса: https://github.com/alvery/nano_service
2. Скопировать `.env.example -> .env`
3. Указать базовый домен BASE_DOMAIN и прописать его в /etc/hosts
4. Указать папку с проектом сервиса SERVICE_DIR_NANO
5. Теперь можно стартовать: `docker-compose up -d`

## Настройка сервиса (nano_service)

1. В папке с проектом скопировать `.env.example -> .env`
2. Запустить из контейнера service_nano:

```
$ docker exec -ti service_nano /bin/sh -c "./bin/init.sh"
```
