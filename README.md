# this repo is updating and asp will be complete
# dns-anti-censorship
Bypass Online Censorship with just changing your DNS addresses
A DNS proxy allows you to transmit selected DNS queries through a tunnel interface, which prevents malicious users from learning about the internal configuration of a network

## :blue_book: Requirements
one Ubuntu/Debian VM on the restricted network (We called it IR)- Ram 512M, 1 CPU core, 8G free space

one Ubuntu/Debian VM on the unrestricted network (We called it DE)- Ram 512M, 1 CPU core, 8G free space

one proxy account on the unrestricted network(We called it Shadow).

** any proxy account you can use i use shadowsocks in this stack you can replace it with any other proxies also I use external shadowsocks you can also setup shadowsocks server on their DE vm

one valid domain address


>this is just for one DNS Address, if you want more than one DNS you should increase your VMs depend on what you want

**‌ if you want to run the service using the docker files, below content is just for learning**

## :clipboard: Summary
the main service on this stack is unblock-proxy.sh, this is a simple shell script to compact install dnsmasq, sniproxy, proxy chains for creating a DNS address and managing the domains list that we want to manage in our name resolution.

we build this script on one container (we called this container dnsproxy) with some changes on it and use Shadow for the proxy address, in this step we can use the public IP address of this VM as a DNS address for the tunnel access to all websites that boycotted from a foreign country like oracle in Iran or network boycott list but some government like Iran used DNS hijacking method so restricted website resolve to an incorrect ip address like 10.10.x.x instead the real IP and it is a big problem.

for solving this problem we should use a DNS over HTTPS (DOH) service on our IR VM but we have a new problem all DOH public services in Iran is under a boycott list and these are not usable for us, so we should create our DOH service too.

finally, should run dnsproxy behind a proxy then use a proxy for our client as the DNS address and also use our DOH service as the resolver in dnsproxy.

let’s get started :smile: 

## :clipboard: containers

for better readably this article I describe each container and then provide docker files and docker compose files for each VM

## DE VM: 

Pi-hole

dnsdist

## IR VM: 

dns_proxy

proxychains_client

shadowsocks_client

### DE VM
#### Pi-hole container:

it is our DNS Server

Build our container with image pihole/pihole:latest

Pi-hole can provide more than one dns server, this dns server provide us some additional feature like ads-blocking and more

Pi-hole web login: 

http://doh.yourdomain.com:8081/admin/login.php

password: MrXKnqaqkQex3RepVxu

dnsdist container: 

it is our DOH and DOT service

Base os: debian:10-slim

*** update this section soon

### IR VM:
#### shadowsocks_client container:
** if you use anything other shadowsocks replace this piece with your proxy client
it is our socks5 provider, depending on shadowsocks server install shadowsocks plus needed plugin, in this article our server is shadowsock + simple obfs

Base os: debian:10-slim

after starting the container we have a socks5 proxy on local network IP address172.18.1.3 on port 8080 number
*** update this section soon


#### proxychains_client container:

it is our http_proxy provider from the Previous stage socks5

Base os: debian:10-slim

install proxychains and proxychains4
*** update this section soon

#### dnsproxy container:

Base os: debian:10-slim

install unblock-proxy.sh and dnscrypt-proxy with some change and all their dependency
*** update this section soon



