---
title: "GStreamer 1.26.0 new major stable release"
date: 2025-03-11T23:30:00Z
version: "1.26.0"
tags: [release]
---

The GStreamer team is excited to announce a new major feature release of
your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and many other improvements.

The 1.26 release series adds new features on top of the previous 1.24 series
and is part of the API and ABI-stable 1.x release series of the GStreamer
multimedia framework.

**Highlights:**

- H.266 Versatile Video Coding (VVC) codec support
- Low Complexity Enhancement Video Coding (LCEVC) support
- Closed captions: H.264/H.265 extractor/inserter, cea708overlay, cea708mux, tttocea708 and more
- New hlscmafsink, hlssink3, and hlsmultivariantsink; HLS/DASH client and dashsink improvements
- New AWS and Speechmatics transcription, translation and TTS services elements, plus translationbin
- Splitmux lazy loading and dynamic fragment addition support
- Matroska: H.266 video and rotation tag support, defined latency muxing
- MPEG-TS: support for H.266, JPEG XS, AV1, VP9 codecs and SMPTE ST-2038 and ID3 meta; mpegtslivesrc
- ISO MP4: support for H.266, Hap, Lagarith lossless codecs; raw video support; rotation tags
- SMPTE 2038 ancillary data streams support
- JPEG XS image codec support
- Analytics: New TensorMeta; N-to-N relationships; Mtd to carry segmentation masks
- ONVIF metadata extractor and conversion to/from relation metas
- New originalbuffer element that can restore buffers again after transformation steps for analytics
- Improved Python bindings for analytics API
- Lots of Vulkan integration and Vulkan Video decoder/encoder improvements
- OpenGL integration improvements, esp. in glcolorconvert, gldownload, glupload
- Qt5/Qt6 QML GL sinks now support direct DMABuf import from hardware decoders
- CUDA: New compositor, Jetson NVMM memory support, stream-ordered allocator
- NVCODEC AV1 video encoder element, and nvdsdewarp
- New Direct3D12 integration support library
- New d3d12swapchainsink and d3d12deinterlace elements and D3D12 sink/source for zero-copy IPC
- Decklink HDR support (PQ + HLG) and frame scheduling enhancements
- AJA capture source clock handling and signal loss recovery improvements
- RTP and RTSP: New rtpbin sync modes, client-side MIKEY support in rtspsrc
- New Rust rtpbin2, rtprecv, rtpsend, and many new Rust RTP payloaders and depayloaders
- webrtcbin support for basic rollbacks and other improvements
- webrtcsink: support for more encoders, SDP munging, and a built-in web/signalling server
- webrtcsrc/sink: support for uncompressed audio/video and NTP & PTP clock signalling and synchronization
- rtmp2: server authentication improvements incl. Limelight CDN (llnw) authentication
- New Microsoft WebView2 based web browser source element
- The GTK3 plugin has gained support for OpenGL/WGL on Windows
- Many GTK4 paintable sink improvements
- GstPlay: id-based stream selection and message API improvements
- Real-time pipeline visualization in a browser using a new dots tracer and viewer
- New tracers for tracking memory usage, pad push timings, and buffer flow as pcap files
- VA hardware-acclerated H.266/VVC decoder, VP8 and JPEG encoders, VP9/VP8 alpha decodebins
- Video4Linux2 elements support DMA_DRM caps negotiation now
- V4L2 stateless decoders implement inter-frame resolution changes for AV1 and VP9
- Editing services: support for reverse playback and audio channel reordering
- New QUIC-based elements for working with raw QUIC streams, RTP-over-QUIC (RoQ) and WebTransport
- Apple AAC audio encoder and multi-channel support for the Apple audio decoders
- cerbero: Python bindings and introspection support; improved Windows installer based on WiX5
- Lots of new plugins, features, performance improvements and bug fixes

For more details check out the [GStreamer 1.26 release notes](/releases/1.26/).

Binaries for Android, iOS, macOS and Windows will be provided in due course.

You can download release tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.26.0.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.26.0.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.26.0.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.26.0.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.26.0.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.26.0.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.26.0.tar.xz),
[gst-python](/src/gst-python/gst-python-1.26.0.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.26.0.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.26.0.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.26.0.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.26.0.tar.xz),
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.26.0.tar.xz).
