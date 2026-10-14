---
title: "GStreamer 1.20.3 stable bug fix release"
date: 2022-06-15T23:00:00Z
version: "1.20.3"
tags: [release]
---

The GStreamer team is pleased to announce the third bug fix release in the
stable 1.20 release series of your favourite cross-platform
multimedia framework!

This release only contains important security fixes. It should be safe to update from 1.20.x
and we recommend you upgrade at your earliest convenience.

**Highlighted bugfixes:**

- Security fixes in Matroska, MP4 and AVI demuxers
- Fix scrambled video playback with hardware-accelerated VA-API decoders on certain Intel hardware
- playbin3/decodebin3 regression fix for unhandled streams
- Fragmented MP4 playback fixes
- Android H.265 encoder mapping
- Playback of MXF files produced by older FFmpeg versions
- Fix rtmp2sink crashes on 32-bit platforms
- WebRTC improvements
- D3D11 video decoder and screen recorder fixes
- Performance improvements
- Support for building against OpenCV 4.6 and other build fixes
- Miscellaneous bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.20.3 release notes](/releases/1.20/#1.20.3)
for more details.

Binaries for Android, iOS, macOS and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.20.3.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.20.3.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.20.3.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.20.3.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.20.3.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.20.3.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.20.3.tar.xz),
[gst-python](/src/gst-python/gst-python-1.20.3.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.20.3.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.20.3.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.20.3.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.20.3.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.20.3.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.20.3.tar.xz).
