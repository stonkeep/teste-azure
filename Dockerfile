FROM alpine

# copy needed scripts to containers
ADD .docker /docker
RUN chmod -R +x /docker

# installations
RUN /docker/installations/prepare.sh \
    && /docker/installations/basic.sh \
    && /docker/installations/apache.sh \
    && /docker/installations/php.sh \
    && /docker/installations/redis.sh \
    && /docker/installations/cleanup.sh

# expose ports
EXPOSE 80

WORKDIR /app
ADD . /app
RUN composer install --no-dev --no-interaction \
    && chown -R apache:apache .

# run bootstrap/start
ENTRYPOINT ["/docker/start.sh"]
