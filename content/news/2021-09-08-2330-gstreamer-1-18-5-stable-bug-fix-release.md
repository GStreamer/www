---
title: "GStreamer 1.18.5 stable bug fix release"
date: 2021-09-08T23:30:00Z
version: "1.18.5"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release in the
stable 1.18 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and [important security fixes](/security/),
and it should be safe to update from 1.18.x.

**Highlighted bugfixes:**

- basesink: fix reverse frame stepping
- downloadbuffer/sparsefile: several fixes for win32
- systemclock: Update monotonic reference time when re-scheduling, fixes high CPU usage with gnome-music when pausing playback
- audioaggregator: fix glitches when resyncing on discont
- compositor: Fix NV12 blend operation
- rtspconnection: Add IPv6 support for tunneled mode
- avidemux: fix playback of some H.264-in-AVI streams
- jpegdec: Fix crash when interlaced field height is not DCT block size aligned
- qmlglsink: Keep old buffers around a bit longer if they were bound by QML
- qml: qtitem: don't potentially leak a large number of buffers
- rtpjpegpay: fix image corruption when compiled with MSVC on Windows
- rtspsrc: seeking improvements
- rtpjitterbuffer: Avoid generation of invalid timestamps
- rtspsrc: Fix behaviour of select-streams, new-manager, request-rtcp-key and before-send signals with GLib &gt;= 2.62
- multiudpsink: Fix broken SO_SNDBUF get/set on Windows
- openh264enc: fix broken sps/pps header generation and some minor leaks
- mpeg2enc: fix interlace-mode detection and unbound memory usage if encoder can't keep up
- mfvideosrc: Fix for negative MF stride and for negotiation when interlace-mode is specified
- tsdemux: fix seek-with-stop regression and decoding errors after seeking with dvdlpcmdec
- rtsp-server: seek handling improvements
- gst-libav: fix build (and other issues) with ffmpeg 4.4
- cerbero: spandsp: Fix build error with Visual Studio 2019
- win32 packages: Fix hang in GLib when `G_SLICE` environment variable is set
- various stability, performance and reliability improvements
- memory leak fixes
- build fixes

See the [GStreamer 1.18.5 release notes](/releases/1.18/#1.18.5)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Download tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.18.5.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.18.5.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.18.5.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.18.5.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.18.5.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.18.5.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.18.5.tar.xz),
[gst-python](/src/gst-python/gst-python-1.18.5.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.18.5.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.18.5.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.18.5.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.18.5.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.18.5.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.18.5.tar.xz).
