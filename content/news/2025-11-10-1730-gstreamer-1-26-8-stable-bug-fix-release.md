---
title: "GStreamer 1.26.8 stable bug fix release"
date: 2025-11-10T17:30:00Z
version: "1.26.8"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.26 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes, and it should be safe to update from 1.26.x.

**Highlighted bugfixes:**

- Fix showtime video player showing washed-out colours for HDR videos when subtitles are active
- core: performance improvements for elements with many source pads
- aacparse: support streams which do not have frequent LOAS config
- av1parse: Fix duplicated frames issue in frame splitting
- fmp4mux: Fix EAC3 datarate calculation and substream writing
- gtk4painablesink: fixes glitches with padded buffers such as for sub-sampled video formats with odd sizes
- mpegtsmux: PUSI flag and ID3 tag handling fixes
- rtpbaseaudiopay2: Fix marker bit handling for DISCONT and RESYNC buffer flags
- rtpvp9pay: Fix parsing of show-existing-frame flag, fixes compatibility with vavp9lpenc
- splitmuxsink: accept pads named 'sink\_%u' on the muxer for fmp4 muxer support
- webrtcsink: Correct lock ordering to prevent deadlock
- gst-plugins-rs meson build gained an \`auto_plugin_features\` option and no longer requires all gstreamer libraries to be available
- v4l2 device monitor fixes
- x265enc: advertise latency based on encoder parameters instead of hard-coding it to 5 frames
- cerbero package builder: Add Rust support for 32-bit Linux x86
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.8 release notes](/releases/1.26/#1.26.8)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
