FROM php:7.4-fpm
# Install PHP extensions
RUN apt-get update && apt-get install --no-install-recommends -y \
    cron \
    git \
    wget \
    build-essential \
    ruby-full \
    locales \
    sudo \
    libc-client-dev \
    libicu-dev \
    libkrb5-dev \
    libmcrypt-dev \
    libzip-dev \
    libssl-dev \
    libonig-dev \
    libz-dev \
    libpng-dev \
    vim \
    unzip \
    zip \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/* \
    && rm /etc/cron.daily/*

RUN pecl install mcrypt-1.0.3

RUN docker-php-ext-configure imap --with-imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install imap intl sockets mysqli gd pdo_mysql zip opcache bcmath \
    && docker-php-ext-enable imap intl sockets mcrypt gd mysqli pdo_mysql zip opcache bcmath

RUN apt-get update && apt-get install -y procps

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN useradd -m -s /bin/bash linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER linuxbrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

USER root
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
RUN brew install gh

# Define Mautic volume to persist data
VOLUME /var/www/html

# Define Mautic version and expected SHA1 signature
ENV MAUTIC_VERSION 3.2.5
ENV GIT_REPO "BrightSpark-Software/mautic"
ENV GIT_BRANCH "brightspark-features"
ENV GIT_ACCESS_TOKEN ""

# Copy init scripts and custom .htaccess
COPY docker-entrypoint.sh /entrypoint.sh

# Apply necessary permissions
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]
