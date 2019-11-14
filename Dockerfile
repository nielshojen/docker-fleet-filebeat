FROM alpine

MAINTAINER Niels Højen <niels@hojen.net>

ENV FLEET_VERSION=2.4.0
ENV FILEBEAT_VERSION=7.4.2

RUN apk --update add ca-certificates libc6-compat unzip && rm -rf /var/cache/apk/*

ADD https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz /tmp/filebeat.tar.gz
ADD https://github.com/kolide/fleet/releases/download/${FLEET_VERSION}/fleet.zip /tmp/fleet_latest.zip

RUN cd /tmp \
  && tar -xzvf filebeat.tar.gz \
  && cd filebeat* \
  && cp filebeat /usr/bin \
  && rm -rf /tmp/filebeat* \
  && unzip /tmp/fleet_latest.zip 'linux/*' -d /tmp/fleet_linux \
  && cp /tmp/fleet_linux/linux/fleet /usr/bin/ \
  && cp /tmp/fleet_linux/linux/fleetctl /usr/bin/

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
