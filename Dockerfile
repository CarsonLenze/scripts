FROM ghcr.io/parkervcp/yolks:debian

RUN apt-get update && apt-get install --no-install-recommends -y curl ca-certificates build-essential m4 gzip bzip2 bison git cmake autoconf automake pkg-config libtool libtool-bin re2c

RUN mkdir /build
WORKDIR /build
RUN curl https://raw.githubusercontent.com/pmmp/php-build-scripts/master/compile.sh -o ./compile.sh

RUN chmod +x /build/compile.sh
RUN /build/compile.sh -P5
RUN ln -s /build/bin/php7/bin/php /usr/bin/php


RUN adduser -D -h /home/container container
USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]