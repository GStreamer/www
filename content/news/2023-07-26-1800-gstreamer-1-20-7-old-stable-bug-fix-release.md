---
title: "GStreamer 1.20.7 old-stable bug fix release"
date: 2023-07-26T18:00:00Z
version: "1.20.7"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release in the
now old-stable 1.20 release series of your favourite cross-platform
multimedia framework!

This release only contains bug fixes. It should be safe to update from 1.20.x.

**Highlighted bugfixes:**

- [Security fixes](/security/) for flacparse, dvdspu, and subparse, and the RealMedia demuxer
- h265parse: Fix framerate handling
- filesink: Fix buffered mode writing of buffer lists and buffers with multiple memories
- asfmux, rtpbin_buffer_list test: fix possible unaligned write/read on 32-bit ARM
- ptp clock: Work around bug in ptpd in default configuration
- qtdemux: fix reverse playback regression with edit lists
- rtspsrc: various control path handling server compatibility improvements
- avviddec: fix potential deadlock on seeking with FFmpeg 6.x
- cerbero: Fix pango crash on 32bit Windows; move libass into non-GPL codecs
- Miscellaneous bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.20.7 release notes](/releases/1.20/#1.20.7)
for more details.

Binaries for Android, iOS, macOS and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.20.7.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.20.7.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.20.7.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.20.7.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.20.7.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.20.7.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.20.7.tar.xz),
[gst-python](/src/gst-python/gst-python-1.20.7.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.20.7.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.20.7.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.20.7.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.20.7.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.20.7.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.20.7.tar.xz).

The GStreamer 1.20 series has now been superseded by the new stable
[GStreamer 1.22 series](https://gstreamer.freedesktop.org/releases/1.22/)
and we recommend you upgrade at your earliest convenience.
