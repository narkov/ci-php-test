FROM php:7.4
COPY ./ /app
RUN composer install
EXPOSE 8000
CMD web_server
