FROM php:7.4-apache

# Kopiujemy gotowy skrypt instalatora z oficjalnego obrazu (najszybsza metoda)
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# Instalujemy wszystko jedną komendą
RUN install-php-extensions redis intl bcmath imagick exif opcache xdebug

# Aktywacja mod_rewrite
RUN a2enmod rewrite

# Zwiększenie limitów PHP
RUN echo "max_input_vars = 10000" >> /usr/local/etc/php/conf.d/docker-php-custom.ini \
    && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/docker-php-custom.ini \
    && echo "max_file_uploads = 100" >> /usr/local/etc/php/conf.d/docker-php-custom.ini \
    && echo "post_max_size = 128M" >> /usr/local/etc/php/conf.d/docker-php-custom.ini \
    && echo "upload_max_filesize = 128M" >> /usr/local/etc/php/conf.d/docker-php-custom.ini

# Uwaga: Suhosin zazwyczaj nie jest obecny w standardowych obrazach PHP 7.4+, 
# ale jeśli go doinstalujesz, te linie będą potrzebne:
RUN echo "suhosin.post.max_vars = 10000" >> /usr/local/etc/php/conf.d/docker-php-custom.ini \
    && echo "suhosin.request.max_vars = 10000" >> /usr/local/etc/php/conf.d/docker-php-custom.ini


RUN echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "opcache.memory_consumption=256" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

# XDEBUG
# W Dockerfile użyj tych zmiennych bezpośrednio w pliku ini:
RUN echo "xdebug.mode=\${XDEBUG_MODE}" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

################ APACHE ########################

# Włączenie modułu i obsługa wszystkich sieci prywatnych jako zaufanych proxy
# 1. Włącz moduł remoteip
RUN a2enmod remoteip

# 2. Utwórz konfigurację w poprawnym katalogu (/etc/apache2/conf-available/)
RUN echo "RemoteIPHeader X-Forwarded-For" > /etc/apache2/conf-available/remoteip.conf && \
    echo "RemoteIPInternalProxy 10.0.0.0/8" >> /etc/apache2/conf-available/remoteip.conf && \
    echo "RemoteIPInternalProxy 172.16.0.0/12" >> /etc/apache2/conf-available/remoteip.conf && \
    echo "RemoteIPInternalProxy 192.168.0.0/16" >> /etc/apache2/conf-available/remoteip.conf && \
    a2enconf remoteip


RUN apt-get clean && rm -rf /var/lib/apt/lists/*


