---
title: "GStreamer 1.26.2 stable bug fix release"
date: 2025-05-29T23:55:00Z
version: "1.26.2"
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
- aggregator base class fixes to not produce buffers too early in live mode
- AWS translate element improvements
- D3D12 video decoder workarounds for crashes on NVIDIA cards on resolution changes
- dav1d AV1-decoder performance improvements
- fmp4mux: tfdt and composition time offset fixes, plus AC-3 / EAC-3 audio support
- GStreamer editing services fixes for sources with non-1:1 aspect ratios
- MIDI parser improvements for tempo changes
- MP4 demuxer atom parsing improvements and security fixes
- New skia-based video compositor element
- Subtitle parser security fixes
- Subtitle rendering and seeking fixes
- Playbin3 and uridecodebin3 stability fixes
- GstPlay stream selection improvements
- WAV playback regression fix
- GTK4 paintable sink colorimetry support and other improvements
- WebRTC: allow webrtcsrc to wait for a webrtcsink producer to initiate the connection
- WebRTC: new Janus Video Room WebRTC source element
- vah264enc profile decision making logic fixes
- Python bindings gained support for handling mini object writability (buffers, caps, etc.)
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.2 release notes](/releases/1.26/#1.26.2)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
