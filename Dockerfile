# Set the base image for subsequent instructions
FROM php:7.4.21

RUN apt-get update \
  && apt-get install -qq \
    curl \
    g++ \
    git \
    libbz2-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libonig-dev \
    libmcrypt-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    unzip \
    zip \
    zlib1g-dev \
  && apt-get clean

RUN docker-php-ext-install -j$(nproc) calendar
RUN docker-php-ext-install -j$(nproc) iconv
RUN docker-php-ext-configure intl \
  && docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-configure gd $(GD_OPTIONS) \
  && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) mbstring
RUN docker-php-ext-install -j$(nproc) mysqli
RUN docker-php-ext-install -j$(nproc) pdo_mysql
RUN docker-php-ext-install -j$(nproc) soap
RUN docker-php-ext-install -j$(nproc) xsl
RUN docker-php-ext-install -j$(nproc) zip

# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --2 --install-dir=/usr/local/bin --filename=composer
