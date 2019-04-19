# Download GStreamer

If you're on Linux or a BSD variant, you can install GStreamer using your
package manager.

For other platforms, specifically macOS, Windows, Android, and iOS, we provide
binary releases in the form of official installers or tarballs maintained by
the GStreamer project.

Each binary release also has a SHA256 checksum (`.sha256sum`) file and a PGP
signature file (`.asc`) in the same directory as each release file that you can
use to verify the chain of trust from the GStreamer project to your machine.

**<span style="color:red">Note: the 1.16.0 binaries are not ready yet, so the
links below won't work. Apologies for the inconvience, they should hopefully
be available tomorrow. In the meantime you can grab the 1.15.90 rc1 binaries
from <a href="https://gstreamer.freedesktop.org/pkg/">here</a>.</span>**

### Windows

Binary releases in the form of MSI installers are available. The installers are
split into runtime and development packages. For development, you will want to
install both packages.

* MinGW 64-bit
  - [1.16.0 runtime installer](/data/pkg/windows/1.16.0/gstreamer-1.0-mingw-x86_64-1.16.0.msi)
  - [1.16.0 development installer](/data/pkg/windows/1.16.0/gstreamer-1.0-devel-mingw-x86_64-1.16.0.msi)
* MinGW 32-bit
  - [1.16.0 runtime installer](/data/pkg/windows/1.16.0/gstreamer-1.0-mingw-x86-1.16.0.msi)
  - [1.16.0 development installer](/data/pkg/windows/1.16.0/gstreamer-1.0-devel-mingw-x86-1.16.0.msi)

Starting with the 1.16 release, MSVC 64-bit binaries are also available.
Please note that the library names in MSVC are different from MinGW. If you're
upgrading from a previous version of GStreamer and want a hassle-free upgrade,
you should continue to use the MinGW installers listed above.

* MSVC 64-bit (VS 2017)
  - [1.16.0 runtime installer](/data/pkg/windows/1.16.0/gstreamer-1.0-msvc-x86_64-1.16.0.msi)
  - [1.16.0 development installer](/data/pkg/windows/1.16.0/gstreamer-1.0-devel-msvc-x86_64-1.16.0.msi)

For each of the above listed targets, [a zip file with `.msm` modules](/data/pkg/windows/1.16.0/)
is available for integration into your own WiX-based app installer.

[Older 1.x binary releases](/data/pkg/windows) are also available.

### macOS

Binary releases in the form of `.framework` installers are available. The
installers are split into runtime and development packages. For development,
you will want to install both packages. The target SDK version is macOS 10.10.

* macOS 64-bit
  - [1.16.0 runtime installer](/data/pkg/osx/1.16.0/gstreamer-1.0-1.16.0-x86_64.pkg)
  - [1.16.0 development installer](/data/pkg/osx/1.16.0/gstreamer-1.0-devel-1.16.0-x86_64.pkg)

GStreamer is also available on [Homebrew](https://brew.sh/), and you should be
able to use that. However, please note that some plugins are not shipped by
Homebrew, and you should avoid mixing Homebrew and the official installers on
the same system.

[Older 1.x binary releases](/data/pkg/osx) are also available.

### Android

Binary releases are available with each in the form of a single "universal"
tarball with `armv7`, `arm64`, `x86`, and `x86_64` architectures in subfolders.

The `armv7` and `x86` binaries target Jelly Bean (API v16), while the `arm64`
and `x86_64` binaries target Lollipop (API v21).

* Android Universal [1.16.0 tarball](/data/pkg/android/1.16.0/gstreamer-1.0-android-universal-1.16.0.tar.xz)

[Older 1.x binary releases](/data/pkg/android) are also available.

### iOS and tvOS

Binary releases that integrate into XCode are available in the form of a single
"universal" package with fat library frameworks. Bitcode support is built-in
and the target SDK version is iOS 9.0.

* iOS Universal [1.16.0 framework](/data/pkg/ios/1.16.0/gstreamer-1.0-devel-1.16.0-ios-universal.pkg)

[Older 1.x binary releases](/data/pkg/ios) are also available.

### Linux and BSDs

All Linux distributions and many BSD variants provide packages of GStreamer.
You will find these in your distribution's package repository.

Note that some distributions split the GStreamer plugins up further than the
upstream sources. Additionally, some distributions do not include some plugins
from the gst-plugins-bad package, or omit the gst-plugins-ugly and gst-libav
packages entirely in their main repository for legal reasons.

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
