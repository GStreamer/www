---
title: "GStreamer 1.22.8 stable bug fix release"
date: 2023-12-18T14:00:00Z
version: "1.22.8"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.22.x.

**Highlighted bugfixes:**

- [Security fixes](/security/) for the AV1 codec parser
- \[Security fixes\](https://gstreamer.freedesktop.org/security/) for the AV1 video codec parser <!-- FIXME: update advisory -->
- avdec video decoder: fix another possible deadlock with FFmpeg 6.1
- qtdemux: reverse playback and seeking fixes for files with raw audio streams
- v4l2: fix "newly allocated buffer ... is not free" warning log flood
- GstPlay + GstPlayer library fixes
- dtls: Fix build failure on Windows when compiling against OpenSSL 3.2.0
- d3d11screencapturesrc: Fix wrong color with HDR enabled
- Cerbero build tool: More python 3.12 string escape warning fixes; make sure to bundle build tools as well
- various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.22.8 release notes](/releases/1.22/#1.22.8)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.8.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.8.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.8.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.8.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.8.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.8.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.8.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.8.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.8.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.8.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.8.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.8.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.8.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.8.tar.xz).
