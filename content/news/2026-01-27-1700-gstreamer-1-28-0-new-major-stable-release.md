---
title: "GStreamer 1.28.0 new major stable release"
date: 2026-01-27T17:00:00Z
version: "1.28.0"
tags: [release]
---

The GStreamer team is excited to announce a new major feature release of
your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and many other improvements.

The 1.28 release series adds new features on top of the previous 1.26 series
and is part of the API and ABI-stable 1.x release series of the GStreamer
multimedia framework.

**Highlights:**

- AMD HIP plugin and integration helper library
- Vulkan Video AV1 and VP9 decoding, H.264 encoding, and 10-bit support for H.265 decoder
- waylandsink: Parse and set the HDR10 metadata and other color management improvements
- Audio source separation element based on demucs in Rust
- Analytics combiner and splitter elements plus batch meta to batch buffers from one or more streams
- LiteRT inference element; move modelinfo to analytics lib; add script to help with modelinfo generation and upgrade
- Add general classifier tensor-decoder, facedetector, and more analytics convenience API
- New tensordecodebin element to auto-plug compatible tensor decoders based on their caps and many other additions and improvements
- Add a burn-based YOLOX inference element and a YOLOX tensor decoder in Rust
- applemedia: VideoToolbox VP9 and AV1 hardware-accelerated decoding support, and 10-bit HEVC encoding
- Add new GIF decoder element in Rust with looping support
- input-selector: implements a two-phase sinkpad switch now to avoid races when switching input pads
- The inter wormhole sink and source elements gained a way to forward upstream events to the producer as well as new fine-tuning properties
- webrtcsink: add renegotiation support and support for va hardware encoders
- webrtc WHEP client and server signaller
- New ST-2038 ancillary data combiner and extractor elements
- fallbacksrc gained support for encoded streams
- flv: enhanced rtmp H.265 video support, and support for multitrack audio
- glupload: Implement udmabuf uploader to share buffers between software decoders/sources and GPUs, display engines (wayland), and other dma devices
- video: Add crop, scale, rotate, flip, shear and more GstMeta transformation
- New task pool GstContext to share a thread pool amongst elements for better resource management and performance, especially for video conversion and compositing
- New Deepgram speech-to-text transcription plugin and many other translation and transcription improvements
- Speech synthesizers: expose new "compress" overflow mode that can speed up audio while preserving pitch
- ElevenLabs voice cloning element and support for Speechmatics speaker identification API
- textaccumulate: new element for speech synthesis or translation preprocessing
- New vmaf element to calculate perceptual video quality assessment scores using Netflix's VMAF framework
- decodebin3: expose KLV, ID3 PES and ST-2038 ancillary data streams with new metadata GstStream type
- New MPEG-H audio decoding plugin plus MP4 demuxing support
- LCEVC: Add autoplugging decoding support for LCEVC H265 and H266 video streams and LCEVC H.265 and H.266 encoders
- RTP "robust MPEG audio", raw audio (L8, L16, L24), and SMPTE ST291 ancillary metadata payloaders/depayloaders in Rust
- Add a Rust-based icecastsink element with AAC support
- The Windows IPC plugin gained support for passing generic data in addition to raw audio/video, and various properties
- New D3D12 interlace and overlay compositor elements, plus many other D3D12 improvements
- Blackmagic Decklink elements gained support for capturing and outputting all types of VANC via GstAncillaryMeta
- GstLogContext API to reduce log spam in several components and \`GST_DEBUG_ONCE\` (etc) convenience macros to log things only once
- hlssink3, hlscmafsink: Support the use of a single media file, plus I-frame only playlist support
- Webkit: New wpe2 plugin making use of the "WPE Platform API"
- MPEG-TS demuxer can now disable skew corrections
- New Qt6 QML render source element
- qml6gloverlay: support directly passing a QQuickItem for QML the render tree
- unifxfdsink: Add a property to allow copying to make sink usable with more upstream elements
- dots-viewer: Improve dot file generation and interactivity
- Python bindings: more syntactic sugar, analytics API improvements and type annotations
- cerbero: add support for Python wheel packaging, Windows ARM64, new iOS xcframework, Gtk4 on macOS and Windows, and more plugins
- Smaller binary sizes of Rust plugins in Windows and Android binary packages
- Peel: New C++ bindings for GStreamer
- Lots of new plugins, features, performance improvements and bug fixes
- Countless bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

For more details check out the [GStreamer 1.28 release notes](/releases/1.28/).

Many thanks to everyone who contributed to this release!

Binaries for Android, iOS, macOS and Windows will be provided in due course.

You can download release tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.28.0.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.28.0.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.28.0.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.28.0.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.28.0.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.28.0.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.28.0.tar.xz),
[gst-python](/src/gst-python/gst-python-1.28.0.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.28.0.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.28.0.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.28.0.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.28.0.tar.xz),
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.28.0.tar.xz).
