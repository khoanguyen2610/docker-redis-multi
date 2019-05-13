#!/bin/sh
tee $REDIS_DIR/sentinel.conf <<EOF
port 26379
daemonize yes
logfile "/var/log/sentinel.log"
pidfile "var/run/sentinel.pid"
dir "/var/lib/redis/sentinel"

sentinel monitor docker-cluster $MASTER_HOST 6379 $SENTINEL_QUORUM
sentinel down-after-milliseconds docker-cluster $SENTINEL_DOWN_AFTER
sentinel parallel-syncs docker-cluster 1
sentinel failover-timeout docker-cluster $SENTINEL_FAILOVER
EOF

redis-sentinel $REDIS_DIR/sentinel.conf

if [ "$IS_SLAVE" == true ]; then
	redis-server $REDIS_DIR/redis.conf --slaveof $MASTER_HOST 6379 \
        --loadmodule $REDIS_MODULE_DIR/redisjson-master/src/rejson.so
else
    redis-server $REDIS_DIR/redis.conf \
        --loadmodule $REDIS_MODULE_DIR/redisjson-master/src/rejson.so
fi
