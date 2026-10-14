---
title: "GStreamer 1.24.9 stable bug fix release"
date: 2024-10-30T23:30:00Z
version: "1.24.9"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and a [security fix](/security/sa-2024-0004.html)
and it should be safe to update from 1.24.x.

**Highlighted bugfixes:**

- gst-rtsp-server [security fix](/security/sa-2024-0004.html)
- GstAggregator start time selection and latency query fixes for force-live mode
- audioconvert: fix dynamic handling of mix matrix, and accept custom upstream event for setting one
- encodebin: fix parser selection for encoders that support multiple codecs
- flvmux improvments for pipelines where timestamps don't start at 0
- glcontext: egl: Unrestrict the support base DRM formats
- kms: Add IMX-DCSS auto-detection in sink and fix stride with planar formats in allocator
- macOS main application event loop fixes
- mpegtsdemux: Handle PTS/DTS wraparound with ignore-pcr=true
- playbin3, decodebin3, parsebin, urisourcebin: fix races, and improve stability and stream-collection handling
- rtpmanager: fix early RTCP SR generation for sparse streams like metadata
- qml6glsrc: Reduce capture delay
- qtdemux: fix parsing of rotation matrix with 180 degree rotation
- rtpav1depay: added wait-for-keyframe and request-keyframe properties
- srt: make work with newer libsrt versions and don't re-connect on authentication failure
- v4l2 fixes and improvement
- webrtcsink, webrtcbin and whepsrc fixes
- cerbero: fix Python 3.13 compatibility, g-i with newer setuptools, bootstrap on Arch Linux; iOS build fixes
- Ship qroverlay plugin in binary packages
- Various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.9 release notes](/releases/1.24/#1.24.9)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
