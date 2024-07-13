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
garglk$ cmake --fresh -B build \
    -D CMAKE_EXPORT_COMPILE_COMMANDS=on \
    -D CMAKE_BUILD_TYPE=Release \
    -D QT_VERSION=5 \
    -D WITH_FREEDESKTOP=off \
    -D BUILD_SHARED_LIBS=off \
    -D SOUND=off \
    -D GCC_NO_CXX17=on \
    -D CMAKE_INSTALL_PREFIX=/mnt/ext1/applications/garglk \
    -D CMAKE_INSTALL_BINDIR=/mnt/ext1/applications/garglk \
    -D CMAKE_INSTALL_LIBDIR=/mnt/ext1/applications/garglk \
    -D CMAKE_TOOLCHAIN_FILE=../../3rd-parties/SDK-B288/share/cmake/arm_conf.cmake
garglk$ cmake --build build -j$(nproc)
garglk$ cmake --build build -t install DESTDIR=dist
```

Then copy files to device (with a device with a SSH server with IP address 192.168.1.34):
```
$ scp -R garglk/build/dist/mnt/ext1/applications/ 192.168.1.34:/mnt/ext1/applications/
$ scp gargoyle.app 192.168.1.34:/mnt/ext1/applications/
```

To run the application:
```
/mnt/ext1/applications/garglk # ./gargoyle.app
```
## References

- [The Interactive Fiction Database](https://ifdb.org/) huge catalog
  to test the build with
