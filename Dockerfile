FROM ubuntu:trusty

MAINTAINER TobiLG <tobilg@gmial.com>

# Install InfluxDB
ENV INFLUXDB_VERSION 1.0.2

RUN apt-get update && \
  apt-get install -y curl && \
  curl -s -o /tmp/influxdb_latest_amd64.deb https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_amd64.deb && \
  dpkg -i /tmp/influxdb_latest_amd64.deb && \
  rm /tmp/influxdb_latest_amd64.deb && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ADD types.db /usr/share/collectd/types.db
ADD config.toml /config/config.toml
ADD run.sh /run.sh

ENV PRE_CREATE_DB **None**
ENV SSL_SUPPORT **False**

VOLUME ["/data"]

CMD ["/run.sh"]