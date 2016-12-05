FROM alpine:3.4

MAINTAINER Peter Teich <mail@pteich.xyz>

ENV GOSU_VERSION 1.10
ENV DUMB_INIT_VERSION 1.2.0
ENV LOGFAN_VERSION 10

RUN addgroup -S logfan && adduser -S -G logfan logfan

RUN mkdir -p /opt

RUN set -x \
    && apk update && apk add --no-cache --virtual .deps \
        openssl \
        dpkg \
        ca-certificates \
    && update-ca-certificates \
    && cd /opt \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${dpkgArch}" \
    && wget -O /usr/local/bin/dumb-init "https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_${dpkgArch}" \
    && chmod +x /usr/local/bin/gosu \
    && chmod +x /usr/local/bin/dumb-init \
    && wget -O logfan.tar.gz "https://github.com/veino/logfan/releases/download/${LOGFAN_VERSION}/logfan_v${LOGFAN_VERSION}_linux_${dpkgArch}.tgz" \
    && tar xzvf logfan.tar.gz \
    && rm -f logfan.tar.gz \
    && mv logfan-${LOGFAN_VERSION}-linux-${dpkgArch} /usr/local/bin/logfan \
    && apk del .deps

RUN mkdir /config && chown logfan:logfan /data
VOLUME ["/config"]

ENTRYPOINT ["dumb-init", "gosu", "summitdb", "logfan"]

CMD [""]
