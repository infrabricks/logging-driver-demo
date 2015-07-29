#!/bin/sh
while true ; do logrotate -f /etc/logrotate.d/rsyslog ; sleep 600 ; done &
/usr/sbin/rsyslogd $@
