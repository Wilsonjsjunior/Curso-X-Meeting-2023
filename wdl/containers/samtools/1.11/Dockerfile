FROM ubuntu:20.04 as builder

RUN apt-get update \
    && apt-get install -y \
        gcc \
        libbz2-dev \
        libcurl4-openssl-dev \
        liblzma-dev \
        libncurses5-dev \
        libssl-dev \
        make \
        wget \
        zlib1g-dev

RUN wget https://github.com/samtools/samtools/releases/download/1.11/samtools-1.11.tar.bz2 \
    && tar xf samtools-1.11.tar.bz2 \
    && cd samtools-1.11 \
    && ./configure \
    && make

FROM ubuntu:20.04

RUN apt-get update \
    && apt-get -y install \
        libcurl4-openssl-dev \
        libdigest-md5-file-perl

COPY --from=builder /samtools-1.11/samtools /samtools-1.11/misc/* /bin/
