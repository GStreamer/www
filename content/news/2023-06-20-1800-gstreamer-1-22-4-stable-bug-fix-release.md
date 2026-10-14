---
title: "GStreamer 1.22.4 stable bug fix release"
date: 2023-06-20T18:00:00Z
version: "1.22.4"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.22.x.

**Highlighted bugfixes:**

- [Security fixes](/security/) for flacparse, dvdspu, and subparse
- d3d11videosink: Fix error on pause and play
- decklink: Correctly handle SDK strings on macOS and free strings after usage on Linux
- filesink: Fix buffered mode writing of buffer lists and buffers with multiple memories
- gldownload: handle passthrough without a critical
- h265parse: Fix framerate handling regression
- oggdemux: vp8 fixes
- mp4mux, qtmux, qtdemux: Opus audio mapping fixes
- pngdec: Fix wrong colours output from 16bit RGB images
- ptp clock: Work around ptpd bug in default configuration
- srtpdec: fix critical warnings on shutdown
- v4l2src: fix support for bayer format
- v4l2videoenc: support force-keyframe event in v4l2 encoder
- vtenc: apply DTS offset to ensure DTS &lt;= PTS
- gst-python: allow more functions to be called before `gst_init()`
- cerbero: fix vaapi variant; add qt6 build on windows; ensure errors on unguarded use of new APIs, require macOS 10.13
- packages: ship codecalpha, rtponvif, dvbsubenc, switchbin, videosignal plugins; fix pango crash on 32-bit windows
- various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.22.4 release notes](/releases/1.22/#1.22.4)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.4.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.4.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.4.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.4.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.4.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.4.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.4.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.4.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.4.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.4.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.4.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.4.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.4.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.4.tar.xz).
