#!/bin/sh

/usr/bin/fleet serve

if [ -f /etc/filebeat/filebeat.yml ]; then
  /usr/bin/filebeat -c /etc/filebeat/filebeat.yml
fi
