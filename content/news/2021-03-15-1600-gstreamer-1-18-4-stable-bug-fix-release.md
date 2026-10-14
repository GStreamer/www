---
title: "GStreamer 1.18.4 stable bug fix release"
date: 2021-03-15T16:00:00Z
version: "1.18.4"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release in the
stable 1.18 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and [important security fixes](/security/),
and it should be safe to update from 1.18.x.

**Highlighted bugfixes:**

- important security fixes for ID3 tag reading, matroska and realmedia parsing, and gst-libav audio decoding
- audiomixer, audioaggregator: input buffer handling fixes
- decodebin3: improve stream-selection message handling
- uridecodebin3: make "caps" property work
- wavenc: fix writing of INFO chunks in some cases
- v4l2: bt601 colorimetry, allow encoder resolution changes, fix decoder frame rate negotiation
- decklinkvideosink: fix auto format detection, and fixes for 29.97fps framerate output
- mpeg-2 video handling fixes when seeking
- avviddec: fix bufferpool negotiation and possible memory corruption when changing resolution
- various stability, performance and reliability improvements
- memory leak fixes
- build fixes: rpicamsrc, qt overlay example, d3d11videosink on UWP

See the [GStreamer 1.18.4 release notes](/releases/1.18/#1.18.4)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Download tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.18.4.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.18.4.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.18.4.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.18.4.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.18.4.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.18.4.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.18.4.tar.xz),
[gst-python](/src/gst-python/gst-python-1.18.4.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.18.4.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.18.4.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.18.4.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.18.4.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.18.4.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.18.4.tar.xz).
