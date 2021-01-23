FROM composer as build
WORKDIR /app
COPY . /app
RUN composer install -a

FROM php:7.4-apache
EXPOSE 80
COPY --from=build /app /app
#Copia a configuração do Apache
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

RUN chown -R www-data:www-data /app
RUN chgrp -R www-data /var/www/html
RUN find /var/www/html -type d -exec chmod g+rx {} +
RUN find /var/www/html -type f -exec chmod g+r {} +



#docker build -t laravel-kubernetes-demo .
#docker run -ti -p 8080:80 -e APP_KEY=base64:cUPmwHx4LXa4Z25HhzFiWCf7TlQmSqnt98pnuiHmzgY= laravel-kubernetes-demo
#az webapp create --resource-group testeLaravel --plan ASP-testeLaravel-b816 --name teste-azure-app --multicontainer-config-type compose --multicontainer-config-file docker-compose.yml
