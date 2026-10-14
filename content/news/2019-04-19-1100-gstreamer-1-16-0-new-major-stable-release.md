---
title: "GStreamer 1.16.0 new major stable release"
date: 2019-04-19T11:00:00Z
version: "1.16.0"
tags: [release]
---

The GStreamer team is excited to announce a new major feature release of
your favourite cross-platform multimedia framework!

The 1.16 release series adds new features on top of the previous 1.14 series
and is part of the API and ABI-stable 1.x release series of the GStreamer
multimedia framework.

**Highlights:**

- GStreamer WebRTC stack gained support for data channels
  for peer-to-peer communication based on SCTP, BUNDLE support, as well as
  support for multiple TURN servers.
- AV1 video codec support for Matroska and QuickTime/MP4 containers and more
  configuration options and supported input formats for the AOMedia AV1 encoder
- Support for Closed Captions and other Ancillary Data in video
- Support for planar (non-interleaved) raw audio
- `GstVideoAggregator`, `compositor` and
  OpenGL mixer elements are now in -base
- New alternate fields interlace mode where each buffer carries a single field
- WebM and Matroska ContentEncryption support in the Matroska demuxer
- new WebKit WPE-based web browser source element
- Video4Linux: HEVC encoding and decoding, JPEG encoding, and improved dmabuf import/export
- Hardware-accelerated Nvidia video decoder gained support for VP8/VP9 decoding,
  whilst the encoder gained support for H.265/HEVC encoding.
- Many improvements to the Intel Media SDK based hardware-accelerated video
  decoder and encoder plugin (msdk): dmabuf import/export for zero-copy
  integration with other components; VP9 decoding; 10-bit HEVC encoding; video
  post-processing (vpp) support including deinterlacing; and the video decoder
  now handles dynamic resolution changes.
- The ASS/SSA subtitle overlay renderer can now handle multiple subtitles
  that overlap in time and will show them on screen simultaneously
- The Meson build is now feature-complete (with the exception of plugin docs)
  and it is now the recommended build system on all platforms. The Autotools build is
  scheduled to be removed in the next cycle.
- The GStreamer Rust bindings and Rust plugins module
  are now officially part of upstream GStreamer.
- The GStreamer Editing Services gained a `gesdemux` element that allows
  directly playing back serialized edit list with `playbin` or
  `(uri)decodebin`
- Many performance improvements

Full release notes can be found [here](/releases/1.16/).

Binaries for Android, iOS, Mac OS X and Windows will be provided in the next days.

You can download release tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.16.0.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.16.0.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.16.0.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.16.0.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.16.0.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.16.0.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.16.0.tar.xz),
[gst-python](/src/gst-python/gst-python-1.16.0.tar.xz),
[gst-editing-services](/src/gst-editing-services/gstreamer-editing-services-1.16.0.tar.xz),
[gst-validate](/src/gst-validate/gst-validate-1.16.0.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.16.0.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.16.0.tar.xz), or
[gst-omx](/src/gst-omx/gst-omx-1.16.0.tar.xz).
