---
title: "GStreamer 1.26.6 stable bug fix release"
date: 2025-09-14T13:00:00Z
version: "1.26.6"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.26 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes, and it should be safe to update from 1.26.x.

**Highlighted bugfixes:**

- analytics GstTensorMeta handling changes (see release notes)
- closed caption combiner and transcriberbin stability fixes
- decklinkvideosrc: fix unrecoverable state after failing to start streaming because device is busy
- decodebin3 tag handling improvements
- fallbacksrc: Fix sources only being restarted once, as well as some deadlocks and race conditions on shutdown
- gtk4paintablesink: Try importing dmabufs withouth DMA_DRM caps
- hlsdemux2: Fix parsing of byterange and init map directives
- rtpmp4gdepay2: allow only constantduration with neither constantsize nor sizelength set
- spotifysrc: update to librespot 0.7 to make work after recent Spotify changes
- threadshare: new blocking adapter element for use in front of block elements such as sinks that sync to the clock
- threadshare: various other threadshare element fixes and improvements
- v4l2: Add support for WVC1 and WMV3
- videorate: possible performance improvements when operating in drop-only mode
- GstBaseParse fixes
- Vulkan video decoder fixes
- Fix gst-device-monitor-1.0 tool device-path regression on Windows
- Python bindings: Handle buffer PTS, DTS, duration, offset, and offset-end as unsigned long long (regression fix)
- Cerbero: Reduce recipe parallelism in various cases and dump cerbero and recipe versions into datadir during packaging
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.6 release notes](/releases/1.26/#1.26.6)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
