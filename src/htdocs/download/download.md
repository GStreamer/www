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
build aggregator](https://gitlab.freedesktop.org/gstreamer/cerbero/#description)
maintained by the GStreamer project which supports Linux, macOS, and Windows.

For downloading each GStreamer module individually, check our [modules
page](/modules/), or go straight to our [source download directory](/src/).

Generally, you should not need to build from source yourself unless you need
features that are only available in a newer version of GStreamer than is
provided by your distribution or in the last stable release.

For doing GStreamer development, we recommend using the [GStreamer monorepo
build from Git](https://gitlab.freedesktop.org/gstreamer/gstreamer/#getting-started)
which will build all the main GStreamer modules in one go using [Meson's subproject
feature](https://mesonbuild.com/Subprojects.html).
</div>

<!-- WINDOWS -->
<div class="dl-panel" id="panel-windows" role="tabpanel" tabindex="0" aria-labelledby="tab-windows" hidden="">

Binary releases in the form of MSI installers are available. The installers are
split into runtime and development packages. For development, you will want to
install both packages.

* MSVC 64-bit (VS 2019, Release CRT)
  - [1.26.1 runtime installer](/data/pkg/windows/1.26.1/msvc/gstreamer-1.0-msvc-x86_64-1.26.1.msi)
  - [1.26.1 development installer](/data/pkg/windows/1.26.1/msvc/gstreamer-1.0-devel-msvc-x86_64-1.26.1.msi)
* MSVC 32-bit (VS 2019, Release CRT)
  - [1.26.1 runtime installer](/data/pkg/windows/1.26.1/msvc/gstreamer-1.0-msvc-x86-1.26.1.msi)
  - [1.26.1 development installer](/data/pkg/windows/1.26.1/msvc/gstreamer-1.0-devel-msvc-x86-1.26.1.msi)
* MinGW 64-bit
  - [1.26.1 runtime installer](/data/pkg/windows/1.26.1/mingw/gstreamer-1.0-mingw-x86_64-1.26.1.msi)
  - [1.26.1 development installer](/data/pkg/windows/1.26.1/mingw/gstreamer-1.0-devel-mingw-x86_64-1.26.1.msi)
* MinGW 32-bit
  - [1.26.1 runtime installer](/data/pkg/windows/1.26.1/mingw/gstreamer-1.0-mingw-x86-1.26.1.msi)
  - [1.26.1 development installer](/data/pkg/windows/1.26.1/mingw/gstreamer-1.0-devel-mingw-x86-1.26.1.msi)

For each of the above listed targets, [a zip file with `.msm` modules](/data/pkg/windows/1.26.1/)
is available for integration into your own WiX-based app installer.

If you are not sure which to pick between MSVC and MinGW, just pick MSVC.
However, do see the [toolchain compatibility notes](#toolchain-compatibility-notes)
below which may affect you based on what toolchain your app will be built with.

Starting with 1.26, the default installation directory has been changed from
`ROOT:\gstreamer` (where `ROOT` matches the MSI folder's drive)
to within the Program Files directory corresponding to the chosen architecture
e.g. `C:\Program Files (x86)\gstreamer` for the 32-bit package.

NOTE for MSI packagers: Starting with 1.26, the installers are compiled with
WiX 5.0. As part of the port, the property for setting the installation
directory is now `INSTALLDIR`, and it requires a full path to
the desired directory, e.g. `C:\gstreamer` instead of just `C:\`.

NOTE: The library names in MSVC are different from MinGW; specifically the DLLs
are of the form `foo.dll` instead of `libfoo.dll`.

NOTE: [GstSharp .NET bindings](https://www.nuget.org/packages/GstSharp/)
require the MSVC binaries starting with 1.18.

NOTE: Some of the plugins shipped with the MSVC binaries link to non-gstreamer
libraries built with MinGW because they are built with Autotools. [See below](#toolchain-compatibility-notes)
for what this means for your application.

[Older 1.x binary releases](/data/pkg/windows) are also available.

#### Universal Windows Platform

Binary releases built to target the Universal Windows Platform (UWP). Used for
shipping apps on the Windows Store, such as for an XBox, HoloLens 2, etc.

* UWP Universal (ARM64, X86, X86_64) (VS 2019, Release CRT) (old old old stable)
  - [1.20.7 runtime + development tarball](/data/pkg/windows/1.20.7/uwp/gstreamer-1.0-uwp-universal-1.20.7.tar.xz)
* UWP Universal (ARM64, X86, X86_64) (VS 2019, Debug CRT) (old old old stable)
  - [1.20.7 runtime + development tarball](/data/pkg/windows/1.20.7/uwp/gstreamer-1.0-uwp+debug-universal-1.20.7.tar.xz)

UWP apps cannot use plugins that use dependencies built with MinGW because of
forbidden APIs. Hence, these plugins are omitted from the binaries.

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
installers are split into runtime and development packages. For development,
you will want to install _both_ packages. The target SDK version for 1.20 and
1.22 was macOS 10.11, and for 1.24 it is macOS 10.13 (High Sierra).
<!-- FIXME: and for 1.26? -->

* **macOS Universal (X86_64 &amp; ARM64) 1.24 release (current stable version)**
  - **[1.26.1 runtime installer](/data/pkg/osx/1.26.1/gstreamer-1.0-1.26.1-universal.pkg)**
  - **[1.26.1 development installer](/data/pkg/osx/1.26.1/gstreamer-1.0-devel-1.26.1-universal.pkg)**
*macOS Universal (X86_64 &amp; ARM64) 1.24 release (old stable version)
  - [1.24.12 runtime installer](/data/pkg/osx/1.24.12/gstreamer-1.0-1.24.12-universal.pkg)
  - [1.24.12 development installer](/data/pkg/osx/1.24.12/gstreamer-1.0-devel-1.24.12-universal.pkg)

GStreamer is also available as a 
[![Homebrew package](https://repology.org/badge/version-for-repo/homebrew/gstreamer.svg)](https://formulae.brew.sh/formula/gstreamer), and you should be
able to use that. However, please note that some plugins are not shipped by
Homebrew, and you should avoid mixing Homebrew and the official installers on
the same system.


[Older 1.x binary releases](/data/pkg/osx) are also available.
</div>

<!-- LINUX -->
<div class="dl-panel" id="panel-linux" role="tabpanel" tabindex="0" aria-labelledby="tab-linux" hidden="">

All Linux distributions and many BSD variants provide packages of GStreamer.
You will find these in your distribution's package repository.

[![Arch package](https://repology.org/badge/version-for-repo/arch/gstreamer.svg?header=Arch)](https://repology.org/project/gstreamer/versions)
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/gstreamer.svg?header=Debian)](https://repology.org/project/gstreamer/versions)
[![Fedora 40 package](https://repology.org/badge/version-for-repo/fedora_40/gstreamer.svg?header=Fedora)](https://repology.org/project/gstreamer/versions)
[![Manjaro Stable package](https://repology.org/badge/version-for-repo/manjaro_stable/gstreamer.svg?header=Manjaro)](https://repology.org/project/gstreamer/versions)
[![openSUSE Leap 15.6 package](https://repology.org/badge/version-for-repo/opensuse_leap_15_6/gstreamer.svg?header=openSUSE)](https://repology.org/project/gstreamer/versions)
[![Ubuntu 24.04 package](https://repology.org/badge/version-for-repo/ubuntu_24_04/gstreamer.svg?header=Ubuntu)](https://repology.org/project/gstreamer/versions)

Note that some distributions split the GStreamer plugins up further than the
upstream sources. Additionally, some distributions do not include some plugins
from the gst-plugins-bad package, or omit the gst-plugins-ugly and gst-libav
packages entirely in their main repository for legal reasons.

</div>

<!-- ANDROID -->
<div class="dl-panel" id="panel-android" role="tabpanel" tabindex="0" aria-labelledby="tab-android" hidden="">

Binary releases are available with each in the form of a single "universal"
tarball with `armv7`, `arm64`, `x86`, and `x86_64` architectures in subfolders.

* **Android Universal [1.26.1 tarball](/data/pkg/android/1.26.1/gstreamer-1.0-android-universal-1.26.1.tar.xz) (current stable version)**
* Android Universal [1.24.12 tarball](/data/pkg/android/1.24.12/gstreamer-1.0-android-universal-1.24.12.tar.xz) (old stable version)

The Android NDKs used by our stable releases are:

| GStreamer version | NDK Version |
| ----------------- | ----------- |
| 1.26.x            | r25c        |
| 1.24.x            | r25c        |
| 1.22.x            | r21         |
| 1.20.x            | r21         |
| 1.18.x            | r21         |
| 1.16.x            | r18b        |

The Android APIs targeted by our stable release(s) are:

| Architecture | API Targeted<br/><small>(GStreamer <= 1.20)</small> | API Targeted<br/><small>(GStreamer >= 1.22)</small> |
| ------------ | -------------------------------------------------- | -------------------------------------------------- |
| armv7        | v16 (Jelly Bean)                                   | v21 (Lollipop)                                    |
| x86          | v16 (Jelly Bean)                                   | v21 (Lollipop)                                    |
| arm64        | v21 (Lollipop)                                     | v21 (Lollipop)                                    |
| x86_64       | v21 (Lollipop)                                     | v21 (Lollipop)                                    |

[Older 1.x binary releases](/data/pkg/android) are also available.
</div>

<!-- iOS -->
<div class="dl-panel" id="panel-ios" role="tabpanel" tabindex="0" aria-labelledby="tab-ios" hidden="">

Binary releases that integrate into XCode are available in the form of a single
"universal" package with fat library frameworks. Bitcode support is built-in
and the target SDK version for 1.16.x was iOS 9.0, for 1.18.x, 1.20.x and
1.22.x it was iOS 11.0, and for 1.24.x it is iOS 12.0.

* **iOS Universal [1.26.1 framework](/data/pkg/ios/1.26.1/gstreamer-1.0-devel-1.26.1-ios-universal.pkg) (ARM64, X86_64) (current stable version)**
* iOS Universal [1.24.12 framework](/data/pkg/ios/1.24.12/gstreamer-1.0-devel-1.24.12-ios-universal.pkg) (ARM64, X86_64) (old stable version)

[Older 1.x binary releases](/data/pkg/ios) are also available.
</div></div>
