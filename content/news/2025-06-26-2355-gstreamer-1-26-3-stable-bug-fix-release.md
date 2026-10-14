---
title: "GStreamer 1.26.3 stable bug fix release"
date: 2025-06-26T23:55:00Z
version: "1.26.3"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.26 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes as well as a number of
[security fixes](/security/) and important playback fixes,
and it should be safe to update from 1.26.x.

**Highlighted bugfixes:**

- Various [security fixes](/security/) and playback fixes
- Security fix for the H.266 video parser
- Fix regression for WAV files with acid chunks
- Fix high memory consumption caused by a text handling regression in uridecodebin3 and playbin3
- Fix panic on late GOP in fragmented MP4 muxer
- Closed caption conversion, rendering and muxing improvements
- Decklink video sink preroll frame rendering and clock drift handling fixes
- MPEG-TS demuxing and muxing fixes
- MP4 muxer fixes for creating very large files with faststart support
- New thread-sharing 1:N inter source and sink elements, and a ts-rtpdtmfsrc
- New speech synthesis element around ElevenLabs API
- RTP H.265 depayloader fixes and improvements, as well as TWCC and GCC congestion control fixes
- Seeking improvements in DASH client for streams with gaps
- WebRTC sink and source fixes and enhancements, including to LiveKit and WHIP signallers
- The macOS osxvideosink now posts navigation messages
- QtQML6GL video sink input event handling improvements
- Overhaul detection of hardware-accelerated video codecs on Android
- Video4Linux capture source fixes and support for BT.2100 PQ and 1:4:5:3 colorimetry
- Vulkan buffer upload and memory handling regression fixes
- Python bindings: fix various regressions introduced in 1.26.2
- cerbero: fix text relocation issues on 32-bit Android and fix broken VisualStudio VC templates
- packages: ship pbtypes plugin and update openssl to 3.5.0 LTS
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.3 release notes](/releases/1.26/#1.26.3)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
