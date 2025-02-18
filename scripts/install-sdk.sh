#!/bin/bash

set -e

SDK_PATH=SDK-B288
SDK_ARCHIVE=SDK-B288-6.8.7z

function download_archive() {
    echo Downloading ${SDK_ARCHIVE}
    wget -nv -O ${SDK_ARCHIVE} https://github.com/pocketbook/SDK_6.3.0/releases/download/6.8/${SDK_ARCHIVE} > /dev/null
}

function unpack() {
    sha256sum -c ${SDK_ARCHIVE}.sha256

    7z x ${SDK_ARCHIVE}
}

function configure_and_fix() {
    ./SDK-B288/bin/update_path.sh

    patch env_set.sh patches/extend-env_set.sh.diff
    ./env_set.sh

    PWDESC=$(echo ${PWD} | sed 's_/_\\/_g')
    sed "s/@pwd@/$PWDESC/g" crossfile_arm.ini.in > crossfile_arm.ini

    find SDK-B288/ -type f \
	 \( -name "qt.conf" -or -name "Qt5*.cmake" \) \
	 -execdir sed -i "s@/BUILD/@${PWDESC}/@g" {} \;

    find SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/usr/lib/pkgconfig \
	 -type f -name "*.pc" \
	 -execdir sed -i "s@/srv/Jenkins/workspace/SDK-GEN/output-b288/host@@g" {} \;

    sed -i "s@Cflags:@#Cflags:@g" \
	SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/usr/lib/pkgconfig/fontconfig.pc
}
# ⚠️ Make sure this function is idempotent

if [ ! -d ${SDK_PATH} ]; then
    if [ ! -e ${SDK_ARCHIVE} ]; then
	download_archive
    fi
    unpack
fi

configure_and_fix
