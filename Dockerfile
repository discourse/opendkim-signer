# opendkim is only in edge as of 2016-07-04
FROM alpine:edge

EXPOSE 8891

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >>/etc/apk/repositories \
	&& apk update \
	&& apk add opendkim socat \
	&& adduser -SDH -u 9001 -h /usr/share/empty opendkim \
	&& rm -f /var/cache/apk/*

COPY opendkim.conf /etc/
COPY init /sbin/

ENTRYPOINT ["/sbin/init"]
