---
title: "GStreamer 1.20.5 stable bug fix release"
date: 2022-12-19T23:00:00Z
version: "1.20.5"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release in the
stable 1.20 release series of your favourite cross-platform
multimedia framework!

This release only contains bug fixes. It should be safe to update from 1.20.x.

**Highlighted bugfixes:**

- systemclock waiting fixes for certain 32-bit platforms/libcs
- alphacombine: robustness improvements for corner case scenarios
- avfvideosrc: Report latency when doing screen capture
- d3d11videosink: various thread-safety and stability fixes
- decklink: fix performance issue when HDMI signal has been lost for a long time
- flacparse: Fix handling of headers advertising 32 bits per sample
- mpegts: Handle when iconv doesn't support ISO 6937 (e.g. musl libc)
- opengl: fix automatic dispmanx detection for rpi4 and fix usage of eglCreate/DestroyImage
- opusdec: Various channel-related fixes
- textrender: event handling fixes, esp. for GAP event
- subparse: Fix non-closed tag handling
- videoscale: fix handling of unknown buffer metas
- videosink: reverse playback handling fixes
- qtmux: Prefill mode fixes, especially for raw audio
- multiudpsink: allow binding to IPv6 address
- rtspsrc: Fix usage of IPv6 connections in SETUP
- rtspsrc: Only EOS on timeout if all streams are timed out/EOS
- splitmuxsrc: fix playback stall if there are unlinked pads
- v4l2: Fix SIGSEGV on state change during format changes
- wavparse robustness fixes
- Fix static linking on macOS (opengl, vulkan)
- gstreamer-vaapi: fix headless build against mesa &gt;= 22.3.0
- GStreamer Editing Services library: Fix build with tools disabled
- webrtc example/demo fixes
- unit test fixes for aesdec and rtpjitterbuffer
- Cerbero: Fix ios cross-compile with cmake on M1; some recipe updates and other build fixes
- Binary packages: pkg-config file fixes for various recipes (ffmpeg, taglib, gstreamer)
- Binary packages: Enable high bitdepth support for libvpx (VP8/VP9 encoding/decoding)
- Binary packages: ship aes plugin
- Performance improvements
- Miscellaneous bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.20.5 release notes](/releases/1.20/#1.20.5)
for more details.

Binaries for Android, iOS, macOS and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.20.5.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.20.5.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.20.5.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.20.5.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.20.5.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.20.5.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.20.5.tar.xz),
[gst-python](/src/gst-python/gst-python-1.20.5.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.20.5.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.20.5.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.20.5.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.20.5.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.20.5.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.20.5.tar.xz).
