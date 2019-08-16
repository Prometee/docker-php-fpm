[![Build Status](https://travis-ci.org/Prometee/docker-php-fpm.svg?branch=master)](https://travis-ci.org/Prometee/docker-php-fpm)

Alpine PHP FPM
--

ARG vars
---

 - `PHP_VERSION` switchable PHP version
 - `PHP_ROOT` configure the `WORKDIR`
 - `PHP_EXTRA_EXTENSIONS` allow to add extra extensions
 - `PHP_EXTRA_PECL_EXTENSIONS` allow to add extra PECL extensions

Bundled extensions
---

 - gd
 - soap
 - intl
 - zip
 - pdo_mysql
 - pcntl
 - opcache

Optional PECL extensions
---

 - xdebug
 - apcu

Composer installed with `hirak/prestissimo` and `squizlabs/php_codesniffer` installed globally.
