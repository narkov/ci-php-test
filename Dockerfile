FROM php:7.4
COPY ./ /app
RUN curl -sS https://getcomposer.org/installer | \
            php -- --install-dir=/usr/bin/ --filename=composer
RUN "composer install"
EXPOSE 8000
CMD "symfony serve -d --host 0.0.0.0 --port 80"
