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
        python3 \
        python3-pip \
        patch \
        && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

ENV HOST_PLATFORM=x86_64-linux
ENV TERM=xterm

# install sifive toolchain
RUN mkdir /opt/gcc && \
    cd /opt/gcc && \
    curl -L -O https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-${HOST_PLATFORM}-ubuntu14.tar.gz && \
    tar -xf riscv64-unknown-elf-gcc-8.3.0-2019.08.0-${HOST_PLATFORM}-ubuntu14.tar.gz && \
    rm -rf riscv64-unknown-elf-gcc-8.3.0-2019.08.0-${HOST_PLATFORM}-ubuntu14.tar.gz

# install esptool
RUN pip install esptool

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
RUN export PATH=/opt/gcc/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin:$PATH && \
    cd /nuttx/nf-interpreter/targets-community/posix && \
    ./build.sh esp32c3 release

WORKDIR /
COPY generate.sh generate.sh
RUN chmod +x generate.sh

CMD [ "./generate.sh" ]
