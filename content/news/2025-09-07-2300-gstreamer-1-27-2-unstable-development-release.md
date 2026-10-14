---
title: "GStreamer 1.27.2 unstable development release"
date: 2025-09-07T23:00:00Z
version: "1.27.2"
tags: [release]
---

The GStreamer team is pleased to announce another development release in
the API/ABI-unstable 1.27 release series.

The API/ABI-unstable 1.27 release series is for testing and development purposes
in the lead-up to the stable 1.28 series which is scheduled for release in late
2025\. Any newly-added API can still change until that point.

This development release is primarily for developers and early adopters, and
distros should probably not package it.

**Highlighted changes:**

- Add more 10bit RGB formats in GStreamer Video, OpenGL and Wayland, as well as in deinterlace and gdkpixbufoverlay
- analytics: new analytics combiner and splitter elements plus batch meta to batch buffers from one or more streams
- analyticsoverlay: Add expire-overlay property
- onnx: Add Verisilicon provider support
- awstranscriber2: add property for setting show_speaker_labels
- awstranslate: expose property for turning brevity on
- speechmatics: expose mask-profanities property
- textaccumulate: new element for speech synthesis or translation preprocessing
- tttocea608: expose speaker-prefix property
- cea708mux: expose "discarded-services" property on sink pads
- cuda crop meta support
- hlssink3, hlscmafsink: Support the use of a single media file
- s302mparse: Add new S302M audio parser
- webrtc: add WHEP client signaller; sdp and stats-related improvements
- threadshare: many improvements to the various elements, plus examples and a new benchmark program; relicense to MPL-2.0
- gtk4paintablesink: Add YCbCr memory texture formats and improve color-state fallbacks
- OpenGL: Add support for the NV24 pixel format; support changing caps and \`get_gl_context()\` in glbasesrc
- rtspsrc: Send RTSP keepalives also in TCP/interleaved modes
- nvencoder: interlaced video handling improvements
- vaav1enc: Enable intrablock copy and palette mode
- videopool: support parsing dma_drm caps
- Vulkan VP9 video decode support and many other video encode and decode improvements
- waylandsink: Parse and set the HDR10 metadata and other color management improvements
- LCEVC: Add autoplugging decoding support for LCEVC H265 and H266 video streams and LCEVC H.265 encoder
- GstMiniObject: Add missing \`take()\` and \`steal()\` functions and convert \`is_writable()\` and \`make_writable()\` macros to inline functions
- alsa: Improve PCM sink enumeration
- d3d12: various d3d12swapchainsink enhancements and bug fixes; fisheye image dewarping support
- wasapi2: add support for dynamic device switching, exclusive mode and format negotiation; device provider and latency enhancements
- windows: Disable all audio device providers except wasapi2
- dots-viewer: Improve dot file generation and interactivity
- gst-editing-services: Make framepositioner zorder controllable and expose it
- Various introspection fixes and bindings updates
- Cerbero: Update to Android API level 24; add config for number of cargo jobs; ship unixfd plugin
- Cerbero: Implement library melding for smaller binary sizes of Rust plugins

Binaries for Android, iOS, Mac OS X and Windows will be made available shortly
at the [usual location](https://gstreamer.freedesktop.org/pkg/).

Release tarballs can be downloaded directly here:

- [gstreamer-1.27.2.tar.xz](/src/gstreamer/gstreamer-1.27.2.tar.xz)
- [gst-plugins-base-1.27.2.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.27.2.tar.xz)
- [gst-plugins-good-1.27.2.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.27.2.tar.xz)
- [gst-plugins-ugly-1.27.2.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.27.2.tar.xz)
- [gst-plugins-bad-1.27.2.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.27.2.tar.xz)
- [gst-libav-1.27.2.tar.xz](/src/gst-libav/gst-libav-1.27.2.tar.xz)
- [gst-rtsp-server-1.27.2.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.27.2.tar.xz)
- [gst-python-1.27.2.tar.xz](/src/gst-python/gst-python-1.27.2.tar.xz)
- [gst-editing-services-1.27.2.tar.xz](/src/gst-editing-services/gst-editing-services-1.27.2.tar.xz)
- [gst-devtools-1.27.2.tar.xz](/src/gst-devtools/gst-devtools-1.27.2.tar.xz),
- [gstreamer-docs-1.27.2.tar.xz](/src/gstreamer-docs/gstreamer-docs-1.27.2.tar.xz)

As always, please give it a spin and let us know of any issues you run into by filing an
issue in [GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer/).
