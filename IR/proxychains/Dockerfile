FROM debian:10-slim
LABEL org.opencontainers.image.authors="m.mohammadi721@gmail.com"
LABEL description="Connect to Socks5 server and expose http_proxy to local port"
ARG DEBIAN_FRONTEND=noninteractive
ENV PROXY_SERVER_IP=1.2.3.4 \
	PROXY_SERVER_PORT=1080 \
	PROXY_SERVER_PROTOCOL=socks5 \
	CLIENT_PORT=8081 
    
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install proxychains proxychains4 ncat && \
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

COPY entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]
