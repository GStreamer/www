---
title: "GStreamer 1.24.4 stable bug fix release"
date: 2024-05-29T14:00:00Z
version: "1.24.4"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.24.x.

**Highlighted bugfixes:**

- audioconvert: support more than 64 audio channels
- avvidec: fix dropped frames when doing multi-threaded decoding of I-frame codecs such as DV Video
- mpegtsmux: Correctly time out in live pipelines, esp. for sparse streams like KLV and DVB subtitles
- vtdec deadlock fixes on shutdown and format/resolution changes (as might happen with e.g. HLS/DASH)
- fmp4mux, isomp4mux: Add support for adding AV1 header OBUs into the MP4 headers, and add language from tags
- gtk4paintablesink improvements: fullscreen mode and gst-play-1.0 support
- webrtcsink: add support for insecure TLS and improve error handling and VP9 handling
- vah264enc, vah265enc: timestamp handling fixes; generate IDR frames on force-keyunit-requests, not I frames
- v4l2codecs: decoder: Reorder caps to prefer \`DMA_DRM\` ones, fixes issues with playbin3
- Visualizer plugins fixes
- Avoid using private APIs on iOS
- various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.4 release notes](/releases/1.24/#1.24.4)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
