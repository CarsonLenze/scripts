FROM ghcr.io/parkervcp/yolks:debian
ARG PMMP_Version='4'

#update dependencies
RUN apt-get update && apt-get install --no-install-recommends -y curl ca-certificates build-essential m4 gzip bzip2 bison git cmake autoconf automake pkg-config libtool libtool-bin re2c

#install php
RUN mkdir /build
WORKDIR /build
RUN curl https://raw.githubusercontent.com/pmmp/php-build-scripts/master/compile.sh -o ./compile.sh

#build php
WORKDIR /build
RUN chmod +x /build/compile.sh
RUN /build/compile.sh -P$PMMP_Version
RUN ln -s /build/bin/php7/bin/php /usr/bin/php

#install composer
WORKDIR /build
RUN curl -L https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer

#setup pterodactyl
RUN adduser -D -h /home/container container
USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]