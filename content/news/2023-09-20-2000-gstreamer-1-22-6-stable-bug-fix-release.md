---
title: "GStreamer 1.22.6 stable bug fix release"
date: 2023-09-20T20:00:00Z
version: "1.22.6"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.22.x.

**Highlighted bugfixes:**

- [Security fixes](/security/) for the MXF demuxer and H.265 video parser
- Fix latency regression in H.264 hardware decoder base class
- androidmedia: fix HEVC codec profile registration and fix coded_data handling
- decodebin3: fix switching from a raw stream to an encoded stream
- gst-inspect: prettier and more correct signal and action signals printing
- rtmp2: Allow NULL flash version, omitting the field, for better RTMP server compatibility
- rtspsrc: better compatibility with buggy RTSP servers that don't set a clock-rate
- rtpjitterbuffer: fix integer overflow that led to more packets being declared lost than have been lost
- v4l2: fix video encoding regression on RPi and fix support for left and top padding
- waylandsink: Crop surfaces to their display width height
- cerbero: Recognise Manjaro; add Rust support for MSVC ARM64; cmake detection fixes
- various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.22.6 release notes](/releases/1.22/#1.22.6)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.6.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.6.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.6.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.6.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.6.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.6.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.6.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.6.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.6.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.6.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.6.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.6.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.6.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.6.tar.xz).
