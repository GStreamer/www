---
title: "GStreamer 1.14.0 new major stable release"
date: 2018-03-19T20:00:00Z
version: "1.14.0"
tags: [release]
---

The GStreamer team is proud to announce a new major feature release of
your favourite cross-platform multimedia framework!

The 1.14 release series adds new features on top of the previous 1.12 series
and is part of the API and ABI-stable 1.x release series of the GStreamer
multimedia framework.

**Highlights:**

- WebRTC support: real-time audio/video streaming to and from web browsers
- Experimental support for the next-gen royalty-free AV1 video codec
- Video4Linux: encoding support, stable element names and faster device probing
- Support for the Secure Reliable Transport (SRT) video streaming protocol
- RTP Forward Error Correction (FEC) support (ULPFEC)
- RTSP 2.0 support in `rtspsrc` and gst-rtsp-server
- ONVIF audio backchannel support in gst-rtsp-server and `rtspsrc`
- `playbin3` gapless playback and pre-buffering support
- `tee`, our stream splitter/duplication element, now does allocation query
  aggregation which is important for efficient data handling and zero-copy
- QuickTime muxer has a new prefill recording mode that allows file import
  in Adobe Premiere and FinalCut Pro while the file is still being written.
- `rtpjitterbuffer` fast-start mode and timestamp offset adjustment smoothing
- `souphttpsrc` connection sharing, which allows for connection reuse, cookie sharing, etc.
- `nvdec`: new plugin for hardware-accelerated video decoding using the NVIDIA NVDEC API
- Adaptive DASH trick play support
- `ipcpipeline`: new plugin that allows splitting a pipeline across
  multiple processes
- Major `gobject-introspection` annotation improvements for large parts of the library API
- GStreamer C# bindings have been revived and seen many updates and fixes
- The externally-maintained GStreamer Rust bindings have many
  usability improvements and cover most of the API now

Full release notes can be found [here](/releases/1.14/).

Binaries for Android, iOS, Mac OS X and Windows will be provided in the next days.

You can download release tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.14.0.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.14.0.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.14.0.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.14.0.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.14.0.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.14.0.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.14.0.tar.xz),
[gst-python](/src/gst-python/gst-python-1.14.0.tar.xz),
[gst-editing-services](/src/gst-editing-services/gstreamer-editing-services-1.14.0.tar.xz),
[gst-validate](/src/gst-validate/gst-validate-1.14.0.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.14.0.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.14.0.tar.xz), or
[gst-omx](/src/gst-omx/gst-omx-1.14.0.tar.xz).
