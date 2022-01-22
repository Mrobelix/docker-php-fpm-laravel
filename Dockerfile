FROM php:apache
MAINTAINER mrobelix <admin@mrobelix.de>

# Healthcheck
#HEALTHCHECK --interval=10s --timeout=10s --start-period=10s --retries=3 \
#  CMD curl --fail http://localhost || exit 1

# Update and Upgrade System
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends libfreetype6-dev libjpeg-dev libpng-dev libwebp-dev libgmp-dev zlib1g-dev libicu-dev g++ curl npm openssl libonig-dev libzip-dev zip unzip git

# Install the PHP Extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql intl gd gmp zip mbstring exif pcntl bcmath
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure opcache --enable-opcache

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel
RUN composer global require laravel/installer

# Set Workdirectory
WORKDIR /var/www/html

# Cleaning the container
RUN apt-get autoremove -y

# Start the Website
CMD php artisan serve --host=0.0.0.0 --port=80

EXPOSE 80
