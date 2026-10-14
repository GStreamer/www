---
title: "GStreamer 1.22.10 stable bug fix release"
date: 2024-02-13T15:00:00Z
version: "1.22.10"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.22.x.

**Highlighted bugfixes:**

- gst-python: fix bindings overrides for Python &gt;= 3.12
- glcolorconvert: fix wrong RGB to YUV matrix with bt709
- glvideoflip: fix "method" property setting at construction time
- gtk4paintablesink: Always draw a black background behind the video frame, and other fixes
- pad: keep segment event seqnums the same when applying a pad offset
- basesink: Preroll on out of segment buffers when not dropping them
- Prefer FFmpeg musepack decoder/demuxer, fixing musepack playback in decodebin3/playbin3
- livesync: add support for image formats such as JPEG or PNG
- sdpdemux: Add SDP message (aka session) attributes to the caps too
- textwrap: add support for gaps
- macos: Fix gst_macos_main() terminating whole process, and set activation policy
- webrtcbin: Improve SDP intersection for Opus
- various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.22.10 release notes](/releases/1.22/#1.22.10)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.10.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.10.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.10.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.10.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.10.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.10.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.10.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.10.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.10.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.10.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.10.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.10.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.10.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.10.tar.xz).
