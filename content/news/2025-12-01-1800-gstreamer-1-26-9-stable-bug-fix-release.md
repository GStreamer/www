---
title: "GStreamer 1.26.9 stable bug fix release"
date: 2025-12-01T18:00:00Z
version: "1.26.9"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.26 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes, and it should be safe to update from 1.26.x.

**Highlighted bugfixes:**

- playback: playbin3 and decodebin3 stability fixes
- Ancillary metadata handling fixes for AJA playout and Blackmagic Decklink capture cards
- HLS and DASH adaptive streaming clients stability improvements
- gst-play-1.0 will now print details of any missing plugins again
- gtk4paintablesink: Add property to fine-tune reconfiguration behaviour on window-resize
- macOS device monitoring: fix potential crash when probing for audio devices
- macOS video decoder stability improvements
- NDI source: fix audio corruption for non-interleaved audio with stride padding
- Add SMPTE ST291-1 ancillary metadata RTP payloader and depayloader
- Add ST-2038 metadata combiner and extractor
- webrtcsink: support hardware-accelerated encoders from the \`va\` VA-API plugin
- spotifysrc: fix the Spotify integration by using Spotify's extended metadata endpoint
- Python bindings cross compilation fixes
- cerbero: add Visual Studio 2026 support, fix building on drives other than C:\\, and ship svtjpegxs plugin on Windows
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.9 release notes](/releases/1.26/#1.26.9)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
