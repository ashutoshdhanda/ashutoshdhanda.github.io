FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    meson \
    ninja-build \
    git \
    wget \
    curl \
    poppler-utils \
    fontconfig \
    locales \
    pkg-config \
    libpoppler-glib-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgif-dev \
    libxml2-dev \
    libfreetype6-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    fonts-dejavu \
    fonts-liberation \
    fonts-noto \
    ttf-mscorefonts-installer && \
    fc-cache -fv

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Clone the new maintained repo and build with Meson
WORKDIR /opt
RUN git clone https://github.com/pdf2htmlEX/pdf2htmlEX.git && \
    cd pdf2htmlEX && \
    meson setup build && \
    meson compile -C build && \
    meson install -C build

WORKDIR /pdf
ENTRYPOINT ["pdf2htmlEX"]
