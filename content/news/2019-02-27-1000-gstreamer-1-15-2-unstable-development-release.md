---
title: "GStreamer 1.15.2 unstable development release"
date: 2019-02-27T10:00:00Z
version: "1.15.2"
tags: [release]
---

The GStreamer team is pleased to announce the second development release in
the unstable 1.15 release series.

The unstable 1.15 release series adds new features on top of the current
stable 1.16 series and is part of the API and ABI-stable 1.x release series
of the GStreamer multimedia framework.

The unstable 1.15 release series is for testing and development purposes in
the lead-up to the stable 1.16 series which is scheduled for release in a
few weeks time. Any newly-added API can still change until that point, although
it is rare for that to happen.

Check out the [draft release notes](https://gstreamer.freedesktop.org/releases/1.16/)
highlighting all the new features, bugfixes, performance optimizations and other important changes.

Packagers: please note that quite a few plugins and libraries have moved
between modules since 1.14, so please take extra care and make sure inter-module
version dependencies are such that users can only upgrade all modules in one go,
instead of seeing a mix of 1.15 and 1.14 on their system.

Binaries for Android, iOS, Mac OS X and Windows will be provided shortly.

Release tarballs can be downloaded directly here:

- [gstreamer-1.15.2.tar.xz](/src/gstreamer/gstreamer-1.15.2.tar.xz)
- [gst-plugins-base-1.15.2.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.15.2.tar.xz)
- [gst-plugins-good-1.15.2.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.15.2.tar.xz)
- [gst-plugins-ugly-1.15.2.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.15.2.tar.xz)
- [gst-plugins-bad-1.15.2.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.15.2.tar.xz)
- [gst-libav-1.15.2.tar.xz](/src/gst-libav/gst-libav-1.15.2.tar.xz)
- [gst-rtsp-server-1.15.2.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.15.2.tar.xz)
- [gst-editing-services-1.15.2.tar.xz](/src/gst-editing-services/gstreamer-editing-services-1.15.2.tar.xz)
- [gst-validate-1.15.2.tar.xz](/src/gst-validate/gst-validate-1.15.2.tar.xz),
- [gstreamer-vaapi-1.15.2.tar.xz](/src/gstreamer-vaapi/gstreamer-vaapi-1.15.2.tar.xz)
- [gst-omx-1.15.2.tar.xz](/src/gst-omx/gst-omx-1.15.2.tar.xz)
- [gst-python-1.15.2.tar.xz](/src/gst-python/gst-python-1.15.2.tar.xz)
- [gstreamer-sharp-1.15.2.tar.xz](/src/gstreamer-sharp/gstreamer-sharp-1.15.2.tar.xz)
