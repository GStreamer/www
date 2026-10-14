---
title: "GStreamer 1.28.7 stable bug fix release"
date: 2026-09-07T23:00:00Z
version: "1.28.7"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.28 release series of your favourite cross-platform
multimedia framework!

This release only contains bug fixes as well as a number of
[security fixes](/security/). It should be safe to update
from 1.28.x, and we recommend you do so at your earliest convenience.

**Highlighted bugfixes:**

- Various [security fixes](/security/) and playback fixes
- appsrc EOS handling regression fix for applications pushing EOS into a blocked appsrc
- glcolorconvert fixes for older OpenGL/GLSL versions
- mxfdemux: Fix keyframe detection regression and possible artefacts after seeking
- QML6 GL Overlay output texture lifetime handling fixes
- opencv: Add support for building against OpenCV 5
- hip: Add missing API version suffix in HIP support library filename and fix hipcc detection on Windows with HIP SDK 7.x
- analytics: fix classes off-by-one in ssdtensordec leading to mislabelling of objects in the examples
- isobmff: Fix min_display_mastering_luminance in mdcv box
- rtpbin2: rtprecv: limit the number of remote sources being tracked
- st2038anc: parity bit handling fixes for ST 291 ADF words
- video converter and videoconvertscale fixes
- mpegdemux: restore gap event sending in MPEG-PS demuxer
- typefinding: fix typefinding regressions for ogg and text files
- Fix x264enc high bit depth support in binary packages
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.28.7 release notes](/releases/1.28/#1.28.7)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
