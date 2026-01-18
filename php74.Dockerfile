FROM php:7.4-fpm

# Kopiujemy gotowy skrypt instalatora z oficjalnego obrazu (najszybsza metoda)
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# Instalujemy wszystko jedną komendą
RUN install-php-extensions redis opcache mysqli pdo_mysql intl bcmath imagick exif zip xdebug

# Aktywacja mod_rewrite
# RUN a2enmod rewrite

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


# Optymalna konfiguracja Opcache dla PHP 7.4

RUN { \
    # Ta linia jest kluczowa, aby PHP w ogóle włączyło moduł!
    echo 'zend_extension=opcache'; \
    echo 'opcache.enable=1'; \
    echo 'opcache.enable_cli=1'; \
    echo 'opcache.memory_consumption=256'; \
    echo 'opcache.interned_strings_buffer=16'; \
    echo 'opcache.max_accelerated_files=20000'; \
 #   echo 'opcache.validate_timestamps=0'; \
 #   echo 'opcache.revalidate_freq=0'; \
    echo 'opcache.fast_shutdown=1'; \
} > /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

# XDEBUG
# W Dockerfile użyj tych zmiennych bezpośrednio w pliku ini:
# XDEBUG - Tryb "Stealth" (Cichy)
ARG XDEBUG_MODE=off
ENV XDEBUG_MODE=${XDEBUG_MODE}

RUN if [ "$XDEBUG_MODE" = "debug" ]; then \
        { \
            echo 'zend_extension=xdebug'; \
            echo 'xdebug.mode=debug'; \
            echo 'xdebug.start_with_request=yes'; \
            # echo 'xdebug.discover_client_host=0'; \
            echo 'xdebug.client_host=host.docker.internal'; \
            echo 'xdebug.client_port=9003'; \
            echo 'xdebug.idekey=VSCODE'; \
            echo 'xdebug.log_level=0'; \
        } > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    else \
        echo "" > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
    fi

################ APACHE ########################

# Włączenie modułu i obsługa wszystkich sieci prywatnych jako zaufanych proxy
# 1. Włącz moduł remoteip
# RUN a2enmod remoteip

# # 2. Utwórz konfigurację w poprawnym katalogu (/etc/apache2/conf-available/)
# RUN echo "RemoteIPHeader X-Forwarded-For" > /etc/apache2/conf-available/remoteip.conf && \
#     echo "RemoteIPInternalProxy 10.0.0.0/8" >> /etc/apache2/conf-available/remoteip.conf && \
#     echo "RemoteIPInternalProxy 172.16.0.0/12" >> /etc/apache2/conf-available/remoteip.conf && \
#     echo "RemoteIPInternalProxy 192.168.0.0/16" >> /etc/apache2/conf-available/remoteip.conf && \
#     a2enconf remoteip


RUN apt-get clean && rm -rf /var/lib/apt/lists/*


