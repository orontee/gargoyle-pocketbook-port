#!/bin/bash

set -e

function fetch_and_compile_libpng() {
    echo Downloading and building libpng

    local name=libpng-1.6.40
    local archive=${name}.tar.xz
    local archive_url=https://download.sourceforge.net/libpng/${archive}

    wget -nv -O ${archive} ${archive_url} > /dev/null
    sha256sum -c ${archive}.sha256

    tar -xf ${archive}
    rm ${archive}

    cd ${name}
    cmake -B build build -S . \
          -D CMAKE_INSTALL_PREFIX=${BUILDROOT}/SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/usr \
          -D CMAKE_TOOLCHAIN_FILE=${BUILDROOT}/SDK-B288/share/cmake/arm_conf.cmake

    cmake --build build
    cmake --install build

    rm -rf build
    cd ..
}

function fetch_and_compile_brotli() {
    echo Downloading and building Brotli

    local archive=v1.1.0.zip
    local archive_url=https://github.com/google/brotli/archive/refs/tags/${archive}

    wget -nv -O ${archive} ${archive_url} > /dev/null
    sha256sum -c ${archive}.sha256

    unzip ${archive}
    rm ${archive}

    cd brotli-1.1.0
    cmake -B build build -S . \
          -D CMAKE_INSTALL_PREFIX=${BUILDROOT}/SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/usr \
          -D CMAKE_TOOLCHAIN_FILE=${BUILDROOT}/SDK-B288/share/cmake/arm_conf.cmake

    cmake --build build
    cmake --install build

    rm -rf build
    cd ..
}

function fetch_and_compile_harfbuzz() {
    echo Downloading and building Harfbuzz

    local name=harfbuzz-8.5.0
    local archive=${name}.tar.xz
    local archive_url=https://github.com/harfbuzz/harfbuzz/releases/download/8.5.0/${archive}

    wget -nv -O ${archive} ${archive_url} > /dev/null
    sha256sum -c ${archive}.sha256

    tar -xf ${archive}
    rm ${archive}

    cd ${name}
    meson setup build . --cross-file=../../crossfile_arm.ini --prefix=/usr
    meson compile -C build
    meson install -C build --destdir=${BUILDROOT}/SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/

    rm -rf build
    cd ..
}

function fetch_and_compile_freetype() {
    echo Downloading and building FreeType

    local name=freetype-2.13.2
    local archive=${name}.tar.xz
    local archive_url=https://download.savannah.gnu.org/releases/freetype/${archive}

    wget -nv -O ${archive} ${archive_url} > /dev/null
    sha256sum -c ${archive}.sha256

    tar -xf ${archive}
    rm ${archive}

    cd ${name}
    meson setup build . --cross-file=../../crossfile_arm.ini --prefix=/usr
    meson compile -C build
    meson install -C build --destdir=${BUILDROOT}/SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/

    echo "SET(FREETYPE_FOUND TRUE)" \
	 >> ${BUILDROOT}/SDK-B288/usr/share/cmake/modules/FindFreetype.cmake

    rm -rf build
    cd ..
}

cd 3rd-parties

fetch_and_compile_libpng
# The version provided by PocketBook SDK doesn't match FreeType
# expectations

fetch_and_compile_brotli
fetch_and_compile_harfbuzz
# Not provided by PocketBook SDK

fetch_and_compile_freetype
# The version provided by PocketBook SDK doesn't match garglk
# expectations

cd ..
