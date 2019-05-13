FROM redis:latest

COPY redis-entrypoint.sh $REDIS_DIR/
COPY redis.conf $REDIS_DIR/
RUN mkdir -p $REDIS_DIR/ &&\
    mkdir -p /var/lib/redis/sentinel &&\
    touch /var/log/sentinel.log &&\
    chown redis:redis /var/log/sentinel.log &&\
    chown redis:redis $REDIS_DIR/redis-entrypoint.sh
RUN chmod +x $REDIS_DIR/redis-entrypoint.sh

# Set up a build environment
RUN set -ex;\
    apt-get update; \
	apt-get install -y build-essential wget zip make

# Install Module ReJson
WORKDIR /etc/redis/modules
RUN wget -O ReJSON.zip https://github.com/RedisLabsModules/ReJSON/archive/master.zip
RUN unzip ReJSON
WORKDIR /etc/redis/modules/redisjson-master
RUN make

ENTRYPOINT [ $REDIS_DIR"/redis-entrypoint.sh" ]
