# Download GStreamer

If you're on Linux or a BSD variant, you can install GStreamer using your
package manager.

For other platforms, specifically [Windows](#windows), [macOS](#macos),
[Android](#android), and [iOS](#ios-and-tvos), we provide binary releases in
the form of official installers or tarballs maintained by the GStreamer
project.

<a name="windows"></a>
### Windows

Binary releases in the form of MSI installers are available. The installers are
split into runtime and development packages. For development, you will want to
install both packages.

* MSVC 64-bit (VS 2019, Release CRT)
  - [1.24.0 runtime installer](/data/pkg/windows/1.24.0/msvc/gstreamer-1.0-msvc-x86_64-1.24.0.msi)
  - [1.24.0 development installer](/data/pkg/windows/1.24.0/msvc/gstreamer-1.0-devel-msvc-x86_64-1.24.0.msi)
* MSVC 32-bit (VS 2019, Release CRT)
  - [1.24.0 runtime installer](/data/pkg/windows/1.24.0/msvc/gstreamer-1.0-msvc-x86-1.24.0.msi)
  - [1.24.0 development installer](/data/pkg/windows/1.24.0/msvc/gstreamer-1.0-devel-msvc-x86-1.24.0.msi)
* MinGW 64-bit
  - [1.24.0 runtime installer](/data/pkg/windows/1.24.0/mingw/gstreamer-1.0-mingw-x86_64-1.24.0.msi)
  - [1.24.0 development installer](/data/pkg/windows/1.24.0/mingw/gstreamer-1.0-devel-mingw-x86_64-1.24.0.msi)
* MinGW 32-bit
  - [1.24.0 runtime installer](/data/pkg/windows/1.24.0/mingw/gstreamer-1.0-mingw-x86-1.24.0.msi)
  - [1.24.0 development installer](/data/pkg/windows/1.24.0/mingw/gstreamer-1.0-devel-mingw-x86-1.24.0.msi)

For each of the above listed targets, [a zip file with `.msm` modules](/data/pkg/windows/1.24.0/)
is available for integration into your own WiX-based app installer.

If you are not sure which to pick between MSVC and MinGW, just pick MSVC.
However, do see the [toolchain compatibility notes](#toolchain-compatibility-notes)
below which may affect you based on what toolchain your app will be built with.

NOTE: The library names in MSVC are different from MinGW; specifically the DLLs
are of the form `foo.dll` instead of `libfoo.dll`.

NOTE: [GstSharp .NET bindings](https://www.nuget.org/packages/GstSharp/)
require the MSVC binaries starting with 1.18.

NOTE: Some of the plugins shipped with the MSVC binaries link to non-gstreamer
libraries built with MinGW because they are built with Autotools. [See below](#toolchain-compatibility-notes)
for what this means for your application.

[Older 1.x binary releases](/data/pkg/windows) are also available.

<a name="uwp"></a>
#### Universal Windows Platform

Binary releases built to target the Universal Windows Platform (UWP). Used for
shipping apps on the Windows Store, such as for an XBox, HoloLens 2, etc.

* UWP Universal (ARM64, X86, X86_64) (VS 2019, Release CRT) (old old stable)
  - [1.20.7 runtime + development tarball](/data/pkg/windows/1.20.7/uwp/gstreamer-1.0-uwp-universal-1.20.7.tar.xz)
* UWP Universal (ARM64, X86, X86_64) (VS 2019, Debug CRT) (old old stable)
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

<table style='border-collapse: collapse;'>
 <tr style='background-color: #f2f2f2;'>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>GStreamer version</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>MinGW</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>MSVC</th>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.18+</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>ucrtbase.dll</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>ucrtbase.dll</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.16</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>msvcrt.dll</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>ucrtbase.dll</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.14</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>msvcrt.dll</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>N/A</td>
 </tr>
</table>

This is the toolchain compatibility matrix with the stable releases:

<table style='border-collapse: collapse;'>
 <tr style='background-color: #f2f2f2;'>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>App Toolchain</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>1.16 MinGW</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>1.16 MSVC</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>1.18+ MinGW</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>1.18+ MSVC</th>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>Visual Studio 2015 and newer (ucrtbase.dll)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>Visual Studio 2013 and older (msvcrt.dll)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'><a href="http://mingw.org">MinGW</a> (msvcrt.dll)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'><a href="https://mingw-w64.org">MinGW-w64</a> (msvcrt.dll)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'><a href="https://www.msys2.org">MSYS2 MinGW-w64</a> (msvcrt.dll)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'><a href="http://cygwin.com">Cygwin</a></td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>NONE</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>NONE</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>NONE</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>NONE</td>
 </tr>
</table>

**FULL** means full C compatibility, including debugging symbols.

**PARTIAL** means mixing the two should be fine as long as you are careful while
[passing memory across CRT boundaries](https://docs.microsoft.com/en-us/cpp/c-runtime-library/potential-errors-passing-crt-objects-across-dll-boundaries).

**NONE** means fully unsupported, and *will* lead to crashes.

<a name="macos"></a>
### macOS

Binary releases in the form of `.pkg` framework installers are available. The
installers are split into runtime and development packages. For development,
you will want to install _both_ packages. The target SDK version for 1.20 and
1.22 was macOS 10.11, and for 1.24 it is macOS 10.13 (High Sierra).

* **macOS Universal (X86_64 &amp; ARM64) 1.24 release (current stable version)**
  - **[1.24.0 runtime installer](/data/pkg/osx/1.24.0/gstreamer-1.0-1.24.0-universal.pkg)**
  - **[1.24.0 development installer](/data/pkg/osx/1.24.0/gstreamer-1.0-devel-1.24.0-universal.pkg)**
* **macOS Universal (X86_64 &amp; ARM64) 1.22 release (old stable version)**
  - **[1.22.11 runtime installer](/data/pkg/osx/1.22.11/gstreamer-1.0-1.22.11-universal.pkg)**
  - **[1.22.11 development installer](/data/pkg/osx/1.22.11/gstreamer-1.0-devel-1.22.11-universal.pkg)**

GStreamer is also available on [Homebrew](https://brew.sh/), and you should be
able to use that. However, please note that some plugins are not shipped by
Homebrew, and you should avoid mixing Homebrew and the official installers on
the same system.

[Older 1.x binary releases](/data/pkg/osx) are also available.

<a name="android"></a>
### Android

Binary releases are available with each in the form of a single "universal"
tarball with `armv7`, `arm64`, `x86`, and `x86_64` architectures in subfolders.

* **Android Universal [1.24.0 tarball](/data/pkg/android/1.24.0/gstreamer-1.0-android-universal-1.24.0.tar.xz) (current stable version)**
* Android Universal [1.22.11 tarball](/data/pkg/android/1.22.11/gstreamer-1.0-android-universal-1.22.11.tar.xz) (old stable version)

The Android NDKs used by our stable releases are:

<table style='border-collapse: collapse;'>
 <tr style='background-color: #f2f2f2;'>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>GStreamer version</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>NDK Version</th>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.24.x</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>r25c</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.22.x</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>r21</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.20.x</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>r21</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.18.x</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>r21</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.16.x</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>r18b</td>
 </tr>
</table>

The Android APIs targeted by our stable release(s) are:

<table style='border-collapse: collapse;'>
 <tr style='background-color: #f2f2f2;'>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>Architecture</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>API Targeted<br/><small>GStreamer &lt;= 1.20</small></th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>API Targeted<br/><small>GStreamer &gt;= 1.22</small></th>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>armv7</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v16 (Jelly Bean)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v21 (Lollipop)</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>x86</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v16 (Jelly Bean)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v21 (Lollipop)</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>arm64</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v21 (Lollipop)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v21 (Lollipop)</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>x86_64</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v21 (Lollipop)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v21 (Lollipop)</td>
 </tr>
</table>

[Older 1.x binary releases](/data/pkg/android) are also available.

<a name="ios-and-tvos"></a>
### iOS

Binary releases that integrate into XCode are available in the form of a single
"universal" package with fat library frameworks. Bitcode support is built-in
and the target SDK version for 1.16.x was iOS 9.0, for 1.18.x, 1.20.x and
1.22.x it was iOS 11.0, and for 1.24.x it is iOS 12.0.

* **iOS Universal [1.24.0 framework](/data/pkg/ios/1.24.0/gstreamer-1.0-devel-1.24.0-ios-universal.pkg) (ARM64, X86_64) (current stable version)**
* iOS Universal [1.22.11 framework](/data/pkg/ios/1.22.11/gstreamer-1.0-devel-1.22.11-ios-universal.pkg) (ARM64, X86_64) (old stable version)

[Older 1.x binary releases](/data/pkg/ios) are also available.

<a name="linux-and-bsds"></a>
### Linux and BSDs

All Linux distributions and many BSD variants provide packages of GStreamer.
You will find these in your distribution's package repository.

Note that some distributions split the GStreamer plugins up further than the
upstream sources. Additionally, some distributions do not include some plugins
from the gst-plugins-bad package, or omit the gst-plugins-ugly and gst-libav
packages entirely in their main repository for legal reasons.

<a name="sources"></a>
### Sources

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
