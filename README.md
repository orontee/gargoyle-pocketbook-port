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

The build host is expected to be a Linux box. Examples are written
with Debian 12 (Bookworm) in mind.

Install build tools:

```sh
$ sudo apt install cmake meson 7z build-essentials
```

Download, unpack and patch PocketBook SDK, then activate SDK and
cross-compile 3rd-parties libraries:

```sh
$ ./scripts/install-sdk.sh
$ source env_set.sh
$ ./scripts/install-3rd-parties.sh
```

Finally build:

```sh
$ cd garglk
garglk$ git apply ../patchs/fix-missing-pair-constructor.patch
garglk$ git apply ../patchs/fix-linkage.patch
garglk$ cmake --fresh -B build -S . \
    -D CMAKE_EXPORT_COMPILE_COMMANDS=ON \
    -D CMAKE_BUILD_TYPE=Release \
    -D QT_VERSION=5 \
    -D WITH_LAUNCHER=OFF \
    -D WITH_FREEDESKTOP=OFF \
    -D INSTALL_DEV=ON \
    -D BUILD_SHARED_LIBS=OFF \
    -D SOUND=OFF \
    -D GCC_NO_CXX17=on \
    -D CMAKE_INSTALL_PREFIX=/mnt/ext1/applications/garglk \
    -D CMAKE_INSTALL_BINDIR=/mnt/ext1/applications/garglk \
    -D CMAKE_INSTALL_LIBDIR=/mnt/ext1/applications/garglk \
    -D CMAKE_TOOLCHAIN_FILE=${BUILDROOT}/SDK-B288/share/cmake/arm_conf.cmake
garglk$ cmake --build build -j$(nproc)
garglk$ cmake --build build -t install DESTDIR=dist
```

## References

- [The Interactive Fiction Database](https://ifdb.org/) huge catalog
  to test the build with
- [MobileRead
  discussion](https://www.mobileread.com/forums/showthread.php?t=358364)
  at the origin of this project
