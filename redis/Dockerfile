FROM redis:latest

COPY redis-entrypoint.sh .
COPY redis.conf /etc/redis/
RUN mkdir -p /etc/redis &&\
    mkdir -p /var/lib/redis/sentinel &&\
    touch /var/log/sentinel.log &&\
    chown redis:redis /var/log/sentinel.log &&\
    mv redis-entrypoint.sh /etc/redis/redis-entrypoint.sh &&\
    chown redis:redis /etc/redis/redis-entrypoint.sh
RUN chmod +x /etc/redis/redis-entrypoint.sh


# Set up a build environment
RUN set -ex;\
    deps="$DEPS";\
    apt-get update; \
	apt-get install -y build-essential wget zip make

WORKDIR /usr/lib/redis/modules
RUN wget -O ReJSON.zip https://github.com/RedisLabsModules/ReJSON/archive/master.zip
RUN unzip ReJSON

WORKDIR /usr/lib/redis/modules/redisjson-master
RUN make

ENTRYPOINT [ "/etc/redis/redis-entrypoint.sh" ]
