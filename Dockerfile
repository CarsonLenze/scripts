FROM ubuntu:18.04

RUN apt-get update && apt-get install --no-install-recommends -y curl ca-certificates build-essential m4 gzip bzip2 bison git cmake autoconf automake pkg-config libtool libtool-bin re2c

RUN mkdir /build
WORKDIR /build
RUN curl https://raw.githubusercontent.com/pmmp/php-build-scripts/master/compile.sh -o ./compile.sh

RUN ln -s /build/compile.sh /usr/bin/php