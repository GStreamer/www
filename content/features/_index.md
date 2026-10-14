---
title: "Features"
---
## Multiplatform

GStreamer runs on all major operating systems, including Linux, Android,
Windows, macOS and iOS, as well as the BSDs. It supports all major hardware
architectures, such as x86, ARM and RISC-V, on 32-bit as well as 64-bit
systems. Binary installers are available for Android, iOS, macOS and Windows
on the [download page](/download/).

GStreamer makes use of the hardware acceleration and the native media APIs of
each platform:

* Linux: VA-API, V4L2 (including stateless codecs), NVIDIA NVCODEC, Intel QSV, Vulkan, DMA-BUF, KMS/DRM and Wayland
* Windows: Direct3D 11 and 12, Media Foundation, WASAPI, AMD AMF and NVIDIA NVCODEC
* macOS and iOS: VideoToolbox, AVFoundation and Core Audio
* Android: MediaCodec

## Comprehensive Core Library

* Graph-based structure allows arbitrary pipeline construction
* Based on the [GObject](https://docs.gtk.org/gobject/) object model for object-oriented design and inheritance
* Multi-threaded pipelines are trivial and transparent to construct
* Clean, simple and stable [API](/documentation/gstreamer/) for both plugin and application developers
* Extremely lightweight data passing means very high performance and low latency
* Buffers can wrap DMA-BUF and GPU memory, so video frames can stay on the hardware between elements
* Complete [debugging system](/documentation/gstreamer/gstinfo.html) for both core and plugin/app developers, with tracers for latency, statistics and leaks
* Clocking to ensure global inter-stream synchronization (a/v sync) and support for live pipelines with latency management
* Quality of service (QoS) to ensure the best possible quality under high CPU load

## Intelligent Plugin Architecture

* [Dynamically loaded](/documentation/gstreamer/gstplugin.html) plugins provide elements and media types, demand-loaded via a registry cache
* [Elements](/documentation/application-development/index.html) handle all known types of sources, filters and sinks
* The [capabilities system](/documentation/gstreamer/gstcaps.html) allows verification of element compatibility using media types and media-specific properties
* Autoplugging uses the capabilities system to complete complex paths automatically: playbin3 and decodebin3 build complete playback pipelines from a URI
* Pipelines can be visualised by dumping them to a .dot file and creating an image from that
* Resource friendly plugins don't waste memory
* Plugins can be written in C, in Rust ([gst-plugins-rs](/modules/)) and in Python

## Broad Coverage of Multimedia Technologies

GStreamer's capabilities can be extended through new plugins. The features
listed below are just a rough overview of what is available using the
GStreamer project's own plugins, not counting any third-party offerings.

* container formats: MP4/MOV (including fragmented MP4), Matroska/WebM, MPEG-PS/TS, MXF and Ogg
* streaming and real-time communication: WebRTC (including WHIP and WHEP), RTP, RTSP, HLS, DASH, SRT, RIST, RTMP and HTTP
* codecs: H.264, H.265, H.266, VP8, VP9, AV1, JPEG XS, Opus, AAC, FLAC and many more, through hardware accelerated decoders and encoders, dedicated codec libraries and FFmpeg
* metadata: native container formats with a common mapping between them
* video: various colorspaces, progressive and interlaced video, HDR, and OpenGL, Vulkan and Direct3D rendering
* audio: integer and float audio in various bit depths and multichannel configurations
* machine learning and video analytics: ONNX Runtime, TensorFlow Lite and OpenCV integration, with analytics metadata and tensor decoders for detection, classification and tracking

## Extensive Development Tools

* gst-launch-1.0 command-line tool for quick prototyping and testing, gst-inspect-1.0 to explore the available elements, and gst-play-1.0 for playback
* Tools to find and inspect devices, media files and pipelines: gst-device-monitor-1.0, gst-discoverer-1.0 and gst-stats-1.0
* GstValidate and its launcher for testing pipelines and applications, and viewers for debug logs and pipeline graphs
* A lot of [documentation](/documentation/), including [tutorials](/documentation/tutorials/index.html), the [application development manual](/documentation/application-development/index.html) and the [plugin writer's guide](/documentation/plugin-development/index.html)
* Large selection of test programs and example code in each module
* Access to GStreamer API with [various programming languages](/bindings/), such as Python, Rust, C++, C#, Java and Go

GStreamer 1.x has been API and ABI stable since 2012.
