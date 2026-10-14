---
title: "GStreamer 1.22.2 stable bug fix release"
date: 2023-04-11T20:00:00Z
version: "1.22.2"
tags: [release]
---

The GStreamer team is pleased to announce the second bug fix release
in the stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe to update from
1.22.x.

**Highlighted bugfixes:**

- avdec_h264: fix decoder deadlocks with FFmpeg 6.0
- rtspsrc: fix regression with URI protocols in OPTIONS requests for RTSP over TLS
- rtspsrc: improved control url handling compatibility for broken servers
- decklink: fix 10 bit RGB (r210) format auto detection for capture and fix playout if video caps are configured before audio caps
- d3d11videosink: Fix tearing in case of fullscreen mode
- playbin: fix deadlock when stopping stream with subtitles visible (even more)
- typefinding: fix regression not detecting application/dash+xml in some corner cases
- osxvideosink: fix broken aspect ratio and frame drawing region
- decodebin3, parsebin: Improve elementary stream handling when decoders are not present and fix hang when removing a failing stream
- urisourcebin: Propagate sticky events from parsebin, so that the `STREAM_START` event with the `GstStream` info is always available when pads get exposed
- v4l2: Add support for YVU420M format; mark JPEG content as parsed
- h264decoder, h265decoder: DPB bumping process and latency reporting fixes
- Opus: Fix reading of extended channel config in MPEG-TS and fix missing sample rate when remuxing from RTP to Matroska
- zxing: add support for building against zxing-c++ 2.0
- cerbero: Fix packaging of Rust plugins on Android; fix modern Gentoo distro detection
- various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.22.2 release notes](/releases/1.22/#1.22.2)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.2.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.2.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.2.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.2.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.2.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.2.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.2.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.2.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.2.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.2.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.2.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.2.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.2.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.2.tar.xz).
