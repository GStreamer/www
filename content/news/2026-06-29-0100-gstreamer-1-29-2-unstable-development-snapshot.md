---
title: "GStreamer 1.29.2 unstable development snapshot"
date: 2026-06-29T01:00:00Z
---

The GStreamer team is pleased to announce another development snapshot in
the API/ABI-unstable 1.29 release series.

The API/ABI-unstable 1.29 release series is for testing and development purposes
in the lead-up to the stable 1.30 series which is scheduled for release in Q4
2026\. Any newly-added API can still change until that point.

This development release is primarily for developers and early adopters, and
distros should probably not package it.

**Highlighted changes:**

- webrtcbin2: New scalable WebRTC bin that uses fewer threads and native Rust DTLS, ICE and RTP session management implementations
- rtspsrc2: implement support for SRTP, authentication, HTTP tunnelling, keep alive, stream selection, TLS validation, latency configuration
- rtp2: New Rust RTP payloader and depayloader implementations for MPA audio, MPEG-2 video and raw video
- Digitally Signed Content (DSC) support, initially for H.266 video
- New D3D12-based element which performs color lookup operations using user-provided Adobe .cube LUT files
- videoencoders: Support adaptive presets with resolution-dependent properties and implement in x264enc and nvh264enc
- closedcaption: add h266seiinserter; add "do-timestamp" property to codecseiiinserter
- flv: Add support for AV1 video
- v4l2: add capture timestamps to buffers in v4l2src, and "bitrate" and "gop-size" properties to video encoders
- applemedia: new iosurface helper library providing a memory:IOSurface abstraction
- AMF: add super resolution hq-scaler component
- New OpenGL glalphacombine element for RGBA inputs and Vulkan/OpenGL memory support for alphacombine
- openjpeg: Add support for high bit depth formats
- analytics: add semantic tag getter to GstAnalyticsMtd
- tensordecoders: Add YOLO26 detection decoder
- tfliteinference: support for external delegates, XNNPACK, and GRAY8 input
- MP4: add support for losslessly-compressed video
- matroskamux: add TrueHD audio and HDMV PGS subpicture support
- playsink reconfiguration stability improvements
- New agingradio and sofalizer audio effect elements
- New image-rs based imagersoverlay element in Rust to replace gdkpixbufoverlay
- webrtcsink: add v4l2h264enc (Raspberry Pi) encoder support and a signaller for Unreal Engine PixelStreaming
- webrtcsink, webrtcsource: make custom signalling protocol extendable
- Speech elements: implement support for non-synchronized output
- d3d12: Add support for hardware-accelerated decoding of VP9 with alpha
- androidmedia: New source element for Android assets
- filesink: Add support for Windows file sharing mode to allow reading of file while it's being written to
- tracing: custom spans and events API and new tracers that integrate with the Rust tracing ecosystem
- editing-services: auto-plug raw video converters from the registry based on compositor memory family and prepare for multi-threaded usage
- dots-viewer: General enhancement of the web app
- New viuersink video sink that plays video in the terminal, replacing aasink and cacasink
- cerbero: Added ccache support for MSVC
- Countless bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

Binaries for Android, iOS, Mac OS X and Windows will be made available shortly
at the [usual location](https://gstreamer.freedesktop.org/pkg/).

Release tarballs can be downloaded directly here:

- [gstreamer-1.29.2.tar.xz](/src/gstreamer/gstreamer-1.29.2.tar.xz)
- [gst-plugins-base-1.29.2.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.29.2.tar.xz)
- [gst-plugins-good-1.29.2.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.29.2.tar.xz)
- [gst-plugins-ugly-1.29.2.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.29.2.tar.xz)
- [gst-plugins-bad-1.29.2.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.29.2.tar.xz)
- [gst-libav-1.29.2.tar.xz](/src/gst-libav/gst-libav-1.29.2.tar.xz)
- [gst-rtsp-server-1.29.2.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.29.2.tar.xz)
- [gst-python-1.29.2.tar.xz](/src/gst-python/gst-python-1.29.2.tar.xz)
- [gst-editing-services-1.29.2.tar.xz](/src/gst-editing-services/gst-editing-services-1.29.2.tar.xz)
- [gst-devtools-1.29.2.tar.xz](/src/gst-devtools/gst-devtools-1.29.2.tar.xz),
- [gstreamer-docs-1.29.2.tar.xz](/src/gstreamer-docs/gstreamer-docs-1.29.2.tar.xz)

As always, please give it a spin and let us know of any issues you run into by filing an
issue in [GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer/).
