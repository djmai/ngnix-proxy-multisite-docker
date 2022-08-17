# FROM php:8.0.2-fpm
FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    vim \
    unzip \
    wget \
    && true

# |--------------------------------------------------------------------------
# | Extensiones para PHP
# |--------------------------------------------------------------------------
# |
# | Installing all the php extensions that you occupy
# |

# Install and configure php plugins
RUN set -xe \
    && buildDeps=" \
        $PHP_EXTRA_BUILD_DEPS \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libxpm-dev \
        libpng-dev \
        libicu-dev \
        libxslt1-dev \
        libmemcached-dev \
        libxml2-dev \
        libmagickwand-dev \
        libpq-dev \
    " \
	&& apt-get update -q -y && apt-get install -q -y --no-install-recommends $buildDeps && rm -rf /var/lib/apt/lists/* \
# Extract php source and install missing extensions
    && docker-php-source extract \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-xpm-dir=/usr/include/ --enable-gd-jis-conv \
    && docker-php-ext-install exif gd mbstring intl xsl zip mysqli pdo_mysql pdo_pgsql pgsql soap bcmath \
    && docker-php-ext-enable opcache \
    && cp /usr/src/php/php.ini-production ${PHP_INI_DIR}/php.ini \
    \
# Install imagemagick
    && for i in $(seq 1 3); do pecl install -o imagick && s=0 && break || s=$? && sleep 1; done; (exit $s) \
    && docker-php-ext-enable imagick \
# Install xdebug
    && for i in $(seq 1 3); do echo yes | pecl install -o "xdebug" && s=0 && break || s=$? && sleep 1; done; (exit $s) \
# Install blackfire: https://blackfire.io/docs/integrations/docker
    && version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && rm -f /tmp/blackfire-probe.tar.gz \
    \
# Install igbinary (for more efficient serialization in redis/memcached)
    && for i in $(seq 1 3); do pecl install -o igbinary && s=0 && break || s=$? && sleep 1; done; (exit $s) \
    && docker-php-ext-enable igbinary \
    \
# Install redis (manualy build in order to be able to enable igbinary)
    && for i in $(seq 1 3); do pecl install -o --nobuild redis && s=0 && break || s=$? && sleep 1; done; (exit $s) \
    && cd "$(pecl config-get temp_dir)/redis" \
    && phpize \
    && ./configure --enable-redis-igbinary \
    && make \
    && make install \
    && docker-php-ext-enable redis \
    && cd - \
    \
# Install memcached (manualy build in order to be able to enable igbinary)
    && for i in $(seq 1 3); do echo no | pecl install -o --nobuild memcached && s=0 && break || s=$? && sleep 1; done; (exit $s) \
    && cd "$(pecl config-get temp_dir)/memcached" \
    && phpize \
    && ./configure --enable-memcached-igbinary \
    && make \
    && make install \
    && docker-php-ext-enable memcached \
    && cd - \
    \
# Delete source & builds deps so it does not hang around in layers taking up space
    && pecl clear-cache \
    && rm -Rf "$(pecl config-get temp_dir)/*" \
    && docker-php-source delete \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps

# |--------------------------------------------------------------------------
# | Composer
# |--------------------------------------------------------------------------
# |
# | Installs Composer to easily manage your PHP dependencies.
# |

ENV COMPOSER_VERSION 2.3.10
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=$COMPOSER_VERSION &&\
    chmod +x /usr/local/bin/composer

# |--------------------------------------------------------------------------
# | NodeJS
# |--------------------------------------------------------------------------
# |
# | Installs NodeJS and npm. The later will allow you to easily manage
# | your frontend dependencies.
# |

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash

# and install node 
RUN apt-get install -y nodejs

WORKDIR /var/www
