ARG BASE=alpine:latest
FROM ${BASE}

LABEL maintainer="Emile <emile239@qq.com>"

ARG RCLONE_VERSION=current
ARG ARCH=amd64

RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
RUN apk update \
    && apk add --no-cache  tzdata wget \
    && cp -ra /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
RUN URL=http://downloads.rclone.org/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip; \
  cd /tmp \
  && wget  $URL \
  && unzip /tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip \
  && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin \
  && rm -r /tmp/rclone*

RUN mkdir /download /data \
    && touch /data/1.log

COPY root /var/spool/cron/crontabs/root
COPY do-rclone.sh /bin/do-rclone.sh
COPY test.sh /bin/test.sh
RUN chmod +x /bin/do-rclone.sh

VOLUME /download 
VOLUME /data

CMD crond -l 2 -f
