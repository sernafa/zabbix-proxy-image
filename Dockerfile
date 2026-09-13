ARG ZABBIX_VERSION=7.0.26
FROM zabbix/zabbix-proxy-sqlite3:ubuntu-${ZABBIX_VERSION}

USER root

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dnsutils \
        iproute2 \
        iputils-ping \
        netcat-openbsd \
        openssl \
    && rm -rf /var/lib/apt/lists/*

USER zabbix
