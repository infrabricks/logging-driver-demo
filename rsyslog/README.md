# Check Logging driver at Docker 1.7


```
$ docker build -t infrabricks/rsyslog .
$ docker run -d --name rsyslog -p 127.0.0.1:514:514/udp infrabricks/rsyslog
$ echo netcat:"Host test log" | nc -u -w 1 127.0.0.1 514
$ docker exec -ti rsyslog tail -f /var/log/syslog
2015-06-10T14:36:37.923928+00:00 172.17.42.1 netcat: Host test log
# Nice timestamp :)
$ docker run -d --log-driver syslog --log-opt=syslog-address=udp://127.0.0.1:514  busybox /bin/sh -c 'while true; do >&2 echo "$(date +"%Y-%m-%dT%H:%M:%S%z") hello log"; sleep 1; done;'
$ docker exec -ti rsyslog tail -f /var/log/syslog
2015-06-10T14:36:38Z 1.7rc2 docker/0427b7b2cda8[1689]: 2015-06-10T14:36:38+0000 hello log
2015-06-10T14:36:39Z 1.7rc2 docker/0427b7b2cda8[1689]: 2015-06-10T14:36:39+0000 hello log
```


## Trouble...

Comment this out with sed?

/etc/rsylogd.conf

```
# daemon.*;mail.*;\
# news.err;\
# *.=debug;*.=info;\
# *.=notice;*.=warn |/dev/xconsole
```


## send to remote host

Which Facility/level oder used?


```
CustomLog "|/usr/bin/logger -t apache -p local6.info" combined
```

```
# Syntax:
# <level> @<IP>:<port>
local6.info @10.11.12.13:514

```


```
# Write all apache logs to this file (please note the comma)
$template apacheAccess,"/var/log/apache_access_log"

# If the log's tag is "apache" and matches
# the defined level, send it to a specific file
if $syslogtag == 'apache' then {
    local6.info ?apacheAccess
    & ~
}
```

## Reference

* http://www.rsyslog.com/storing-messages-from-a-remote-system-into-a-specific-file/
