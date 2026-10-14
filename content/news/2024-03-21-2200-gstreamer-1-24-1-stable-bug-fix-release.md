---
title: "GStreamer 1.24.1 stable bug fix release"
date: 2024-03-21T22:00:00Z
version: "1.24.1"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.24.0.

**Highlighted bugfixes:**

- Fix instant-EOS regression in audio sinks in some cases when volume is 0
- rtspsrc: server compatibility improvements and ONVIF trick mode fixes
- rtsp-server: fix issues if RTSP media was set to be both shared and reusable
- (uri)decodebin3 and playbin3 fixes
- adaptivdemux2/hlsdemux2: Fix issues with failure updating playlists
- mpeg123 audio decoder fixes
- v4l2codecs: DMA_DRM caps support for decoders
- va: various AV1 / H.264 / H.265 video encoder fixes
- vtdec: fix potential deadlock regression with ProRes playback
- gst-libav: fixes for video decoder frame handling, interlaced mode detection
- avenc_aac: support for 7.1 and 16 channel modes
- glimagesink: Fix the sink not always respecting preferred size on macOS
- gtk4paintablesink: Fix scaling of texture position
- webrtc: Allow resolution and framerate changes, and many other improvements
- webrtc: Add new LiveKit source element
- Fix usability of binary packages on arm64 iOS
- various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.1 release notes](/releases/1.24/#1.24.1)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.24.1.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.24.1.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.24.1.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.24.1.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.24.1.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.24.1.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.24.1.tar.xz),
[gst-python](/src/gst-python/gst-python-1.24.1.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.24.1.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.24.1.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.24.1.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.24.1.tar.xz),
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.24.1.tar.xz).
