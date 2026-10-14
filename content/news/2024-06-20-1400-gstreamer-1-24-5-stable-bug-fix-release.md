---
title: "GStreamer 1.24.5 stable bug fix release"
date: 2024-06-20T14:00:00Z
version: "1.24.5"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.24.x.

**Highlighted bugfixes:**

- webrtcsink: Support for AV1 via nvav1enc, av1enc or rav1enc encoders
- AV1 RTP payloader/depayloader fixes to work correctly with Chrome and Pion WebRTC
- av1parse, av1dec error handling/robustness improvements
- av1enc: Handle force-keyunit events properly for WebRTC
- decodebin3: selection and collection handling improvements
- hlsdemux2: Various fixes for discontinuities, variant switching, playlist updates
- qml6glsink: fix RGB format support
- rtspsrc: more control URL handling fixes
- v4l2src: Interpret V4L2 report of sync loss as video signal loss
- d3d12 encoder, memory and videosink fixes
- vtdec: more robust error handling, fix regression
- ndi: support for NDI SDK v6
- Various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.5 release notes](/releases/1.24/#1.24.5)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
