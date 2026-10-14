---
title: "GStreamer 1.26.10 stable bug fix release"
date: 2025-12-25T18:00:00Z
version: "1.26.10"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.26 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes, and it should be safe to update from 1.26.x.

**Highlighted bugfixes:**

- curlhttpsrc fixes and improvements
- decklinkvideosink: Fix frame completion callbacks for firmware 14.3+
- flac: Fix 6.1 and 7.1 channel layouts and support encoding and decoding of 32-bit audio
- glimagesink: Fix handling of odd height buffers
- matroskademux: make maximum allowed block size large enough to support 4k uncompressed video
- mxf: Add support for custom Sony XDCAM video variant
- opusenc: multichannel and surround sound handling improvements
- playbin3: HLS/DASH stream selection handling improvements to fix disabling and re-enabling of audio/video streams with adaptivedemux2
- qtmux: robust recording mode space left estimation fixes for streams that start with a timestamp offset
- splitmuxsrc seeking improvements
- Support FLAC audio in DASH manifests
- Python bindings: fix regression where buffers were no longer writable in pad probe callbacks
- cerbero: add python bindings for GstApp; Windows installer improvements
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.10 release notes](/releases/1.26/#1.26.10)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
