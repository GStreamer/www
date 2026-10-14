---
title: "GStreamer 1.18.2 stable bug fix release"
date: 2020-12-06T15:00:00Z
version: "1.18.2"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release in the
stable 1.18 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe to update from
1.18.x.

**Highlighted bugfixes:**

- Fix MPEG-TS timestamping regression when playing DVB streams
- compositor: fix artefacts in certain input scaling/conversion situations
  and make sure that the output format is actually supported, plus
  renegotiation fixes
- Fix sftp:// URI playback in decodebin/playbin via giosrc
- adaptivedemux/dashdemux/hlsdemux fixes
- rtsp-server fixes
- android media: fix crash when encoding AVC
- fix races in various unit tests
- lots of other bug fixes and memory leak fixes
- various stability, performance and reliability improvements
- g-i annotation fixes
- build fixes

See the [GStreamer 1.18.2 release notes](/releases/1.18/#1.18.2)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Download tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.18.2.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.18.2.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.18.2.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.18.2.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.18.2.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.18.2.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.18.2.tar.xz),
[gst-python](/src/gst-python/gst-python-1.18.2.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.18.2.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.18.2.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.18.2.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.18.2.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.18.2.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.18.2.tar.xz).
