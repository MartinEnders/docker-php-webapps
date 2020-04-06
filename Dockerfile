FROM php:7.4-apache

# RUN-Commands are based on the following repository: https://hub.docker.com/r/easyengine/php7.4/dockerfile
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    	    imagemagick \
	    less \
	    mariadb-client msmtp \
	    libc-client-dev \
	    libfreetype6-dev \
	    libjpeg-dev \
	    libjpeg62-turbo-dev \
	    libkrb5-dev \
	    libmagickwand-dev \
	    libmcrypt-dev \
	    libmemcached-dev \
	    libxml2-dev \
	    libpng-dev \
	    libzip-dev \
	    libssl-dev \
	    unzip \
	    vim \
	    zip

RUN pecl install imagick; \
    pecl install memcached; \
    pecl install mcrypt-1.0.3; \
    pecl install redis; \
    docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include \
    docker-php-ext-configure zip --with-libzip; \
    docker-php-ext-install gd; \
    PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
    echo "extension=memcached.so" >> /usr/local/etc/php/conf.d/memcached.ini; \
    docker-php-ext-install imap; \
    docker-php-ext-install mysqli; \
    docker-php-ext-install opcache; \
    docker-php-ext-install soap; \
    docker-php-ext-install zip; \
    docker-php-ext-install exif; \
    docker-php-ext-enable imagick mcrypt redis; \
    docker-php-ext-install bcmath; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*;

