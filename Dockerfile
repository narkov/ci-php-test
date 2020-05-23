FROM php:7.4-alpine
FROM composer:latest AS composer
COPY ./ /app
WORKDIR '/app'
#RUN curl -sS https://getcomposer.org/installer | php -- \
#        --filename=composer \
#        --install-dir=/usr/local/bin && \
#        echo "alias composer='composer'" >> /root/.bashrc && \
#        composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
#RUN composer --version && php --v
#RUN composer install
CMD ["/usr/bin/composer", "install"]
EXPOSE 8000
EXPOSE 80
#RUN /usr/bin/composer install
RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony
RUN symfony server:ca:install
#RUN symfony serve -d
# export PATH="$HOME/.symfony/bin:$PATH"
CMD ["symfony", "serve", "-d"]
#CMD symfony serve -d 
#CMD symfony serve -d --host 0.0.0.0 --port 80