---
title: "GStreamer 1.21.3 unstable development release"
date: 2022-12-05T02:00:00Z
version: "1.21.3"
tags: [release]
---

The GStreamer team is pleased to announce another development release in
the unstable 1.21 release series on the road to the 1.22 stable release.

The unstable 1.21 release series adds new features on top of the current
stable 1.20 series and is part of the API and ABI-stable 1.x release series
of the GStreamer multimedia framework.

The unstable 1.21 release series is for testing and development purposes in
the lead-up to the stable 1.22 series which is scheduled for release in
December 2022. Any newly-added API can still change until that point.

A feature freeze is now into effect for the 1.21 series, but newly-added API
might still change until the final 1.22.0 stable release, and minor features
may also still be added until then.

<!--

Full release notes will be provided in the near future, highlighting all the
new features, bugfixes, performance optimizations and other important changes.

-->

This development release is primarily for developers and early adaptors.

Packagers: please note that plugins (e.g. xingmux) may have moved between
modules, so please take extra care and make sure inter-module version
dependencies are such that users can only upgrade all modules in one go,
instead of seeing a mix of different 1.21 and/or 1.20 versions on their system.

--&gt;

Binaries for Android, iOS, Mac OS X and Windows are also available at the
[usual location](https://gstreamer.freedesktop.org/pkg/).

Release tarballs can be downloaded directly here:

- [gstreamer-1.21.3.tar.xz](/src/gstreamer/gstreamer-1.21.3.tar.xz)
- [gst-plugins-base-1.21.3.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.21.3.tar.xz)
- [gst-plugins-good-1.21.3.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.21.3.tar.xz)
- [gst-plugins-ugly-1.21.3.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.21.3.tar.xz)
- [gst-plugins-bad-1.21.3.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.21.3.tar.xz)
- [gst-libav-1.21.3.tar.xz](/src/gst-libav/gst-libav-1.21.3.tar.xz)
- [gst-rtsp-server-1.21.3.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.21.3.tar.xz)
- [gst-python-1.21.3.tar.xz](/src/gst-python/gst-python-1.21.3.tar.xz)
- [gst-editing-services-1.21.3.tar.xz](/src/gst-editing-services/gst-editing-services-1.21.3.tar.xz)
- [gst-devtools-1.21.3.tar.xz](/src/gst-devtools/gst-devtools-1.21.3.tar.xz),
- [gstreamer-vaapi-1.21.3.tar.xz](/src/gstreamer-vaapi/gstreamer-vaapi-1.21.3.tar.xz)
- [gst-omx-1.21.3.tar.xz](/src/gst-omx/gst-omx-1.21.3.tar.xz)
- [gstreamer-docs-1.21.3.tar.xz](/src/gstreamer-docs/gstreamer-docs-1.21.3.tar.xz)

As always, please let us know of any issues you run into by filing an
issue in [Gitlab](https://gitlab.freedesktop.org/gstreamer/gstreamer/).
