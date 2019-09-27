# Download GStreamer

If you're on Linux or a BSD variant, you can install GStreamer using your
package manager.

For other platforms, specifically [Windows](#windows), [macOS](#macos),
[Android](#android), and [iOS](#ios-and-tvos), we provide binary releases in
the form of official installers or tarballs maintained by the GStreamer
project.

Each binary release also has a SHA256 checksum (`.sha256sum`) file and a PGP
signature file (`.asc`) in the same directory as each release file that you can
use to verify the chain of trust from the GStreamer project to your machine.

<a name="windows"></a>
### Windows

Binary releases in the form of MSI installers are available. The installers are
split into runtime and development packages. For development, you will want to
install both packages.

* MinGW 64-bit
  - [1.16.1 runtime installer](/data/pkg/windows/1.16.1/gstreamer-1.0-mingw-x86_64-1.16.1.msi)
  - [1.16.1 development installer](/data/pkg/windows/1.16.1/gstreamer-1.0-devel-mingw-x86_64-1.16.1.msi)
* MinGW 32-bit
  - [1.16.1 runtime installer](/data/pkg/windows/1.16.1/gstreamer-1.0-mingw-x86-1.16.1.msi)
  - [1.16.1 development installer](/data/pkg/windows/1.16.1/gstreamer-1.0-devel-mingw-x86-1.16.1.msi)

Starting with the 1.16 release, MSVC 64-bit binaries are also available. If
you're upgrading from a previous version of GStreamer and want a hassle-free
upgrade, you should continue to use the MinGW installers listed above. Also see
the [toolchain compatibility notes](#toolchain-compatibility-notes) below.

NOTE: The library names in MSVC are different from MinGW; specifically the DLLs
are of the form `foo.dll` instead of `libfoo.dll`.

NOTE: The MSVC binaries currently don't work with the gst-sharp .NET bindings.

NOTE: Some of the plugins shipped with the MSVC binaries link to non-gstreamer
libraries built with MinGW because they are built with Autotools. [See below](#toolchain-compatibility-notes)
for what this means for your application.

* MSVC 64-bit (VS 2017)
  - [1.16.1 runtime installer](/data/pkg/windows/1.16.1/gstreamer-1.0-msvc-x86_64-1.16.1.msi)
  - [1.16.1 development installer](/data/pkg/windows/1.16.1/gstreamer-1.0-devel-msvc-x86_64-1.16.1.msi)

For each of the above listed targets, [a zip file with `.msm` modules](/data/pkg/windows/1.16.1/)
is available for integration into your own WiX-based app installer.

[Older 1.x binary releases](/data/pkg/windows) are also available.

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
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.14.x</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>msvcrt.dll</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>N/A</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.16.x</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>msvcrt.dll</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>ucrtbase.dll</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.17.x (development)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>ucrtbase.dll</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>ucrtbase.dll</td>
 </tr>
</table>

This is the toolchain compatibility matrix with the stable releases:

<table style='border-collapse: collapse;'>
 <tr style='background-color: #f2f2f2;'>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>App Toolchain</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>1.14 MinGW</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>1.16 MinGW</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>1.16 MSVC</th>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>Visual Studio 2015 and newer</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>Visual Studio 2013 and older</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'><a href="http://mingw.org">MinGW</a></td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'><a href="https://mingw-w64.org">MinGW-w64</a></td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'><a href="https://www.msys2.org">MSYS2 MinGW-w64</a></td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>FULL</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>PARTIAL</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'><a href="http://cygwin.com">Cygwin</a></td>
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

Binary releases in the form of `.framework` installers are available. The
installers are split into runtime and development packages. For development,
you will want to install both packages. The target SDK version is macOS 10.10.

* macOS 64-bit
  - [1.16.1 runtime installer](/data/pkg/osx/1.16.1/gstreamer-1.0-1.16.1-x86_64.pkg)
  - [1.16.1 development installer](/data/pkg/osx/1.16.1/gstreamer-1.0-devel-1.16.1-x86_64.pkg)

GStreamer is also available on [Homebrew](https://brew.sh/), and you should be
able to use that. However, please note that some plugins are not shipped by
Homebrew, and you should avoid mixing Homebrew and the official installers on
the same system.

[Older 1.x binary releases](/data/pkg/osx) are also available.

<a name="android"></a>
### Android

Binary releases are available with each in the form of a single "universal"
tarball with `armv7`, `arm64`, `x86`, and `x86_64` architectures in subfolders.

* Android Universal [1.16.1 tarball](/data/pkg/android/1.16.1/gstreamer-1.0-android-universal-1.16.1.tar.xz)

The Android NDKs used by the stable releases are:

<table style='border-collapse: collapse;'>
 <tr style='background-color: #f2f2f2;'>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>GStreamer version</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>NDK Version</th>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.14.x</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>r16</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>1.16.x</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'><a href="https://developer.android.com/ndk/downloads/older_releases.html#ndk-18b-downloads">r18b</a></td>
 </tr>
</table>

The Android APIs targeted by the GStreamer 1.16.x stable release(s) are:

<table style='border-collapse: collapse;'>
 <tr style='background-color: #f2f2f2;'>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>Architecture</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400;'>API Targeted</th>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>armv7</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v16 (Jelly Bean)</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>x86</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v16 (Jelly Bean)</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>arm64</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v21 (Lollipop)</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>x86_64</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>v21 (Lollipop)</td>
 </tr>
</table>

[Older 1.x binary releases](/data/pkg/android) are also available.

<a name="ios-and-tvos"></a>
### iOS and tvOS

Binary releases that integrate into XCode are available in the form of a single
"universal" package with fat library frameworks. Bitcode support is built-in
and the target SDK version is iOS 9.0.

* iOS Universal [1.16.1 framework](/data/pkg/ios/1.16.1/gstreamer-1.0-devel-1.16.1-ios-universal.pkg)

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

For doing GStreamer development, we recommend using the [gst-build
project](https://gitlab.freedesktop.org/gstreamer/gst-build/#gst-build) which
will aggregate all the GStreamer modules using [Meson's subproject
feature](https://mesonbuild.com/Subprojects.html).
