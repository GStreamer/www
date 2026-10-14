---
title: "GStreamer 1.24.3 stable bug fix release"
date: 2024-04-30T01:00:00Z
version: "1.24.3"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.24.x.

**Highlighted bugfixes:**

- EXIF image tag parsing [security fixes](/security/)
- Subtitle handling improvements in parsebin
- Fix issues with HLS streams that contain VTT subtitles
- Qt6 QML sink re-render and re-sizing fixes
- unixfd ipc plugin timestamp and segment handling fixes
- vah264enc, vah265enc: Do not touch the PTS of the output frame
- vah264dec and vapostproc fixes and improvements
- v4l2: multiple fixes and improvements, incl. for mediatek JPEG decoder and v4l2 loopback
- v4l2: fix hang after seek with some v4l2 decoders
- Wayland sink fixes
- ximagesink: fix regression on RPi/aarch64
- fmp4mux, mp4mux gained FLAC audio support
- D3D11, D3D12: reliablity improvements and memory leak fixes
- Media Foundation device provider fixes
- GTK4 paintable sink improvements including support for directly importing dmabufs with GTK 4.14
- WebRTC sink/source fixes and improvements
- AWS s3sink, s3src, s3hlssink now support path-style addressing
- MPEG-TS demuxer fixes
- Python bindings fixes
- various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.3 release notes](/releases/1.24/#1.24.3)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.24.3.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.24.3.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.24.3.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.24.3.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.24.3.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.24.3.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.24.3.tar.xz),
[gst-python](/src/gst-python/gst-python-1.24.3.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.24.3.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.24.3.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.24.3.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.24.3.tar.xz),
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.24.3.tar.xz).
