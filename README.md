# DNS anti-censorship
Bypass Online Censorship by just changing your DNS addresses

A DNS proxy allows you to transmit selected DNS queries through a tunnel interface, which prevents malicious users from learning about the internal configuration of a network
## :blue_book: Requirements
One Ubuntu/Debian VM on the restricted network (We called it IR)- Ram 512M, 1 CPU core, 8G free space

One Ubuntu/Debian VM on the unrestricted network (We called it DE)- Ram 512M, 1 CPU core, 8G free space

One proxy account on the unrestricted network(We called it Shadow).

One valid domain or subdomain + valid SSL

** any proxy account you can use I use Shadowsocks in this stack you can replace it with any other proxies also I use external Shadowsocks you can also setup Shadowsocks server on their DE VM

one valid domain address

>this is just for one DNS Address, if you want more than one DNS you should increase your VMs depending on what you want

**‌ if you want to run the service Jump to [installation section](https://github.com/momohammadi/dns-anti-censorship#installation), the below content is just for learning**

## :clipboard: Summary

the main service on this stack is unblock-proxy.sh, this is a simple shell script to compact install Dnsmasq, SNI Proxy, and proxy chains for creating a DNS address and managing the domains list that we want to manage in our name resolution tunnel.

we build this script on one container (we called this container dnsproxy) with some changes to it and use Shadow for the proxy address, in this step we can use the public IP address of this VM as a DNS address for the tunnel access to all websites that boycotted from a foreign country like an oracle in Iran or network boycott list but some government like Iran used DNS hijacking method so restricted website resolve to an incorrect IP address like 10.10.x.x instead the actual IP and it is a big problem.

To solve this problem we should use a DNS over HTTPS (DOH) service on our IR VM but we have a new problem all DOH public services in Iran is under a boycott list and these are not usable for us, so we should create our DOH service too.

finally, should run dnsproxy behind a proxy then use a proxy for our client as the DNS address, and also use our DOH service as the resolver in dnsproxy.

let’s get started :smile: 
## :clipboard: containers

for better readably this article I describe each container and then provide docker files and docker-compose files for each VM
## DE VM: 
Pi-hole

dnsdist
## IR VM: 
dns_proxy

proxychains_client

shadowsocks_client
### DE VM
#### Pi-hole container:
Pi-hole is a free DNS server provider with a web interface [Pi-hole](https://pi-hole.net/)

Build our container with image [pihole/pihole](https://hub.docker.com/r/pihole/pihole)

Pi-hole can provide more than one DNS server, this DNS server provide us with some additional feature like ads-blocking and more

Pi-hole web login: 

http://doh.yourdomain.com:8081/admin/login.php

password: MrXKnqaqkQex3RepVxu

#### dnsdist container: 

[DOH](https://en.wikipedia.org/wiki/DNS_over_HTTPS) and DOT service

'dns-anti-censorship/DE/dnsdist/Dockerfile'
### IR VM:
#### shadowsocks_client container:
** if you use anything other than Shadowsocks replace this piece with your proxy client

it is our socks5 provider, depending on the Shadowsocks server install Shadowsocks plus the needed plugin, in this article our server is Shadowsocks + simple obfs

after starting the container we have a socks5 proxy on the local network IP address 172.18.1.3 on port number 8080

`dns-anti-censorship/IR/shadowsocks_client/Dockerfile`

#### proxychains_client container:
Convert socks5 to HTTP proxy to use on dns_proxy container as a whole system proxy

install ProxyChains and ProxyChains4

`dns-anti-censorship/IR/proxychains/Dockerfile`

#### dns_proxy container:

Thanks to [unblock-proxy.sh](https://github.com/suuhm/unblock-proxy.sh).

this is the main container that works to do tunnel DNS service

install unblock-proxy.sh and DNSCrypt  with some change and all their dependency

`dns-anti-censorship/IR/dns_proxy/Dockerfile`
## installation
finally you can install all of this stack by docker-compse

note: You should first run on DE VM
#### DE VM

```
git clone https://github.com/momohammadi/dns-anti-censorship.git
cd dns-anti-censorship/DE
#open docker-compose.yml
# find and replce below string:
# REPLCAE_YOUR_DOMAIN, PIHOLE_ADMIN_PASS, CERTIFICATE_PATH, CERTIFICATE_PRIVATEKEY_PATH
docker compose up -d
```
pi-hole web access port number is 8081

#### IR VM
DOH stamp genrated here: [DNSCrypt - DNS Stamps online calculator ](https://dnscrypt.info/stamps/)
add domain list to file dns-anti-censorship/IR/dns_proxy/data/domains.lst only this domain will be behind of tunnel, anything else resolve and load directly from inertnet client
```
git clone https://github.com/momohammadi/dns-anti-censorship.git
cd dns-anti-censorship/IR
#open docker-compose.yml
# find and replce below string:
# REPLACE_SHADOWSOCKS_IP, SHADOWSOCKS_SERVER_PORT, SHADOWSOCKS_SERVER_PASSWORD, SHADOWSOCKS_METHOD, REPLACE_SERVER_PUBLIC_IP, REPLACE_YOUR_DOMAIN, DOH_STAMP_STRING
docker compose up -d
```
note after each time of edite domains.lst file run `docker compose restart`

## usage
depend on your OS change your dns address to your IR VM IPs
on some os like android you should install 3rd party app for doing dns change
### trick
you ca run this stack and use his dns address for other services in the restricted network as DNS server such v2ray, pptp, l2tp, openconect or etc and then use their connection/authentication for connecting to it and with this trick finally you have an anti-censorship system with authentication solution.
