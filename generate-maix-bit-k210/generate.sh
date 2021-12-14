#!/bin/bash

#ls -lah /nuttx/nf-interpreter/targets-community/posix/

# copy from bind mount to the romfs appdir
rm -rf /nuttx/apps/examples/nf_romfs/appdir/*.pe
cp /nf/*.pe /nuttx/apps/examples/nf_romfs/appdir/

# go to the source code folder
cd /nuttx/nuttx

# generate
export PATH=/opt/gcc/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin:$PATH

make -j12 && \
    cp nuttx.bin /nf/dotnetnf.bin
