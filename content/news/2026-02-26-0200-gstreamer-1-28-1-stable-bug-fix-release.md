---
title: "GStreamer 1.28.1 stable bug fix release"
date: 2026-02-26T02:00:00Z
version: "1.28.1"
tags: [release]
---

The GStreamer team is pleased to announce the first bug fix release
in the new stable 1.28 release series of your favourite cross-platform
multimedia framework!

This release only contains bug fixes as well as a number of
[security fixes](/security/). It should be safe to update
from 1.28.0, and we recommend you do so at your earliest convenience.

**Highlighted bugfixes:**

- Various [security fixes](/security/) and playback fixes
- Add new whisper-based speech-to-text transcription element
- Add new debugseimetainserter plugin for testing SEI meta insertion
- Fix scaling and resizing with UIView on EAGL and Vulkan
- Reverse playback and gap handling fixes in various components
- avviddec: Handle field/order changes in mixed interlace mode
- awstranscriber2: workaround for suspected Rust SDK regression
- cudaupload, cudadownload: Fix CUDA/GL interop copy path
- decodebin3: Fix switch to smaller collections and improve collection change on existing pad
- devenv: Add a subproject for providing the LunarG MoltenVK SDK
- livesync: fixes and reverse playback handling; ignore upstream latency when upstream is not live
- objectdetectionoverlay: add support for rotated bounding boxes
- qml6glsrc: Fix rendering of scene with clipped items
- speechmatics: allow configuring audio events such as detecting applause, laughter and music
- livekit webrtc: emit session-requested only for Producer role
- tsdemux: Fix Continuity Counter handling and handle clock change/resets without skew correction
- v4l2: Add support for AV1 stateful V4l2 decoder
- vpxdec: Support downstream pools with alignment requirements
- vtdec, vtenc: Lots of Apple VideoToolbox decoder and encoder fixes
- applemedia build improvements, patches for tvOS support, tvos cross file
- wavpack: Fix handling of format changes, extend parser with new features, handle non-S32 samples
- webrtcsink: allow specifying custom headers to signalling server
- webrtcsink: negotiate profile and level for input encoded in H.264
- webrtcsrc: add request type pads and allow sending encoded data downstream
- cerbero: wheel: Add a new \`gstreamer_meta\` package with fewer deps
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.28.1 release notes](/releases/1.28/#1.28.1)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
