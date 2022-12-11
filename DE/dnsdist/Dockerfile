FROM debian:10-slim
LABEL org.opencontainers.image.authors="m.mohammadi721@gmail.com"

ENV TZ Asia/tehran \
	SNI_ADDRESS=google.com

WORKDIR /etc/dnsdist

RUN apt-get -y update && \ 
	DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install curl \
	gnupg && \
	echo "deb [arch=amd64] http://repo.powerdns.com/debian buster-dnsdist-17 main" > /etc/apt/sources.list.d/pdns.list && \
	echo "Package: dnsdist*" >> /etc/apt/preferences.d/dnsdist && \
	echo "Pin: origin repo.powerdns.com" >> /etc/apt/preferences.d/dnsdist && \
	echo "Pin-Priority: 600" >> /etc/apt/preferences.d/dnsdist && \
	curl -k https://repo.powerdns.com/FD380FBB-pub.asc -o FD380FBB-pub.asc && \
	apt-key add FD380FBB-pub.asc && \
	apt-get -y update && \
	DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends -y install -o DPkg::Options::="--force-confnew" dnsdist && \	
	apt-get -y purge curl \
	gnupg && \
	apt-get -y autoremove --purge && \
	apt-get -y autoclean && \
	apt-get -y clean && \	
	rm -rf /var/lib/apt/lists/* \
		/tmp/* /var/tmp/*  \
		/usr/share/man/??  \
		/usr/share/man/??_*  \
		/etc/apt/sources.list.d \
		/etc/apt/sources.list \
		/var/lib/apt/lists/* \
		FD380FBB-pub.asc
	

COPY ["entrypoint.sh", "./data/dnsdist.conf", "./"]

RUN chmod +x entrypoint.sh
ENTRYPOINT ["/bin/bash", "-c",  "./entrypoint.sh"]
