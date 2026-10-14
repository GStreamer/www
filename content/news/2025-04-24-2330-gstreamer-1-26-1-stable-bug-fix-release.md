---
title: "GStreamer 1.26.1 stable bug fix release"
date: 2025-04-24T23:30:00Z
version: "1.26.1"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.26 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes, and it should be safe to update from 1.26.0.

**Highlighted bugfixes:**

- awstranslate and speechmatics plugin improvements
- decodebin3 fixes and urisourcebin/playbin3 stability improvements
- Closed captions: CEA-708 generation and muxing fixes, and H.264/H.265 caption extractor fixes
- dav1d AV1 decoder: RGB support, plus colorimetry, renegotiation and buffer pool handling fixes
- Fix regression when rendering VP9 with alpha
- H.265 decoder base class and caption inserter SPS/PPS handling fixes
- hlssink3 and hlsmultivariantsink feature enhancements
- Matroska v4 support in muxer, seeking fixes in demuxer
- macOS: framerate guessing for cameras or capture devices where the OS reports silly framerates
- MP4 demuxer uncompressed video handling improvements and sample table handling fixes
- oggdemux: seeking improvements in streaming mode
- unixfdsrc: fix gst_memory_resize warnings
- Plugin loader fixes, especially for Windows
- QML6 GL source renegotiation fixes
- RTP and RTSP stability fixes
- Thread-safety improvements for the Media Source Extension (MSE) library
- v4l2videodec: fix A/V sync issues after decoding errors
- Various improvements and fixes for the fragmented and non-fragmented MP4 muxers
- Video encoder base class segment and buffer timestamp handling fixes
- Video time code support for 119.88 fps and drop-frames-related conversion fixes
- WebRTC: Retransmission entry creation fixes and better audio level header extension compatibility
- YUV4MPEG encoder improvments
- dots-viewer: make work locally without network access
- gst-python: fix compatibility with PyGObject &gt;= 3.52.0
- Cerbero: recipe updates, compatibility fixes for Python &lt; 3.10; Windows Android cross-build improvements
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.1 release notes](/releases/1.26/#1.26.1)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
