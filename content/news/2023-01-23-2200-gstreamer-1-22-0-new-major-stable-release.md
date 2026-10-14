---
title: "GStreamer 1.22.0 new major stable release"
date: 2023-01-23T22:00:00Z
version: "1.22.0"
tags: [release]
---

The GStreamer team is excited to announce a new major feature release of
your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and many other improvements.

The 1.22 release series adds new features on top of the previous 1.20 series
and is part of the API and ABI-stable 1.x release series of the GStreamer
multimedia framework.

**Highlights:**

- AV1 video codec support improvements
- New HLS, DASH and Microsoft Smooth Streaming adaptive streaming clients
- Qt6 support for rendering video inside a QML scene
- Minimal builds optimised for binary size, including only the individual elements needed
- Playbin3, Decodebin3, UriDecodebin3, Parsebin enhancements and stabilisation
- WebRTC simulcast support and support for Google Congestion Control
- WebRTC-based media server ingestion/egress (WHIP/WHEP) support
- New easy to use batteries-included WebRTC sender plugin
- Easy RTP sender timestamp reconstruction for RTP and RTSP
- ONVIF timed metadata support
- New fragmented MP4 muxer and non-fragmented MP4 muxer
- New plugins for Amazon AWS storage and audio transcription services
- New gtk4paintablesink and gtkwaylandsink renderers
- New videocolorscale element that can convert and scale in one go for better performance
- High bit-depth video improvements
- Touchscreen event support in navigation API
- Rust plugins now shipped in macOS and Windows/MSVC binary packages
- H.264/H.265 timestamp correction elements for PTS/DTS reconstruction before muxers
- Improved design for DMA buffer sharing and modifier handling for hardware-accelerated video decoders/encoders/filters and capturing/rendering on Linux
- Video4Linux2 hardware accelerated decoder improvements
- CUDA integration and Direct3D11 integration and plugin improvements
- New H.264 / AVC, H.265 / HEVC and AV1 hardware-accelerated video encoders for AMD GPUs using the Advanced Media Framework (AMF) SDK
- applemedia: H.265 / HEVC video encoding + decoding support
- androidmedia: H.265 / HEVC video encoding support
- New "force-live" property for audiomixer, compositor, glvideomixer, d3d11compositor etc.
- Lots of new plugins, features, performance improvements and bug fixes

For more details check out the [GStreamer 1.22 release notes](/releases/1.22/).

Binaries for Android, iOS, macOS and Windows will be provided in due course.

You can download release tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.22.0.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.22.0.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.22.0.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.22.0.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.22.0.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.22.0.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.22.0.tar.xz),
[gst-python](/src/gst-python/gst-python-1.22.0.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.22.0.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.22.0.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.22.0.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.22.0.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.22.0.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.22.0.tar.xz).
