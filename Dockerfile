FROM ghcr.io/linuxserver/baseimage-alpine:3.14

ARG BUILD_DATE
ARG VERSION
ARG SYSLOG_NG_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="TheSpad"

RUN \
  echo "**** install packages ****" && \
  apk add -U --upgrade --no-cache  \
    curl && \
  if [ -z ${SYSLOG_NG_VERSION+x} ]; then \
    SYSLOG_NG_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.14/main/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
    && awk '/^P:syslog-ng$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  apk add -U --upgrade --no-cache  \
    syslog-ng==${SYSLOG_NG_VERSION} \
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
    py3-syslog-ng && \
  rm -rf \
    /tmp/*

COPY root/ /

EXPOSE 5514/udp 6601/tcp 6514/tcp

VOLUME /config