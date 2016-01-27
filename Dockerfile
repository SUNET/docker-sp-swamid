FROM ubuntu
MAINTAINER leifj@sunet.se
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update
RUN apt-get -y install apache2 libapache2-mod-shib2 ssl-cert augeas-tools libapache2-mod-php5 libcgi-pm-perl libemail-mime-encodings-perl
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod shib2
RUN a2enmod headers
RUN a2enmod cgi
ENV SP_HOSTNAME sp.example.com
ENV SP_CONTACT noc@nordu.net
ENV SP_ABOUT /
ENV METADATA_SIGNER md-signer.crt
ENV DEFAULT_LOGIN md.nordu.net
RUN rm -f /etc/apache2/sites-available/*
RUN rm -f /etc/apache2/sites-enabled/*
ADD start.sh /start.sh
RUN chmod a+rx /start.sh
ADD certs/ /etc/shibboleth/
ADD attribute-map.xml /etc/shibboleth/attribute-map.xml
ADD secure /var/www/secure
RUN chmod a+rx /var/www/secure/index.cgi
COPY /apache2.conf /etc/apache2/
ADD shibd.logger /etc/shibboleth/shibd.logger
ADD index.php /var/www/
EXPOSE 443
EXPOSE 80
ENTRYPOINT ["/start.sh"]
