#!/bin/bash
set -e
if [[ ! -f "/fixedDone.lock" ]]; then
	sed -i "s/socks4.*9050$//g" /etc/proxychains.conf

	echo "${PROXY_SERVER_PROTOCOL} ${PROXY_SERVER_IP} ${PROXY_SERVER_PORT}" >> /etc/proxychains.conf
	touch /fixedDone.lock
fi

proxychains4 ncat -k -4 -l ${CLIENT_PORT} --proxy-type http
