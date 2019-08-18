ARG PHP_VERSION=7.2

FROM composer:latest
FROM php:${PHP_VERSION}-fpm-alpine

ARG PHP_ROOT=/var/www/html
ENV PHP_ROOT ${PHP_ROOT}

ARG PHP_EXTRA_EXTENSIONS=""
ENV PHP_EXTRA_EXTENSIONS ${PHP_EXTRA_EXTENSIONS}

ARG PHP_EXTRA_PECL_EXTENSIONS="xdebug apcu"
ENV PHP_EXTRA_PECL_EXTENSIONS ${PHP_EXTRA_PECL_EXTENSIONS}

RUN apk add --update --no-cache --virtual .persistent-deps \
		git \
		icu-libs \
		zlib
RUN set -xe; \
	apk add --update --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		libxml2-dev \
		icu-dev \
        libzip-dev \
		zlib-dev \
		freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
	&& docker-php-ext-install \
		-j"$(getconf _NPROCESSORS_ONLN)" gd \
	&& docker-php-ext-install \
	    soap \
		intl \
		zip \
		pdo_mysql \
		pcntl \
	&& docker-php-ext-enable opcache \
	&& apk del .build-deps \
	&& apk add --update --no-cache \
	    freetype \
	    libpng \
	    libjpeg-turbo

RUN set -xe; \
    for ext in ${PHP_EXTRA_EXTENSIONS}; do \
        docker-php-ext-install $ext; \
    done

RUN set -xe; \
    apk add --update --no-cache --virtual .build-deps \
            $PHPIZE_DEPS \
            libxml2-dev \
            icu-dev \
            libzip-dev \
            zlib-dev \
            freetype-dev \
            libjpeg-turbo-dev \
            libpng-dev \
    && for pecl_ext in ${PHP_EXTRA_PECL_EXTENSIONS}; do \
        pecl install $pecl_ext; \
        docker-php-ext-enable ${pecl_ext%-[0-9.]*}; \
    done \
    && apk del .build-deps

COPY --from=0 /usr/bin/composer /usr/bin/composer

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1

# Speedup composer
RUN composer global require "hirak/prestissimo" "squizlabs/php_codesniffer=*"

VOLUME /root

WORKDIR ${PHP_ROOT}

