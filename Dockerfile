FROM ubuntu:14.04
MAINTAINER Nobody Noden

RUN apt-get update \
        && apt-get install -y \
        openssh-server \
        apache2 \
        nginx \
        memcached \
        php5 \
        php5-mysql \
        php-pear \
        php-soap \
        php5-intl \
        php-gettext \
        php5-memcache \
        php5-curl \
        php5-tidy \
        php5-imagick \
        php5-geoip \
        upstart \
        phpmyadmin \
        nodejs \
        unzip \
        supervisor \
        && pear channel-discover pear.phing.info \
        && pear install phing/phing \
        && rm -rf /var/lib/apt/lists/* \
        && a2enmod rewrite \
        && wget -O stalker_portal.zip https://github.com/azhurb/stalker_portal/archive/master.zip \
        && unzip stalker_portal.zip -d /var/www/html \
        && rm stalker_portal.zip \
        && ln -s /var/www/html/stalker_portal-* /var/www/html/stalker_portal

COPY supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
COPY supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf
COPY supervisord-nginx.conf /etc/supervisor/conf.d/supervisord-nginx.conf

EXPOSE 22 80 88

CMD ["/usr/bin/supervisord", "-n"]
