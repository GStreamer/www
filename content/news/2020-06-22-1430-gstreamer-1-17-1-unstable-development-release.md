---
title: "GStreamer 1.17.1 unstable development release"
date: 2020-06-22T14:30:00Z
version: "1.17.1"
tags: [release]
---

The GStreamer team is pleased to announce the first development release in
the unstable 1.17 release series.

The unstable 1.17 release series adds new features on top of the current
stable 1.16 series and is part of the API and ABI-stable 1.x release series
of the GStreamer multimedia framework.

The unstable 1.17 release series is for testing and development purposes in
the lead-up to the stable 1.18 series which is scheduled for release in a
few weeks time. Any newly-added API can still change until that point, although
it is rare for that to happen.

Full release notes will be provided in the near future, highlighting all the
new features, bugfixes, performance optimizations and other important changes.

The autotools build has been dropped entirely for this release, so it's
finally all Meson from here on.

This development release is primarily for distributors and early
adaptors and anyone who still needs to update their build/packaging
setup for Meson.

On the documentation front we have switched away from gtk-doc to
hotdoc, but we now provide a release tarball of the built documentation
in html and devhelp format, and we recommend distributors switch to
that and provide a single gstreamer documentation package in future.

Instead of a gst-validate tarball we now ship a gst-devtools tarball, and
the gstreamer-editing-services tarball has been renamed to gst-editing-services
for consistency with the module name in Gitlab.

Packagers: please note that plugins may have moved between modules, so please
take extra care and make sure inter-module version dependencies are such that
users can only upgrade all modules in one go, instead of seeing a mix of 1.17
and 1.16 on their system.

Binaries for Android, iOS, Mac OS X and Windows are also available at the
[usual location](https://gstreamer.freedesktop.org/pkg/).

Release tarballs can be downloaded directly here:

- [gstreamer-1.17.1.tar.xz](/src/gstreamer/gstreamer-1.17.1.tar.xz)
- [gst-plugins-base-1.17.1.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.17.1.tar.xz)
- [gst-plugins-good-1.17.1.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.17.1.tar.xz)
- [gst-plugins-ugly-1.17.1.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.17.1.tar.xz)
- [gst-plugins-bad-1.17.1.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.17.1.tar.xz)
- [gst-libav-1.17.1.tar.xz](/src/gst-libav/gst-libav-1.17.1.tar.xz)
- [gst-rtsp-server-1.17.1.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.17.1.tar.xz)
- [gst-python-1.17.1.tar.xz](/src/gst-python/gst-python-1.17.1.tar.xz)
- [gst-editing-services-1.17.1.tar.xz](/src/gst-editing-services/gst-editing-services-1.17.1.tar.xz)
- [gst-devtools-1.17.1.tar.xz](/src/gst-devtools/gst-devtools-1.17.1.tar.xz),
- [gstreamer-vaapi-1.17.1.tar.xz](/src/gstreamer-vaapi/gstreamer-vaapi-1.17.1.tar.xz)
- [gst-omx-1.17.1.tar.xz](/src/gst-omx/gst-omx-1.17.1.tar.xz)
- [gstreamer-docs-1.17.1.tar.xz](/src/gstreamer-docs/gstreamer-docs-1.17.1.tar.xz)

As always, please let us know of any issues you run into by filing an
issue in [Gitlab](https://gitlab.freedesktop.org/gstreamer).
