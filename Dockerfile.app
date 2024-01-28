# Use the official PHP image with Apache for PHP 8.1
FROM php:8.2-apache

# Install required extensions and dependencies
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Copy the application files to the container
COPY . /var/www/html

# Install Composer and dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-interaction --no-plugins --no-scripts

# Set up Laravel environment variables
COPY .env.example .env
RUN php artisan key:generate

# Expose port 80 for the web server
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
