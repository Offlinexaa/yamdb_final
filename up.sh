#!/bin/bash

echo ' == Check .env file is valid == '
if grep -q '.*=$' "infra/.env"
then
    echo '.env file is invalid. Please check lines:'
    grep '.*=$' "infra/.env"
    echo 'For example of .env see README.md file.'
    exit 0
fi
echo '.env validated succesfully'

read -p 'Import sample data? [y/n] (n): ' y

echo ' == Creating containers == '
docker-compose -f infra/docker-compose.yaml up -d

echo ' == Make and apply migrations == '
docker-compose -f infra/docker-compose.yaml exec web python manage.py makemigrations
docker-compose -f infra/docker-compose.yaml exec web python manage.py migrate

echo ' == Collecting static data == '
docker-compose -f infra/docker-compose.yaml exec web python manage.py collectstatic --noinput

if [ $y = 'y' ] || [ $y = 'yes' ] || [ $y = 'Y' ] || [ $y = 'Yes' ] || [ $y = 'YES' ]
then
    echo ' == Importing sample data == '
    docker-compose -f infra/docker-compose.yaml exec web python3 manage.py loaddata fixtures.json
fi

read -p 'Create super user? [y/n] (n): ' s
if [ $s = 'y' ] || [ $s = 'yes' ] || [ $s = 'Y' ] || [ $s = 'Yes' ] || [ $s = 'YES' ]
then
    echo ' == Creating super user == '
    docker-compose -f infra/docker-compose.yaml exec web python3 manage.py createsuperuser
fi

echo ' == Project api_yamdb up an running =='
echo 'Now admin site acessible at http://localhost/admin'
