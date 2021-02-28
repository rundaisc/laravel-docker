FROM php:7.3.27-fpm-alpine3.12

LABEL maintainer="Daisc <jiumengfadian@live.com>"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache --update --virtual buildDeps autoconf\
    libzip-dev \
    gcc \
    tzdata \
    g++ \
    make \
    libffi-dev \
    openssl-dev \
    && pecl install https://pecl.php.net/get/xlswriter-1.3.7.tgz \
    && docker-php-ext-enable xlswriter \
    && rm -rf /var/cache/apk/* \
    && curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/



WORKDIR /var/www
