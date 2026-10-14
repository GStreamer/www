---
title: "GStreamer 1.22.7 stable bug fix release"
date: 2023-11-13T12:00:00Z
version: "1.22.7"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.22.x.

**Highlighted bugfixes:**

- [Security fixes](/security/) for the MXF demuxer and AV1 codec parser
- glfilter: Memory leak fix for OpenGL filter elements
- d3d11videosink: Fix toggling between fullscreen and maximized, and window switching in fullscreen mode
- DASH / HLS adaptive streaming fixes
- Decklink card device provider device name string handling fixes
- interaudiosrc: handle non-interleaved audio properly
- openh264: Fail gracefully if openh264 encoder/decoder creation fails
- rtspsrc: improved whitespace handling in response headers by certain cameras
- v4l2codecs: avoid wrap-around after 1000000 frames; tiled formats handling fixes
- video-scaler, audio-resampler: downgraded "Can't find exact taps" debug log messages
- wasapi2: Don't use global volume control object
- Rust plugins: various improvements in aws, fmp4mux, hlssink3, livesync, ndisrc, rtpav1depay, rsfilesink, s3sink, sccparse
- WebRTC: various webrtchttp, webrtcsrc, and webrtcsink improvements and fixes
- Cerbero build tools: recognise Windows 11; restrict parallelism of gst-plugins-rs build on small systems
- Packages: ca-certificates update; fix gio module loading and TLS support on macOS

See the [GStreamer 1.22.7 release notes](/releases/1.22/#1.22.7)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.7.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.7.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.7.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.7.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.7.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.7.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.7.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.7.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.7.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.7.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.7.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.7.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.7.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.7.tar.xz).
