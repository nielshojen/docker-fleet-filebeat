FROM alpine

MAINTAINER Niels Højen <niels@hojen.net>

ENV FILEBEAT_VERSION=5.1.1 \
    FILEBEAT_SHA1=6e629825010b816b627ac531ddbb50b960bbbcba

RUN apk --update add ca-certificates
RUN apk add -U unzip && rm -rf /var/cache/apk/*

ADD https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz /tmp/filebeat.tar.gz
ADD https://dl.kolide.co/bin/fleet_latest.zip /tmp/fleet_latest.zip

RUN cd /tmp \
  && echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha1sum -c - \
  && tar -xzvf filebeat.tar.gz \
  && cd filebeat* \
  && cp filebeat /usr/bin \
  && rm -rf /tmp/filebeat* \
  && unzip /tmp/fleet_latest.zip 'linux/*' -d /tmp/fleet_linux \
  && cp /tmp/fleet_linux/linux/fleet /usr/bin/ \
  && cp /tmp/fleet_linux/linux/fleetctl /usr/bin/

CMD ["fleet", "serve"]
