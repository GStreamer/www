---
title: "GStreamer 1.20.4 stable bug fix release"
date: 2022-10-12T15:00:00Z
version: "1.20.4"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release in the
stable 1.20 release series of your favourite cross-platform
multimedia framework!

This release only contains bug fixes. It should be safe to update from 1.20.x.

**Highlighted bugfixes:**

- avaudiodec: fix playback issue with WMA files, would throw an error at EOS with FFmpeg 5.x
- Fix deadlock when loading gst-editing-services plugin
- Fix input buffering capacity in live mode for aggregator, video/audio aggregator subclasses, muxers
- glimagesink: fix crash on Android
- subtitle handling and subtitle overlay fixes
- matroska-mux: also allow width + height changes for avc3|hev1|vp8|vp9
- rtspsrc: fix control url handling for spec compliant servers and add fallback for incompliant servers
- WebRTC fixes
- RTP retransmission fixes
- video: fixes for formats with 4x subsampling and horizontal co-sited chroma (Y41B, YUV9, YVU9 and IYU9)
- macOS build and packaging fixes, in particular fix finding of gio modules on macOS for https/TLS support
- Performance improvements
- Miscellaneous bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.20.4 release notes](/releases/1.20/#1.20.4)
for more details.

Binaries for Android, iOS, macOS and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.20.4.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.20.4.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.20.4.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.20.4.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.20.4.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.20.4.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.20.4.tar.xz),
[gst-python](/src/gst-python/gst-python-1.20.4.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.20.4.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.20.4.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.20.4.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.20.4.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.20.4.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.20.4.tar.xz).
