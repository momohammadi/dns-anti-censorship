#!/bin/bash
set -e

sed -i "s/SERVER_IP/${SERVER_IP}/g" local.json
sed -i "s/LOCAL_IP/${LOCAL_IP}/g" local.json
sed -i "s/LOCAL_PORT/${LOCAL_PORT}/g" local.json
sed -i "s/SERVER_PORT/${SERVER_PORT}/g" local.json
sed -i "s/SERVER_METHOD/${SERVER_METHOD}/g" local.json
sed -i "s/SERVER_PASS/${SERVER_PASS}/g" local.json

ss-local -c /etc/shadowsocks/local.json
