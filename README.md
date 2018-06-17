# Nano service deployment


## Настройка deployment

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

3. Проверить что воркеры запущены (если нет, то стартануть):

```
$ docker exec -ti service_nano /bin/sh -c "supervisorctl status"
$ docker exec -ti service_nano /bin/sh -c "supervisorctl start queue:*"
```

## Примеры API запросов

Все запросы и обработка сообщений логируются: `tail -f ./storage/logs/laravel.log`

##### Отправка одного сообщения
`POST`  http://app.local/api/send-message

```
curl -X POST \
  http://app.local/api/send-message \
  -H 'Accept: application/json' \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
	"type": 1,
	"message": "Hello kitty",
	"delay": 0
}'
```



##### Отправка нескольких сообщений
`POST`  http://app.local/api/send-message-multiple

```
curl -X POST \
  http://app.local/api/send-message-multiple \
  -H 'Accept: application/json' \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
	"data":
	[
		{
			"type": 1,
			"message": "Hello kitty 1",
			"delay": 10
		},
		{
			"type": 2,
			"message": "Hello kitty 2"
		},
		{
			"type": 3,
			"message": "Hello kitty 3",
			"delay": 0
		}
	]

}'
```

| Поле | Тип | Описание |
| ------ | ------ | ------ |
| type | integer | 1 - Telegram; 2 - Viber; 3 - WhatsApp |
| message | string | текст сообщения |
| delay | integer | задержка отправки в секундах; 0 - отправить без задержки; если не указано - будет использована отправка по расписанию |
