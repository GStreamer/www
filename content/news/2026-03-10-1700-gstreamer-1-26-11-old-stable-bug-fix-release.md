---
title: "GStreamer 1.26.11 old-stable bug fix release"
date: 2026-03-10T17:00:00Z
version: "1.26.11"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the now old-stable 1.26 release series of your favourite cross-platform
multimedia framework!

Please note that the 1.26 old-stable series is no longer actively maintained
and has been superseded by the GStreamer 1.28 stable series now.

This release only contains bugfixes, and it should be safe to update from 1.26.x.

**Highlighted bugfixes:**

- Security fixes for the JPEG, H.265 and H.266 video parsers and the DVB subtitle overlay
- Security fixes for the ASF, RealMedia and QuickTime/MP4 demuxers and RIFF library
- Security fixes for the WAV audio parser and the RTP QDM2 depayloader
- avviddec: Handle field/order changes in mixed interlace mode
- awstranscriber2: workaround AWS SDK regression, plus transcriberbin latency reporting fixes
- videodecoder: Handle recovery from temporary reordered output
- Decodebin3 collection handling improvements
- fmp4mux: fragment duration handling improvements for HLS
- Gap event handling fixes in audio/video decoders and aggregator/muxers
- GstPlay stream selection handling improvements
- Input selector fixes
- MPEG-TS demuxer continuity counter handling fixes
- Reverse playback fixes for the MP4 demuxer
- RTP, SRTP, RTCP and RTSP and Transport-Wide Congestion Control fixes
- Webrtcsink: better handling of platform-specific NVIDIA encoder differences, plus other improvements
- Apple macOS VideoToolbox decoder improvements
- Python bindings: more type hinting
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.11 release notes](/releases/1.26/#1.26.11)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
