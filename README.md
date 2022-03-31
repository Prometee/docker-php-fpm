[![Build Status][ico-github-actions]][link-github-actions]
[![Docker][ico-microbadger]][link-microbadger]

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
 - imagick
 - intl
 - zip
 - pdo_mysql
 - pcntl
 - opcache
 - exif

Additional extensions (not available in '*-minimum' images)
---

 - soap
 - xmlrpc (Since PHP >=8 it becomes a PECL extension)

Optional PECL extensions (not available in '*-minimum' images)
---

 - xdebug
 - apcu

Composer
--- 

Globally installed with no extra packages

[ico-github-actions]: https://github.com/Prometee/docker-php-fpm/workflows/Build/badge.svg
[ico-microbadger]: https://images.microbadger.com/badges/image/fluxaudio/php-fpm.svg

[link-github-actions]: https://github.com/Prometee/docker-php-fpm/actions?query=workflow%3A"Build"
[link-microbadger]: https://microbadger.com/images/fluxaudio/php-fpm
