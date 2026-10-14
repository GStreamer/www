---
title: "GStreamer 1.24.10 stable bug fix release"
date: 2024-12-03T23:30:00Z
version: "1.24.10"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and [security fixes](/security/).

It should be safe to update from 1.24.x, and we would recommend you update at
your earliest convenience.

**Highlighted bugfixes:**

- More than [40 security fixes](https://gstreamer.freedesktop.org/security/)
  across a wide range of elements following an audit by the GitHub Security Lab, including
  the MP4, Matroska, Ogg and WAV demuxers, subtitle parsers, image decoders, audio
  decoders and the id3v2 tag parser
- avviddec: Fix regression that could trigger assertions about width/height mismatches
- appsink and appsrc fixes
- closed caption handling fixes
- decodebin3 and urisourcebin fixes
- glupload: dmabuf: Fix emulated tiled import
- level: fix LevelMeta values outside of the stated range
- mpegtsmux, flvmux: fix potential busy looping with high cpu usage in live mode
- pipeline dot file graph generation improvements
- qt(6): fix criticals with multiple qml(6)gl{src,sink}
- rtspsrc: Optionally timestamp RTP packets with their receive times in TCP/HTTP mode to enable clock drift handling
- splitmuxsrc: reduce number of file descriptors used
- systemclock: locking order fixes
- v4l2: fix possible v4l2videodec deadlock on shutdown; 8-bit bayer format fixes
- x265: Fix build with libx265 version &gt;= 4.1 after masteringDisplayColorVolume API change
- macOS: fix rendering artifacts in retina displays, plus ptp clock fixes
- cargo: Default to thin lto for the release profile (for faster builds with lower memory requirements)
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements
- Translation updates

See the [GStreamer 1.24.10 release notes](/releases/1.24/#1.24.10)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
