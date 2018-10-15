# libmilter in alpine is IPv4 only...
FROM ubuntu:14.04

EXPOSE 8891

RUN apt-get update \
	&& useradd --uid 9001 --home /usr/share/empty --shell /bin/bash opendkim \
	&& apt-get install -y opendkim socat \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY opendkim.conf /etc/
COPY init /sbin/

ENTRYPOINT ["/sbin/init"]
