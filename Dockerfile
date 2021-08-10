FROM php:apache
MAINTAINER mrobelix <admin@mrobelix.de>

# Healthcheck
HEALTHCHECK --interval=10s --timeout=10s --start-period=10s --retries=3 \
  CMD curl --fail http://localhost || exit 1

# Update and Upgrade System
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends libfreetype6-dev libjpeg-dev libpng-dev libwebp-dev libgmp-dev zlib1g-dev libpng-dev libicu-dev g++ curl libzip-dev zip unzip git

# Install the PHP Extensions
RUN docker-php-ext-install opcache mysqli intl gd gmp zip
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure opcache --enable-opcache
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set Workdirectory
WORKDIR /var/www/html

# Cleaning the container
RUN apt-get autoremove -y

EXPOSE 80