# Download GStreamer

If you're on Linux or a BSD variant, you can install GStreamer using your
package manager.

For other platforms listed below, we provide binary releases in
the form of official installers or tarballs maintained by the GStreamer
project. 

Choose your platform below for more information.

<div class="dl-content">
<div class="dl-tablist" role="tablist">
  <button class="dl-tab dl-tab-r" id="tab-sources" aria-selected="true" aria-controls="panel-sources" role="tab">Sources</button>
  <button class="dl-tab dl-tab-g" id="tab-windows" aria-selected="false" aria-controls="panel-windows" role="tab">Windows</button>
  <button class="dl-tab dl-tab-g" id="tab-macos" aria-selected="false" aria-controls="panel-macos" role="tab">macOS</button>
  <button class="dl-tab dl-tab-g" id="tab-linux" aria-selected="false" aria-controls="panel-linux" role="tab">Linux</button>
  <button class="dl-tab dl-tab-b" id="tab-android" aria-selected="false" aria-controls="panel-android" role="tab">Android</button>
  <button class="dl-tab dl-tab-b" id="tab-ios" aria-selected="false" aria-controls="panel-ios" role="tab">iOS</button>
</div>

<!-- SOURCES -->
<div class="dl-panel" id="panel-sources" role="tabpanel" tabindex="0" aria-labelledby="tab-sources">
<!-- 
  Please note the empty line between the <div> and its content.
  This is needed for Markdown to be parsed inside HTML blocks. 
-->

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
</div>

<!-- WINDOWS -->
<div class="dl-panel" id="panel-windows" role="tabpanel" tabindex="0" aria-labelledby="tab-windows" hidden="">

The latest stable release is **1.28.0**. Installers are available for the following targets:

* [MSVC x86_64 (VS 2022, Release CRT)](/data/pkg/windows/1.28.0/msvc/gstreamer-1.0-msvc-x86_64-1.28.0.exe)
* [MSVC x86 (VS 2022, Release CRT)](/data/pkg/windows/1.28.0/msvc/gstreamer-1.0-msvc-x86-1.28.0.exe)
* [MSVC arm64 (VS 2022, Release CRT)](/data/pkg/windows/1.28.0/msvc/gstreamer-1.0-msvc-arm64-1.28.0.exe)
* [MinGW x86_64](/data/pkg/windows/1.28.0/mingw/gstreamer-1.0-mingw-x86_64-1.28.0.exe)
* [MinGW x86](/data/pkg/windows/1.28.0/mingw/gstreamer-1.0-mingw-x86-1.28.0.exe)

If you are not sure which to pick between MSVC and MinGW, just pick MSVC.
However, do see the [toolchain compatibility notes](#toolchain-compatibility-notes)
below which may affect you based on what toolchain your app will be built with.

NOTE: The libraries built with MSVC are named differently from MinGW;
specifically the DLLs are of the form `foo.dll` instead of `libfoo.dll`.

NOTE: [GstSharp .NET bindings](https://www.nuget.org/packages/GstSharp/)
require the MSVC binaries starting with 1.18.

[Older 1.x binary releases](/data/pkg/windows) are also available. Older
installers are split into runtime and development packages, so for app
development, you will want to install both packages.

#### Universal Windows Platform

Binary releases built to target the Universal Windows Platform (UWP). Used for
shipping apps on the Windows Store, such as for an Xbox, HoloLens 2, etc.

* UWP Universal (ARM64, X86, X86_64) (VS 2019, Release CRT) (ancient stable)
  - [1.20.7 runtime + development tarball](/data/pkg/windows/1.20.7/uwp/gstreamer-1.0-uwp-universal-1.20.7.tar.xz)
* UWP Universal (ARM64, X86, X86_64) (VS 2019, Debug CRT) (ancient stable)
  - [1.20.7 runtime + development tarball](/data/pkg/windows/1.20.7/uwp/gstreamer-1.0-uwp+debug-universal-1.20.7.tar.xz)

UWP apps cannot use plugins that use dependencies built with MinGW because of
forbidden APIs. Hence, these plugins are omitted from the binaries.

UWP has been abandoned by Microsoft, and as such is no longer supported by the
GStreamer project. This section will be removed in the future.

<a name="toolchain-compatibility-notes"></a>
#### Toolchain Compatibility Notes

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
</div>

<!-- MACOS -->
<div class="dl-panel" id="panel-macos" role="tabpanel" tabindex="0" aria-labelledby="tab-macos" hidden="">

Binary releases in the form of `.pkg` framework installers are available. The
installers are split into runtime, development, and debug packages. For
development, you will want to install both runtime and development packages.
The oldest supported macOS is 10.13 (High Sierra).

* **macOS Universal (X86_64 &amp; ARM64) 1.28 release (current stable version)**
  - **[1.28.0 runtime installer](/data/pkg/osx/1.28.0/gstreamer-1.0-1.28.0-universal.pkg)**
  - **[1.28.0 development installer](/data/pkg/osx/1.28.0/gstreamer-1.0-devel-1.28.0-universal.pkg)**
  - **[1.28.0 debug installer](/data/pkg/osx/1.28.0/gstreamer-1.0-debug-1.28.0-universal.pkg)**

* macOS Universal (X86_64 &amp; ARM64) 1.26 release (old stable version)
  - [1.26.10 runtime installer](/data/pkg/osx/1.26.10/gstreamer-1.0-1.26.10-universal.pkg)
  - [1.26.10 development installer](/data/pkg/osx/1.26.10/gstreamer-1.0-devel-1.26.10-universal.pkg)

GStreamer is also maintained by third-parties in the
[![Homebrew package](https://repology.org/badge/version-for-repo/homebrew/gstreamer.svg)](https://formulae.brew.sh/formula/gstreamer).
You should be able to use that, but please note that some plugins are not
shipped by Homebrew, and you should avoid mixing Homebrew and the official
installers on the same system.


[Older 1.x binary releases](/data/pkg/osx) are also available.
</div>

<!-- LINUX -->
<div class="dl-panel" id="panel-linux" role="tabpanel" tabindex="0" aria-labelledby="tab-linux" hidden="">

All Linux distributions and many BSD variants provide packages of GStreamer.
You will find these in your distribution's package repository.

[![Arch package](https://repology.org/badge/version-for-repo/arch/gstreamer.svg?header=Arch)](https://repology.org/project/gstreamer/versions)
[![Debian 14 package](https://repology.org/badge/version-for-repo/debian_14/gstreamer.svg?header=Debian 14)](https://repology.org/project/gstreamer/versions)
[![Debian unstable package](https://repology.org/badge/version-for-repo/debian_unstable/gstreamer.svg?header=Debian Unstable)](https://repology.org/project/gstreamer/versions)
[![Fedora 43 package](https://repology.org/badge/version-for-repo/fedora_43/gstreamer.svg?header=Fedora 43)](https://repology.org/project/gstreamer/versions)
[![Fedora rawhide package](https://repology.org/badge/version-for-repo/fedora_rawhide/gstreamer.svg?header=Fedora Rawhide)](https://repology.org/project/gstreamer/versions)
[![Manjaro stable package](https://repology.org/badge/version-for-repo/manjaro_stable/gstreamer.svg?header=Manjaro Stable)](https://repology.org/project/gstreamer/versions)
[![Manjaro unstable package](https://repology.org/badge/version-for-repo/manjaro_unstable/gstreamer.svg?header=Manjaro Unstable)](https://repology.org/project/gstreamer/versions)
[![openSUSE Leap 15.6 package](https://repology.org/badge/version-for-repo/opensuse_leap_15_6/gstreamer.svg?header=openSUSE 15.6)](https://repology.org/project/gstreamer/versions)
[![openSUSE Tumbleweed package](https://repology.org/badge/version-for-repo/opensuse_tumbleweed/gstreamer.svg?header=openSUSE Tumbleweed)](https://repology.org/project/gstreamer/versions)
[![Ubuntu 24.04 LTS package](https://repology.org/badge/version-for-repo/ubuntu_24_04/gstreamer.svg?header=Ubuntu LTS)](https://repology.org/project/gstreamer/versions)
[![Ubuntu 26.04 package](https://repology.org/badge/version-for-repo/ubuntu_26_04/gstreamer.svg?header=Ubuntu 26.04)](https://repology.org/project/gstreamer/versions)

Note that some distributions split the GStreamer plugins up further than the
upstream sources. Additionally, some distributions do not include some plugins
from the gst-plugins-bad package, or omit the gst-plugins-ugly and gst-libav
packages entirely in their main repository for legal reasons.

gst-plugins-rs is another large set of plugins that aren't packaged by some
distros. Since these are in [a standalone repository](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs),
it is straightforward for developers to build them by hand with [`cargo-c`](https://github.com/lu-zero/cargo-c/).

</div>

<!-- ANDROID -->
<div class="dl-panel" id="panel-android" role="tabpanel" tabindex="0" aria-labelledby="tab-android" hidden="">

Binary releases are available with each in the form of a single "universal"
tarball with `armv7`, `arm64`, `x86`, and `x86_64` architectures in subfolders.

* **Android Universal [1.28.0 tarball](/data/pkg/android/1.28.0/gstreamer-1.0-android-universal-1.28.0.tar.xz) (current stable version)**
* Android Universal [1.26.10 tarball](/data/pkg/android/1.26.10/gstreamer-1.0-android-universal-1.26.10.tar.xz) (old stable version)

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

| Architecture | API Targeted<br/><small>(GStreamer 1.22 - 1.26)</small> | API Targeted<br/><small>(GStreamer >= 1.28)</small> |
| ------------ | --------------------------------------------------- | --------------------------------------------------- |
| armv7        | v21 (Lollipop) | v24 (Nougat) |
| x86          | v21 (Lollipop) | v24 (Nougat) |
| arm64        | v21 (Lollipop) | v24 (Nougat) |
| x86_64       | v21 (Lollipop) | v24 (Nougat) |

[Older 1.x binary releases](/data/pkg/android) are also available.
</div>

<!-- iOS -->
<div class="dl-panel" id="panel-ios" role="tabpanel" tabindex="0" aria-labelledby="tab-ios" hidden="">

Binary releases are available in two forms: a legacy framework, and an
xcframework (1.28+). If you need to test using an iOS Simulator running on an
Apple Silicon Mac, you need the xcframework. In all other cases, either release
will work.

* **iOS Universal [1.28.0 xcframework](/data/pkg/ios/1.28.0/gstreamer-1.28.0-xcframework.tar.xz) (iOS ARM64, iOS Simulator ARM64, iOS Simulator X86_64) (current stable version)**
* **iOS Universal [1.28.0 legacy framework](/data/pkg/ios/1.28.0/gstreamer-1.0-devel-1.28.0-ios-universal.pkg) (iOS ARM64, iOS Simulator X86_64) (current stable version)**
* iOS Universal [1.26.10 legacy framework](/data/pkg/ios/1.26.10/gstreamer-1.0-devel-1.26.10-ios-universal.pkg) (iOS ARM64, iOS Simulator X86_64) (old stable version)

The legacy framework will be removed in a future GStreamer release.

[Older 1.x binary releases](/data/pkg/ios) are also available.
</div></div>
