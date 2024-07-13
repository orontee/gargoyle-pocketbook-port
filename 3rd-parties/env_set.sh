#!/bin/bash
if [ $(basename "$0") = "env_set.sh" ]; then sed -e "s+^BUILDROOT=..*+BUILDROOT="$(realpath "$(dirname "$0")")"+" -i $0; fi
BUILDROOT=/home/matthias/Projets/gpp/3rd-parties
APPLICATIONS=defaultenv,ioc_b288,dictionaries,third_party_libs,pbres,themes-2,reader_lib.bin,qt-5.12.4-prebuilt,license,fonts,language,manuals-2,demos,extracontent-2,offlogo,pbframework11,pbframework,docx2html,antiword,hwlib,inkview,monitor-mt,common_utilities,dictionary_pb,usage_statistics,pocketbook2,digital_frame,pb_components,browser-2,audio-engine,player-2,taskmgr,reader-controller,pocketnews,ebrcfg,picviewer,pbframework-2,lcpdrmhelper,pbdictpm,calendar-2,pbonleihe,lcpdrm,pblegal,send_to_pb,obreeysocial,pbttspm,bookinfo-2,notes-2,bluetooth_configurator,audio_books,legimi,opds,bt_keymapping,empik-2,dropbox,scanner,sync_status,auto_connect,adobe_manager,pbcloud,bookstore-2,store-native-auth,umbreit_store,knv_store,bookstore,ttsengine,setup_wizard,settings,checkupdate-2,gesture_tools,eink-reader,sudoku,start,registration,swupdate,rootfs,install_scripts,cramfs,pbcrypto,sysinstall,desktop,controlpanelcustomizer,bookcard,synopsis,bookinfo,explorer-3,adobescanner,netagent,kosynka,ntpdate,chess,calc,checkupdate,bookstate,scribble,release-notes
BUILD_CFG=U_634_6.8
CMAKE_CXX_COMPILER=${BUILDROOT}/SDK-B288/usr/bin/arm-obreey-linux-gnueabi-clang++
CMAKE_CXX_COMPILER_X64=/usr/bin/g++
CMAKE_C_COMPILER=${BUILDROOT}/SDK-B288/usr/bin/arm-obreey-linux-gnueabi-clang
CMAKE_C_COMPILER_X64=/usr/bin/gcc
CMAKE_INSTALL_PREFIX=${BUILDROOT}/SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/usr/local
CMAKE_INSTALL_PREFIX_X64=${BUILDROOT}/SDK-B288/usr/local
CMAKE_TOOLCHAIN_FILE=${BUILDROOT}/SDK-B288/share/cmake/arm_conf.cmake
CMAKE_TOOLCHAIN_FILE_X64=${BUILDROOT}/SDK-B288/share/cmake/pc_conf.cmake
DATE_PART=20230626
DESTBLD=${BUILDROOT}/build
FORCE_INFFILE=mb_634.inf-user
NAME_PART=20230626_U634_6.8.1691
PB_APPLICATIONS=audio-engine,bluetooth_configurator,audio_books,player-2,!qt-5.11.2.bin,!qt-5.10.0.bin,qt-5.12.4.bin,!qt-5.10.0.bin,!qt-5.11.2.bin,!qt-5.12.4.bin,qt-5.12.4-prebuilt,!reader_lib,reader_lib.bin,bookinfo-2,bookinfo,pb_components,notes-2,manuals-2,offlogo,demos,pbres,pbttspm,pblegal,!obreeystore,bookstore-2,!pay_online,empik-2,pocketbook2,usage_statistics,!usage_stat,pbonleihe,third_party_libs,lcpdrm,!calendar,calendar-2,pbdictpm,!dictionary,!universal_sync,digital_frame,!summary,lcpdrmhelper,bt_keymapping,gesture_tools,dictionary_pb,dictionaries,!menca,!qtpb,!book-preferences,checkupdate-2,controlpanelcustomizer,!ioc,ioc_b288
PB_APPS_X=explorer-3,bookstore,!settings,calendar,!photos
PB_BIN_DIR=/srv/Jenkins/workspace/fwbuilder-ng-2/bin
PB_BRANCH=624
PB_BRAND=
PB_BUILD_FOR_X64=third_party_libs
PB_CFGFILE=config/634-config-6.8.cfg
PB_CLOUD=prod
PB_CMAKE_FLAGS=-DPBDRM=yes
PB_COMPRESS_FS=ebrmain,rootfs
PB_CONTENT2=
PB_CONTENT3=yes
PB_CPU_COUNT=12
PB_CRAMFS=squashfs-lzo
PB_CREATEFW=${BUILDROOT}/createFW
PB_DATA_DIR=/srv/Jenkins/workspace/fwbuilder-ng-2/DATA
PB_DATETIME=20230626_051108
PB_DEBUG=
PB_DESTFS=${BUILDROOT}/ebrmain_fs
PB_DEVICE=634
PB_DEVICE_AUDIO=5
PB_DEVICE_BLUETOOTH=6
PB_DISPLAY_DPI=300
PB_DISPLAY_HEIGHT=1448
PB_DISPLAY_WIDTH=1072
PB_DROPBOX_VERSION=V1
PB_FREEZE=network
PB_FWINFO_SERIAL=YTG_________________
PB_GCP=
PB_GDB=yes
PB_GLIBC=2.23
PB_HAS_EXTCARD=0
PB_HAVE_OPENCV=yes
PB_HAVE_TOUCHPANEL=yes
PB_HOST_CTEST=yes
PB_HOST_GTEST_SRC=/usr/src/gtest
PB_HTTP_ROOT=https://files.obreey-products.com/FW/by_dev/
PB_HTTP_URL_CHECK=no
PB_HWLIB=yes
PB_KERNEL=634
PB_LABEL=6.8
PB_LABEL_reader_lib=6.8,eink_epub3
PB_LCP_DRM=yes
PB_LCP_PASSPHRASE=yes
PB_LEGIMIDRM=yes
PB_LIBCURL=libcurl-nspr
PB_LOCAL_REPOS=/srv/hg/repos
PB_LOG=log_20230626_U634_6.8.1691
PB_LOG_LEVEL=0
PB_MAX_EBRMAIN=409600
PB_MOVENOTES=
PB_NEW_MOTION=yes
PB_OBREEYDRM=yes
PB_OBREEYSOCIAL=no
PB_OBREEYSTORE=yes
PB_OBREEYSYNC=no
PB_OPDS=yes
PB_OTA_CONFIG_UPDATER=yes
PB_OTA_SERVER_TYPE=Release
PB_OTA_SN=
PB_PROTECTION_OFF=
PB_PUSH_NOTIFICATIONS=no
PB_QML_IN_OTA=yes
PB_QT=no
PB_QT_REBUILD=full
PB_QT_REPO=qt-5.12.4.bin
PB_QT_SEPARATE_BUILD=yes
PB_QT_XPLATFORM=linux-arm-gnueabi-630-clang++
PB_READER_LIB_BIN=true
PB_REPO_APP=defaultenv
PB_REPO_URL=ssh://repo@repo.obreey-products.com
PB_S2PB=yes
PB_SDK_CFG=${BUILDROOT}/SDK-B288/config.cmake
PB_SDK_URL=http://download.pocketbook-int.com/TestFW/SDK/toolchain-SDK-B288-6.7.tar.gz
PB_SETTINGS_VERSION=3
PB_STATIC_PBCRYPTO=yes
PB_STRIP=${BUILDROOT}/SDK-B288/usr/bin/arm-obreey-linux-gnueabi-strip
PB_STRIP_X64=/usr/bin/strip
PB_TEMPLATE_DIR=/srv/Jenkins/workspace/fwbuilder-ng-2/templates
PB_THEME=Line
PB_TOOLCHAIN_PATH=${BUILDROOT}/SDK-B288
PB_TOOLCHAIN_PREFIX=arm-obreey-linux-gnueabi
PB_TOUCHPANEL=17
PB_UNIX_DATETIME=1687745468
PB_USAGE_STAT=no
PB_USE_AUDIOBOOKS=yes
PB_USE_DROPBOX=yes
PB_USE_PAYONLINE=yes
PB_USE_QT5=yes
PB_USE_SSH=yes
PB_USE_TTS=yes
PB_VARIANT=U
PB_VERSION=6.8.1691
PB_WITH_EFS_FUNCTIONS=yes
PB_X64_BUILD=yes
PS4=+ 
SWTYP=user
TOOLCHAIN_PATH=${BUILDROOT}/SDK-B288/usr
TOOLCHAIN_PREFIX=arm-obreey-linux-gnueabi
WORKSPACE=/srv/Jenkins/workspace/fwbuilder-ng-2
export BUILD_CFG
export PB_CMAKE_FLAGS
export PB_UNIX_DATETIME
export PB_HTTP_URL_CHECK
export PB_TEMPLATE_DIR
export PB_HOST_GTEST_SRC
export PB_HTTP_ROOT
export PB_FREEZE
export PB_DATA_DIR
export PB_READER_LIB_BIN
export PB_COMPRESS_FS
export PB_DESTFS
export PB_SETTINGS_VERSION
export CMAKE_TOOLCHAIN_FILE_X64
export PB_LIBCURL
export PB_OTA_CONFIG_UPDATER
export NAME_PART
export PB_DEVICE
export PB_QT_REBUILD
export PB_USE_QT5
export PB_MERCURIAL
export PB_CPU_COUNT
export PB_DISPLAY_HEIGHT
export PB_BIN_DIR
export PB_OPDS
export PB_OBREEYSYNC
export PB_OBREEYSOCIAL
export WORKSPACE
export PB_SDK_URL
export PB_QT
export PB_WITH_EFS_FUNCTIONS
export PB_THEME
export PB_HAVE_OPENCV
export CMAKE_CXX_COMPILER_X64
export SWTYP
export PS4
export PB_FTP_ROOT
export PB_REPO_URL
export PB_TOOLCHAIN_PATH
export PB_CFGFILE
export PB_LOG_LEVEL
export PB_LCP_PASSPHRASE
export PB_USAGE_STAT
export TOOLCHAIN_PATH
export PB_QT_REPO
export CMAKE_TOOLCHAIN_FILE
export PB_BUILD_FOR_X64
export PB_LOG
export CMAKE_C_COMPILER_X64
export PPID
export PB_OTA_SN
export PB_MOVENOTES
export PB_APPLICATIONS
export DESTBLD
export PB_HOST_CTEST
export PB_QT_XPLATFORM
export PB_HAS_EXTCARD
export PB_REPO_APP
export PB_DATETIME
export PB_LABEL
export PB_S2PB
export PB_GCP
export PB_USE_AUDIOBOOKS
export PB_SDK_CFG
export PB_FTP_LOGIN
export PB_FWINFO_SERIAL
export CMAKE_CXX_COMPILER
export PB_DISPLAY_WIDTH
export TOOLCHAIN_PREFIX
export PB_GDB
export PB_OBREEYDRM
export PB_USE_SSH
export PB_STATIC_PBCRYPTO
export PB_BRANCH
export CMAKE_INSTALL_PREFIX
export PB_USE_TTS
export PB_CRAMFS
export PB_DEBUG
export PB_QT_SEPARATE_BUILD
export DATE_PART
export PB_X64_BUILD
export PB_APPS_X
export PB_CREATEFW
export PB_BRAND
export PB_LEGIMIDRM
export PB_VARIANT
export PB_DISPLAY_DPI
export BUILDROOT
export PB_TOOLCHAIN_PREFIX
export PB_QML_IN_OTA
export PB_VERSION
export APPLICATIONS
export PB_CLOUD
export PB_STRIP
export PB_LOCAL_REPOS
export PB_HWLIB
export PB_OTA_SERVER_TYPE
export PB_NEW_MOTION
export CMAKE_INSTALL_PREFIX_X64
export PB_LABEL_reader_lib
export PB_MAX_EBRMAIN
export PB_OTA_REMOTEDIR
export PB_DEVICE_AUDIO
export PB_DEVICE_BLUETOOTH
export PB_PUSH_NOTIFICATIONS
export PB_PROTECTION_OFF
export FORCE_INFFILE
export PB_KERNEL
export PB_HAVE_TOUCHPANEL
export PB_GLIBC
export PB_FTP_PASS
export PB_USE_PAYONLINE
export PB_CONTENT3
export PB_CONTENT2
export PB_OBREEYSTORE
export PB_STRIP_X64
export PB_FTP_HOST
export PB_DROPBOX_VERSION
export CMAKE_C_COMPILER
export PB_TOUCHPANEL
export PB_LCP_DRM
export PB_USE_DROPBOX
