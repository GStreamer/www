---
title: "GStreamer 1.20.6 old-stable bug fix release"
date: 2023-02-23T23:50:00Z
version: "1.20.6"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release in the
now old-stable 1.20 release series of your favourite cross-platform
multimedia framework!

This release only contains bug fixes. It should be safe to update from 1.20.x.

**Highlighted bugfixes:**

- audio: channel-mix: allow up to 64 channels instead of up to 63 channels
- AOM AV1 encoder timestamp handling improvements
- AV1 video codec caps handling improvements in aom plugin, isomp4 and matroska muxers/demuxers
- avvidenc: fix bitrate control and timestamps off FFmpeg-based video encoders
- h264parse: fix missing timestamps on outputs when splitting a frame
- rtspsrc: more workarounds for servers with broken control uri handling
- playbin3: fix issue with UDP streams, making sure there's enough buffering
- qmlglsrc: Fix deadlock when stopping and some other fixes
- qtmux: fix default timescale unit for N/1001 framerates
- v4l2h264dec: Fix Raspberry Pi4 will not play video in application
- vtdec: Fix non-deterministic frame output after seeks
- wasapi2src: Fix loopback capture on Windows 10 Anniversary Update
- macOS, iOS: Fix Xcode 14 ABI breakage with older Xcode
- cerbero: Fix some regressions for CentOS in the 1.20 branch
- cerbero: Fix setuptools site.py breakage in Python 3.11
- Fix gst-libav build against FFmpeg from git
- gobject-introspection annotation fixes for bindings
- Miscellaneous bug fixes, memory leak fixes, and other stability and reliability improvements
- Performance improvements

See the [GStreamer 1.20.6 release notes](/releases/1.20/#1.20.6)
for more details.

Binaries for Android, iOS, macOS and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.20.6.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.20.6.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.20.6.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.20.6.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.20.6.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.20.6.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.20.6.tar.xz),
[gst-python](/src/gst-python/gst-python-1.20.6.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.20.6.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.20.6.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.20.6.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.20.6.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.20.6.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.20.6.tar.xz).

The GStreamer 1.20 series has now been superseded by the new stable
[GStreamer 1.22 series](https://gstreamer.freedesktop.org/releases/1.22/)
and we recommend you upgrade at your earliest convenience.
