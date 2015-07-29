FROM java:8-jre

ENV LOGSTASH_VERSION=1.5.1
WORKDIR /logstash

RUN curl -Ls https://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz -o logstash.tar.gz \
  && tar -xvf logstash.tar.gz --strip-components=1 \
  && rm logstash.tar.gz
ENTRYPOINT [ "/logstash/bin/logstash" ]
CMD [""]
