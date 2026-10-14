---
title: "GStreamer 1.22.5 stable bug fix release"
date: 2023-07-20T16:00:00Z
version: "1.22.5"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.22.x.

**Highlighted bugfixes:**

- [Security fixes](/security/) for the RealMedia demuxer
- vaapi decoders, postproc: Disable DMAbuf from caps negotiation to fix garbled video in some cases
- decodebin3, playbin3, parsebin fixes, especially for stream reconfiguration
- hlsdemux2: fix early seeking; don't pass referer when updating playlists; webvtt fixes
- gtk: Fix critical caused by pointer movement when stream is getting ready
- qt6: Set sampler filtering method, fixes bad quality with qml6glsink and gstqt6d3d11
- v4l2src: handle resolution change when buffers are copied
- videoflip: update orientation tag in auto mode
- video timecode: Add support for framerates lower than 1fps and accept 119.88 (120/1.001) fps
- webrtcsink: fixes for x264enc and NVIDIA encoders
- cerbero: Pull ninja from system if possible, avoid spurious bootstrap of cmake
- packages: Recipe updates for ffmpeg, libsoup, orc
- various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.22.5 release notes](/releases/1.22/#1.22.5)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.5.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.5.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.5.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.5.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.5.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.5.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.5.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.5.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.5.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.5.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.5.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.5.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.5.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.5.tar.xz).
