---
title: "GStreamer 1.27.50 unstable development release (feature freeze)"
date: 2025-12-09T23:30:00Z
version: "1.27.50"
tags: [release]
---

The GStreamer team is pleased to announce another development release in
the API/ABI-unstable 1.27 release series.

The API/ABI-unstable 1.27 release series is for testing and development purposes
in the lead-up to the stable 1.28 series which is scheduled for release in late
2025\. Any newly-added API can still change until that point.

The 1.27.50 release marks the beginning of our feature freeze in preparation of
the upcoming 1.28 stable release.

This development release is primarily for developers and early adopters, and
distros should probably not package it.

**Highlighted changes:**

- Vulkan Video AV1 decoder
- webrtcsink: add renegotiation support, and support for va hardware encoders
- New ST-2038 ancillary data combiner and extractor elements
- applemedia: VP9 and AV1 hardware-accelerated video decoding support, and 10-bit HEVC encoding
- fallbacksrc gained support for encoded streams
- flv: enhanced rtmp H.265 video support, and support for multitrack audio
- glupload: Implement udmabuf uploader to share buffers between software decoders/sources and GPUs, display engines (wayland), and other dma devices
- video: Add crop, scale, rotate, flip, shear and more GstMeta transformation
- New task pool GstContext to share a thread pool amongst elements for better resource management and performance, especially for video conversion and compositing
- analytics: New tensordecodebin element to auto-plug compatible tensor decoders based on their caps and many other additions and improvements
- New Deepgram speech-to-text transcription plugin
- Speech synthesizers: expose new "compress" overflow mode that can speed up audio while preserving pitch
- Support new Speechmatics speaker identification API
- ElevenLabs voice cloning element
- New Qt6 QML qml6 render source element
- appsink, appsrc: new bindings-friendly "simple" callbacks API
- New element to calculate perceptual video quality assessment scores using Netflix's VMAF framework
- Add new metadata GstStream type and use in decodebin3 for KLV, ID3 PES and ST-2038 ancillary data
- New MPEG-H audio decoding plugin plus MP4 demuxing support
- The inter plugin wormhole sink and source elements gained new properties to fine tune the inner elements
- hlscmafsink can generate I-frame only playlist now
- New LCEVC H.266 encoder element
- webrtc: add WHEP server signaller
- Added "robust MPEG audio", raw audio (L8, L16, L24), and ancillary metadata RTP payloaders in Rust
- The Windows IPC plugin gained support for passing generic data in addition to raw audio/video, and various properties
- New D3D12 interlace and overlay compositor elements
- GStreamer AMD HIP integration functionality is now available in a helper library
- Blackmagic Decklink elements gained support for capturing and outputting all types of VANC via GstAncillaryMeta
- Replaygain R128 gain tags support
- aws: URI handler for S3 URIs; dropped registration of rusotos3src and rusotos3sink
- quinn: Support sharing of QUIC/WebTransport connection/session
- validate: New plugin with a check-last-frame-qrcode action
- clocksync: new "rate" property and "resync" action signal
- debug logging: Add convenience macros around GstLogContext for logging things only once
- Countless bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

Binaries for Android, iOS, Mac OS X and Windows will be made available shortly
at the [usual location](https://gstreamer.freedesktop.org/pkg/).

Release tarballs can be downloaded directly here:

- [gstreamer-1.27.50.tar.xz](/src/gstreamer/gstreamer-1.27.50.tar.xz)
- [gst-plugins-base-1.27.50.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.27.50.tar.xz)
- [gst-plugins-good-1.27.50.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.27.50.tar.xz)
- [gst-plugins-ugly-1.27.50.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.27.50.tar.xz)
- [gst-plugins-bad-1.27.50.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.27.50.tar.xz)
- [gst-libav-1.27.50.tar.xz](/src/gst-libav/gst-libav-1.27.50.tar.xz)
- [gst-rtsp-server-1.27.50.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.27.50.tar.xz)
- [gst-python-1.27.50.tar.xz](/src/gst-python/gst-python-1.27.50.tar.xz)
- [gst-editing-services-1.27.50.tar.xz](/src/gst-editing-services/gst-editing-services-1.27.50.tar.xz)
- [gst-devtools-1.27.50.tar.xz](/src/gst-devtools/gst-devtools-1.27.50.tar.xz),
- [gstreamer-docs-1.27.50.tar.xz](/src/gstreamer-docs/gstreamer-docs-1.27.50.tar.xz)

As always, please give it a spin and let us know of any issues you run into by filing an
issue in [GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer/).
