ARG PHP_VERSION=7.2

FROM composer:latest
FROM php:${PHP_VERSION}-fpm-alpine

ARG PHP_ROOT=/var/www/html
ENV PHP_ROOT ${PHP_ROOT}

ARG PHP_EXTRA_EXTENSIONS="exif"
ENV PHP_EXTRA_EXTENSIONS ${PHP_EXTRA_EXTENSIONS}

ARG PHP_EXTRA_PECL_EXTENSIONS="xdebug apcu"
ENV PHP_EXTRA_PECL_EXTENSIONS ${PHP_EXTRA_PECL_EXTENSIONS}

ARG COMPOSER_GLOBAL_REQUIREMENTS="hirak/prestissimo \
    squizlabs/php_codesniffer=*"
ENV COMPOSER_GLOBAL_REQUIREMENTS ${COMPOSER_GLOBAL_REQUIREMENTS}

RUN set -xe; \
    apk add --update --no-cache --virtual .persistent-deps \
		git \
		icu-libs \
		zlib \
		gettext \
        libzip \
        freetype \
        libpng \
        libjpeg-turbo \
	&& apk add --update --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		libxml2-dev \
		icu-dev \
		libzip-dev \
		zlib-dev \
		freetype-dev \
                libjpeg-turbo-dev \
                libpng-dev \
		gettext-dev \
    && docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
	&& docker-php-ext-install \
		-j"$(getconf _NPROCESSORS_ONLN)" gd \
	&& docker-php-ext-install \
	    soap \
		intl \
		gettext \
		zip \
		pdo_mysql \
		pcntl \
	&& docker-php-ext-enable opcache \
	&& for ext in ${PHP_EXTRA_EXTENSIONS}; do \
        docker-php-ext-install $ext; \
    done \
    && for pecl_ext in ${PHP_EXTRA_PECL_EXTENSIONS}; do \
        pecl install $pecl_ext; \
        docker-php-ext-enable ${pecl_ext%-[0-9.]*}; \
    done \
	&& apk del .build-deps


COPY --from=0 /usr/bin/composer /usr/bin/composer

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1

# Speedup composer
RUN composer global require $COMPOSER_GLOBAL_REQUIREMENTS

# Allow saving of sh history and composer/git cache
VOLUME /root

WORKDIR ${PHP_ROOT}

