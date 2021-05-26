FROM ghcr.io/linuxserver/baseimage-alpine:3.13

ARG BUILD_DATE
ARG VERSION
ARG SYSLOG_NG_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="TheSpad"

RUN \
  echo "**** install packages ****" && \
  apk add -U --upgrade --no-cache  \
    syslog-ng \
    syslog-ng-add-contextual-data \
    syslog-ng-amqp \
    syslog-ng-graphite \
    syslog-ng-http \ 
    syslog-ng-json \
    syslog-ng-map-value-pairs \
    syslog-ng-redis \
    syslog-ng-scl \
    syslog-ng-sql \
    syslog-ng-stardate \
    syslog-ng-stomp \
    syslog-ng-tags-parser \
    syslog-ng-xml \
    py3-syslog-ng

COPY root/ /

EXPOSE 5514/udp 6601/tcp 6514/tcp

VOLUME /config