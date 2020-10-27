# libmilter in alpine is IPv4 only...
FROM debian:buster-slim

EXPOSE 8891

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade \
	&& useradd --uid 9001 --home /usr/share/empty --shell /bin/bash opendkim \
	&& DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y opendkim socat \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean \
	&& ( find /var/lib/apt/lists -mindepth 1 -maxdepth 1 -delete || true ) \
	&& ( find /var/tmp -mindepth 1 -maxdepth 1 -delete || true ) \
	&& ( find /tmp -mindepth 1 -maxdepth 1 -delete || true )

COPY opendkim.conf /etc/
COPY init /sbin/

ENTRYPOINT ["/sbin/init"]
