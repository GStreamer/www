---
title: "GStreamer 1.22.3 stable bug fix release"
date: 2023-05-19T10:00:00Z
version: "1.22.3"
tags: [release]
---

The GStreamer team is pleased to announce the second bug fix release
in the stable 1.22 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe to update from
1.22.x.

**Highlighted bugfixes:**

- avdec: fix occasional video decoder deadlock on seeking with FFmpeg 6.0
- decodebin3: fix regression handling input streams without CAPS or TIME segment such as e.g. `udpsrc` or `pushfilesrc`
- bluez: a2dpsink: fix Bluetooth SIG Certification test failures
- osxvideosink: fix deadlock upon closing output window
- qtdemux: fix edit list handling regression and AV1 codec box parsing
- qtmux: fix extraction of CEA608 closed caption data from S334-1A packets
- rtspsrc: Fix handling of `*` control path
- splitmux: timestamp handling improvements
- v4l2videodec: Rework dynamic resolution change handling (needed for IMX6 mainline codec)
- videoflip: fix regression with automatically rotating video based on tags
- d3d11: many d3d11videosink and d3d11compositor fixes
- webrtc, rtp: numerous data race fixes and stability fixes
- cerbero: Add support for RHEL9 and Rocky Linux; build timecodestamper plugin with libltc support
- various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.22.3 release notes](/releases/1.22/#1.22.3)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.

Release tarballs can be downloaded directly here:

[gstreamer](/src/gstreamer/gstreamer-1.22.3.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.3.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.3.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.3.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.3.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.3.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.3.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.3.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.3.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.3.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.3.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.3.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.3.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.3.tar.xz).
