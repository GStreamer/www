---
title: "GStreamer 1.22.12 old-stable bug fix release"
date: 2024-04-29T22:00:00Z
version: "1.22.12"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the now old-stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.22.x.

**Highlighted bugfixes:**

- EXIF image tag parsing [security fixes](/security/)
- glimagesink, gl/macos: race and reference count fixes
- GstPlay, dvbsubenc, alphadecodebin, d3dvideosink fixes
- rtpjitterbuffer extended timestamp handling fixes
- v4l2: fix regression with tiled formats
- ximagesink: fix regression on RPi/aarch64
- Thread-safety fixes
- Python bindings fixes
- cerbero build fixes with clang 15 on latest macOS/iOS
- various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.22.12 release notes](/releases/1.22/#1.22.12)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.12.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.12.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.12.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.12.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.12.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.12.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.12.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.12.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.12.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.12.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.12.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.12.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.12.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.12.tar.xz).

PS: GStreamer 1.22 has now been superseded by [GStreamer 1.24](/releases/1.24/).
