---
title: "GStreamer 1.20.0 new major stable release"
date: 2022-02-03T12:00:00Z
version: "1.20.0"
tags: [release]
---

The GStreamer team is excited to announce a new major feature release of
your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and many other improvements.

The 1.20 release series adds new features on top of the previous 1.18 series
and is part of the API and ABI-stable 1.x release series of the GStreamer
multimedia framework.

**Highlights:**

- Development in GitLab was [switched](https://gstreamer.freedesktop.org/documentation/frequently-asked-questions/mono-repository.html) to a single git repository containing all the modules
- GstPlay: new high-level playback library, replaces GstPlayer
- WebM Alpha decoding support
- Encoding profiles can now be tweaked with additional application-specified element properties
- Compositor: multi-threaded video conversion and mixing
- RTP header extensions: unified support in RTP depayloader and payloader base classes
- SMPTE 2022-1 2-D Forward Error Correction support
- Smart encoding (pass through) support for VP8, VP9, H.265 in `encodebin` and `transcodebin`
- Runtime compatibility support for libsoup2 and libsoup3 (libsoup3 support experimental)
- Video decoder subframe support
- Video decoder automatic packet-loss, data corruption, and keyframe request handling for RTP / WebRTC / RTSP
- mp4 and Matroska muxers now support profile/level/resolution changes for H.264/H.265 input streams (i.e. codec data changing on the fly)
- mp4 muxing mode that initially creates a fragmented mp4 which is converted to a regular mp4 on EOS
- Audio support for the WebKit Port for Embedded (WPE) web page source element
- CUDA based video color space convert and rescale elements and upload/download elements
- NVIDIA `memory:NVMM` support for OpenGL `glupload` and `gldownload` elements
- Many WebRTC improvements
- The new VA-API plugin implementation fleshed out with more decoders and new postproc elements
- AppSink API to retrieve events in addition to buffers and buffer lists
- AppSrc gained more configuration options for the internal queue (leakiness, limits in buffers and time, getters to read current levels)
- Updated Rust bindings and many new Rust plugins
- Improved support for custom minimal GStreamer builds
- Support build against FFmpeg 5.0
- Linux Stateless CODEC support gained MPEG-2 and VP9
- Windows Direct3D11/DXVA decoder gained AV1 and MPEG-2 support
- Lots of new plugins, features, performance improvements and bug fixes

For more details check out the [GStreamer 1.20 release notes](/releases/1.20/).

Binaries for Android, iOS, macOS and Windows will be provided in due course.

You can download release tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.20.0.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.20.0.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.20.0.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.20.0.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.20.0.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.20.0.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.20.0.tar.xz),
[gst-python](/src/gst-python/gst-python-1.20.0.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.20.0.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.20.0.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.20.0.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.20.0.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.20.0.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.20.0.tar.xz).
