---
title: "GStreamer 1.22.1 stable bug fix release"
date: 2023-03-04T14:00:00Z
version: "1.22.1"
tags: [release]
---

The GStreamer team is pleased to announce the first bug fix release in the
stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe to update from
1.22.0.

**Highlighted bugfixes:**

- audio channel-mix: allow up to 64 channels (instead of up to 63 channels)
- avfvideosrc: Don't wait on main thread for permissions request
- avvidenc: avoid generating inaccurate output timestamps, especially with variable framerate streams
- AV1 video codec caps signalling improvements in various elements
- codectimestamper: Fix timestamping on sequence update
- d3d11overlaycompositor: fix texture width and height
- d3d11videosink: Fix rendering on external handle
- dashdemux2: fix seek operation taking a log time to finish for some streams
- nvencoder: Fix B-frame encoding on Linux and min buffers in auto GPU mode
- playbin3: fixing buffering for live pipelines
- playbin: fix potential deadlock when stopping stream with subtitles visible
- redenc: fix setting of extension ID for twcc
- rtspsrc: improved compatibility with more broken RTSP servers
- v4l2h264dec: Fix Raspberry Pi4 will not play video in application
- vtdec: fix jittery playback of H.264 Level 4.1 movies in macOS
- vtdec: Fix non-deterministic frame output after flushing seeks
- vtenc: fix handling of interlaced ProRes on Apple M1 hardware
- vtenc: don't advertise ARGB/RGBA64 input caps on M1 Pro/Max with macOS &lt;13
- wasapi2src: Fix loopback capture on Windows 10 Anniversary Update
- tools: better handling of non-ASCII command line arguments on Windows
- gst-libav: fix build against newer ffmpeg versions
- gst-python: Use arch-specific install dir for gi overrides
- cerbero: Fix setuptools site.py breakage in Python 3.11
- macOS packages: Fix broken binaries on macos &lt; 11.0
- various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.22.1 release notes](/releases/1.22/#1.22.1)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.1.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.1.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.1.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.1.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.1.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.1.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.1.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.1.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.1.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.1.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.1.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.1.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.1.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.1.tar.xz).
