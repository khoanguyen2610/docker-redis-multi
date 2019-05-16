#!/bin/sh
tee /etc/redis/sentinel.conf <<EOF
port 26379
daemonize yes
logfile "/var/log/sentinel.log"
pidfile "var/run/sentinel.pid"
dir "/var/lib/redis/sentinel"

sentinel monitor docker-cluster $MASTER_HOST $MASTER_PORT $SENTINEL_QUORUM
sentinel auth-pass docker-cluster redis-auth
sentinel down-after-milliseconds docker-cluster $SENTINEL_DOWN_AFTER
sentinel parallel-syncs docker-cluster 1
sentinel failover-timeout docker-cluster $SENTINEL_FAILOVER
EOF
redis-sentinel /etc/redis/sentinel.conf

if [ "$IS_SLAVE" = true ]; then
    redis-server /etc/redis/redis.conf --slaveof $MASTER_HOST $MASTER_PORT
else
    redis-server /etc/redis/redis.conf
fi