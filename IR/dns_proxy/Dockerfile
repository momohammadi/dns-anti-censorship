FROM debian:10-slim
LABEL org.opencontainers.image.authors="m.mohammadi721@gmail.com"
LABEL description="run unblock-proxy.sh script with fix some missconfiguration and also add doh dns support + http_proxy on that. this has some dependency to other container, recommended use docker-compose.yml to run all container"
WORKDIR /opt/unblock-proxy.sh/
ENV	MODE=dns \
		NGINE=proxychain \
		DNSIP=127.0.0.1 \
		DNS_MASSQ_PORT=5300

RUN	apt-get -y update && \
		DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install \
		iptables \
		iproute2 \
		procps \
		curl \
		lsof \
		gawk \
		git \
		sniproxy \
		dnsmasq \
		privoxy \
		tor \
		redsocks \
		proxychains-ng \
		dnscrypt-proxy \	
		ca-certificates && \
		git clone https://github.com/suuhm/unblock-proxy.sh /opt/unblock-proxy.sh && \
		chmod +x /opt/unblock-proxy.sh/unblock-proxy.sh && \
		ln -s /opt/unblock-proxy.sh/unblock-proxy.sh /usr/bin/unblock-proxy.sh && \
		touch /opt/unblock-proxy.sh/web-acp/web-tail.log && \
		apt-get -y purge git curl && \
		apt-get -y autoremove --purge && \
		apt-get -y autoclean && \
		apt-get -y clean && \
		rm -rf /var/lib/apt/lists/* \
    /tmp/* /var/tmp/*  \
    /usr/share/man/??  \
    /usr/share/man/??_*  \
    /etc/apt/sources.list.d \
    /etc/apt/sources.list

EXPOSE 53/udp
EXPOSE 80/tcp
EXPOSE 443/tcp
COPY entrypoint.sh ./data/proxies.lst ./data/domains.lst /opt/unblock-proxy.sh/
COPY ./data/dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
COPY ./data/sniproxy.conf /opt/unblock-proxy.sh/configs/sniproxy.conf
ENTRYPOINT ["/bin/bash", "-c",  "./entrypoint.sh"]
