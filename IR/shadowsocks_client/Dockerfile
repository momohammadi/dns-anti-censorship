FROM debian:10-slim
LABEL org.opencontainers.image.authors="m.mohammadi721@gmail.com"
LABEL description="Connect to shadowsocks server with simple obfs plugin and expose socks5 proxy to local port"

ENV LOCAL_PORT=8080 \
	LOCAL_IP=127.0.0.1 \
	SERVER_IP=1.2.3.4 \
	SERVER_PORT=443 \
	LOCAL_PORT=8080 \
	SERVER_METHOD="aes-256-gcm" \
	SERVER_PASS="password"

WORKDIR /etc/shadowsocks/

RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install shadowsocks simple-obfs && \
	apt-get -y autoremove --purge && \
	apt-get -y autoclean && \
	apt-get -y clean && \
  rm -rf /var/lib/apt/lists/* \
    /tmp/* /var/tmp/*  \
    /usr/share/man/??  \
    /usr/share/man/??_*  \
    /etc/apt/sources.list.d \
    /etc/apt/sources.list \
    /var/lib/apt/lists/*

COPY ./data/local.json entrypoint.sh ./

ENTRYPOINT ["./entrypoint.sh"]
