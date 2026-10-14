---
title: "Download GStreamer"
---

If you're on Linux or a BSD variant, you can install GStreamer using your
package manager.

For other platforms listed below, we provide binary releases in
the form of official installers or tarballs maintained by the GStreamer
project. 

Choose your platform below for more information.

{{< tabs >}}

{{% tab id="sources" title="Sources" color="r" %}}
For building the aforementioned binary releases, you need to use the [Cerbero
build aggregator](/documentation/installing/building-from-source-using-cerbero.html)
maintained by the GStreamer project which supports building on Linux, macOS,
and Windows.

For downloading each GStreamer module individually, check our [modules
page](/modules/), or go straight to our [source download directory](/src/).

Generally, you should not need to build from source yourself unless you need
features that are only available in a newer version of GStreamer than is
provided by your distribution or in the last stable release.

For doing GStreamer development, we recommend using the [GStreamer monorepo
build from Git](/documentation/installing/building-from-source-using-meson.html)
which will build all the main GStreamer modules in one go using [Meson's subproject
feature](https://mesonbuild.com/Subprojects.html).
{{% /tab %}}

{{% tab id="windows" title="Windows" color="g" %}}
The latest stable release is **{{% ver bin %}}**. Installers are available for the following targets:

* [MSVC x86_64 (VS 2022, Release CRT)](/data/pkg/windows/{{% ver bin %}}/msvc/gstreamer-1.0-msvc-x86_64-{{% ver bin %}}.exe)
* [MSVC x86 (VS 2022, Release CRT)](/data/pkg/windows/{{% ver bin %}}/msvc/gstreamer-1.0-msvc-x86-{{% ver bin %}}.exe)
* [MSVC arm64 (VS 2022, Release CRT)](/data/pkg/windows/{{% ver bin %}}/msvc/gstreamer-1.0-msvc-arm64-{{% ver bin %}}.exe)
* [MinGW x86_64](/data/pkg/windows/{{% ver bin %}}/mingw/gstreamer-1.0-mingw-x86_64-{{% ver bin %}}.exe)
* [MinGW x86](/data/pkg/windows/{{% ver bin %}}/mingw/gstreamer-1.0-mingw-x86-{{% ver bin %}}.exe)

If you are not sure which to pick between MSVC and MinGW, just pick MSVC.
However, do see the [toolchain compatibility notes](#toolchain-compatibility-notes)
below which may affect you based on what toolchain your app will be built with.

Starting with 1.28, the installers are built with Inno Setup 6, which now allows
user-only as well as system-wide installs. The default installation directory is
`%LOCALAPPDATA%\Programs\gstreamer\1.0\abi>_<arch>` for user-only installs,
and `%ProgramFiles%\gstreamer\1.0\<abi>_<arch>` for system-wide installs.
This can be changed from the installation wizard or from the command line (see
below).

The installers also accept optional command line parameters. These can be useful
for unattended installations. Here's a short list of the most important ones:

- `/DIR=path` sets the full path to the installation directory, e.g. `/DIR=z:/path/to/gst` will result in `gst-launch-1.0` being installed to `z:/path/to/gst/bin/gst-launch-1.0.exe`. This parameter allows slashes and backslashes for directory separator.
- `/TYPE=debug` (or `devel`, `runtime`) sets the installation type to "Runtime, development headers and debug symbols", "Runtime and development headers", and "Only runtime", respectively.
- `/ALLUSERS` and `/CURRENTUSER` set the installation to be performed for all users or just the current user, respectively.
- `/SILENT` just displays the progress dialog; `/VERYSILENT` displays no dialogs at all except when an error occurs. They are usually coupled with `/NORESTART` to avoid unattended reboots.

You can read more about them in the [Inno Setup Help](https://jrsoftware.org/ishelp/index.php?topic=setupcmdline).

**Python wheels** are also available via PyPI, starting with 1.28.0. Simply run:

```
pip install gstreamer-bundle
```

NOTE: The libraries built with MSVC are named differently from MinGW;
specifically the DLLs are of the form `foo.dll` instead of `libfoo.dll`.

NOTE: [GstSharp .NET bindings](https://www.nuget.org/packages/GstSharp/)
require the MSVC binaries starting with 1.18.

[Older 1.x binary releases](/data/pkg/windows) are also available. Older
installers are split into runtime and development packages, so for app
development, you will want to install both packages.

The Universal Windows Platform builds are in the [download archive](/download/archive.html).

#### Toolchain Compatibility Notes {#toolchain-compatibility-notes}

On Windows, you can use a number of different toolchains and versions thereof,
and it is not always obvious how these can be mixed and matched with the
binaries provided above by GStreamer.

The first step is ensuring that you're using the correct architecture. You
should not try to mix 32-bit code built with any toolchain with 64-bit code
built with any toolchain.

Next, understand that since GStreamer is written mostly in C, all APIs exported
by GStreamer libraries and plugins use C ABIs. Even plugins written in other
languages such as Rust, C++, C#, Python, etc, are loaded using the C ABI.

This means you can consume the GStreamer binaries from any toolchain that uses
the same C ABI. Using the same [CRT (C Runtime)](https://docs.microsoft.com/en-us/cpp/c-runtime-library/crt-library-features)
is better, but it's not always a requirement. Here's the matrix outlining the
CRT used for each GStreamer version:

| GStreamer version | MinGW        | MSVC         |
| ----------------- | ------------ | ------------ |
| 1.18+             | ucrtbase.dll | ucrtbase.dll |
| 1.16              | msvcrt.dll   | ucrtbase.dll |
| 1.14              | msvcrt.dll   | N/A          |

This is the toolchain compatibility matrix with the stable releases:

| App Toolchain                                         | 1.16 MinGW | 1.16 MSVC | 1.18+ MinGW | 1.18+ MSVC |
| ----------------------------------------------------- | ---------- | --------- | ----------- | ---------- |
| Visual Studio 2015 and newer (ucrtbase.dll)           | PARTIAL    | FULL      | FULL        | FULL       |
| Visual Studio 2013 and older (msvcrt.dll)             | PARTIAL    | PARTIAL   | PARTIAL     | PARTIAL    |
| [MinGW](http://mingw.org) (msvcrt.dll)                | FULL       | PARTIAL   | PARTIAL     | PARTIAL    |
| [MinGW-w64](https://mingw-w64.org) (msvcrt.dll)       | FULL       | PARTIAL   | PARTIAL     | PARTIAL    |
| [MSYS2 MinGW-w64](https://www.msys2.org) (msvcrt.dll) | FULL       | PARTIAL   | PARTIAL     | PARTIAL    |
| [Cygwin](http://cygwin.com)                           | NONE       | NONE      | NONE        | NONE       |

**FULL** means full C compatibility, including debugging symbols.

**PARTIAL** means mixing the two should be fine as long as you are careful while
[passing memory across CRT boundaries](https://docs.microsoft.com/en-us/cpp/c-runtime-library/potential-errors-passing-crt-objects-across-dll-boundaries).

**NONE** means fully unsupported, and *will* lead to crashes.
{{% /tab %}}

{{% tab id="macos" title="macOS" color="g" %}}
Binary releases in the form of `.pkg` framework installers are available. The
installers are split into runtime, development, and debug packages. For
development, you will want to install both runtime and development packages.
The oldest supported macOS is 10.13 (High Sierra).

* **macOS Universal (X86_64 & ARM64) {{% ver bin_branch %}} release (current stable version)**
  - **[{{% ver bin %}} runtime installer](/data/pkg/osx/{{% ver bin %}}/gstreamer-1.0-{{% ver bin %}}-universal.pkg)**
  - **[{{% ver bin %}} development installer](/data/pkg/osx/{{% ver bin %}}/gstreamer-1.0-devel-{{% ver bin %}}-universal.pkg)**
  - **[{{% ver bin %}} debug installer](/data/pkg/osx/{{% ver bin %}}/gstreamer-1.0-debug-{{% ver bin %}}-universal.pkg)**

* macOS Universal (X86_64 & ARM64) {{% ver old_bin_branch %}} release (old stable version)
  - [{{% ver old_bin %}} runtime installer](/data/pkg/osx/{{% ver old_bin %}}/gstreamer-1.0-{{% ver old_bin %}}-universal.pkg)
  - [{{% ver old_bin %}} development installer](/data/pkg/osx/{{% ver old_bin %}}/gstreamer-1.0-devel-{{% ver old_bin %}}-universal.pkg)

**Python wheels** are also available via PyPI, starting with 1.28.0. Simply run:

```
pip install gstreamer-bundle
```

GStreamer is also maintained by third-parties in the
[![Homebrew package](https://repology.org/badge/version-for-repo/homebrew/gstreamer.svg)](https://formulae.brew.sh/formula/gstreamer).
You should be able to use that, but please note that some plugins are not
shipped by Homebrew, and you should avoid mixing Homebrew and the official
installers on the same system.


[Older 1.x binary releases](/data/pkg/osx) are also available.
{{% /tab %}}

{{% tab id="linux" title="Linux" color="g" %}}
All Linux distributions and many BSD variants provide packages of GStreamer.
You will find these in your distribution's package repository.

[![Arch package](https://repology.org/badge/version-for-repo/arch/gstreamer.svg?header=Arch)](https://repology.org/project/gstreamer/versions)
[![Debian 14 package](https://repology.org/badge/version-for-repo/debian_14/gstreamer.svg?header=Debian%2014)](https://repology.org/project/gstreamer/versions)
[![Debian unstable package](https://repology.org/badge/version-for-repo/debian_unstable/gstreamer.svg?header=Debian%20Unstable)](https://repology.org/project/gstreamer/versions)
[![Fedora 44 package](https://repology.org/badge/version-for-repo/fedora_44/gstreamer.svg?header=Fedora%2044)](https://repology.org/project/gstreamer/versions)
[![Fedora rawhide package](https://repology.org/badge/version-for-repo/fedora_rawhide/gstreamer.svg?header=Fedora%20Rawhide)](https://repology.org/project/gstreamer/versions)
[![Manjaro stable package](https://repology.org/badge/version-for-repo/manjaro_stable/gstreamer.svg?header=Manjaro%20Stable)](https://repology.org/project/gstreamer/versions)
[![Manjaro unstable package](https://repology.org/badge/version-for-repo/manjaro_unstable/gstreamer.svg?header=Manjaro%20Unstable)](https://repology.org/project/gstreamer/versions)
[![openSUSE Leap 15.6 package](https://repology.org/badge/version-for-repo/opensuse_leap_15_6/gstreamer.svg?header=openSUSE%2015.6)](https://repology.org/project/gstreamer/versions)
[![openSUSE Tumbleweed package](https://repology.org/badge/version-for-repo/opensuse_tumbleweed/gstreamer.svg?header=openSUSE%20Tumbleweed)](https://repology.org/project/gstreamer/versions)
[![Ubuntu 24.04 LTS package](https://repology.org/badge/version-for-repo/ubuntu_24_04/gstreamer.svg?header=Ubuntu%20LTS)](https://repology.org/project/gstreamer/versions)
[![Ubuntu 26.04 package](https://repology.org/badge/version-for-repo/ubuntu_26_04/gstreamer.svg?header=Ubuntu%2026.04)](https://repology.org/project/gstreamer/versions)

Note that some distributions split the GStreamer plugins up further than the
upstream sources. Additionally, some distributions do not include some plugins
from the gst-plugins-bad package, or omit the gst-plugins-ugly and gst-libav
packages entirely in their main repository for legal reasons.

gst-plugins-rs is another large set of plugins that aren't packaged by some
distros. Since these are in [a standalone repository](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs),
it is straightforward for developers to build them by hand with [`cargo-c`](https://github.com/lu-zero/cargo-c/).
{{% /tab %}}

{{% tab id="android" title="Android" color="b" %}}
Binary releases are available with each in the form of a single "universal"
tarball with `armv7`, `arm64`, `x86`, and `x86_64` architectures in subfolders.

* **Android Universal [{{% ver bin %}} tarball](/data/pkg/android/{{% ver bin %}}/gstreamer-1.0-android-universal-{{% ver bin %}}.tar.xz) (current stable version)**
* Android Universal [{{% ver old_bin %}} tarball](/data/pkg/android/{{% ver old_bin %}}/gstreamer-1.0-android-universal-{{% ver old_bin %}}.tar.xz) (old stable version)

The Android NDKs used by our stable releases are:

| GStreamer version | NDK Version |
| ----------------- | ----------- |
| 1.28.x            | r25c        |
| 1.26.x            | r25c        |
| 1.24.x            | r25c        |
| 1.22.x            | r21         |
| 1.20.x            | r21         |
| 1.18.x            | r21         |
| 1.16.x            | r18b        |

The Android APIs targeted by our stable release(s) are:

| Architecture | API Targeted (GStreamer 1.22 - 1.26) | API Targeted (GStreamer >= 1.28) |
| ------------ | --------------------------------------------------- | --------------------------------------------------- |
| armv7        | v21 (Lollipop) | v24 (Nougat) |
| x86          | v21 (Lollipop) | v24 (Nougat) |
| arm64        | v21 (Lollipop) | v24 (Nougat) |
| x86_64       | v21 (Lollipop) | v24 (Nougat) |

[Older 1.x binary releases](/data/pkg/android) are also available.
{{% /tab %}}

{{% tab id="ios" title="iOS, tvOS" color="b" %}}
Binary releases are available in two forms: a legacy framework, and an
xcframework (1.28+). The legacy framework only supports iOS and an iOS
Simulator on an Intel Mac. The xcframework supports iOS and iOS Simulator (ARM64
and X86_64). Starting with 1.28.8, it also supports tvOS, and tvOS Simulator
(ARM64 and X86_64).

* **iOS & tvOS [{{% ver bin %}} xcframework](/data/pkg/ios/{{% ver bin %}}/gstreamer-{{% ver bin %}}-xcframework.tar.xz) (current stable version)**

The legacy framework downloads are in the [download archive](/download/archive.html).

[Older 1.x binary releases](/data/pkg/ios) are also available.
{{% /tab %}}

{{< /tabs >}}
