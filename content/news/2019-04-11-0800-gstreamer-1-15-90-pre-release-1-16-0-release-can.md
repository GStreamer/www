---
title: "GStreamer 1.15.90 pre-release (1.16.0 release candidate 1)"
date: 2019-04-11T08:00:00Z
version: "1.15.90"
tags: [release]
---

The GStreamer team is pleased to announce the first release candidate for the
upcoming stable 1.16.0 release.

Check out the [draft release notes](https://gstreamer.freedesktop.org/releases/1.16/)
highlighting all the new features, bugfixes, performance optimizations and other important changes.

Packagers: please note that quite a few plugins and libraries have moved
between modules since 1.14, so please take extra care and make sure inter-module
version dependencies are such that users can only upgrade all modules in one go,
instead of seeing a mix of 1.15 and 1.14 on their system.

Binaries for Android, iOS, Mac OS X and Windows will be provided shortly.

Release tarballs can be downloaded directly here:

- [gstreamer-1.15.90.tar.xz](/src/gstreamer/gstreamer-1.15.90.tar.xz)
- [gst-plugins-base-1.15.90.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.15.90.tar.xz)
- [gst-plugins-good-1.15.90.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.15.90.tar.xz)
- [gst-plugins-ugly-1.15.90.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.15.90.tar.xz)
- [gst-plugins-bad-1.15.90.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.15.90.tar.xz)
- [gst-libav-1.15.90.tar.xz](/src/gst-libav/gst-libav-1.15.90.tar.xz)
- [gst-rtsp-server-1.15.90.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.15.90.tar.xz)
- [gst-editing-services-1.15.90.tar.xz](/src/gst-editing-services/gstreamer-editing-services-1.15.90.tar.xz)
- [gst-validate-1.15.90.tar.xz](/src/gst-validate/gst-validate-1.15.90.tar.xz),
- [gstreamer-vaapi-1.15.90.tar.xz](/src/gstreamer-vaapi/gstreamer-vaapi-1.15.90.tar.xz)
- [gst-omx-1.15.90.tar.xz](/src/gst-omx/gst-omx-1.15.90.tar.xz)
- [gst-python-1.15.90.tar.xz](/src/gst-python/gst-python-1.15.90.tar.xz)
- [gstreamer-sharp-1.15.90.tar.xz](/src/gstreamer-sharp/gstreamer-sharp-1.15.90.tar.xz)

Known errata: [possible crash on 32-bit systems when creating seek events](https://gitlab.freedesktop.org/gstreamer/gstreamer/merge_requests/130)
