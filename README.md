# logging-driver-demo

Test the syslog docker driver

```
$ ./gen-test-certs.sh
$ docker-compose -p logging up -d
$ b2d ssh
> echo netcat:"Host test log" | nc -u -w 1 127.0.0.1 514
> docker exec -ti logging_rsyslog_1 tail -f /var/log/syslog
> docker run -d --log-driver syslog \
  --log-opt=syslog-address=udp://127.0.0.1:514  \
  busybox \
  /bin/sh -c 'while true; do >&2 echo "$(date +"%Y-%m-%dT%H:%M:%S%z") hello log"; sleep 1; done;'
> docker exec -ti logging_rsyslog_1 tail -f /var/log/syslog
```

All json logs are forwarded with logstash-forwarder!

```
$ docker run -d \
  busybox \
  /bin/sh -c 'while true; do >&2 echo "$(date +"%Y-%m-%dT%H:%M:%S%z") hello log"; sleep 1; done;'
$ docker exec -ti logging_logstash_1 /bin/bash
> cd /var/log/docker
> # tail json logstash output
```
