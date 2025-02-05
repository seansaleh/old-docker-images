FROM force-local-image-php:5.4.45-apache AS php-base

WORKDIR /var/www/html

# Install Apache rewrite, pdo_mysql, mbstring, apc, and xdebug-2.4.1
RUN a2enmod rewrite
RUN docker-php-ext-install pdo_mysql mbstring
RUN pecl channel-update pecl.php.net && yes '' | pecl install -f apc xdebug-2.4.1
RUN docker-php-ext-enable apc

# Squash the image down
FROM scratch
COPY --from=php-base / /

LABEL version="5.4.45-apache" name="php"
LABEL source="php:5.4.45-apache"

WORKDIR /var/www/html

# These values are from the original php:5.4.45-apache
ENV PHP_ENVIRONMENT=localhost \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    PHP_INI_DIR=/usr/local/etc/php \
    PHP_EXTRA_BUILD_DEPS=apache2-dev \
    PHP_EXTRA_CONFIGURE_ARGS=--with-apxs2 \
    GPG_KEYS=F38252826ACD957EF380D39F2F7956BC5DA04B5D \
    PHP_VERSION=5.4.45

EXPOSE 80
CMD [ "apache2-foreground" ]
