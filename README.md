# Gargoyle for PocketBook e-readers

A port of [Gargoyle](http://ccxvii.net/gargoyle/), the great
interactive fiction player, to
[PocketBook](https://pocketbook.ch/en-ch)
e-readers.

💡 Only support for Linux based PocketBook readers is envisionned,
Android excluded.

## 🚧 Installation

This project is work in progress.  There's nothing to install right
now, sorry.

## 🚧 Build instructions

⚠️ Don't expect anything working!  Build almost work but the
interpreter path and font path are hard-coded in the built executable…

The build host is expected to be a Linux box. Examples are written
with Debian 12 (Bookworm) in mind.

```sh
$ git submodule update --init --recursive
$ cd 3rd-parties
$ sudo apt install wget 7z build-essentials
```

Start by downloading the SDK:

```sh
3rd-parties$ wget https://github.com/pocketbook/SDK_6.3.0/releases/download/6.8/SDK-B288-6.8.7z
3rd-parties$ 7z x SDK-B288-6.8.7z
3rd-parties$ rm SDK-B288-6.8.7z
```

Update SDK paths:

```sh
3rd-parties$ ./SDK-B288/bin/update_path.sh
3rd-parties$ ./env_set.sh
```

Then activate SDK (for `CMake` uses), complete environment for `make`
and `meson` uses and fix some paths in SDK:

```sh
3rd-parties$ source env_set.sh
3rd-parties$ export  CC=${CMAKE_C_COMPILER} \
          CXX=${CMAKE_CXX_COMPILER} \
          AR=${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX}-ar \
          STRIP=${PB_STRIP} \
          RANLIB=${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX}-ranlib \
          PKGCONFIG=${TOOLCHAIN_PATH}/bin/pkg-config \
          CFLAGS="-march=armv7-a -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp"
3rd-parties$ PWDESC=$(echo ${PWD} | sed 's_/_\\/_g')
3rd-parties$ sed "s/@pwd@/$PWDESC/g" crossfile_arm.ini.in > crossfile_arm.ini
3rd-parties$ find SDK-B288/ -type f  \( -name "qt.conf" -or -name "Qt5*.cmake" \) -execdir sed -i "s@/BUILD/@${PWDESC}/@g" {} \;
3rd-parties$ find SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/usr/lib/pkgconfig -type f -name "*.pc" -execdir sed -i "s@/srv/Jenkins/workspace/SDK-GEN/output-b288/host@@g" {} \;
```

Install [libpng](http://www.libpng.org/pub/png/libpng.html) 1.6 since
Pocketbook SDK provides 1.4 only:

```sh
3rd-parties$ wget https://download.sourceforge.net/libpng/libpng-1.6.40.tar.xz
3rd-parties$ tar -xf libpng-1.6.40.tar.xz
3rd-parties$ rm libpng-1.6.40.tar.xz
3rd-parties$ cd libpng-1.6.40
3rd-parties/libpng-1.6.40$ ./configure \
           --prefix=${TOOLCHAIN_PATH}/${TOOLCHAIN_PREFIX}/sysroot/usr \
           --host=${TOOLCHAIN_PREFIX} \
           --build=x86_64-pc-linux-gnu \
           --target=${TOOLCHAIN_PREFIX}
3rd-parties/libpng-1.6.40$ make -j$(nproc)
3rd-parties/libpng-1.6.40$ make install
3rd-parties/libpng-1.6.40$ make clean
3rd-parties/libpng-1.6.40$ cd ..
```

Install [Brottli](https://github.com/google/brotli), not provided by
Pocketbook SDK:

```sh
3rd-parties$ wget https://github.com/google/brotli/archive/refs/tags/v1.1.0.zip
3rd-parties$ unzip v1.1.0.zip
3rd-parties$ rm v1.1.0.zip
3rd-parties$ cd brotli-1.1.0
3rd-parties/brotli-1.1.0$ cmake -B build -D CMAKE_INSTALL_PREFIX=${BUILDROOT}/SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/usr
3rd-parties/brotli-1.1.0$ cmake --build build -j$(nproc)
3rd-parties/brotli-1.1.0$ cmake --install build
3rd-parties/brotli-1.1.0$ rm -rf build
3rd-parties/brotli-1.1.0$ cd ..
```

Install [Harfbuzz](https://github.com/harfbuzz/harfbuzz), not provided
by Pocketbook SDK:

```sh
3rd-parties$ wget https://github.com/harfbuzz/harfbuzz/releases/download/8.5.0/harfbuzz-8.5.0.tar.xz
3rd-parties$ tar -xf harfbuzz-8.5.0.tar.xz
3rd-parties$ rm harfbuzz-8.5.0.tar.xz
3rd-parties$ cd harfbuzz-8.5.0
3rd-parties/harfbuzz-8.5.0$ meson setup build . --cross-file=../crossfile_arm.ini --prefix=/usr
3rd-parties/harfbuzz-8.5.0$ meson compile -C build
3rd-parties/harfbuzz-8.5.0$ meson install -C build --destdir=${BUILDROOT}/SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/
3rd-parties/harfbuzz-8.5.0$ rm -rf build
3rd-parties/harfbuzz-8.5.0$ cd ..
```

Install [Freetype](https://freetype.org/) since Pocketbook SDK
provides an incomplete one:

```sh
3rd-parties$ wget https://download.savannah.gnu.org/releases/freetype/freetype-2.13.2.tar.xz
3rd-parties$ tar -xf freetype-2.13.2.tar.xz
3rd-parties$ rm freetype-2.13.2.tar.xz
3rd-parties$ cd freetype-2.13.2
3rd-parties/freetype-2.13.2$ meson setup build . --cross-file=../crossfile_arm.ini --prefix=/usr
3rd-parties/freetype-2.13.2$ meson compile -C build
3rd-parties/freetype-2.13.2$ meson install -C build --destdir=${BUILDROOT}/SDK-B288/usr/arm-obreey-linux-gnueabi/sysroot/
3rd-parties/freetype-2.13.2$ rm -rf build
3rd-parties/freetype-2.13.2$ cd ..
```

⚠️ Fix CMake module `FindFreetype.cmake`:

```sh
3rd-parties$ echo "SET(FREETYPE_FOUND TRUE)" >> SDK-B288/usr/share/cmake/modules/FindFreetype.cmake
```

⚠️ Fix paths in `fontconfig.pc` and `libpng16.pc`.

Finally build:

```sh
3rd-parties$ cd ../garglk
garglk$ git apply ../fix-missing-pair-constructor.patch
garglk$ git apply ../fix-linkage.patch
garglk$ cmake -B build \
    -D BUILD_SHARED_LIBS=off \
    -D CMAKE_EXPORT_COMPILE_COMMANDS=on \
    -D CMAKE_BUILD_TYPE=Release \
    -D QT_VERSION=5 \
    -D SOUND=off \
    -D GCC_NO_CXX17=on \
    -D CMAKE_INSTALL_PREFIX=${PWD}/dist \
    -D CMAKE_TOOLCHAIN_FILE=../../3rd-parties/SDK-B288/share/cmake/arm_conf.cmake
garglk$ cmake --build build -j$(nproc) -k
```

Then copy files to device:
```
/mnt/ext1/applications/garglk # ls -lh
drwxrwxrwx    3 root     root        8.0K Jun 23 14:20 fonts
-rwxrwxrwx    1 root     root      949.7K Jun 23 14:20 gargoyle
drwxrwxrwx    3 root     root        8.0K Jun 23 14:20 icons
drwxrwxrwx    2 root     root        8.0K Jun 23 15:22 lib
drwxrwxrwx    2 root     root        8.0K Jun 23 15:46 libexec
/mnt/ext1/applications/garglk # ls -lh libexec/
-rwxrwxrwx    1 root     root      881.6K Jun 23 14:20 advsys
-rwxrwxrwx    1 root     root        1.1M Jun 23 14:20 agility
-rwxrwxrwx    1 root     root      926.2K Jun 23 14:20 alan2
-rwxrwxrwx    1 root     root     1006.0K Jun 23 14:20 alan3
-rwxrwxrwx    1 root     root        1.1M Jun 23 14:20 bocfel
-rwxrwxrwx    1 root     root      974.0K Jun 23 14:20 git
-rwxrwxrwx    1 root     root      956.8K Jun 23 14:20 glulxe
-rwxrwxrwx    1 root     root      961.6K Jun 23 14:20 hugo
-rwxrwxrwx    1 root     root      994.1K Jun 23 14:20 jacl
-rwxrwxrwx    1 root     root      965.9K Jun 23 14:20 level9
-rwxrwxrwx    1 root     root      949.7K Jun 23 14:20 magnetic
-rwxrwxrwx    1 root     root      954.8K Jun 23 14:20 plus
-rwxrwxrwx    1 root     root        1.2M Jun 23 14:20 scare
-rwxrwxrwx    1 root     root        1.1M Jun 23 14:20 scott
-rwxrwxrwx    1 root     root        2.4M Jun 23 14:20 tadsr
-rwxrwxrwx    1 root     root        1.0M Jun 23 14:20 taylor
/mnt/ext1/applications/garglk # ls -lh lib
lrwxrwxrwx    1 root     root         128 Jun 23 15:11 libbrotlicommon.so -> libbrotlicommon.so.1.1.0
-rwxrwxrwx    1 root     root      129.4K Jun 23 10:38 libbrotlicommon.so.1.1.0
lrwxrwxrwx    1 root     root         114 Jun 23 15:12 libbrotlidec.so -> libbrotlidec.so.1
lrwxrwxrwx    1 root     root         122 Jun 23 15:12 libbrotlidec.so.1 -> libbrotlidec.so.1.1.0
-rwxrwxrwx    1 root     root       41.4K Jun 23 10:38 libbrotlidec.so.1.1.0
lrwxrwxrwx    1 root     root         114 Jun 23 15:12 libbrotlienc.so -> libbrotlienc.so.1
lrwxrwxrwx    1 root     root         122 Jun 23 15:12 libbrotlienc.so.1 -> libbrotlienc.so.1.1.0
-rwxrwxrwx    1 root     root      641.4K Jun 23 10:38 libbrotlienc.so.1.1.0
lrwxrwxrwx    1 root     root         112 Jun 23 15:13 libfreetype.so -> libfreetype.so.6
lrwxrwxrwx    1 root     root         122 Jun 23 15:13 libfreetype.so.6 -> libfreetype.so.6.20.1
-rwxrwxrwx    1 root     root        3.3M Jun 23 11:30 libfreetype.so.6.20.1
-rwxrwxrwx    1 root     root      180.7K Jun 23 11:27 libharfbuzz-gobject.so.0.60850.0
-rwxrwxrwx    1 root     root       85.7K Jun 23 11:27 libharfbuzz-icu.so.0.60850.0
-rwxrwxrwx    1 root     root       35.6M Jun 23 11:27 libharfbuzz-subset.so.0.60850.0
lrwxrwxrwx    1 root     root         112 Jun 23 15:14 libharfbuzz.so -> libharfbuzz.so.0
lrwxrwxrwx    1 root     root         128 Jun 23 15:14 libharfbuzz.so.0 -> libharfbuzz.so.0.60850.0
-rwxrwxrwx    1 root     root       35.9M Jun 23 11:25 libharfbuzz.so.0.60850.0
lrwxrwxrwx    1 root     root         108 Jun 23 15:15 libpng16.so -> libpng16.so.16
lrwxrwxrwx    1 root     root         118 Jun 23 15:15 libpng16.so.16 -> libpng16.so.16.40.0
-rwxrwxrwx    1 root     root      306.7K Jun 23 10:18 libpng16.so.16.40.0
/mnt/ext1/applications/garglk # 
```

To run the application:
```
/mnt/ext1/applications/garglk # LD_LIBRARY_PATH=./lib ./gargoyle -platform pocketbook2
```

## References

- [The Interactive Fiction Database](https://ifdb.org/) huge catalog
  to test the build with
