FROM redis:latest

COPY redis-entrypoint.sh .
COPY redis.conf .
RUN mkdir -p /etc/redis &&\
    mkdir -p /etc/redis/data &&\
    mkdir -p /var/lib/redis/sentinel &&\
    mv redis.conf /etc/redis/redis.conf &&\
    touch /var/log/sentinel.log &&\
    chown redis:redis /var/log/sentinel.log &&\
    mv redis-entrypoint.sh /etc/redis/redis-entrypoint.sh &&\
    chown redis:redis /etc/redis/redis-entrypoint.sh
RUN chmod +x /etc/redis/redis-entrypoint.sh

# Set up a build environment
ENV DEPS "python python-setuptools python-pip wget unzip build-essential"
RUN set -ex;\
    deps="$DEPS";\
    apt-get update; \
	apt-get install -y build-essential wget zip make

# Install Module ReJson
WORKDIR /etc/redis/modules
RUN wget -O ReJSON.zip https://github.com/RedisLabsModules/ReJSON/archive/master.zip
RUN unzip ReJSON
WORKDIR /etc/redis/modules/RedisJSON-master
RUN make
RUN echo "\r\nloadmodule /etc/redis/modules/RedisJSON-master/src/rejson.so" >> /etc/redis/redis.conf

ENTRYPOINT [ "/etc/redis/redis-entrypoint.sh" ]