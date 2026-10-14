---
title: "GStreamer RTSP Server Library 1.2.3 stable release"
date: 2014-02-25T22:00:00Z
---

The GStreamer team is pleased to announce the first release
of the GStreamer RTSP Server Library for the GStreamer 1.x
API series.

Major changes include:

- Ported to GStreamer 1.0 API
- Multithreaded for better responsiveness and scaleability
- Support for authentication and access restrictions
- Support for TLS
- API refactored a bit for clarity (e.g. MediaMapping -&gt; MountPoints)
- Improved seeking support
- Better live pipeline support
- Better IPv6 and multicast support
- Improved portability (ported to gio)
- Support for automatic synchronous playback of multiple clients via GstNetTimeProvider
- Support for more range formats
- New example how to feed data to the server via appsrc
- New example how to prioritise some clients over others using cgroups
- Many more unit tests
- Hundreds of bug-fixes and other improvements

Check out the for
[release notes](/releases/gst-rtsp-server/1.2.3.html),
or
[download the gst-rtsp-server-1.2.3.tar.xz tarball](/src/gst-rtsp-server/gst-rtsp-server-1.2.3.tar.xz)
directly.

Binaries for Android, Windows, OS/X and iOS will hopefully be available
with the next round of bug-fix releases (1.2.4).

The release depends on GStreamer Core and Base Plugin Libraries 1.2.3,
which is why this initial release carries the version number 1.2.3.
