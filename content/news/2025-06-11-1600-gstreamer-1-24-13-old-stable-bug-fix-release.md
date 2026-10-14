---
title: "GStreamer 1.24.13 old-stable bug fix release"
date: 2025-06-11T16:00:00Z
version: "1.24.13"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new old stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes as well as a number of
[security fixes](/security/) and important playback fixes,
and it *should* be safe to update from 1.24.x.

Please note that the 1.24 old-stable series is no longer actively maintained
and has been superseded by the GStreamer 1.26 stable series now.

**Highlighted bugfixes:**

- Various [security fixes](/security/) and playback fixes
- MP4 demuxer atom parsing improvements and security fixes
- H.265 decoder base class and caption inserter SPS/PPS handling fixes
- Subtitle parser security fixes
- Subtitle rendering and seeking fixes
- Closed caption fixes
- Matroska rotation tag support and v4 muxing support
- Ogg seeking improvements in streaming mode
- Windows plugin loading fixes
- MIDI parser improvements for tempo changes
- Video time code support for 119.88 fps and drop-frames-related conversion fixes
- GStreamer editing services fixes for sources with non-1:1 aspect ratios
- RTP session handling and RTSP server fixes
- Thread-safety improvements for the Media Source Extension (MSE) library
- macOS video capture improvements for external devices
- Python bindings: Fix compatibility with PyGObject &gt;= 3.52.0
- cerbero: bootstrapping fixes on Windows, improved support for RHEL, and openh264 recipe update
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.13 release notes](/releases/1.24/#1.24.13)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
