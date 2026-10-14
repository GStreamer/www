---
title: "GStreamer 1.24.11 stable bug fix release"
date: 2025-01-06T23:30:00Z
version: "1.24.11"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe to update from 1.24.x.

**Highlighted bugfixes:**

- playback: Fix SSA/ASS subtitles with embedded fonts
- decklink: add missing video modes and fix 8K video modes
- matroskamux: spec compliance fixes for audio-only files
- onnx: disable onnxruntime telemetry
- qtdemux: Fix base offset update when doing segment seeks
- srtpdec: Fix a use-after-free issue
- (uri)decodebin3: Fix stream change scenarios, possible deadlock on shutdown
- video: fix missing alpha flag in AV12 format description
- avcodecmap: Add some more channel position mappings
- cerbero bootstrap fixes for Windows 11
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.11 release notes](/releases/1.24/#1.24.11)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
