---
title: "GStreamer 1.26.7 stable bug fix release"
date: 2025-10-14T18:30:00Z
version: "1.26.7"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.26 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes, and it should be safe to update from 1.26.x.

**Highlighted bugfixes:**

- cea608overlay: improve handling of non-system memory
- cuda: Fix runtime kernel compile with CUDA 13.0
- d3d12: Fix crop meta support in converter and passthrough handling in deinterlacer
- fallbacksrc: source handling improvements; no-more-pads signal for streams-unaware parents
- inter: add properties to fine tune the inner elements
- qtdemux: surround sound channel layout handling fixes and performance improvements for GoPro videos
- rtp: Add linear audio (L8, L16, L24) RTP payloaders / depayloaders
- rtspsrc: Send RTSP keepalives in TCP/interleaved modes
- rtpamrpay2: frame quality indicator flag related fixes
- rtpbasepay2: reuse last PTS when possible, to work around problems with NVIDIA Jetson AV1 encoder
- mpegtsmux, tsdemux: Opus audio handling fixes
- threadshare: latency related improvements and many other fixes
- matroskamux, tsmux, flvmux, cea608mux: Best pad determination fixes at EOS
- unixfd: support buffers with a big payload
- videorate unknown buffer duration assertion failure with variable framerates
- editing services: Make GESTimeline respect \`SELECT_ELEMENT_TRACK\` signal discard decision; memory leak fixes
- gobject-introspection annotation fixes
- cerbero: Update meson to 1.9.0 to enable Xcode 26 compatibility
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.7 release notes](/releases/1.26/#1.26.7)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
