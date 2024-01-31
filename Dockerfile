FROM ghcr.io/parkervcp/yolks:debian

RUN apt-get update && apt-get install --no-install-recommends -y curl ca-certificates build-essential m4 gzip bzip2 bison git cmake autoconf automake pkg-config libtool libtool-bin re2c

RUN adduser -D -h /home/container container
USER container
ENV  USER=container HOME=/home/container

RUN mkdir /build
WORKDIR /build
RUN curl https://raw.githubusercontent.com/pmmp/php-build-scripts/master/compile.sh -o ./compile.sh

RUN ./compile.sh -P5 -j ${THREADS:-$(grep -E ^processor /proc/cpuinfo | wc -l)}
RUN ln -s ./bin/php7/bin/php /usr/bin/php

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]