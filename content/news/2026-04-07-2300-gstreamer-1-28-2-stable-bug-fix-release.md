---
title: "GStreamer 1.28.2 stable bug fix release"
date: 2026-04-07T23:00:00Z
version: "1.28.2"
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
- audioencoder: allow change of channel configuration with avenc_aac
- audioinvert: fix float format handling
- h264parse, h265parse, baseparse: Preserve upstream buffer duration if possible
- compositor: fix segfault with force-live=true and no sink pads (regression)
- fallbacksrc: send select-streams event to collection source element directly
- hlsdemux2: fix seekable range for live HLS streams
- glupload: Fix linking glupload with restrictive caps filter
- nvcodec: Add capability caching to speed up plugin initialization
- RTP and RTCP packet handling fixes
- RTSP server fixes for clean-up of timed out play requests
- video-converter: fix I420/A420 BGRA/ARGB output on big-endian
- qtdemux: fix invalid WebVTT timestamps, and other fixes
- qmlgl6sink: Qt6GLVideoItem caps update handling fixes
- threadshare udp sink and source fixes
- transcriberbin and speechmatics text-to-speech fixes and improvements
- videorate: Fix wrong caps in case of PTS going backward
- vtdec: more Apple VideoToolbox decoder fixes
- wavparse: Fix parsing of RF64 wave files
- wasapi2sink: Ignore transient device errors from default device
- waylandsink: various fixes and improvements
- WebRTC DTLS robustness/stability improvements
- Cerbero: Various inno Windows installer fixes and improvements; new 'gstreamer_bundle' wheels meta-package
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.28.2 release notes](/releases/1.28/#1.28.2)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
