#!/bin/bash

echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf

#fix some bash script unblock-proxy.sh bugs
if [[ ! -f "/opt/unblock-proxy.sh/fixedDone.lock" ]]; then
	sed -i "s/proxycheck.coldwareveryday.com/google.com/g" /opt/unblock-proxy.sh/unblock-proxy.sh
	sed -i "s/ping -c 1 -i 0.1 -W 0.7/fping -c1 -T400/g" /opt/unblock-proxy.sh/unblock-proxy.sh
	sed -i "s/IPADDR=.*n1)$/IPADDR=${DNSIP}/g" /opt/unblock-proxy.sh/unblock-proxy.sh
	sed -i "s/DOH_ADDRESS/${DOH_ADDRESS}/g" /etc/dnscrypt-proxy/dnscrypt-proxy.toml
	sed -i "s/DOH_STAMP/${DOH_STAMP}/g" /etc/dnscrypt-proxy/dnscrypt-proxy.toml
	sed -i "s/port=53/port=${DNS_MASSQ_PORT}/g" /opt/unblock-proxy.sh/configs/dnsmasq.conf
	echo "export http_proxy=\"http://${HTTP_PROXY_IP}:${HTTP_PROXY_PORT}\"" >> /etc/environment
	echo "export http_proxy=\"http://${HTTP_PROXY_IP}:${HTTP_PROXY_PORT}\"" >> ~/.bashrc
	touch /opt/unblock-proxy.sh/fixedDone.lock
fi

echo "Starting BASH ENVMT..."

sleep 3

dnscrypt-proxy -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml &

sleep 5

echo "nameserver 127.0.0.250" > /etc/resolv.conf

sleep 3

unblock-proxy.sh dns --${NGINE} -W -d ; \
tail -f /opt/unblock-proxy.sh/web-acp/web-tail.log
