FROM php:7.4-fpm

LABEL vendor="Mautic"
LABEL maintainer="Luiz Eduardo Oliveira Fonseca <luiz@powertic.com>"

# Install PHP extensions
RUN apt-get update && apt-get install --no-install-recommends -y \
    cron \
    git \
    wget \
    sudo \
    libc-client-dev \
    libicu-dev \
    libkrb5-dev \
    libmcrypt-dev \
    libzip-dev \
    libssl-dev \
    libz-dev \
    libonig-dev \
    vim \
    unzip \
    unar \
    zip \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/* \
    && rm /etc/cron.daily/*

RUN pecl install mcrypt-1.0.3

RUN docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install imap intl mysqli pdo_mysql zip opcache bcmath \
    && docker-php-ext-enable imap intl mcrypt mysqli pdo_mysql zip opcache bcmath

RUN apt-get update && apt-get install -y procps

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Define Mautic volume to persist data
VOLUME /var/www/html

# Define Mautic version and expected SHA1 signature
ENV MAUTIC_VERSION 3.2.5
ENV MAUTIC_SHA1 f57071c500fcedd2a64c0e7b94f0354cfa54d0aa

# By default enable cron jobs
ENV MAUTIC_RUN_CRON_JOBS true

# Setting an root user for test
ENV MAUTIC_DB_USER root
ENV MAUTIC_DB_NAME mautic

# Setting PHP properties
ENV PHP_INI_DATE_TIMEZONE='UTC' \
    PHP_MEMORY_LIMIT=2048M \
    PHP_MAX_UPLOAD=128M \
    PHP_MAX_EXECUTION_TIME=1500

# Download package and extract to web volume
COPY mautic.zip /mautic.zip
RUN unzip /mautic.zip -d /usr/src \
    && rm /mautic.zip \
    && chown -R www-data:www-data /usr/src/mautic

COPY www.conf /usr/local/etc/php-fpm.d/
COPY www.conf /usr/local/etc/php-fpm.d/www.conf.default

# Copy init scripts and custom .htaccess
COPY docker-entrypoint.sh /entrypoint.sh
COPY makeconfig.php /makeconfig.php
COPY makedb.php /makedb.php

# Apply necessary permissions
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
