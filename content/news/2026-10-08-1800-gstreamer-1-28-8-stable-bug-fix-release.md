---
title: "GStreamer 1.28.8 stable bug fix release"
date: 2026-10-08T18:00:00Z
version: "1.28.8"
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
- Fix adaptivedemux2 HLS and DASH playback regression
- Fix FLAC audio seeking regression
- Various RTP depayloader and RTSP client SDP handling fixes
- MXF demuxer: Added support for reading AAF AIFF-AIFC audio
- VA-API compositor: Fix alpha blending with Intel driver
- Windows media audio/video seeking improvements
- AMD AMF AV1 video encoder force-keyframe fixes
- Fix endless drain in some FFmpeg wrapper audio encoders and support dual mono
- hlssink3 improvements
- ISOBMFF dash/iso/fmp4 muxer fixes for timestamp rollover in 2036
- cerbero: Rework checksum verification to allow mirror retries
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.28.8 release notes](/releases/1.28/#1.28.8)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
