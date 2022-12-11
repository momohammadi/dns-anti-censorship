#!/bin/bash
if [[ ! -f "/etc/dnsdist/fixedDone.lock" ]]; then
	sed -i "s/SNI_ADDRESS/${SNI_ADDRESS}/g" /etc/dnsdist/dnsdist.conf
	touch /etc/dnsdist/fixedDone.lock
fi
sleep 20
/usr/bin/dnsdist -C /etc/dnsdist/dnsdist.conf
