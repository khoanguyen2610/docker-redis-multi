# Build fault-tolerance Redis cluster with Sentinel on Docker
## Topology
![topology](https://vnsys.files.wordpress.com/2019/01/redis-ha-with-haproxy-2.jpg?w=614)
## Run
`docker-compose up -d`
## Tail sentinel logs
`clear && tail -f /var/log/sentinel.log`
## Get redis replication info per seconds
`while true; do redis-cli info replication; sleep 1; clear; done`