FROM alpine

# copy needed scripts to containers
ADD .docker /docker
RUN chmod -R +x /docker

# installations
RUN /docker/installations/prepare.sh
RUN /docker/installations/basic.sh
RUN /docker/installations/apache.sh
RUN /docker/installations/php.sh
RUN /docker/installations/redis.sh
RUN /docker/installations/cleanup.sh

# expose ports
EXPOSE 80

WORKDIR /app
ADD . /app
RUN composer install --no-dev --no-interaction \
    && chown -R apache:apache .

# run bootstrap/start
ENTRYPOINT ["/docker/start.sh"]
