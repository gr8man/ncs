FROM serversideup/php:7.4-fpm-nginx

USER root

# Instalacja zależności i rozszerzeń (w tym xdebug)
RUN apt-get update && apt-get install -y --no-install-recommends qpdf \
    && install-php-extensions intl bcmath imagick exif opcache xdebug \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalacja ionCube Loader
RUN curl -fSL "https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz" -o ioncube.tar.gz \
    && tar -xzf ioncube.tar.gz \
    && export PHP_EXT_DIR=$(php-config --extension-dir) \
    && cp ioncube/ioncube_loader_lin_$(php -r 'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;').so $PHP_EXT_DIR \
    && echo "zend_extension=$PHP_EXT_DIR/ioncube_loader_lin_$(php -r 'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;').so" > /usr/local/etc/php/conf.d/00-ioncube.ini \
    && rm -rf ioncube.tar.gz ioncube

USER www-data
