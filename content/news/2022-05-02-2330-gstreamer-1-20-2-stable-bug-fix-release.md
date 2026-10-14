---
title: "GStreamer 1.20.2 stable bug fix release"
date: 2022-05-02T23:30:00Z
version: "1.20.2"
tags: [release]
---

The GStreamer team is pleased to announce the second bug fix release in the
stable 1.20 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe to update from 1.20.x.

**Highlighted bugfixes:**

- avviddec: Remove vc1/wmv3 override and fix crashes on WMV files with FFMPEG 5.0+
- macOS: fix plugin discovery for GStreamer installed via brew and fix loading of Rust plugins
- rtpbasepayload: various header extension handling fixes
- rtpopusdepay: fix regression in stereo input handling if sprop-stereo is not advertised
- rtspclientsink: fix possible shutdown deadlock
- mpegts: gracefully handle "empty" program maps and fix AC-4 detection
- mxfdemux: Handle empty VANC packets and fix EOS handling
- playbin3: various playbin3, uridecodebin3, and playsink fixes
- ptpclock: fix initial sync-up with certain devices
- gltransformation: let graphene alloc its structures memory aligned
- webrtcbin fixes and webrtc sendrecv example improvements
- video4linux2: various fixes including some fixes for Raspberry Pi users
- videorate segment handling fixes and other fixes
- nvh264dec, nvh265dec: Fix broken key-unit trick modes and reverse playback
- wpe: Reintroduce persistent WebContext
- cerbero: Make it easier to consume 1.20.1 macOS GStreamer .pkgs
- build fixes and gobject annotation fixes
- bug fixes, security fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.20.2 release notes](/releases/1.20/#1.20.2)
for more details.

Binaries for Android, iOS, macOS and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.20.2.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.20.2.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.20.2.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.20.2.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.20.2.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.20.2.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.20.2.tar.xz),
[gst-python](/src/gst-python/gst-python-1.20.2.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.20.2.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.20.2.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.20.2.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.20.2.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.20.2.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.20.2.tar.xz).
