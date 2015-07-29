#!/bin/sh
mkdir -p certs
cd certs
openssl req -x509  -batch -nodes -newkey rsa:2048 -keyout logstash-forwarder.key -out logstash-forwarder.crt -subj /CN=logstash
