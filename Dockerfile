FROM php:7.4
COPY ./ /app
WORKDIR '/app'
RUN curl -sS https://getcomposer.org/installer | php -- \
        --filename=composer \
        --install-dir=/usr/local/bin && \
        echo "alias composer='composer'" >> /root/.bashrc && \
        composer
RUN "composer install"
EXPOSE 8000
CMD "symfony serve -d --host 0.0.0.0 --port 80"
