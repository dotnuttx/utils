FROM debian:bullseye-slim

# install initial deps
RUN apt-get -y update \
        && apt-get install \
        --no-install-recommends \
        --no-install-suggests -y \
        make \
        g++ \
        git \
        genromfs \
        xxd \
        curl \
        ca-certificates \
        tar \
        bzip2 \
        xz-utils \
        kconfig-frontends-nox \
        bison \
        flex \
        gettext \
        texinfo \
        gperf \
        libtool \
        libelf-dev \
        libexpat-dev \
        u-boot-tools \
        util-linux \
        patch \
        cmake \
        && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

ENV HOST_PLATFORM=x86_64-linux
ENV TERM=xterm

# install arm toolchain
RUN mkdir /opt/gcc && \
    cd /opt/gcc && \
    curl -L -O https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-${HOST_PLATFORM}.tar.bz2 && \
    tar xf gcc-arm-none-eabi-9-2019-q4-major-${HOST_PLATFORM}.tar.bz2 && \
    rm -rf gcc-arm-none-eabi-9-2019-q4-major-${HOST_PLATFORM}.tar.bz2

# install Raspberry Pi Pico SDK
RUN mkdir /pipico-sdk && \
    cd /pipico-sdk && \
    git clone -b 1.1.2 https://github.com/raspberrypi/pico-sdk.git

# download dotnuttx
RUN mkdir /nuttx && \
    cd /nuttx && \
    git clone --depth=1 https://github.com/dotnuttx/incubator-nuttx nuttx && \
    git clone --depth=1 https://github.com/dotnuttx/incubator-nuttx-apps apps && \
    git clone --depth=1 --recursive --shallow-submodules https://github.com/dotnuttx/nf-interpreter nf-interpreter && \
    cd nuttx && \
    git tag nuttx-10.2.0-MicroHobby && \
    echo "v2.7.0.3.1"

# configure and build
RUN export PATH=/opt/gcc/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH && \
    export PICO_SDK_PATH=/pipico-sdk/pico-sdk && \
    cd /nuttx/nf-interpreter/targets-community/posix && \
    ./build.sh pi-pico

WORKDIR /
COPY generate.sh generate.sh
RUN chmod +x generate.sh

CMD [ "./generate.sh" ]
