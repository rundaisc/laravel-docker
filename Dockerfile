FROM php:7.2.34-fpm-alpine3.12


RUN mkdir -p /var/www/html
RUN mkdir -p /run/nginx &&  touch /run/nginx/nginx.pid
WORKDIR /var/www/html

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
    supervisor \
    nginx \
    vim \
    && pecl install https://pecl.php.net/get/xlswriter-1.3.7.tgz \
    && pecl install redis \
    && docker-php-ext-enable xlswriter redis\
    && rm -rf /var/cache/apk/* \
    && curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

#RUN sed '/user/d' /etc/nginx/nginx.conf

#RUN echo "user www-data www-data;">>/etc/nginx/nginx.conf

ENV TZ Asia/Kuala_Lumpur

RUN apk add tzdata && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone



EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
