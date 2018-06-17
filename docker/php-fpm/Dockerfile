FROM php:7.2.6-fpm-alpine

RUN apk --update add --no-cache \
    shadow \
    ca-certificates \
    curl \
    git \
    nano \
    openssh-client \
    icu \
    postgresql-dev \
    supervisor \
    rabbitmq-c \
 && apk --no-cache --virtual .temporary-dependency add \
    g++ \
    make \
    re2c \
    autoconf \
    icu-dev\
    zlib-dev \
    libc-dev \
    rabbitmq-c-dev

# Install extensions
RUN docker-php-ext-install \
    intl \
    mbstring \
    pdo \
    pgsql \
    pdo_pgsql \
    zip \
    bcmath

 # AMQP
 RUN echo autodetect | pecl install amqp \
  && docker-php-ext-enable amqp

 # Install XDebug
 RUN yes | pecl install xdebug

# Install composer package manager
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --filename=composer --install-dir=\/usr\/local\/bin \
 && php -r "unlink('composer-setup.php');"

# Remove temporary
RUN apk del .temporary-dependency


# Copy php-fpm config files
COPY ./php.ini /usr/local/etc/php/conf.d/php.ini

#Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy ssh public/private keys
COPY .ssh/ /root/.ssh

# Copy supervisor config
COPY supervisord.conf /etc/supervisord.conf

WORKDIR /var/www/backend
ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
