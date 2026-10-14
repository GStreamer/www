---
title: "GStreamer 1.20.1 stable bug fix release"
date: 2022-03-14T12:00:00Z
version: "1.20.1"
tags: [release]
---

The GStreamer team is pleased to announce the first bug fix release in the
stable 1.20 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe to update from
1.20.0.

**Highlighted bugfixes:**

- deinterlace: various bug fixes for yadif, greedy and scalerbob methods
- gtk video sink: Fix rotation not being applied when paused
- gst-play-1.0: Fix trick-mode handling in keyboard shortcut
- jpegdec: fix RGB conversion handling
- matroskademux: improved ProRes video handling
- matroskamux: Handle multiview-mode/flags/pixel-aspect-ratio caps fields correctly when checking caps equality on input caps changes
- videoaggregator fixes (negative rate handling, current position rounding)
- soup http plugin: Lookup libsoup dylib files on Apple platforms; fix Cerbero static build on Android and iOS
- Support build against libfreeaptx in openaptx plugin
- Fix linking issues on Illumos distros
- GstPlay: Fix new error + warning parsing API (was unusuable before)
- mpegtsmux: VBR muxing fixes
- nvdecoder: Various fixes for 4:4:4 and high-bitdepth decoding
- Support build against libfreeaptx in openaptx plugin
- webrtc: Various fixes to the webrtc-sendrecv python example
- macOS: support a relocatable `GStreamer.framework` on macOS
- macOS: fix applemedia plugin failing to load on ARM64 macOS
- windows: ship wavpack library
- gst-python: Fix build with Python 3.11
- various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.20.1 release notes](/releases/1.20/#1.20.1)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.20.1.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.20.1.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.20.1.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.20.1.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.20.1.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.20.1.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.20.1.tar.xz),
[gst-python](/src/gst-python/gst-python-1.20.1.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.20.1.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.20.1.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.20.1.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.20.1.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.20.1.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.20.1.tar.xz).
