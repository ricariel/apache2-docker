FROM debian:stable 
LABEL org.opencontainers.image.authors="fabrice.kirchner@casa-due-pur.de" 

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \ 
		&& apt-get install -y \ 
				apache2 \
				libapache2-mod-security2 \
				libapache2-mod-xsendfile \
		&& rm -rf /var/lib/apt/lists/* \
		&& a2enmod \
			cache_socache \
			proxy_balancer \
			rewrite \
			socache_shmcb \
			proxy_connect \
			mime_magic \
			slotmem_shm \
			proxy_http \
			headers \
			expires \
			vhost_alias \
			proxy_wstunnel \
			mpm_event \
			proxy_fdpass \
			xml2enc \
			http2 \
			security2 \
			lbmethod_byrequests \
			proxy_fcgi \
			proxy \
			include \
			cache \
			ssl \
			proxy_html \
			setenvif \
		&& a2dismod mpm_prefork

WORKDIR /var/www/html
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
