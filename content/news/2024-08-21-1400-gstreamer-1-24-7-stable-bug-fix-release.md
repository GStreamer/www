---
title: "GStreamer 1.24.7 stable bug fix release"
date: 2024-08-21T14:00:00Z
version: "1.24.7"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe
to update from 1.24.x.

**Highlighted bugfixes:**

- Fix APE and Musepack audio file and GIF playback with FFmpeg 7.0
- playbin3: Fix potential deadlock with multiple playbin3s with glimagesink used in parallel
- qt6: various qmlgl6src and qmlgl6sink fixes and improvements
- rtspsrc: expose property to force usage of non-compliant setup URLs for RTSP servers where the automatic fallback doesn't work
- urisourcebin: gapless playback and program switching fixes
- v4l2: various fixes
- va: Fix potential deadlock with multiple va elements used in parallel
- meson: option to disable gst-full for static-library build configurations that do not need this
- cerbero: libvpx updated to 1.14.1; map 2022Server to Windows11; disable rust variant on Linux if binutils is too old
- Various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.7 release notes](/releases/1.24/#1.24.7)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
