FROM debian:8
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get -y -q install rsyslog \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN sed 's/#$ModLoad imudp/$ModLoad imudp/' -i /etc/rsyslog.conf \
 && sed 's/#$UDPServerRun 514/$UDPServerRun 514/' -i /etc/rsyslog.conf \
 && sed 's/$ModLoad imklog/#$ModLoad imklog/' -i /etc/rsyslog.conf \
 && sed 's/#$ModLoad imtcp/$ModLoad imtcp/' -i /etc/rsyslog.conf \
 && sed 's/$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat/#$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat/' -i /etc/rsyslog.conf \
 && sed 's/#$InputTCPServerRun 514/$InputTCPServerRun 514/' -i /etc/rsyslog.conf

EXPOSE 514/tcp 514/udp

ADD run.sh /run.sh
ADD rsyslogrotate.conf /etc/logrotate.d/rsyslog

ENTRYPOINT ["/run.sh"]
CMD ["-n"]
