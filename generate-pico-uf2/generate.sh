#!/bin/bash

#ls -lah /nuttx/nf-interpreter/targets-community/posix/

# copy from bind mount to the romfs appdir
rm -rf /nuttx/apps/examples/nf_romfs/appdir/*.pe
cp /nf/*.pe /nuttx/apps/examples/nf_romfs/appdir/

# go to the source code folder
cd /nuttx/nuttx

# generate
export PATH=/opt/gcc/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH
export PICO_SDK_PATH=/pipico-sdk/pico-sdk

make -j12 && \
    cp nuttx.uf2 /nf/dotnetnf.uf2
