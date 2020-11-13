[![Build Status](https://travis-ci.org/Prometee/docker-php-fpm.svg?branch=master)](https://travis-ci.org/Prometee/docker-php-fpm)
[![](https://images.microbadger.com/badges/image/fluxaudio/php-fpm.svg)](https://microbadger.com/images/fluxaudio/php-fpm "Get your own image badge on microbadger.com")

Alpine PHP FPM + composer
--

ARG vars
---

 - `PHP_VERSION` switchable PHP version
 - `PHP_ROOT` configure the `WORKDIR`
 - `PHP_EXTRA_EXTENSIONS` allow to add extra extensions
 - `PHP_EXTRA_PECL_EXTENSIONS` allow to add extra PECL extensions
 - `COMPOSER_GLOBAL_REQUIREMENTS` allow to add extra global composer requirements

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

Composer
--- 

Globally installed with no extra packages
 
