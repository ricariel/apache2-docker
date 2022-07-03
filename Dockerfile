FROM debian:stable 
LABEL org.opencontainers.image.authors="fabrice.kirchner@casa-due-pur.de" 

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \ 
		&& apt-get upgrade -y \
		&& apt-get install -y \ 
				apache2 \
				libapache2-mod-security2 \
				libapache2-mod-fcgid \
				libapache2-mod-xsendfile \
				libfcgi-bin zip \
        jpegoptim \
        optipng \
        gifsicle \
        openssl \
        zip \
        curl \
		&& rm -rf /var/lib/apt/lists/*
RUN a2dismod mpm_event 
RUN a2enmod \
		cache_socache \
		rewrite \
		remoteip \
		socache_shmcb \
		mime_magic \
		slotmem_shm \
		remoteip \
		headers \
		expires \
		vhost_alias \
		xml2enc \
		http2 \
		security2 \
		lbmethod_byrequests \
		include \
		cache \
		ssl \
		proxy_fcgi \
		setenvif \
		mpm_prefork
RUN a2ensite default-ssl

WORKDIR /var/www/html
EXPOSE 80 
EXPOSE 443
CMD ["apachectl", "-D", "FOREGROUND"]
