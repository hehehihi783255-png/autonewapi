FROM php:8.2-cli

# posix extension (needed for worker kill via SIGTERM)
RUN (php -m | grep -q '^posix$') || docker-php-ext-install posix

WORKDIR /var/www/html

COPY index2.php /var/www/html/index.php

RUN mkdir -p /var/www/html/.data/by_key \
    && chmod -R 700 /var/www/html/.data

ENV PHP_CLI_SERVER_WORKERS=8

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
