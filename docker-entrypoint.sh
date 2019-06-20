#!/bin/sh

if [ -f /etc/filebeat/filebeat.yml ]; then
  echo "Found config file at /etc/filebeat/filebeat.yml"
  /usr/bin/filebeat -c /etc/filebeat/filebeat.yml &
else
  echo "No config file found at /etc/filebeat/filebeat.yml"
fi

/usr/bin/fleet serve
