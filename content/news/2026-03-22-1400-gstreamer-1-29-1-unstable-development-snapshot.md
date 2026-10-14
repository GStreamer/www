---
title: "GStreamer 1.29.1 unstable development snapshot"
date: 2026-03-22T14:00:00Z
---

The GStreamer team is pleased to announce the first development snapshot in
the API/ABI-unstable 1.29 release series.

The API/ABI-unstable 1.29 release series is for testing and development purposes
in the lead-up to the stable 1.30 series which is scheduled for release in Q4
2026\. Any newly-added API can still change until that point.

This development release is primarily for developers and early adopters, and
distros should probably not package it.

**Highlighted changes:**

- ac4parse: New basic AC-4 parser element, plus AC-4 typefinding
- analytics: New GstAnalyticsMtd derivative to represent grouping of Mtd's and Keypoint
- Parse HDR10+ metadata out of H.265 and AV1 bitstreams
- Matroska demuxer: Can build a dynamic seek index now if needed
- New h264seiinserter and h265seiinserter elements that support both closed captions and unregistered user data SEIs
- Add HLS WebVTT sink element to the hlssink3 plugin
- New plugin for general purpose compress/decompress
- New udpsrc2 element with better performance for high bitrate streams
- New VA-API overlay compositor
- Opus audio support for F32 and S24_32 samples and 96kHz sample rate
- Playbin3 subtitle switching fixes
- Bump ranks of the new Rust RTP (de)payloaders to PRIMARY and default to mtu 1200 for payloaders
- rtspsrc2 authentication support
- GstPlay track selection notification improvements
- QML6 GL Source now supports navigation events
- QuickTime demuxer gained Bayer support
- Splitmuxsink now includes the start and end timecodes in fragment-opened and closed messages
- srtpdec gained a way to invalidate keys for a specific SSRC
- The APE tag demuxer can extract cover art tags now
- translationbin can control the textaccumulate latency now via a new property
- Allow device providers rank override using GST_PLUGIN_FEATURE_RANK
- cerbero gained support for Android on RISC-V64
- Countless bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

Binaries for Android, iOS, Mac OS X and Windows will be made available shortly
at the [usual location](https://gstreamer.freedesktop.org/pkg/).

Release tarballs can be downloaded directly here:

- [gstreamer-1.29.1.tar.xz](/src/gstreamer/gstreamer-1.29.1.tar.xz)
- [gst-plugins-base-1.29.1.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.29.1.tar.xz)
- [gst-plugins-good-1.29.1.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.29.1.tar.xz)
- [gst-plugins-ugly-1.29.1.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.29.1.tar.xz)
- [gst-plugins-bad-1.29.1.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.29.1.tar.xz)
- [gst-libav-1.29.1.tar.xz](/src/gst-libav/gst-libav-1.29.1.tar.xz)
- [gst-rtsp-server-1.29.1.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.29.1.tar.xz)
- [gst-python-1.29.1.tar.xz](/src/gst-python/gst-python-1.29.1.tar.xz)
- [gst-editing-services-1.29.1.tar.xz](/src/gst-editing-services/gst-editing-services-1.29.1.tar.xz)
- [gst-devtools-1.29.1.tar.xz](/src/gst-devtools/gst-devtools-1.29.1.tar.xz),
- [gstreamer-docs-1.29.1.tar.xz](/src/gstreamer-docs/gstreamer-docs-1.29.1.tar.xz)

As always, please give it a spin and let us know of any issues you run into by filing an
issue in [GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer/).
