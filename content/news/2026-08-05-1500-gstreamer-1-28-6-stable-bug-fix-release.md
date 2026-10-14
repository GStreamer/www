---
title: "GStreamer 1.28.6 stable bug fix release"
date: 2026-08-05T15:00:00Z
version: "1.28.6"
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
- playbin3, playbin: fix stalls after re-enabling previously disabled subtitles
- Fix regression in core if a pad is re-linked while changed sticky events are being pushed
- dtls/webrtc: fix some issues with OpenSSL 4.0.0
- RTP retransmission bitrate estimation fixes
- Fix RTP depayloading of SMPTE ST291 frames with multiple ANC packets
- Add H.266 muxing support to the Rust (f)mp4 muxers
- Better handling of input buffers without timestamps in Rust (f)mp4 muxers
- webrtcsink H.264 level/profile negotiation fixes and support for nvv4l2h265enc encoder
- SMPTE ST2038 ancillary metadata and closed caption combiner improvements
- Fix SEI insertion into H.265/HEVC streams with alpha
- Windows D3D11 WinRT screen capture element fixes
- Improved coded buffer size handling for VA encoders
- Textaccumulate: various tweaks how the element outputs text, plus better handling of French punctuation
- hlssink3: improved handling of input buffers without timestamps
- Fix build against FFmpeg 9.0
- cerbero: fix Windows packages binary size increase regression; upgrade libsrt recipe to 1.5.6
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.28.6 release notes](/releases/1.28/#1.28.6)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
