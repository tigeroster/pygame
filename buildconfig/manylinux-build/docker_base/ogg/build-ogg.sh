#!/bin/bash
set -e -x

cd $(dirname `readlink -f "$0"`)

OGG=libogg-1.3.5
VORBIS=libvorbis-1.3.7

curl -sL http://downloads.xiph.org/releases/ogg/${OGG}.tar.gz > ${OGG}.tar.gz
curl -sL http://downloads.xiph.org/releases/vorbis/${VORBIS}.tar.gz > ${VORBIS}.tar.gz
sha512sum -c ogg.sha512

tar xzf ${OGG}.tar.gz
cd $OGG

./configure
make
make install

if [[ "$OSTYPE" == "darwin"* ]]; then
    make install DESTDIR=${MACDEP_CACHE_PREFIX_PATH}
fi

cd ..

tar xzf ${VORBIS}.tar.gz
cd $VORBIS

./configure
make
make install

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Install to mac deps cache dir as well
    make install DESTDIR=${MACDEP_CACHE_PREFIX_PATH}
fi

cd ..
