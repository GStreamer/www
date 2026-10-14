---
title: "GStreamer 1.28.4 stable bug fix release"
date: 2026-06-12T14:00:00Z
version: "1.28.4"
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
- audioaggregator: fixes for conversion of in-progress buffers when input caps change
- audioresample: more armv7 fixes
- camerabin: Fix caps negotiation failure when starting video capture
- Debug logging performance improvements
- fmp4mux: Fix draining in chunk mode after partial GOPs were drained
- gldownload: fix handling of directly imported dmabufs from glupload
- matroskamux: Write ReferenceBlock for non-keyframe video in BlockGroups
- rtp2: session: add "stats" property
- rtspsrc2: handle parse errors with TCP interleaved more gracefully where the server just drops data
- rtspsrc2: implement support for SRTP, authentication, HTTP tunnelling, keep alive, stream selection, TLS validation, latency configuration
- st2038combiner: only forward video pad segment, fixing issues for cases where the ST2038 segment differs
- Wavpack audio: Various channel and channel-mask related fixes
- webrtc, sdp: set level in negotiated caps only if level asymmetry not allowed, fixing an H.264 negotiation regression with higher resolutions
- androidmedia: add various new codec mime / profile mappings (WMV, VC1, AC3/EAC3/AC4, AAC, H265) and support decoding FLAC
- d3d12decoder: Fix decoding on Qualcomm GPUs on ARM64 Windows
- wasapi2src: fix hang when using loopback-target-pid (regression from 1.26)
- cerbero: update to Rust 1.96, plus glib-networking OpenSSL backend fixes
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.28.4 release notes](/releases/1.28/#1.28.4)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
