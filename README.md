# api_yamdb (Dockered)

Расширяемая база рецензий и отзывов. Предоставляет доступ через web-интерфейс и c использованием REST API. Подготовлена для запуска в контейнере.

### Деплой

Автоматически выполняется деплой на сервер в облаке Яндекса.

Статус: ![YamDB](https://github.com/offlinexaa/yamdb_final/actions/workflows/yamdb_workflow.yml/badge.svg)

### Как запустить проект:

Клонировать репозиторий и перейти в него в командной строке:

```
git clone https://github.com/Offlinexaa/infra_sp2.git
```

```
cd infra_sp2/
```

Заполнить файл infra/.env (пример заполнения ниже). Для примера используется редактор nano:

```
nano infra/.env
```

Добавить пользователя в группу docker или предоставить права суперпользователя.

```
usermod -a -G docker <current_user_name>
systemctl reload docker.service
```

Запустить проект:

```
sh up.sh
```

Будет выполнена проверка на отсутствие незаполненных переменных в .env. После проверки вам будет предложена возможность импортировать демонстрационный образец данных. После запуска контейнеров так же будет предложено создать учётную запись суперпользователя Django.

В демонстрационных данных имеется преднастроенный пользователь с парой логин/пароль: admin/admin

Проект доступен по ссылке:

```
http://localhost/ или http://<your_external_ip>/
```

### Импорт данных вручную

Для импорта демонстрационных данных воспользуйтесь командой

```
docker-compose -f infra/docker-compose.yaml exec web python3 manage.py loaddata fixtures.json
```

### Создание суперпользователя вручную

Для создания суперпользователя вручную воспользуйтесь командой

```
docker-compose -f infra/docker-compose.yaml exec web python3 manage.py createsuperuser
```

### Требования и пример заполнения файла .env

Файл .env должен содержать следующие переменные:

```
DB_ENGINE - драйвер СУБД для Django
DB_NAME - имя базы данных для api_yamdb
POSTGRES_USER - имя пользователя, владельца базы данных или администратора СУБД
POSTGRES_PASSWORD - пароль пользователя из предыдущего пункта
BD_HOST - имя хоста (docker-контейнера)
DB_PORT - порт для подключения к базе данных
```

Пример заполнения значениями по умолчанию:

```
DB_ENGINE=django.db.backends.postgresql
DB_NAME=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
BD_HOST=db
DB_PORT=5432
```

### Документация доступна по ссылке:

```
http://localhost/redoc/
```

### Требования:

Docker 20.10.14

docker-compose 1.25.0

### Над проектом api_yamdb работали:

Александр Харин (Offlinexaa) - реализация моделей, логики и api: токены, авторизация и пользователи 

Максим Борис (maksim5652) - реализация моделей, логики и api: категории, жанры и произведения.

Отахонов Хайрулло (OtakhonovKh) - реализация моделей, логики и api: отзывы и комментарии.
