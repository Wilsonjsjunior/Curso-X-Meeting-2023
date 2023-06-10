# Base image
FROM ubuntu:18.04

# Install all softwares or dependecies that we need
RUN apt-get update -y && apt-get install -y \
    python \
    git \
    python-pip \
    fastqc \
    libz-dev \
    samtools \
    wget \
    openjdk-8-jdk \
    build-essential \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    bedtools \
    freebayes \
    cutadapt \
    zip \
    python3-setuptools

# Install snpEff
RUN wget https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip && \
    unzip snpEff_latest_core.zip

## Montar o volume com os dados
COPY /* /Curso-ONCOGEN-2022