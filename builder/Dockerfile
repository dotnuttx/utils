ARG ARCH_SHA=debian:sid
FROM debian@$ARCH_SHA

RUN apt-get -y update && apt-get install -y \
    binutils \
    make \
    cmake \
    clang \
    gcc \
    g++ \
    git \
    libgpiod-dev && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# docker run -v $(pwd)/nf-interpreter dotnuttx/builder:<arch>
WORKDIR /nf-interpreter/targets-community/posix

CMD ["./build.sh"]
