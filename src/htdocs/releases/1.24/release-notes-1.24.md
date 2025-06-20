# GStreamer 1.24 Release Notes

GStreamer 1.24.0 was originally released on 4 March 2024.

The latest and most likely last bug-fix release in the stable 1.24 series is [1.24.13](#1.24.13) and was released on 11 June 2025.

See [https://gstreamer.freedesktop.org/releases/1.24/][latest] for the latest version of this document.

The GStreamer 1.24 stable series has now been superseded by the [GStreamer 1.26 stable release series][gstreamer-1.26].

*Last updated: Wednesday 11 June 2025, 01:00 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.24/
[gitlog]: https://gitlab.freedesktop.org/gstreamer/www/commits/main/src/htdocs/releases/1.24/release-notes-1.24.md

[gstreamer-1.26]: https://gstreamer.freedesktop.org/releases/1.26/

<a id="introduction"></a>
## Introduction

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with many new features, bug fixes and other improvements.

<a id="highlights"></a>
## Highlights

- New [Discourse forum][discourse] and [Matrix chat space][matrix]
- New Analytics and Machine Learning abstractions and elements
- Playbin3 and decodebin3 are now stable and the default in gst-play-1.0, GstPlay/GstPlayer
- The va plugin is now preferred over gst-vaapi and has higher ranks
- GstMeta serialization/deserialization and other GstMeta improvements
- New GstMeta for SMPTE ST-291M HANC/VANC Ancillary Data
- New unixfd plugin for efficient 1:N inter-process communication on Linux
- cudaipc source and sink for zero-copy CUDA memory sharing between processes
- New intersink and intersrc elements for 1:N pipeline decoupling within the same process
- Qt5 + Qt6 QML integration improvements including qml6glsrc, qml6glmixer, qml6gloverlay, and qml6d3d11sink elements
- DRM Modifier Support for dmabufs on Linux
- OpenGL, Vulkan and CUDA integration enhancements
- Vulkan H.264 and H.265 video decoders
- RTP stack improvements including new RFC7273 modes and more correct header extension handling in depayloaders
- WebRTC improvements such as support for ICE consent freshness, and a new webrtcsrc element to complement webrtcsink
- WebRTC signallers and webrtcsink implementations for LiveKit and AWS Kinesis Video Streams
- WHIP server source and client sink, and a WHEP source
- Precision Time Protocol (PTP) clock support for Windows and other additions
- Low-Latency HLS (LL-HLS) support and many other HLS and DASH enhancements
- New W3C Media Source Extensions library
- Countless closed caption handling improvements including new cea608mux and cea608tocea708 elements
- Translation support for awstranscriber
- Bayer 10/12/14/16-bit depth support
- MPEG-TS support for asynchronous KLV demuxing and segment seeking, plus various new muxer features
- Capture source and sink for AJA capture and playout cards
- SVT-AV1 and VA-API AV1 encoders, stateless AV1 video decoder
- New uvcsink element for exporting streams as UVC camera
- DirectWrite text rendering plugin for windows
- Direct3D12-based video decoding, conversion, composition, and rendering
- AMD Advanced Media Framework AV1 + H.265 video encoders with 10-bit and HDR support
- AVX/AVX2 support and NEON support on macOS on Apple ARM64 CPUs via new liborc
- GStreamer C# bindings have been updated
- Rust bindings improvements and many new and improved Rust plugins
- Rust plugins now shipped in packages for all major platforms including Android and iOS
- Lots of new plugins, features, performance improvements and bug fixes

<a id="major-changes"></a>
## Major new features and changes

<a id="community"></a>
### Discourse forum and Matrix chat space

- The new [Discourse forum][discourse] and [Matrix chat space][matrix] are
  now our preferred communication channels for support and developer chat.

- The mailing lists and IRC channel are on their way to being phased out,
  but Discourse can be used [via e-mail][discourse-email] as well.

- For release announcements please subscribe to the News + Announcements
  category on Discourse, although we will continue to also send announcements
  to the mailing list for the time being.

[discourse]: https://discourse.gstreamer.org
[discourse-email]: https://discourse.gstreamer.org/t/using-discourse-via-email/109
[matrix]: https://discourse.gstreamer.org/t/new-gstreamer-matrix-chat-space/675

<a id="playbin3"></a>
### Playbin3, decodebin3 now stable and default

- After a year of stability, testing and more improvements, `playbin3`, and its
  various components (`uridecodebin3`, `decodebin3` and `urisourcebin`), are now
  the recommended playback components.

- Some playback components have now switched to defaulting to `playbin3`:
  `gst-play-1.0` and the `GstPlay` / `GstPlayer` libraries. Application developers are
  strongly recommended to switch to using those components instead of the
  legacy `playbin` and `(uri)decodebin`.

Improvements in this cycle:

- Better support missing/faulty decoders, attempt to use another one or
  gracefully un-select the stream.

- Many fixes for more complex gapless and instant-switching scenarios

- Lower latency for live pipelines

- Fix for "chained" streams (ex: Ogg, or PMT update in MPEG-TS)

- Fixes for hardware-accelerated playback with subtitles (provided the sink
  can handle offloading composition). This was also partly due to a historical
  confusion between subtitle "decoders" (which decode the format to text
  and "parsers" (which only do timing detection and optional seeking).

<a id="gst-meta"></a>
### GstMeta serialization/deserialization and other GstMeta improvements

- **GstMeta serialization/deserialization** allows metas to be transmitted or
  stored. This is used by the `unixfd` and `cudaipc` plugins for inter-process
  communication (IPC). Implemented so far for `GstCustomMeta`, `GstVideoMeta`,
  `GstAudioMeta` and `GstReferenceTimestampMeta`.

- **Simplified `GstCustomMeta` registration** with
  `gst_meta_register_custom_simple()` for the simple
  case where tags and transform functions are not needed.

- `GstMetaClearFunction` clears the content of the meta. This will be
   called by buffer pools when a pooled buffer is returned to the pool.

- Add `gst_meta_info_new()` and `gst_meta_info_register()` to
  **register a GstMeta in two steps** for easier extensibility.

<a id="unixfd"></a>
### New unixfd plugin for efficient 1:N inter-process communication on Linux

- **unixfdsink** and **unixfdsrc** are elements that, inspired by
  `shmsink` andn `shmsrc`, send UNIX file descriptors (e.g. memfd, dmabuf)
  from one sink to multiple source elements in other processes on Linux.

- The `unixfdsink` proposes a memfd/shm allocator to upstream elements which
  allows for example `videotestsrc` to write directly into memory that can be
  transfered to other processes without copying.

<a id="smpte-meta"></a>
### New GstMeta for SMPTE ST-291M HANC/VANC Ancillary Data

- Previously only various specific `GstMeta` for ancillary data were
  provided, such as `GstVideoCaptionMeta` and `GstVideoAFDMeta`. The
  new `GstAncillaryMeta` allows passing arbitrary ancillary data between
  elements, including custom and non-standard ancillary data.
  See [`GstAncillaryMeta`][anc-meta] for details.

- Add with `gst_buffer_add_ancillary_meta()` and retrieve with
  `gst_buffer_get_ancillary_meta()` or `gst_buffer_iterate_ancillary_meta()`.
  
- Supported by the newly added AJA sink and source elements

[anc-meta]: https://gstreamer.freedesktop.org/documentation/video/gstvideoanc.html#GstAncillaryMeta

<a id="dsd-audio"></a>
### DSD audio support

- [DSD audio][dsd-audio] is a non-PCM raw audio format representation and the
  GstAudio library gained support for this in form of new [`GstDsdInfo`][dsd-info]
  and [`GstDsdFormat`][dsd-format] API.
 
- Support for DSD audio has been implemented in `alsasink` as well as the
  `GstAudioSink` and `GstAudioRingBuffer` base classes, and the gst-libav
  plugin to enable FFmpeg-based DSD elements and functionality.

[dsd-audio]: https://en.wikipedia.org/wiki/Direct_Stream_Digital#DSD_signal_format
[dsd-format]: https://gstreamer.freedesktop.org/documentation/audio/gstdsdformat.html#GstDsdFormat
[dsd-info]: https://gstreamer.freedesktop.org/documentation/audio/gstdsd.html#GstDsdInfo

<a id="analytics-ml"></a>
### Analytics and Machine Learning

- A new library, [GstAnalytics][analytics], has been added. It defines a
  [GstAnalyticsRelationMeta][analytics-relation-meta] that can efficiently hold
  a large number of observations from a data analysis process, for example
  from machine learning. It also contains a matrix of the relationship
  between those observations.

- Three types of metadata are already defined in the library: object
  detection, classification and tracking.

- A new `objectdetectionoverlay` element has been merged that draws the
  bounding boxes and the classes from the object detection and
  classification metadata types.

- The `onnxinference` element has been split into two parts. The first part
  works with the ONNX Runtime library to do the actual inference, while the
  second part called `ssdobjectdetector` interprets the produced tensor.
  This new element creates [GstAnalyticsRelationMeta][analytics-relation-meta].

- The `onnxinference` element now accepts video frames without
  transformation if the module declares that it accepts the "Image" type
  and the format is something that GStreamer knows.

- In the next release, tensor decoders such as `ssdobjectdetector` will
  live outside of the ONNX plugin so they can be used with other machine
  learning acceleration frameworks.

[analytics]: https://gstreamer.freedesktop.org/documentation/analytics/
[analytics-relation-meta]: https://gstreamer.freedesktop.org/documentation/analytics/gstanalyticsmeta.html#GstAnalyticsMtdImpl

<a id="qt"></a>
### Qt5 + Qt6 QML integration improvements

- The Qt5 **qmlglsink**, **qmlgloverlay**, **qmlglmixer** received support
  for directly consuming `BGRA` and `YV12` video frames without a
  prior `glcolorconvert`.

- New **qml6glsrc**, **qml6glmixer**, and **qml6gloverlay** elements as
  Qt6 counterparts to the existing Qt5 elements, also with support for directly
  consuming `BGRA` and `YV12` video frames without a prior `glcolorconvert`.

- **qml6d3d11sink** is a new **Direct3D11 Qt6 QML sink** for Windows as
  an alternative to the existing qml6glsink.

<a id="drm-dmabuf"></a>
### DRM Modifier Support for dmabufs on Linux

The [Linux dmabuf subsystem][kernel-dmabuf] provides buffer sharing across
different hardware device drivers and subsystems, and is used extensively by
the DRM subsystem to exchange buffers between processes, contexts, and
library APIs within the same process, and also to exchange buffers with
other subsystems such as Linux Media.

In GStreamer, it's used on the capture side (v4l2src, pipewire),
hardware-accelerated video decoders and encoders, OpenGL integration,
Wayland renderers, etc.

GStreamer has had support for dmabufs for a long time and was able to negotiate
"zero-copy" paths between different components, however it only supported and
assumed simple linear formats and was not able to negotiate complex non-linear
formats. This meant that dmabuf support actually had to be disabled in many
scenarios to avoid "garbled video".

With GStreamer 1.24 there is now full DRM modifier support and complex
non-linear formats can be supported and negotiated between components.

This is achieved with an extra `drm_format` field in
`video/x-raw(memory:DMABuf), format=(string)DMA_DRM` caps, e.g.
`drm-format=(string)NV12:0x0x0100000000000001`.

See the [GStreamer DMA buffers design documentation][gstreamer-dmabuf] for
more details.

This is used in the VA-API `va` plugin, `waylandsink`, the MSDK plugin,
and the OpenGL integration. Video4Linux support is expected to land in
one of the next minor releases.

New API has been added for easy handling of these new caps:

 - [`GstVideoInfoDmaDrm`][video-info-dma-drm] plus associated functions,
   similar to `GstVideoInfo`, including conversion to and from `GstVideoInfo`
   with `gst_video_info_dma_drm_from_video_info()` and
   `gst_video_info_dma_drm_to_video_info()`

 - `GST_VIDEO_DMA_DRM_CAPS_MAKE`

 - `GST_VIDEO_FORMAT_DMA_DRM`

[gstreamer-dmabuf]: https://gstreamer.freedesktop.org/documentation/additional/design/dmabuf.html
[kernel-dmabuf]: https://docs.kernel.org/driver-api/dma-buf.html

[video-info-dma-drm]: https://gstreamer.freedesktop.org/documentation/video/video-info-dma-drm.html#GstVideoInfoDmaDrm

<a id="opengl"></a>
### OpenGL integration enhancements

- When using EGL, if both OpenGL ES and OpenGL are available, OpenGL ES is preferred
  over OpenGL. OpenGL ES supports some necessary features required for dmabuf support.
  This does not apply if an external library/application chooses an OpenGL API first.

- Improved support for dmabuf use cases.  The `glupload` element now supports
  the new and improved dmabuf negotiation with explicit modifiers.

- Base classes for mixing with OpenGL are now public API. `GstGLBaseMixer`
  and `GstGLMixer` are exposed matching the existing filter-based
  `GstGLBaseFilter` and `GstGLFilter` base classes. The new OpenGL mixer base
  classes are based on `GstVideoAggregator`.

- Add support for a 'surfaceless' EGL context using `EGL_MESA_platform_surfaceless`.

- Expose Vivante Framebuffer build-related files (pkg-config, gir) as public API

- Add support for more video formats:
  - A420 8/10/12/16-bit.
  - A422 8/10/12/16-bit.
  - A444 8/10/12/16-bit.
  - I420 10/12 bit.
  - RBGA.

- Add support for tiled video formats
  - `NV12_16L32S` (Mediatek format)
  - `NV12_4L4` (Verisilicon Hantro format)

- `glcolorconvert` now has API for retrieving shader strings for:
  - swizzling (reordering components).
  - YUV->RGB conversion.
  - RGB->YUV conversion.

- Add more helpers for information about a particular video and/or GL format
  e.g. number of components, bytes used, or pixel ordering.

- `glvideomixer` has new sink pad properties `sizing-policy`, `xalign`,
  `yalign` matching `compositor`.

- `GstGLBufferPool` now has a configuration option for allowing a number of buffers
  to be always outstanding allowing for reducing the potential synchronisation delay
  when reusing OpenGL memory backed buffers.

<a id="vulkan"></a>
### Vulkan integration enhancements

- Add support for the Vulkan H.264 and H.265 decoders.

- Add support for timeline semaphores.

- Optionally use newer Vulkan functions for format selection.

- Add support for GPU-assisted validation.

- Vulkan/Wayland: add support for `xdg_wm_base` protocol for creating a
  visible debug window.  Required as the previous `wl_shell` interface is
  being removed from compositors.

<a id="cuda-nvcodec"></a>
### CUDA / NVCODEC integration and feature additions

- New **cudaipcsrc** and **cudaipcsink** elements for zero-copy CUDA memory
  sharing between processes

- New `nvJPEG` library based **nvjpegenc** JPEG encoder element

- The NVIDIA desktop GPU decoder `nvh264sldec`, `nvh265sldec`, `nvvp8sldec`,
  and `nvvp9sldec` elements were renamed to `nvh264dec`, `nvh265dec`,
  `nvvp8dec`, and `nvvp9dec`, respectively.

- GStreamer **NVIDIA H.264 and H.265 encoders** except for `nvh264enc` and
  `nvh265enc` **gained support for CEA708 Closed Caption inserting**.

- **OpenGL memory support** is added to `nv{cuda,autogpu}h264enc` and
  `nv{cuda,autogpu}h265enc` elements

- **CUDA stream integration**: As of 1.24, CUDA stream synchronization is an
  application’s responsibility, and GStreamer will not execute unnecessary
  synchronization operations. If an application needs direct access to CUDA
  memory via `GST_MAP_CUDA` map flag, `cuStreamSynchronize()` or
  [gst_cuda_memory_sync()][gst-cuda-memory-sync] call is required unless
  application-side CUDA operation is executed with the GstCudaMemory’s
  [associated CUDA stream][gst-cuda-memory-get-stream].

[gst-cuda-memory-sync]: https://gstreamer.freedesktop.org/documentation/cuda/gst-libs/gst/cuda/gstcudamemory.html?gi-language=c#gst_cuda_memory_sync
[gst-cuda-memory-get-stream]: https://gstreamer.freedesktop.org/documentation/cuda/gst-libs/gst/cuda/gstcudamemory.html?gi-language=c#gst_cuda_memory_get_stream

<a id="rtp"></a>
### RTP stack improvements

- New **rtppassthroughpay** element which just passes RTP packets through
  unchanged, but appears like an RTP payloader element. This is useful for
  relaying an RTP stream as-is through gst-rtsp-server, which expects an RTP
  payloader with certain properties at the end of an RTSP media sub-pipeline.

- New "timeout-inactive-rtp-sources" property on **rtpbin**, **sdpdemux** and
  **rtpsession** to allow applications to disable automatic timeout of sources
  from which no data has been received for a while.

- **rtpvp8pay**, **rtpvp9pay**: expose "picture-id" as a property, and add
  a "picture-id-offset" property to the VP9 payloader to bring it in line
  with the VP8 payloader.

- **rtpjitterbuffer** has seen improved media clock handling (clock equality
  and clock setting/resetting), as well as two new properties that allow
  reconstruction of absolute PTP timestamps without actually syncing to the
  PTP clock, which can be useful in scenarios where one wants to reconstruct
  the absolute PTP clock timestamps on a machine that doesn't have access to
  the network of the PTP clock provider. The two new properties are:

   - "rfc7273-use-system-clock": allows the jitter buffer to assume that the
     system clock is synced sufficiently close to the media clock used by an
     RFC7273 stream. By default the property is disabled and the jitter buffer
     will create a media clock and try to sync to it, but this is only required
     to determine in which wraparound period from the media clock's Epoch the
     current RTP timestamps refer to (and thus to reconstruct absolute time
     stamps from them). If the property is enabled the wraparound period and
     current offset from the Epoch will be determined based on the local
     system clock, which means that no direct network connection to the media
     clock provider is needed to reconstruct absolute timestamps. There is
     also no start-up delay, because there's no clock sync that needs to be
     established first.

   - "rfc7273-reference-timestamp-meta-only": If this property is enabled then
     the jitter buffer will do the normal timestamp calculations for the output
     buffers according to the configured mode instead of making use of the
     RFC7273 media clock for that. It will still calculate RFC7273 media clock
     timestamps, but only attach them to the output buffers in form of a
     clock reference meta.

- RTP payloaders and depayloaders now have an "extensions" property
  for retrieving the list of currently enabled RTP header extensions.

- **rtpbin** and **webrtcbin** no longer blindly set properties on the
  jitter buffer assuming it's a standard `rtpjitterbuffer`, but instead
  check if the property is available first, to better support non-standard
  jitterbuffers or even an `identity` element in lieu of a jitter buffer.

- **RTP header extension handling fixes for depayloaders** that
  aggregate multiple input buffers into a single output buffer. Before,
  only the last RTP input buffer was checked for header extensions. Now the
  depayloader remembers all RTP packets pushed before an output buffer is
  produced and checks all RTP input buffers for header extensions.

   - Affected depayloaders: `rtph264depay`, `rtph265depay`, `rtpvp8depay`,
     `rtpvp9depay`, `rtpxqtdepay`, `rtpasfdepay`, `rtpmp4gdepay`,
     `rtpsbcdepay`, `rtpvorbisdepay`, `rtpmp4vdepay`, `rtptheoradepay`,
     `rtpsv3vdepay`, `rtpmp4adepay`, `rtpklvdepay`, `rtpjpegdepay`,
     `rtpj2kdepay`, `rtph263pdepay`, `rtph263depay`, `rtph261depay`.
     `rtpgstdepay`.

<a id="webrtc"></a>
### WebRTC improvements

- Add support for **ICE consent freshness** (RFC 7675).
  This requires libnice >= 0.1.22.

- Advertise the local side of an end-of-candidates with an empty
  candidate string.

- Add the number of Data Channels opened and closed to `webrtcbin`'s statistics.

- Various improvements and feature additions in the Rust `webrtc` plugin, which provides
  `webrtcsrc` and `webrtcsink` elements as well as specific elements for different
  WebRTC signalling protocols. See the Rust plugins section below for more details.

<a id="adaptivedemux"></a>
### Adaptive Streaming improvements and Low-Latency HLS (LL-HLS) support

- **hlsdemux2** now supports Low-Latency HLS (LL-HLS)

- **hlsdemux2** asynchronous playlist download and update improves
  responsiveness and bandwith usage.

- **hlsdemux2** handles fallback variant URLs.

- **hlsdemux2** is more responsive and accurate when handling seeks.

- **dashdemux2** and **hlsdemux2** have a new "start-bitrate" property,
  improving the decision for which initial stream variant that will be used.

- **dashdemux2**, **hlsdemux2**, **mssdemux2** have received many
  improvements regarding seeking, along with support for "early-seek"
  which allows playback to start immediately from the requested
  position without any previous download.

- **dashdemux2**, **hlsdemux2**, **mssdemux2** better handle errors
  on or near the live edge.

- **dashsink** can now use the `dashmp4mux` muxer from the Rust plugins
  and will also produce better and RFC 6381-compatible codec strings. The
  "suggested-presentation-delay" property allows to set the suggested
  presentation delay in the MPD.

- No development took place on the legacy demuxers (`dashdemux`, `hlsdemux`,
  `mssdemux`). Application developers are reminded to use the new demuxers
  instead. They are automatically picked up when using `urisourcebin`, `uridecodebin3`
  or `playbin3`.

<a id="w3c-mse"></a>
### W3C Media Source Extensions library

- A new GStreamer library ([mse][gst-mse]) implementing the
  W3C Media Source Extensions specification was added.

- Applications can embed this library along with GStreamer in order to
  integrate software that uses the Media Source APIs without relying on
  a web browser engine. Typically an application consuming this library
  will wrap the C API with JavaScript bindings that match the Media Source
  API so their existing code can integrate with this library.

[gst-mse]: https://gstreamer.freedesktop.org/documentation/mselib/index.html

<a id="closed-captions"></a>
### Closed Caption handling improvements

- **ccconverter** supports converting between the two CEA-608 fields.

- New **cea608mux** element for muxing multiple CEA-608 streams together.

- Various improvements and feature additions in the Rust-based closed caption
  elements. Check out the Rust plugins section below for more details.

<a id="ptp"></a>
### Precision Time Protocol (PTP) clock improvements

- Many fixes and compatibility/interoperability improvements.

- Better support for running on devices with multiple network interfaces.

- Allow sync to master clock on same host.

- PTP clock support is now also available on Windows.

- The standalone `ptp-helper` binary has been rewritten in Rust for
  portability and security. This works on Linux, Android, Windows,
  macOS, FreeBSD, NetBSD, OpenBSD, DragonFlyBSD, Solaris and Illumos.
  Newly supported compared to the C version is Windows. Compared to the
  C version various error paths are handled more correctly and a couple
  of memory leaks are fixed. Otherwise it should work identically.
  The minimum required Rust version for compiling this is 1.48, i.e. the
  version currently in Debian oldstable. On Windows, Rust 1.54 is needed at least.

- New `ptp-helper` Meson build option so PTP support can be disabled or required.

- `gst_ptp_init_full()` allows for a more fine-grained and extensible
  configuration and initialization of the GStreamer PTP subsystem, including
  TTL configuration.

<a id="bayer"></a>
### Bayer 10/12/14/16-bit depth support

- **bayer2rgb** and **rgb2bayer** now support bayer with 10/12/14/16 bit depths

- **v4l2src** and **videotestsrc** now support bayer with 10/12/14/16 bit depths

- **imagefreeze** gained bayer support as well

<a id="mpeg-ts"></a>
### MPEG-TS improvements

- **mpegtsdemux** gained support for
  - **segment seeking** for seamless non-flushing looping, and
  - **synchronous KLV**

- **mpegtsmux** now
  - allows attaching PCR to non-PES streams
  - allows **setting of the PES stream number** for AAC audio and AVC video streams
    via a new "stream-number" property on the muxer sink pads. Currently the
    PES stream number is hard-coded to zero for these stream types.
  - allows writing **arbitrary Opus channel mapping families and up to 255 channels**
  - separate handling of DVB and ATSC AC3 descriptors

<a id="new-plugins"></a>
## New elements and plugins

- **analyticsoverlay** visualises object-detection metas on a video stream.

- **autovideoflip** and **autodeinterlace** are two new auto elements.

- **AJA source and sink** elements plus device provider for AJA capture
  and playout cards, including support for HANC/VANC ancillary data.

- New **cea608mux** element for muxing multiple CEA-608 streams together.

- The **codec2json** plugin adds `av12json`, `h2642json`, `h2652json` and
  `vp82json` elements which convert AV1, H.264, H.265 and VP8 frame parameters
  into human readable JSON data, which is useful for debugging and testing
  purposes.

- New **lc3** plugin with a decoder and encoder for the Bluetooth LC3 audio codec.

- New **onnxinference** element to run ONNX inference models on video buffers.

- New **rtppassthroughpay** element which just passes RTP packets through
  unchanged, but appears like an RTP payloader element. This is mostly useful
  for medias that simply pass through an existing RTP stream in `gst-rtsp-server`.

- Qt6: **qml6glsrc**, **qml6glmixer**, **qml6gloverlay**, and **qml6d3d11sink**

- New **SVT-AV1 encoder** plugin, imported from SVT-AV1 but with many fixes.

- Many exciting **new Rust elements**, see Rust section below.

- New **DirectWrite text rendering** and **Direct3D12** plugins (see Windows section below).

- New **vaav1enc** element for encoding video in AV1 (See VA-API section)

- New **uvcsink** element for exporting streams as UVC camera

<a id="new-element-features"></a>
## New element features and additions

- **alphacombine** supports `I420_10LE` now for 10-bit WebM/alpha support.

- The **amfcodec** for **hardware-accelerated video encoding using**
  **the Advanced Media Framework (AMF) SDK for AMD GPUs** gained some new
  features:
  - 10-bit and HDR support for H.265 / HEVC and AV1 video encoders
  - B-frame support in the H.264 encoder
  - Initial support of pre-analysis and pre-encoding
  - Initial support of Smart Access Video for optimal distribution
    amongst multiple AMD hardware instances.

- **appsink**: new "propose-allocation" signal so applications can provide
  a buffer pool or allocators to the upstream elements, as well as "max-time"
  and "max-buffers" properties to configure the maximum size of the
  appsink-internal queue in addition to the existing "max-bytes" property.

- **autovideoconvert** exposes colorspace and scaler elements for well know elements

- **avtp**: add AVTP Raw Video Format payload and de-payload support.

- **cacasink**'s output driver can now be selected via the "driver" property.

- **camerabin**: various fixes and stability improvements

- **clocksync**: "QoS" property to optionally send QoS events upstream like
  a synchronising sink would.

- **cutter**: can add `GstAudioLevelMeta` on output buffers, which can
  be enabled via the new "audio-level-meta" property.

- **dashdemux2** has a new "start-bitrate" property.

- **dashsink** can now use the `dashmp4mux` muxer from the Rust plugins
  and will also produce better and RFC 6381-compatible codec strings. The
  "suggested-presentation-delay" property allows to set the suggested
  presentation delay in the MPD.

- **deinterlace**: Add support for 10/12/16-bit planar YUV formats

- The **dvdspu** subpicture overlay now implements `GstVideoOverlayComposition`
  support to make it work better with hardware decoders where the video data
  should ideally stay on the GPU/VPU and the overlay blitting be delegated to
  the renderer.

- **encodebin** now automatically autoplugs timestamper elements such as
  `h264timestamper` or `h265timestamper`, based on new "Timestamper" element
  factory type and rank.

- New **fakevideodec** element (see debugging section below).

- **filesink**: "file-mode" property to allow the ability to specify `rb+`
  file mode, which overwrites an existing file. This is useful in combination
  with `splitmuxsink` so that files can be pre-allocated which can be useful
  to reduce disk fragmentation over time.

- **flvmux**: add "enforce-increasing-timestamps" property to allow disabling
  a hack that was added back in the day because librtmp as used in `rtmpsink`
  would get confused by timestamps going backwards, but this is no longer
  required with `rtmpsink2`. If set to true (still the default, for backwards
  compatibility), `flvmux` will modify buffers timestamps to ensure they are
  always strictly increasing, inside one stream and also between the audio
  and video streams.

- **giostreamsink**: Add a property to close the stream on stop().

- **h264parse** improved its AU boundary detection.

- **h264parse**, **h265parse**, **mpegvideoparse** now support multiple
  unregistered user data SEI messages.

- **insertbin** is now a registered element and available via the registry,
  so can be constructed via parse-launch and not just via the insertbin API.

- **jack**: libjack is now loaded dynamically at runtime instead of linking it
  at build time. This means the plugin can be shipped on Windows and macOS
  and will work if there's a user-installed JACK server/library setup.

- **jpegparse** now has a rank so it will be autoplugged if needed.

- **kmssink**: Add auto-detection for NXP i.MX8M Plus LCDIFv3, ST STM32 LTDC,
  and Texas Instruments TIDSS display controllers.

- **matroskademux** and **matroskamux** gained support for more raw video
  formats, namely `RGBA64_LE`, `BGRA64_LE`, `GRAY10_BE32`, `GRAY16_LE`

- **mpg123audiodec**'s rank was changed from MARGINAL to PRIMARY so it's now
  higher than `avdec_mp3`, as it works better with "freeformat" MP3s.

- **msdk**:
  - DRM modifier support on Linux
  - only expose codecs and capabilities actually supported by the platform
  - **msdkvpp** video post-processing:
    - new "hdr-tone-mapping" property to enable HDR-to-SDR tone mapping
    - new compute scaling mode
  - **Decoders** sport D3D11 and VA integration, and the VP9 decoder
    supports certain resolution changes.

  - **Encoders**:
    - **msdkh264enc, **msdkh265enc**: "pic-timing-sei" property to insert pic timing SEI
    - **msdkh264enc, **msdkh265enc**: Add properties to allow different max/min-qp values for I/P/B frames
    - **msdkh264enc**: Added BGRx format DMABuf support
    - Advertise special image formats in low power mode

- **mxfdemux** gained support for FFV1 demuxing

- **opusenc**, **opusdec** now support decoding and encoding more than
  8 channels, and can also handle unknown/unpositioned channel layouts.

- The **oss** plugin gained a device provider for audio device discovery

- **pcapparse** learned how to handle the Linux "cooked" capture encapsulation v2

- Intel Quick Sync plugin improvements:
  - **qsvh264enc** gained more encoding options
  - **qsvh265dec** now supports GBR decoding and HEVC RExt profiles

- **qtdemux** now adds audio clipping meta when playing gapless m4a content,
  supports CENC sample grouping, as well as the SpeedHQ video codec.

- **ristsrc** gained support for dynamic payloads via the new "caps" and
  "encoding-name" properties. These can be used to make the `ristsrc` receive
  other payload types than MPEG-TS.

- **rtmp2src**: a new "no-eof-is-error" property was added: There is currently
  no way for applications to know if the stream has been properly terminated
  by the server or if the network connection was disconnected, as an EOS is
  sent in both cases. With the property set, connection errors will be reported
  as errors, allowing applications to distinguish between both scenarios.

- **rtspsrc**: new "extra-http-request-headers" property for adding custom
  http request headers when using http tunnelling.

- **sdpdemux** now supports SDP source filters as per RFC 4570; audio-only or
  video-only streaming can be selected via the new "media" property, and RTCP
  feedback can be disabled via the "rtcp-mode" property.

- **splitmuxsrc** uses natural ordering to sort globbed filenames now, i.e.
  0, 1, 2, 10, 11 instead of 0, 1, 10, 11, 2, ...

- **srt**: Add more fields to the statistics to see how many packets
  were retransmitted and how many were dropped.

- **switchbin**: many improvements, especially for caps handling and
  passthrough.

- **taginject**: a "scope" property was added to allow injection of global
  tags in addition to the current default which is stream tags.

- **timeoverlay**: add `buffer-count` and `buffer-offset` time modes.

- **udpsrc**: new "multicast-source" property to support IGMPv3 Source
  Specific Muliticast (SSM) as per RFC 4604.

- **videoconvertscale**, **videoconvert**: add a "converter-config"
  property to allow fine-tuning conversion parameters that are not
  exposed directly as property.

- **videoflip**: many orientation tag handling fixes and improvements

- **videorate**: add "drop-out-of-segment" property to force dropping
  of out-of-segment buffers.

- **volume** now supports arbitrarily-large positive gains via
  a new "volume-full-range" property (it was not possibly to just
  allow a bigger maximum value for the existing "volume" property
  for `GstController`-related backwards-compatibility reasons).

- **waylandsink**, **gtkwaylandsink**: improved frame scheduling
  reducing frame drops and improve throughput.

- **webpenc** now has support for **animated WebP** which can be enabled
  via the new "animated" property. By default it will just output a
  stand-alone WebP image for each input buffer, just like before.

- **wpe**: added a `WebProcess` crash handler; gained WPEWebKit 2.0 API support.

- **x264enc** gained support for 8-bit monochrome video (`GRAY8`).

- **ximagesrc** gained navigation support (mouse and keyboard events).

- **y4mdec** now parses extended headers to support high bit depth video.

<a id="plugin-library-moves"></a>
## Plugin and library moves

- The **AMR-NB** and **AMR-WB** plugins have been moved from -ugly to -good.

<a id="plugin-element-removals"></a>
## Plugin and element removals

- The entire **gst-omx** package and plugin has been retired.
  See the OMX section below for more details.

- The **RealServer RTSP extension**, RDT handling and PNM source
  have been removed from the realmedia plugin.
 
- The **kate subtitle plugin** has been removed.

<a id="new-api"></a>
## Miscellaneous API additions

### GStreamer Core

- `gst_pipeline_get_configured_latency()` and `gst_pipeline_is_live()`
   **convenience functions to query liveness and configured latency**
   **of a pipeline**.

- Plugins can now provide **status info messages for plugins** that will be
  displayed in `gst-inspect-1.0` and is useful for dynamic plugins that
  register features at runtime. They are now able to provide information
  to the user why features might not be available. This is now used in
  the `amfcodec`, `nvcodec`, `qsv`, and `va` plugins.

- `GST_OBJECT_AUTO_LOCK()` and `GST_PAD_STREAM_AUTO_LOCK()` are
  **`g_autoptr(GMutexLocker)`-based helpers for `GstPad` and `GstObject`** that
  unlock the mutex automatically when the helper goes out of scope. This is
  not portable so should not be used in GStreamer code that needs to be
  portable to e.g. Windows with MSVC.

- `gst_clear_context()`, `gst_clear_promise()`, `gst_clear_sample()`

- `gst_util_ceil_log2()` and `gst_util_simplify_fraction()` utility functions

- New `TAG_CONTAINER_SPECIFIC_TRACK_ID` **tag for container specific track ID**
  as used in an HTML5 context, plus basic support in `matroskademux`, `qtdemux`,
  `dashdemux` and `dashdemux2`

- New **utility functions to create a stream-id without a pad** for elements:
  - `gst_element_decorate_stream_id()`
  - `gst_element_decorate_stream_id_printf_valist()`
  - `gst_element_decorate_stream_id_printf()`

- `GstQueueArray` gained API for sorting and sorted insertion

- Add **strict GstStructure serialisation** with `gst_structure_serialize_full()`
  in combination with `GST_SERIALIZE_FLAG_STRICT` which only succeeds if the
  result can later be fully deserialised again.

- **`GstBaseSrc` enhancements**: the "automatic-eos" property can be used to
  do the equivalent to `gst_base_src_set_automatic_eos()`.
  `gst_base_src_push_segment()` sends a segment event right away which can be
  useful for subclasses like `appsrc` which have their own internal queuing.

- `GstBaseSink` gained a new custom **`GST_BASE_SINK_FLOW_DROPPED`** flow return
  which can be used by subclasses from the virtual `::render` method to signal
  to the base class that a frame is not being rendered. This is used in e.g.
  `waylandsink` and ensures that elements such as `fpsdisplaysink` will
  correctly report the rate of frames rendered and dropped.

### GstDiscoverer

- New "load-serialized-info" signal to retrieve a serialized `GstDiscovererInfo`

### GstSDP

- Add `gst_sdp_message_remove_media()`

### Video Library

#### DRM Modifier Support for dmabufs on Linux

See section above.

#### List of Video Formats for Passthrough

New helper API was added to get a list of all supported video formats,
including DMA_DRM formats, and can be used to advertise all supported
formats for passthrough purposes:

 - `GST_VIDEO_FORMATS_ANY_STR`, `GST_VIDEO_FORMATS_ANY`
 - `gst_video_formats_any()` which can be used by bindings or for code that
   prefers `GstVideoFormat` values instead of strings.

#### New Video Formats

- 12-bit and 16-bit A420 / A422 / A444  (YUV with alpha channel) variants:
  - `A444_12BE`, `A444_12LE`
  - `A422_12BE`, `A422_12LE`
  - `A420_12BE`, `A420_12LE`
  - `A444_16BE`, `A444_16LE`
  - `A422_16BE`, `A422_16LE`
  - `A420_16BE`, `A420_16LE`

- 8-bit A422 / A444 (YUV with alpha channel) variant:
  - `A422`
  - `A444`

- Planar 16-bit 4:4:4 RGB formats:
  - `GBR_16BE`
  - `GBR_16LE`

- `RBGA`, intended to be used by hardware decoders where `VUYA` is only
   supported 4:4:4 decoding surface but the stream is encoded with GBR
   color space, such as HEVC and VP9 GBR streams for example.

- Two tiled Mediatek 10-bit formats:
  - `MT2110T`
  - `MT2110R`

- Tiled 10-bit NV12 format `NV12_10LE40_4L4` (Verisilicon Hantro)

<a id="optimisations"></a>
## Miscellaneous performance, latency and memory optimisations

- liborc 0.4.35 (latest: 0.4.38) adds support for AVX/AVX2 and contains
  improvements for the SSE backend.

- liborc 0.4.37 adds support for NEON on macOS on Apple ARM64 CPUs.

- Most direct use of the GLib `GSLice` allocator has been removed, as there is
  little evidence that it actually still provides much advantage over the standard
  system allocator on Linux or Windows in 2024. There *is* strong evidence however
  that it causes memory fragmentation for standard GStreamer workloads such as
  RTSP/RTP/WebRTC streaming.

- As always there have been plenty of performance, latency and memory optimisations
  all over the place.

<!--

## Miscellaneous other changes and enhancements

- Nothing that hasn't been mentioned elsewhere already.

-->

<a id="tracing"></a>
## Tracing framework and debugging improvements

- The **gst-stats** tool can now be passed a custom regular expression

- **gst-debug-viewer** from the devtools module has seen minor improvements and fixes

### New tracers

- None in this release.

### Debug logging system improvements

- Nothing major in this cycle.

### Fake video decoder

- The new **fakevideodec** element does not decode the input bitstream,
  it only reads video width, height and framerate from the caps and then
  pushes out raw video frames of the expected size in RGB format.
  
- It draws a snake moving from left to right in the middle of the frame,
  which is reasonably light weight and still provides an idea about how
  smooth the rendering is.

<a id="tools"></a>
## Tools

- **gst-launch-1.0** gained a new `--prog-name` command line option to set
  the program name, which will be used by GTK and GStreamer to set the
  class or app-id.

- **gst-play-1.0** now defaults to using `playbin3`, but can still be made to
  use the old `playbin` by passing the `--use-playbin2` command line argument.

<a id="ffmpeg"></a>
## GStreamer FFmpeg wrapper

- New **avvideocompare** element to compare two incoming video buffers
  using a specified comparison method (e.g. SSIM or PSNR).

- **Prefer using FFmpeg Musepack decoder/demuxer** over `musepackdec`
  as they work better with `decodebin3` and `playbin3` which likes to
  have parsers and decoders separate.

- Added **codec mappings** for AV1, MxPEG, FFVHuff video

- Added **raw video format** support for `P010`, `VUYA`, `Y410`,
  `P012`, `Y212` and `Y412`.

- Newer, non-deprecated APIs are used by the plugin when built with FFmpeg 6.0 or newer.

- The FFmpeg meson subproject wrap has been updated to v6.1

- Note: see Known Issues section below for known issues with FFmpeg 6.0.0
  and the latest FFmpeg 7.x release

<a id="rtsp"></a>
## GStreamer RTSP server

- New "ensure-keyunit-on-start" property: While the suspend modes NONE
  and PAUSED provided a low startup latency for connecting clients, it
  did not ensure that streams started on fresh data. With this new
  property it is possible to maintain the low startup latency of those
  suspend modes while also ensuring that a stream starts on a key unit.
  Furthermore, by setting the new "ensure-keyunit-on-start-timeout"
  property it is also possible to accept a key unit of a certain age,
  but discard it if too much time has passed and instead force a new
  key unit.

- rtspclientsink: apply "port-range" property for RTCP port selection as well

<a id="vaapi"></a>
## GStreamer VA-API support

### GstVA

- `vah264dec`, `vah265dec`, `vavp8dec`, `vavp9dec`, `vampeg2dec` and
  `vaav1dec` were promoted to rank PRIMARY+1 on Linux

- Improved support for dmabuf use cases.  All `va` elements now negotiate
  the new and improved dmabuf capabilities with explicit modifiers.
  This supports both import and export of dmabufs.

- Added `vaav1enc` element, available in recent Intel and AMD GPUs

- Added support for the experimental [VA-Win32 backend][va-win32].
  It needs at least libva 1.18

- Improved handling of multi-GPU systems. Still, sharing buffers among them
  is not advised.

- Bumped minimum libva version to 1.12

- Enhanced support for RadeonSI Mesa driver for 10bit decoding

- Register elements only for allowed drivers (Intel and Mesa, for the moment)

[va-win32]: https://devblogs.microsoft.com/directx/video-acceleration-api-va-api-now-available-on-windows/

### GStreamer-VAAPI

- The new GstVA elements (see above) should be preferred when possible.

- Ranks of decoders were demoted to `NONE` so they won't be used
  automatically by `playbin` and similar elements anymore.

- Clean-ups and minimal fixes.

- **gstreamer-vaapi should be considered deprecated** and may be
  discontinued as soon as the `va` plugin is fully feature equivalent.
  Users who rely on gstreamer-vaapi are encouraged to migrate and
  test the `va` elements at the earliest opportunity.

<a id="v4l2"></a>
## GStreamer Video4Linux2 support

- **New `uvcsink` element**, based on v4l2sink allow streaming your pipeline
  as a UVC camera using Linux UVC Gadget driver.

- `v4l2src` now supports **10/12/14/16-bit bayer formats**.

- Stateful decoders now pass too large encoded frames over multiple buffers.

- **AV1 Stateless video decoder**.

- Stateless decoders now tested using Virtual driver (visl), making it possible to run the tests in the cloud based CI

<a id="omx"></a>
## GStreamer OMX

- The gst-omx module has been removed. The OpenMAX standard is long dead and
  even the Raspberry Pi OS no longer supports it. There has not been any
  development since 1.22 was released. Users of these elements should switch
  to the Video4Linux-based video encoders and decoders which have been the
  standard on embedded Linux for quite some time now.

- Hardware vendors which still use OpenMAX are known to have non-standard
  forks and it is recommended that they maintain it while planning their
  move to the Video4Linux API.

<a id="ges"></a>
## GStreamer Editing Services and NLE

- Implement a `gesvideoscale` effect which gives user the ability to chooses where
  a clip has to be scaled in the chain of effects. By default scaling is done in
  the `compositor`.

- Add support for `gessrc` as sub-timeline element so third party can implement their own
  formatters and use their timelines as sub-timelines. Before that, only timelines serialized
  as files on the filesystem could be loaded as sub-timelines (using `gesdemux`).

- Implement a new `GESDiscovererManager` singleton object making management of the discoverers used
  to discoverer media files cleaner and allowing to expose the following APIs:
    - `load-serialize-info` signal so `GstDiscovererInfo` can be serialized by users the way they like and load them without requiring discovering the file when reloading a project.
    - `source-setup` signal so user can tweak source elements during discovery

- Expose `GESFrameCompositionMeta` in public API so user can implement their own effects
  targetting GES which take into account that meta.

- Expose `audioconvert:mix-matrix` property in audio sources

- Port `GESPipeline` rendering to use `encodebin2`. This allows rendering timelines directly with
  a muxing sink (like `hlssinkX` etc..) and leverage all new features of that new element.

### ges-launch

- Fix setting keyframes

- Add an `ignore-eos` option

- Allow overriding container profile so that the user can build encoding profiles
  following the media format of a specific media file, for example, but ensuring
  it is muxed using a specific format

- Ensure sink elements are inside a `GstBin` and never in a `GstPipeline`

- Move `+effect` stack effects from source to last effect added, so it feels more natural
  to user as adding them at the beginning of the chain while the syntax is `+effect`
  felt wrong

<a id="validate"></a>
## GStreamer validate

- In action types, add a way to avoid checking property value after setting it,
  in case elements do it async for example.

- Add a vmethod to free `GstValidateActionParameter`s to be more binding friendly.

- Allow scenarios to define the pipeline state target in the metadata
  instead of assuming `PLAYING` state.

- Add support to run sub-pipelines/scenarios
  - Added support to forward buffers from appsink to appsrc

- Add a way to set pipeline base-time, start-time and force using the system clock.

- Add a 'fill-mode' to the `appsrc-push` action type so we can create some type
  of streams easily using an appsrc, giving control when writing scenarios
  without requiring files with the content.

- Add a "select-streams" action type to test "stream aware" elements.

- Add a way to wait for a property to reach a specified value before executing
  an action. For example it is possible to wait for a pad to get some specific
  caps set before executing an action.

- validate: Add support to replace variables in deeply nested structures in
  particular for more complex action types where some of the properties are
  inside structures.

- Fixed compatibility with Python 3.12.

<a id="python"></a>
## GStreamer Python Bindings

gst-python is an extension of the regular GStreamer Python bindings based on
gobject-introspection information and PyGObject, and provides "syntactic sugar"
in form of overrides for various GStreamer APIs that makes them easier to use
in Python and more pythonic; as well as support for APIs that aren't available
through the regular gobject-introspection based bindings, such as e.g.
GStreamer's fundamental GLib types such as `Gst.Fraction`, `Gst.IntRange` etc.

- Added a **`GstTagList` override that makes a tag list act like a dict**

- Fix build and usage in Windows

- Various fixes for Python >= 3.12

- Rework libpython loading to be relocatable

- Fix libpython dlopen on macOS

<a id="csharp"></a>
## GStreamer C# Bindings

- The GStreamer C# bindings have been updated to a more recent
  version of GtkSharp and the bindings have been regenerated
  with that version.
  
- GStreamer API added in recent GStreamer releases is now available

- GstRtspServer bindings have been added, plus an RTSP server example

<a id="rust"></a>
## GStreamer Rust Bindings and Rust Plugins

The GStreamer Rust bindings and plugins are released separately with a different release
cadence that's tied to the twice-a-year GNOME release cycle.

The latest release of the bindings (0.22) has already been updated for the new GStreamer 1.24 APIs, and works with any GStreamer version starting at 1.14.

`gst-plugins-rs`, the module containing GStreamer plugins written in Rust,
has also seen lots of activity with many new elements and plugins. The GStreamer 1.24 binaries track the 0.12 release series of `gst-plugins-rs`, and fixes from newer versions will be backported as needed to the 0.12 brach for future 1.24.x bugfix releases.

Rust plugins can be used from any programming language. To applications
they look just like a plugin written in C or C++.

<a id="rust-webrtc"></a>
### WebRTC

- New element `webrtcsrc` that can act as a recvonly WebRTC client. Just like the opposite direction, `webrtcsink`, this can support various different WebRTC signalling protocols. Some are included with the plugin and provide their own element factory for easier usage but it is also possible for applications to provide new signalling protocol implementations.

- `webrtcsink` now exposes the signaller as property and allows implementing a custom signaller by connecting signal handlers to the default signaller.

- A new signaller and `webrtcsink` implementation for Janus' VideoRoom implementation. The corresponding `webrtcsrc` signaller implementation is currently in a merge request in GitLab.

- New `whepsrc` element that can receive WHEP WebRTC streams. This is currently not based on `webrtcsrc` but in the future a new element around `webrtcsrc` will be added.

- New `whipserversrc` element around `webrtcsrc` for ingesting WHIP WebRTC streams in GStreamer.

- New `whipclientsink` element around `webrtcsink` for publishing WHIP WebRTC streams from GStreamer. This deprecates the old `whipsink` element.

- A new signaller and `webrtcsink` implementation for LiveKit. The corresponding `webrtcsrc` signaller implementation was merged into the git repository recently.

- A new signaller and `webrtcsink` implementation for AWS Kinesis Video Streams

- `webrtcsink` has a new `payloader-setup` signal to allow the application more fine grained control over the RTP payloader configuration, similar to the already existing `encoder-setup` signal for encoders.

- `webrtcsrc` gained support for a custom navigation event protocol over the data channel, which is compatible with the navigation event protocol supported by `webrtcsink`.

- `webrtcsink` supports encoded streams as input. Using encoded streams will disable `webrtcsink`s congestion control changing any encoded stream parameters.

- `webrtcsink` and `webrtcsrc` have a new signal 'request-encoded-filter' to allow transformations of the encoded stream. This can be used, for example, for the same use-cases as the WebRTC Insertable Streams API.

- gstwebrtc-api: JavaScript API for interacting with the default signalling protocol used by `webrtcsink` / `webrtcsrc`.

... and various other smaller improvements!

<a id="rust-rtsp"></a>
### RTSP

- **New `rtspsrc2` element**. Only a subset of RTSP features are implemented so far:
  - RTSP 1.0 support
  - TCP, UDP, UDP-Multicast lower transports
  - RTCP SR, RTCP RR, RTCP-based A/V sync
    - Tested for correctness in multicast cases too
  - Lower transport selection and order (NEW!)
    - The existing `rtspsrc` has a hard-coded order list for lower transports
  - Many advanced features are not implemented yet, such as non-live support.
    See the [README][rtspsrc2-readme] for the current status.

[rtspsrc2-readme]: https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/main/net/rtsp/README.md?ref_type=heads

<a id="rust-gtk4"></a>
### GTK4

- Support for **rendering GL textures** on X11/EGL, X11/GLX, Wayland, macOS, and WGL/EGL on Windows.

- Create a window for testing purposes when running in `gst-launch-1.0` or if `GST_GTK4_WINDOW=1` is set.

- New `background-color` property for **setting the color of the background of the frame and the borders**, if any. This also allows setting a fully transparent background.

- New `scale-filter` property for defining how to scale the frames.

- Add Python example application to the repository.

- Various bugfixes, including support for the new GTK 4.14 GL renderer. The plugin needs to be built with at least the `gtk_v4_10` feature to work with the new GTK 4.14 GL renderer, and will work best if built with the `gtk_v4_14` feature.

<a id="rust-closed-caption"></a>
### Closed Caption

- Add `cea608tocea708` element for **upconverting CEA-608 captions to their CEA-708 representation**.

- Add **support for translations** within `transcriberbin`.

- `awstranscriber` supports **translating the transcribed text into different languages**, including **multiple languages at the same time**.

- `awstranscriber` is using the new HTTP/2-based API now instead of the WebSocket-based one.

<a id="rust-other-elements"></a>
### Other new elements

- New `awss3putobjectsink` that works similar to `awss3sink` but with a different upload strategy.

- New `hlscmafsink` element for **writing HLS streams with CMAF/ISOBMFF fragments**.

- New `inter` plugin with **new `intersink` and `intersrc` elements that allow to 1:N connect different pipelines in the same process**. This is implemented around the `appsrc` / `appsink`-based `StreamProducer` API that is provided as part of the GStreamer Rust bindings, and is also used inside `webrtcsrc` and `webrtcsink`.

- New `livesync` element that allows **maintaining a contiguous live stream without gaps from a potentially unstable source**.

- New `isomp4mux` **non-fragmented MP4 muxer** element.

<a id="rust-other-improvements"></a>
### Other improvements

- audiornnoise
  - Attach audio level meta to output buffers.
  - Add voice detection threshold property

- fmp4mux
  - Add support for CMAF-style chunking, e.g. low-latency / LL HLS and DASH
  - Add support for muxing Opus, VP8, VP9 and AV1 streams
  - Add 'offset-to-zero' property and make media/track timescales configurable

- hlssink3
  - Allow adding `EXT-X-PROGRAM-DATE-TIME` tag to the manifest.
  - Allow generating I-frame-only playlist

- ndi
  - Closed Caption support in `ndisrc` / `ndisink`
  - Zero-copy output support in `ndisrc` for raw video and audio

- spotifyaudiosrc: Support configurable bitrate

For a full list of changes in the Rust plugins see the
[gst-plugins-rs ChangeLog][rs-changelog] between versions 0.9 (shipped with GStreamer 1.22) and 0.12 (shipped with GStreamer 1.24).

[rs-changelog]: https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/main/CHANGELOG.md

<a id="rust-cerbero"></a>
## Cerbero Rust support

- As of GStreamer 1.24, the GStreamer Rust plugins are shipped as part of
  our binary packages on all major platforms. This includes Android and iOS
  now in addition to macOS and Windows/MSVC.

<a id="build-and-deps"></a>
## Build and Dependencies

- Meson >= 1.1 is now required for all modules

- The GLib requirement has been bumped to >= 2.64

- liborc >= 0.4.38 is strongly recommended

- libnice >= 0.1.22 is strongly recommended, as it is required
  for WebRTC **ICE consent freshness** (RFC 7675).

- gst-libav was updated for FFmpeg API deprecations and removals

- libwebpmux is required for the animated WebP support

- The wpe plugin gained support for the WPEWebKit 2.0 API version 

- Bumped minimum libva version to 1.12 for the `va` plugin.

- zxing: added support for the zxing-c++ 2.0 API

- The `ptp-helper` for Precision Time Protocol (PTP) support in GStreamer core
  has been rewritten in Rust, and the minimum required Rust version for building
  this is 1.48, i.e. the version currently in Debian oldstable. On Windows, at least
  Rust 1.54 is needed. There is a new `ptp-helper` Meson feature option that can
  be used to make sure everything needed for PTP support is available (if set to
  `ptp-helper=enabled`). `cargo` is not required for building.

- `gst-plugins-rs` requires Rust 1.70 or newer.

- Link to libsoup at build time in all cases on non-Linux, and only load it
  dynamically on Linux systems where we might need to support a mix of applications
  with dependencies that might be using libsoup2 or libsoup3.
  A "soup-version" meson build option was added to prefer a specific version.
  Distros should make sure that libsoup is still a package dependency, since it's
  still required at runtime for the `soup` and `adaptivedemux2` plugins to function.

- libjack is now dynamically loaded at runtime by the JACK audio plugin, and no
  longer a hard build dependency. However, it still is a runtime dependency, so
  distros should make sure it remains a package dependency.

### Monorepo build (née gst-build)

- There is now a top-level meson build option to enable/require `webrtc`

- The FFmpeg subproject wrap was udpated to 6.1

- A libvpx wrap was added (for VP8/VP9 software encoding/decoding)

### gstreamer-full

- Add **full static build** support, including on Windows: Allow a project to use
  gstreamer-full as a static library and link to create a binary without
  dependencies. Introduce the meson build option `gst-full-target-type` to
  select the build type: `dynamic` (default) or `static`.

- Registers all full features in a plugin now to offer the possibility to
  get information at the plugin level and get it from the registry. All the
  full features are now registered in a `fullstaticfeatures` meta plugin
  instead of having a `NULL` plugin.

### Development environment

- add VSCode IDE integration

- gst-env.py: Output a setting for the prompt with `--only-environment`

<a id="cerbero"></a>
### Cerbero

Cerbero is a meta build system used to build GStreamer plus dependencies
on platforms where dependencies are not readily available, such as Windows,
Android, iOS, and macOS.

#### General improvements

- New plugins have been added
  - `codecalpha` `dvbsubenc` `rtponvif` `switchbin` `videosignal` `isac` `ivfparse` `inter` `rtspsrc2`
- JACK plugin is now available all platforms (previously only Linux), and will be loaded if the JACK library is found at plugin load time
- Several recipes were ported to meson, leading to faster builds and better MSVC support
  - ffmpeg, gperf, lame, libvpx, ogg, opencore-amr, sbc, speex, tiff, webrtc-audio-processing
  - For more information, please see [the tracker issue](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/215)
- Some recipes are now outdated or unnecessary and have been removed:
  - intltool, libkate
- Various recipe updated to their latest versions
- Rust toolchain updated to 1.76.0 (latest as of writing)
- Rust plugins are now stripped and debug info split out correctly, reducing their size
- Fix several spurious build issues, especially with the Rust toolchain
- CMake is picked up from the system if available
- Cerbero will no longer OOM or consume excessive resources on low-end systems
- Python recipes have been moved from setuptools to virtualenv
- Fixed support for Python 3.12+

#### macOS

- Minimum macOS version has been increased to 10.13 (High Sierra)
  - Released 5½ years ago, >95% marketshare
- Fix macOS app store validation issue caused by absolute RPATHs
- Rosetta is automatically installed if required for universal builds on Apple Silicon
- The official macOS binaries now also include static libs for the GStreamer Rust plugins

#### iOS

- Minimum iOS version has been increased to 12.0
- The iOS binary packages now include the GStreamer Rust plugins
- `tremor` and `ivorbisdec` plugins are no longer shipped on iOS

#### Windows

- New features shipped with the official binaries:
  - plugins: `dwrite` `d3d12` (MSVC) `soundtouch` (MSVC) `taglib` (MSVC) `webrtcdsp` (MSVC)
  - plugin features: `d3d11-wgc` (Windows Graphics Capture Support)
  - libraries: `gstdxva-1.0`
- New `qml6` plugin can be built on Windows with the `qt6` variant enabled
   - Similar to qt5, this plugin cannot be included in the official binaries
- GLib process handling helpers for Windows are now shipped
- Windows 11 SDK is now required for builds
  - Visual Studio 2019 and newer ship this SDK
- MSYS is now deprecated for building Windows binaries, will be removed in the next release
  - MSYS2 is required, and the bootstrap script `tools/bootstrap-windows.ps` can install it for you
- Windows bootstrap script `tools/bootstrap-windows.ps1` is much more interactive and user-friendly now
- Fixed Pango crash on 32-bit Windows
- WiX packaging now works with cross-windows builds from linux

#### Linux

- Linux packages will now also include static libs for the GStreamer Rust plugins
- Add Python support for multiarch distributions
- Build fixes for various recipes on multiarch distributions
- Use arch-specific libdir correctly on multiarch distributions
- gst-omx was removed from gstreamer, and hence is no longer shipped
- Fixed Gentoo support
- Added support for RHEL 9
- Added support for Rocky Linux
- Added support for Manjaro Linux

#### Android

- Android NDK has been updated to r25c
  - Only the Clang toolchain is used from the NDK now (both target and host)
  - gnustl has been completely removed
- The Android binary packages now include the GStreamer Rust plugins
- `tremor` and `ivorbisdec` plugins are no longer shipped on Android
- `openh264` plugin no longer enables ASM optimizations on Android x86 due to relocation errors

<a id="platform-specific"></a>
## Platform-specific changes and improvements

<a id="android"></a>
### Android

- Add NDK implementation of Android MediaCodec. This reduces the amount of
  Java <-> native calls, which should reduce overhead.

- Add support for AV1 to the `androidmedia` video encoder and decoder.

<a id="apple"></a>
### Apple macOS and iOS

- osxaudio: **audio clock improvements** (interpolate based on system time)

- Set activation policy in `gst_macos_main()` and in **osxvideosink** and
  **glimagesink**. Setting the policy to `NSApplicationActivationPolicyAccessory`
  by default makes sure that we can activate windows programmatically or
  by clicking on them. Without that, windows would disappear if you clicked
  outside them and there would be no way to bring them to front again. This
  change also allows osxvideosink to receive navigation events correctly.

<a id="windows"></a>
### Windows

- New **DirectWrite text rendering plugin** with **dwriteclockoverlay**,
  **dwritetimeoverlay**, **dwritetextoverlay**, **dwritesubtitlemux**,
  and **dwritesubtitleoverlay** elements, including closed caption overlay
  support in dwritetextoverlay.

- **PTP clock support** is now also available on Windows

- **qml6d3d11sink** is a new **Direct3D11 Qt6 QML sink** for Windows
  as an alternative to the existing qml6glsink.

- **wasapi2** audio plugin:
  - Added an option to monitor a loopback device's mute state
  - Allows process loopback capture on Windows 10

- **win32ipc** supports zero-copy rendering now through a shared bufferpool.

- Add a **Windows-specific plugin loader implementation** (`gst-plugin-scanner`),
  so plugin loading during registry updates happens in an external process
  on Windows as well.

- `gst_video_convert_sample()` which is often used for thumbnailing
  gained a D3D11 specific conversion path.

- **d3d11** plugin:
  - `d3d11mpeg2dec` element is promoted to `PRIMARY` + 1 rank
  - Added `d3d11ipcsrc` and `d3d11ipcsink` elements for zero-copy GPU memory sharing between multiple processes.
  - Added HLSL shader pre-compilation (at binary build time) support in MSVC build.
  - `d3d11videosink` and `d3d11convert` elements support 3D transform, MSAA (MultiSampling Anti-Aliasing) and anisotropic sampling method.
  - Added support for more raw video formats by using compute shader. A list of supported raw video formats can be found in the [`d3d11videosink` plugin documentation][d3d11videosink-docs].
  - Added `d3d11overlay` element for applications to be able to draw/blend an overlay image on Direct3D11 texture directly. 

[d3d11videosink-docs]: https://gstreamer.freedesktop.org/documentation/d3d11/d3d11videosink.html#pad-templates

- **New Direct3D12 plugin**: From a video decoding, conversion, composition, and rendering point of view, this new `d3d12` plugin is feature-wise near equivalent to the `d3d11` plugin. Notable differences between `d3d12` and `d3d11` are:
  - The GStreamer Direct3D12 integration layer is not exposed as a GStreamer API yet. Thus, other plugins such as `amfcodec`, `nvcodec`, `qsv`, and `dwrite` are not integrated with `d3d12` yet.
  - H.264 video encoding support via `d3d12h264enc` element.
    - Direct3D12 video encoding API requires Windows 11 or [DirectX 12 Agility SDK][directx-12-agility-sdk]
  - IPC, overlay, and deinterlace elements are not implemented in `d3d12`
  - [Windows Graphics Capture][windows-graphics-capture] API based screen capturing is not implemented in `d3d12`
  - In this release, MSVC is the only officially supported toolchain for the `d3d12` plugin build.
  - All `d3d12` elements are zero ranked for now. Users will need to adjust rank of each `d3d12` element via `GST_PLUGIN_RANK` environment or appropriate plugin feature APIs if they want these elements autoplugged.

[directx-12-agility-sdk]: https://devblogs.microsoft.com/directx/gettingstarted-dx12agility/
[windows-graphics-capture]: https://learn.microsoft.com/en-us/uwp/api/windows.graphics.capture

<!--

<a id="linux"></a>
### Linux

- Many improvements which are described in other sections.

-->

<a id="docs"></a>
## Documentation improvements

- hotdoc has been updated to the latest version, and the theme has also
  been updated, which should fix various usability issues.

<a id="breaking-changes"></a>
## Possibly Breaking Changes

- `gst_plugin_feature_check_version()` has been updated to fix unexpected
  version check behaviour for git versions. It would return TRUE if the
  plugin version is for a git development version (e.g. 1.24.0.1) and the
  check is for the "next" micro version (1.24.1). Now it no longer does this.
  This just brings the runtime version check in line with the build time
  version checks which have been fixed some time ago.

- `GstAudioAggregator` and subclasses such as **audiomixer** now sync
  property values to output timestamp, which is what `GstVideoAggregator`
  has been doing already since 2019, and which makes sense, as the properties
  need to change at every output frame based on the output time because they
  may change even though the input frame is not changing.

- **rtpac3depay** now outputs `audio/x-ac3` instead of `audio/ac3` as that
  is the canonical media format in GStreamer. `audio/ac3` is still sometimes
  accepted as input format for backwards compatibility (e.g. in `rtpac3pay`
  or `ac3parse`), but shouldn't be output.

- **timecodestamper**: The "drop-frame" property now defaults to TRUE

- The NVIDIA desktop GPU decoders `nvh264sldec`, `nvh265sldec`, `nvvp8sldec`
  and `nvvp9sldec` were renamed to `nvh264dec`, `nvh265dec`, `nvvp8dec` and
  `nvvp9dec`, respectively.

<a id="known-issues"></a>
## Known Issues

- There are known issues with FFmpeg version 6.0.0 due to opaque passing
  being broken in that version. This affects at least `avdec_h264`, but
  may affect other decoders as well. Versions before 6.0.0, and 6.0.1 or higher
  are not affected.

- gst-libav < 1.24.6 didn't build against the latest FFmpeg 7.0 release.
  This has been worked on and tracked in [this "libav: Fix compatibility with ffmpeg 7" Merge Request][ffmpeg-7-0-compat-mr].

[ffmpeg-7-0-compat-mr]: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6505

<a id="statistics"></a>
## Statistics

- 4643 commits
- 2405 Merge Requests
- 850 Issues
- 290+ Contributors
- ~25% of all commits and Merge Requests were in Rust modules

- 4747 files changed
- 469633 lines added
- 209842 lines deleted
- 259791 lines added (net)

<a id="contributors"></a>
## Contributors

Aaron Boxer, Aaron Huang, Acky Xu, adixonn, Adrian Fiergolski,
Adrien De Coninck, Akihiro Sagawa, Albert Sjölund, Alessandro Bono,
Alexande B, Alexander Slobodeniuk, Alicia Boya García, amindfv,
Amir Naghdinezhad, anaghdin, Anders Hellerup Madsen, Andoni Morales Alastruey,
Antonio Kevo, Antonio Rojas, Arnaud Rebillout, Arnaud Vrac, Arun Raghavan,
badcel, Balló György, Bart Van Severen, Bastien Nocera, Benjamin Gaignard,
Bilal Elmoussaoui, Brad Hards, Camilo Celis Guzman, Carlo Cabrera,
Carlos Falgueras García, Carlos Rafael Giani, Célestin Marot, Chao Guo,
Charlie Blevins, Cheah, Vincent Beng Keat, Chris Degawa, Chris Spencer,
Christian Curtis Veng, Christian Meissl, Christopher Degawa, Chris Wiggins,
Cidana-Developers, Colin Kinloch, Damian Hobson-Garcia, Daniel Almeida,
Daniel Knobe, Daniel Moberg, Daniel Morin, Daniel Pendse, Daniel Stone,
Daniel Ulery, Dan Searles, Dario Marino Saccavino, Dave Patrick Caberto,
David Craven, David Revay, David Rosca, David Svensson Fors, Detlev Casanova,
Diego Nieto, Dominique Leroux, Dongyun Seo, Doug Nazar, Edward Hervey,
Ekwang Lee, elenril, Elliot Chen, Enrique Ocaña González, Erik Fröbrant,
Eva Pace, Evgeny Pavlov, Fabian Orccon, Felix Yan, Fernando Jiménez Moreno,
Florian Zwoch, François Laignel, Frank Dana, Georges Basile Stavracas Neto,
Guillaume Desmottes, Guillaume Gomez, Gwyn Ciesla, Haihua Hu, Hassene Tmar,
hassount, Heiko Becker, He Junyan, hguermaz, Hiero32, Hosang Lee, Hou Qi,
Hugo Svirak, Hugues Fruchet, Hu Qian, Hyung Song, Ignazio Pillai, Ilie Halip,
Itamar Marom, Ivan Molodetskikh, Ivan Tishchenko, JackZhouVCD, Jacob Johnsson,
jainl28patel, Jakub Adam, James Cowgill, James Hilliard, James Oliver,
Jan Alexander Steffens (heftig), Jan Beich, Jan Schmidt, Jan Vermaete,
Jayson Reis, Jeff Wilson, Jeongki Kim, Jeri Li, Jimmi Holst Christensen,
Jimmy Ohn, Jochen Henneberg, Johan Adam Nilsson, Johan Sternerup, John King,
Jonas Danielsson, Jonas K Danielsson, Jonas Kvinge, Jordan Petridis,
Jordan Yelloz, Josef Kolář, Juan Navarro, Julien Isorce, Jun Zhao,
Jurijs Satcs, Kalev Lember, Kamal Mostafa, kelvinhu325, Kevin Song, Khem Raj,
Kourosh Firoozbakht, Leander Schulten, Leif Andersen, L. E. Segovia,
Lieven Paulissen, lijing0010, Lily Foster, Link Mauve, Li Yuanheng,
Loïc Le Page, Loïc Molinari, Lukas Geiger, Luke McGartland, Maksym Khomenko,
Ma, Mingyang, Manel J, Marcin Kolny, Marc Leeman, Marc Solsona,
Marc Wiblishauser, Marek Vasut, Marijn Suijten, Mark Hymers, Markus Ebner,
Martin Nordholts, Martin Robinson, Mart Raudsepp, Marvin Schmidt,
Mathieu Duponchelle, Matt Feury, Matthew Waters, Matthias Fuchs, Matthieu Volat,
Maxim P. Dementyev, medithe, Mengkejiergeli Ba, Michael Bunk, Michael Gruner,
Michael Grzeschik, Michael Olbrich, Michael Tretter, Michiel Westerbeek,
Mihail Ivanchev, Ming Qian, Nader Mahdi, naglis, Nick Steel, Nicolas Beland,
Nicolas Dufresne, Nirbheek Chauhan, Olivier Babasse, Olivier Blin,
Olivier Crête, Omar Khlif, Onur Demiralay, Patricia Muscalu, Paul Fee,
Pawel Stawicki, Peter Stensson, Philippe Normand, Philipp Zabel,
PhoenixWorthVCD, Piotr Brzeziński, Priit Laes, Qian Hu, Rabindra Harlalka,
Rafał Dzięgiel, Rahul T R, rajneeshksoni, Ratchanan Srirattanamet, renjun wang,
Rhythm Narula, Robert Ayrapetyan, Robert Mader, Robert Rosengren,
Robin Gustavsson, Roman Lebedev, Rouven Czerwinski, Ruben Gonzalez,
Ruslan Khamidullin, Ryan Pavlik, Sanchayan Maity, Sangchul Lee, Scott Kanowitz,
Scott Moreau, SeaDve, Sean DuBois, Sebastian Dröge, Sebastian Szczepaniak,
Sergey Radionov, Seungha Yang, Shengqi Yu, Simon Himmelbauer, Slava Andrejev,
Slawomir Pawlowski, soak, Stefan Brüns, Stéphane Cerveau, Stephan Seitz,
Stijn Last, Talha Khan, Taruntej Kanakamalla, Jin Chung Teng, Théo Maillart,
Thibault Saunier, Thomas Schneider, Tim-Philipp Müller, Tobias Rapp, Tong Wu,
Tristan van Berkom, ttrigui, U. Artie Eoff, utzcoz, Víctor Manuel Jáquez Leal,
Vivia Nikolaidou, Wang Chuan, William Manley, Wojciech Kapsa,
Xabier Rodriguez Calvar, Xavier Claessens, Xuchen Yang, Yatin Maan, Yinhang Liu,
Yorick Smilda, Yuri Fedoseev, Gang Zhao, Jack Zhou, ...

... and many others who have contributed bug reports, translations,
sent suggestions or helped testing. Thank you all!

## Stable 1.24 branch

After the 1.24.0 release there will be several 1.24.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.24.x bug-fix releases will be made from the git 1.24 branch,
which will be a stable branch.

<a id="1.24.0"></a>

### 1.24.0

GStreamer 1.24.0 was released on 4 March 2024.

<a id="1.24.1"></a>

### 1.24.1

The first 1.24 bug-fix release (1.24.1) was released on 21 March 2024.

This release only contains bugfixes and it *should* be safe to update
from 1.24.0.

#### Highlighted bugfixes in 1.24.1

- Fix instant-EOS regression in audio sinks in some cases when volume is 0
- rtspsrc: server compatibility improvements and ONVIF trick mode fixes
- rtsp-server: fix issues if RTSP media was set to be both shared and reusable
- (uri)decodebin3 and playbin3 fixes
- adaptivdemux2/hlsdemux2: Fix issues with failure updating playlists
- mpeg123 audio decoder fixes
- v4l2codecs: DMA_DRM caps support for decoders
- va: various AV1 / H.264 / H.265 video encoder fixes
- vtdec: fix potential deadlock regression with ProRes playback
- gst-libav: fixes for video decoder frame handling, interlaced mode detection
- avenc_aac: support for 7.1 and 16 channel modes
- glimagesink: Fix the sink not always respecting preferred size on macOS
- gtk4paintablesink: Fix scaling of texture position
- webrtc: Allow resolution and framerate changes, and many other improvements
- webrtc: Add new LiveKit source element
- Fix usability of binary packages on arm64 iOS
- various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [registry, ptp: Canonicalize the library path returned by dladdr](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6343)
 - [segment: Don't use g_return_val_if_fail() in gst_segment_to_running_time_full()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6275)
 - [uri: Sort uri protocol sources/sinks by feature name to break a feature rank tie](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6342)
 - [ptp: Initialize expected DELAY_REQ seqnum to an invalid value](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6365)
 - [ptp: Don't install test executable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6268)
 - [gst-inspect: fix --exists for plugins with versions other than GStreamer's version, like the Rust plugins](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6414)
 - [identity: Don't refuse seeks unless single-segment=true](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6314)

#### gst-plugins-base

 - [audiobasesink: Don't wait on gap events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6384)
 - [audioencoder: Avoid using temporarily mapped memory as base for input buffers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6339)
 - [decodebin3: Be more specific when sending missing plugin messages](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6377)
 - [decodebin3: Fix re-usability issues](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6332)
 - [decodebin3: Provide clear error message if no decoders present](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6329)
 - [playbin3: Remove un-needed URI NULL check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6338)
 - [uridecodebin3: Don't hold lock when posting messages or signals](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6403)
 - [uridecodebin3: Handle potential double redirection errors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6394)
 - [glimagesink: Fix the sink not always respecting preferred size on macOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6276)
 - [glupload: Do not propose allocators with sysmem, fixes warning when playing VP9 with alpha](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6350)
 - [shmallocator: fix build on Illumos](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6362)
 - [meson: Fix the condition to skip theoradec test](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6269)

#### gst-plugins-good

 - [adaptivdemux/hlsdemux2: Fix issues with failure updating playlists](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6410)
 - [mpg123audiodec: Correctly handle the case of clipping all decoded samples](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6357)
 - [mpg123audiodec: gst_audio_decoder_allocate_output_buffer: assertion 'size > 0' failed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3365)
 - [qt: Fix description in meson build options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6313)
 - [qtdemux: Do not set channel-mask to zero](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6296)
 - [rtspsrc: remove 'deprecated' flag from the 'push-backchannel-sample' signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6363)
 - [rtspsrc: Consider 503 Service Not Available when handling broken control urls](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6267)
 - [rtspsrc, rtponviftimestamp: ONVIF mode fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6295)
 - [rtspsrc: Don't invoke close when stopping if we've started cleanup, fixing potential crash on shutdown](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6330)
 - [rtpgstpay: Delay pushing of event packets until the next buffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6298)

#### gst-plugins-bad

 - [asio: Fix {input,output}-channels property handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6372)
 - [cuda,d3d11,d3d12bufferpool: Disable preallocation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6345)
 - [d3d11device: Fix adapter LUID comparison in wrapped device mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6364)
 - [d3d12device: Fix IDXGIFactory2 leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6353)
 - [d3d12: Fix SDK debug layer activation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6383)
 - [dvbsubenc: Fix bottom field size calculation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6277)
 - [dvdspu: avoid null dereference](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6391)
 - [GstPlay: Fix a critical warning in error callback](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6387)
 - [v4l2codecs: decoders: Add DMA_DRM caps support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6376)
 - [vaav1enc: Init the output_frame_num when resetting gf group](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6333)
 - [vah264enc, vah265enc, vaav1enc: fix potential crash on devices without rate control](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6344)
 - [vah265enc: checking surface alignment](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6399)
 - [videoparsers: Don't verbosely warn about CEA_708_PROCESS_EM_DATA_FLAG not being set](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6352)
 - [vtdec: Fix a deadlock during ProRes playback, handle non-linked gracefully](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6411)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [gtk4paintablesink: Fix scaling of texture position](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1499)
 - [janusvrwebrtcsink: Handle 64 bit numerical room ids](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1478)
 - [janusvrwebrtcsink: Don't include deprecated audio/video fields in publish messages](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1480)
 - [janusvrwebrtcsink: Handle various other messages to avoid printing errors](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1481)
 - [livekitwebrtc: Fix shutdown behaviour](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1482)
 - [rtpgccbwe: Don't forward buffer lists with buffers from different SSRCs to avoid breaking assumptions in rtpsession](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1502)
 - [sccparse: Ignore invalid timecodes during seeking](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1485)
 - [webrtcsink: Don't try parsing audio caps as video caps](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1511)
 - [webrtc: Allow resolution and framerate changes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1498)
 - [webrtcsrc: Make producer-peer-id optional](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1477)
 - [livekitwebrtcsrc: Add new LiveKit source element](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1461)
 - [regex: Add support for configuring regex behaviour](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1497)
 - [spotifyaudiosrc: Document how to use with non-Facebook accounts](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1490)
 - [webrtcsrc: Add `do-retransmission` property](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1509)

#### gst-libav

 - [avcodecmap: Increase max AAC channels to 16](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6375)
 - [avviddec: Fix how we get back the codec frame](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6331)
 - [avviddec: Fix interlaced mode detection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6297)
 - [avviddec: Double check if AV_CODEC_FLAG_COPY_OPAQUE port is safe for our scenario](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3333)

#### gst-rtsp-server

 - [media: gst_rtsp_media_set_reusable() and gst_rtsp_media_set_shared() have become incompatible](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3412)
 - [rtsp-stream: clear sockets when leaving bin](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6334)

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [ges: Fix critical warning](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6315)

#### gst-validate + gst-integration-testsuites

 - No changes

#### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.24.1

 - [gstreamer: Enable ptp helper explicitly](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1416)
 - [gst-plugins-bad: Package new insertbin plugin](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1412)
 - [gst-plugins-rs: Adjust parallel architecture build blocks](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1405)
 - [libnice: update to 0.1.22](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1399)
 - [pixman: Bump to 0.43.4](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1393)
 - [orc: disable JIT code generation on arm64 on iOS again, fixing crashes](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1419)

#### Contributors to 1.24.1

Alexander Slobodeniuk, Antonio Larrosa, Edward Hervey, Elizabeth Figura,
François Laignel, Guillaume Desmottes, He Junyan, Jan Schmidt,
Jordan Yelloz, L. E. Segovia, Mark Nauwelaerts, Mathieu Duponchelle,
Michael Tretter, Mikhail Rudenko, Nicolas Dufresne, Nirbheek Chauhan,
Philippe Normand, Piotr Brzeziński, Robert Mader, Ruijing Dong,
Sebastian Dröge, Seungha Yang, Thomas Goodwin, Thomas Klausner,
Tim-Philipp Müller, Xi Ruoyao,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.1

- [List of Merge Requests applied in 1.24.1](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.1)
- [List of Issues fixed in 1.24.1](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.1)

<a id="1.24.2"></a>

### 1.24.2

The second 1.24 bug-fix release (1.24.2) was released on 9 April 2024.

This release only contains bugfixes and it *should* be safe to update
from 1.24.x.

#### Highlighted bugfixes in 1.24.2

- H.264 parsing regression fixes
- WavPack typefinding improvements
- Video4linux fixes and improvements
- Android build and runtime fixes
- macOS OpenGL memory leak and robustness fixes
- Qt/QML video sink fixes
- Package new analytics and mse libraries in binary packages
- Windows MSVC binary packages: fix libvpx avx/avx2/avx512 instruction set detection
- various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [clock: Block futex_time64 usage on Android API level < 30](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6518)
 - [basesrc: Clear submitted buffer lists consistently with buffers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6463)
 - [ptpclock: fix double free of domain data during deinit](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6457)
 - [clocksync: Proxy allocation queries](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6525)
 - [inputselector: fix possible clock leak on shutdown](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6455)
 - [typefind: Handle WavPack block sizes > 131072](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6541)

#### gst-plugins-base

 - [glcolorconvert: Ensure glcolorconvert does not miss supported RGB formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6517)
 - [gl/macos: a couple of race/reference count fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6524)
 - [pbutils: descriptions: Don't warn on MPEG-1 audio caps without layer field](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6538)
 - [encodebin: Add the parser before timestamper to tosync list](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6486)
 - [videorate: Reset last_ts when a new segment is received](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6522)

#### gst-plugins-good

 - [qml6glsink: fix destruction of underlying texture](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6506)
 - [qt/qt6: Fixup for dummy textures](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6581)
 - [rtpjitterbuffer: Don't use estimated_dts to do default skew adjustment](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6561)
 - [rtpjitterbuffer: Use an extended RTP timestamp for the clock-base](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6575)
 - [rtpmp4adepay: Set duration on outgoing buffers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6456)
 - [tests: rtpred: fix out-of-bound writes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6478)
 - [v4l2: allocator: Fix unref log/trace on memory release](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6556)
 - [v4l2: Also set max_width/max_width if enum framesize fail](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6430)
 - [v4l2: enforce a pixel aspect ratio of 1/1 if no data are available](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6559)
 - [v4l2: fix error in calculating padding bottom for tile format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6554)
 - [v4l2src: need maintain the caps order in caps compare when fixate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6473)
 - [vpxenc: Include vpx error details in errors and warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6584)

#### gst-plugins-bad

 - [h264parse: element hangs with some video streams (regression)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3436)
 - [h264parse: Revert "AU boundary detection changes"](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6562)
 - [alphadecodebin: Explicitly pass 64 bit integers as such through varargs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6469)
 - [atdec: Set a channel mask for channel counts greater than 2](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6546)
 - [ccconverter: Fix caps leak and remove unnecessary code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6587)
 - [d3d11videosink: disconnect signals before releasing the window](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6492)
 - [d3d11: meson: Add support for MinGW DirectXMath package and update directxmath wrap to 3.1.9](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6503)
 - [d3d11: meson: Disable library build if DirectXMath header was not found](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6472)
 - [dwrite: Fix crash on device update](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6521)
 - [GstPlay: Update `video_snapshot` to support playbin3](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6526)
 - [jpegparse: avi1 tag can be progressive](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6453)
 - [jpegparse: turn some bus warnings into object ones](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6539)
 - [qsvdecoder: Release too old frames](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6586)
 - [ristsrc: Only free caps if needed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6485)
 - [va: av1enc: Correct the reference number and improve the reference setting](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6507)
 - [va: {vp9, av1}enc: Avoid reopen encoder or renegotiate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6519)
 - [videoparsers: Demote CC warning message](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6555)
 - [vkbufferpool: correct usage flags type](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6528)
 - [vkh26xdec: a couple decoding fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6534)
 - [vtdec: Fix caps criticals during negotiation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6454)
 - [wpe: avoid crash with G_DEBUG=fatal_criticals and static build](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6488)
 - [Sink missing floating references](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6527)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [aws: use fixed BehaviorVersion](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1520)
 - [aws: improve error message logs](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1521)
 - [fmp4: Update to dash-mpd 0.16](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1523)
 - [fmp4mux: Require gstreamer-pbutils 1.20 for the examples](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1530)
 - [onvifmetadataparse: Reset state in PAUSED->READY after pad deactivation, fixing occasional deadlock on shutdown](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1526)
 - [reqwest: Update to reqwest 0.12](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1510)
 - [webrtcsink: set perfect-timestamp=true on audio encoders](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1524)
 - [webrtcsink: improve panic message on unexpected caps during discovery](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1524)
 - [webrtchttp: Update to reqwest 0.12](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1530)
 - [webrtc: fix inconsistencies in documentation of object names](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1529)
 - [Fix clippy warnings after upgrade to Rust 1.77](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1512)

#### gst-libav

 - [avviddec: Fix AVPacket leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6545)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [ges: frame-composition-meta: Stop using keyword 'operator' for field in C++](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6448)

#### gst-validate + gst-integration-testsuites

 - No changes

#### gst-examples

 - [webrtc examples: set perfect-timestamp=true on opusenc for better Chrome interoperability](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6523)

#### Development build environment

 - [flac: Add subproject wrap and allow falling back to it in the flac plugin](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6560)
 - [libnice: bump subproject wrap to v0.1.22 (needed for ICE consent freshness support in gstwebrtc)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6431)

#### Cerbero build tool and packaging changes in 1.24.2

 - [glib: Block futex_time64 usage on Android API level < 30](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1441)
 - [libvpx: Fix build with Python 3.8](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1443)
 - [libvpx: Fix errors with avx* instruction set detection for x86* builds and MSVC](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1448)
 - [openjpeg: Update to 2.5.2](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1440)
 - [directxmath: Update to 3.1.9](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1438)
 - [gst-plugins-rs: Fix superstripping for ELF breaking all plugins](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1437)
 - [Rust-based plugin initialization hangs on Android with GStreamer 1.24.0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3358)

#### Contributors to 1.24.2

Alexander Slobodeniuk, Arnaud Vrac, Chao Guo, Chris Spencer, Daniel Morin,
Edward Hervey, Elizabeth Figura, Elliot Chen, eri, François Laignel,
Guillaume Desmottes, Haihua Hu, He Junyan, Hou Qi, Jan Schmidt,
Jochen Henneberg, L. E. Segovia, Martin Nordholts, Matthew Waters,
Nicolas Dufresne, Philippe Normand, Philipp Zabel, Piotr Brzeziński,
Robert Guziolowski, Robert Mader, Ruben Gonzalez, Sebastian Dröge,
Seungha Yang, Taruntej Kanakamalla, Thibault Saunier, Tim Blechmann,
Tim-Philipp Müller, Víctor Manuel Jáquez Leal, Wojciech Kapsa,
Xavier Claessens,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.2

- [List of Merge Requests applied in 1.24.2](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.2)
- [List of Issues fixed in 1.24.2](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.2)

<a id="1.24.3"></a>

### 1.24.3

The third 1.24 bug-fix release (1.24.3) was released on 30 April 2024.

This release only contains bugfixes and it *should* be safe to update
from 1.24.x.

#### Highlighted bugfixes in 1.24.3

- EXIF image tag parsing [security fixes][security]
- Subtitle handling improvements in parsebin
- Fix issues with HLS streams that contain VTT subtitles
- Qt6 QML sink re-render and re-sizing fixes
- unixfd ipc plugin timestamp and segment handling fixes
- vah264enc, vah265enc: Do not touch the PTS of the output frame
- vah264dec and vapostproc fixes and improvements
- v4l2: multiple fixes and improvements, incl. for mediatek JPEG decoder and v4l2 loopback
- v4l2: fix hang after seek with some v4l2 decoders
- Wayland sink fixes
- ximagesink: fix regression on RPi/aarch64
- fmp4mux, mp4mux gained FLAC audio support
- D3D11, D3D12: reliablity improvements and memory leak fixes
- Media Foundation device provider fixes
- GTK4 paintable sink improvements including support for directly importing dmabufs with GTK 4.14
- WebRTC sink/source fixes and improvements
- AWS s3sink, s3src, s3hlssink now support path-style addressing
- MPEG-TS demuxer fixes
- Python bindings fixes
- various bug fixes, memory leak fixes, and other stability and reliability improvements

[security]: https://gstreamer.freedesktop.org/security/

#### gstreamer

 - [ptp: Silence Rust compiler warning about some unused trait methods](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6606)

#### gst-plugins-base

 - [EXIF image tag parsing security fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6768)
 - [glcolorconvert: remove some dead code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6605)
 - [parsebin: Ensure non-time subtitle streams get "parsed"](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6597)
 - [playbin3: Handle combiner update in case of errors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6742)
 - [ximagesink: initialize mask for XISelectEvents](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6654)

#### gst-plugins-good

 - [adaptivedemux2: Playback hangs with VTT fragments](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3463)
 - [adaptivedemux2: Avoid double usage of parsebin](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6716)
 - [pulsedeviceprovider: Add compare_device_type_name function and missing lock](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6599)
 - [qml6glsink: Notify that the returned QSGNode node has changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6633)
 - [qml6glsink: video content resizes to new item size](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6759)
 - [qtdemux: fix wrong full_range offset when parsing colr box](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6634)
 - [soup: fix thread name](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6739)
 - [v4l2: add multiplane y42b (yuv422m) support (for mediatek v4l2 jpeg decoder)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6657)
 - [v4l2: bufferpool: Drop writable check on output pool process](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6648)
 - [v4l2: bufferpool: Ensure freshly created buffers are not marked as queued, fixing issues with v4l2sink on a v4l2loopback device](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6685)
 - [v4l2: bufferpool: queue back the buffer flagged LAST but empty, fixes hangs after seek with some decoders](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6649)
 - [v4l2: silence valgrind warning](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6761)
 - [vpx: Include vpx error details in errors and warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6636)

#### gst-plugins-bad

 - [d3d11device: protect device_lock vs device_new](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6702)
 - [d3d11decoder, d3d12decoder: Fix potential use after free](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6710)
 - [d3d11videosink: Fix rendering on keyed mutex enabled handle](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6635)
 - [d3d12decoder: Fix d3d12 resource copy](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6755)
 - [d3d12encoder: Fix buffer pool leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6637)
 - [d3d12videosink: HWND event handling related fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6700)
 - [d3d12vp9dec: Fix Intel GPU crash occurred when decoding VP9 SVC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6717)
 - [dvbsubenc: fixed some memory leaks and a crash](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6672)
 - [GstPlay: fix read duration failure issue for some type rtsp streams which have valid duration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6701)
 - [mediafoundation: Fix device enumeration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6647)
 - [mediafoundation: Fix infinite loop in device provider](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6707)
 - [tests: fix possible libscpp build failure in gst-plugins-bad](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6644)
 - [tsdemux, tsparse: Fix Program equality check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6719)
 - [tsdemux: Disable smart program update](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6708)
 - [unixfdsink: Take segment into account when converting timestamps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6747)
 - [va: videoformat: use video library to get DRM fourcc](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6744)
 - [va: radeonsi: DRM RGB formats doesn't look correctly mapped to VA formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3354)
 - [vah264enc, vah265enc: Do not touch the PTS of output frame](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6764) 
 - [vaav1enc: Change the alignment of output to "tu"](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6751)
 - [vaallocator: disable derived all together for Mesa <23.3](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6746)
 - [waylandsink: free staged buffer when do gst_wl_window_finalize](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6735)
 - [wlwindow: clear configure mutex and cond when finalize](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6724)
 - [waylandsink: config buffer pool with query size when propose_allocation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6687)
 - [v4l2codecs: Don't unref allocation query caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6682)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

Fixed:

 - [hrtfrender: Use a bitmask instead of an int in the caps for the channel-mask](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1549)
 - [rtpgccbwe: Don't log an error when pushing a buffer list fails while stopping](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1535)
 - [webrtcsink: Don't panic in bitrate handling with unsupported encoders](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1534)
 - [webrtcsink: Don't panic if unsupported input caps are used](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1540)
 - [webrtcsrc: Allow a `None` producer-id in `request-encoded-filter` signal](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1528)

Added:

 - [aws: New property to support path-style addressing](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1527)
 - [fmp4mux / mp4mux: Support FLAC inside (f)MP4](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1401)
 - [gtk4: Support directly importing dmabufs with GTK 4.14](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1547)
 - [gtk4: Add force-aspect-ratio property similar to other video sinks](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1547)

#### gst-libav

 - [libav: guard some recently dropped APIs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6632)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - [Fix Python library name fetching and library searching on Windows](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6748)
 - [Don't link to python for the gi overrides module](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6638)

#### gst-editing-services

 - [ges-launcher: Fix for forcing container profiles](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6675)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [debug-viewer: Fix plugin loading machinery](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6678)
 - [validate/flvdemux: Stop spamming audio/video on test](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6728)

#### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.24.3

 - No changes

#### Contributors to 1.24.3

Alexander Slobodeniuk, Edward Hervey, Elliot Chen, F. Duncanh, François Laignel,
Haihua Hu, He Junyan, Hou Qi, Jan Schmidt, Jimmy Ohn, Maksym Khomenko,
Matthew Waters, Nicolas Dufresne, Nirbheek Chauhan, Philippe Normand,
Philipp Zabel, Qian Hu (胡骞), Sanchayan Maity, Sebastian Dröge, Seungha Yang,
Simonas Kazlauskas, Taruntej Kanakamalla, Tim Blechmann, Tim-Philipp Müller,
U. Artie Eoff, Víctor Manuel Jáquez Leal, William Wedler, Xavier Claessens,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.3

- [List of Merge Requests applied in 1.24.3](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.3)
- [List of Issues fixed in 1.24.3](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.3)

<a id="1.24.4"></a>

### 1.24.4

The fourth 1.24 bug-fix release (1.24.4) was released on 29 May 2024.

This release only contains bugfixes and it *should* be safe to update
from 1.24.x.

#### Highlighted bugfixes in 1.24.4

 - audioconvert: support more than 64 audio channels
 - avvidec: fix dropped frames when doing multi-threaded decoding of I-frame codecs such as DV Video
 - mpegtsmux: Correctly time out in live pipelines, esp. for sparse streams like KLV and DVB subtitles
 - vtdec deadlock fixes on shutdown and format/resolution changes (as might happen with e.g. HLS/DASH)
 - fmp4mux, isomp4mux: Add support for adding AV1 header OBUs into the MP4 headers, and add language from tags
 - gtk4paintablesink improvements: fullscreen mode and gst-play-1.0 support
 - webrtcsink: add support for insecure TLS and improve error handling and VP9 handling
 - v4l2codecs: decoder: Reorder caps to prefer `DMA_DRM` ones, fixes issues with playbin3
 - vah264enc, vah265enc: timestamp handling fixes; generate IDR frames on force-keyunit-requests, not I frames 
 - Visualizer plugins fixes
 - Avoid using private APIs on iOS
 - Various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [clock: Fix 32 bit assertions in GST_TIME_TO_TIMEVAL and GST_TIME_TO_TIMESPEC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6919)
 - [systemclock: fix usage of `__STDC_NO_ATOMICS__`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6856)
 - [filesrc: Don't abort on `_get_osfhandle()` on Windows](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6879)
 - [tests: Avoid using "bool" for the variable name](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6896)
 - [Various Solaris / Illumos fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6947)
 - [parse: Don't assume that child proxy child objects are GstObjects](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6951)

#### gst-plugins-base

 - [audioconvert: Support converting >64 channels](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6828)
 - [decodebin3: Fix caps and stream leaks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6866)
 - [playbin(3), streamsynchronizer: Fix deadlock when streams have been flushed before others start](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6887)
 - [videotestsrc: fix race condition when clearing cached buffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6889)
 - [Fix visualization plugins](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6814)
 - [GstDiscoverer hangs when processing media file containing mebx on MacOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3509)
 - [glmixer: Add `GL_SYNC_META` option to buffer pool](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6784)
 - [typefinding: Fix `ID_ODD_SIZE` handling regression in WavPack typefinder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6944)

#### gst-plugins-good

 - [osxaudio: Avoid using private APIs on iOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6899)
 - [qtdemux: unit test fixes for 32-bit platforms](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6806)

#### gst-plugins-bad

 - [cudamemory: Fix offset of subsampled planar formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6910)
 - [d3d11: Revert "d3d11device: protect device_lock vs device_new](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6907)
 - [d3dshader: Fix gamma and primaries conversion pixel shader](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6803)
 - [dtlsconnection: Fix overflow in timeout calculation on systems with 32 bit time_t](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6920)
 - [GstPlay: Initialize debug category and error quark in class_init](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6821)
 - [kmssink: Do not close the DRM prime handle twice](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6916)
 - [mpegtsmux: Correctly time out and mux anyway in live pipelines](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6859)
 - [nvcodec: Accept progressive-high profiles for h264](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6873)
 - [nvencoder: Fix maximum QP value setting](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6832)
 - [qsvh264dec, qsvh265dec: Fix nalu leaks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6790)
 - [v4l2codecs: decoder: Reorder caps to prefer DMA_DRM ones](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6824)
 - [vah264enc, vah265enc: Let FORCE_KEYFRAME be IDR frame rather than just I frame](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6857)
 - [vah264enc, vah265enc: Set DTS offset before PTS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6913)
 - [vkh26xdec: Fix stop memory leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6787)
 - [vtdec: Fix deadlock when negotiating format change](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6817)
 - [vtdec: Fix PAUSED->READY deadlock when output loop is running](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6788)
 - [wayland: Use wl_display_create_queue_with_name](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6915)
 - [webrtc: request-aux-sender, only sink floating refs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6809)
 - [webrtcbin: Allow session level setup attribute in SDP](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6945/)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

- [fmp4mux, isomp4mux: Add support for adding AV1 header OBUs into the MP4 headers](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1544)
- [fmp4mux, isomp4mux: Add language from tags](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1557)
- [gtk4paintablesink: Also create own window for gst-play-1.0](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1555)
- [gtk4paintablesink: Add `GST_GTK4_WINDOW_FULLSCREEN` environment variable to fullscreen window for testing with e.g. gst-launch-1.0](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1555)
- [gtk4: Fix plugin description and update python examples](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1563)
- [rtpgccbwe: Log effective bitrate in more places, and log delay and loss target bitrates separately](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1567)
- [webrtcsink: Improve error when no encoder was found or RTP plugins were missing](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1560)
- [webrtcsink: Add VP9 parser after the encoder for VP9 too](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1572)
- [webrtc: Add support for insecure TLS connections](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1553)

#### gst-libav

 - [avvidec: Fix dropping wrong "ghost" frames - fixing multi-threaded decoding of I-frame codecs such as DV Video](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6845)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [ges-pipeline: Configure encodebin before linking](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6785)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - No changes

#### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.24.4

 - [Add Fedora 40 support](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1473)
 - [srt: bump version to 1.5.3](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1473)
 - [pango: Fix leaks on Windows (textoverlay plugins)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1469)
 - [windows runtime installer has empty qt6 msm](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/480)
 - [WiX: assorted fixes](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1474)

#### Contributors to 1.24.4

Alexander Slobodeniuk, Bill Nottingham, Brad Reitmeyer, Chris Del Guercio,
Daniel Stone, Edward Hervey, Emil Pettersson, He Junyan, Jordan Petridis,
Joshua Breeden, L. E. Segovia, Martin Nordholts, Mathieu Duponchelle,
Matthew Waters, Nirbheek Chauhan, Philippe Normand, Piotr Brzeziński,
Rafael Carício, Robert Ayrapetyan, Robert Mader, Sebastian Dröge, Seungha Yang,
Shengqi Yu, Stéphane Cerveau, Tim-Philipp Müller,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.4

- [List of Merge Requests applied in 1.24.4](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.4)
- [List of Issues fixed in 1.24.4](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.4)

<a id="1.24.5"></a>

### 1.24.5

The fifth 1.24 bug-fix release (1.24.5) was released on 20 June 2024.

This release only contains bugfixes and it *should* be safe to update
from 1.24.x.

#### Highlighted bugfixes in 1.24.5

 - webrtcsink: Support for AV1 via `nvav1enc`, `av1enc` or `rav1enc` encoders
 - AV1 RTP payloader/depayloader fixes to work correctly with Chrome and Pion WebRTC
 - av1parse, av1dec error handling/robustness improvements
 - av1enc: Handle force-keyunit events properly for WebRTC
 - decodebin3: selection and collection handling improvements
 - hlsdemux2: Various fixes for discontinuities, variant switching, playlist updates
 - qml6glsink: fix RGB format support
 - rtspsrc: more control URL handling fixes
 - v4l2src: Interpret V4L2 report of sync loss as video signal loss
 - d3d12 encoder, memory and videosink fixes
 - vtdec: more robust error handling, fix regression
 - ndi: support for NDI SDK v6
 - Various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [promise: Don't use g_return_* for internal checks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6998)
 - [debug: Add missing gst_debug_log_id_literal() dummy with `gst_debug=false`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6979)
 - [ptp-helper: Add GNU/Hurd support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6974)

#### gst-plugins-base

 - [uridecodebin3: Don't hold PLAY_ITEMS lock when activating them](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7020)
 - [decodebin3: Always ensure we end up with parsebin or identity](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7018)
 - [decodebin3: Properly support changing input collections](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7002)
 - [decodebin3: Avoid usage of parsebin even more](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6995)
 - [decodebin3: Fix dealing with input without caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3609)
 - [video-info: Don't crash in gst_video_info_is_equal() if one videoinfo is zero-initialized](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7059)

#### gst-plugins-good

 - [flacparse: fix buffer overflow](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6960)
 - [hlsdemux2: Various fixes for discontinuities, variant switching, playlist updates](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6961)
 - [qml6glsink: fix RGB format support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6997)
 - [rtpdtmfdepay: fix caps negotiation with audioconvert](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7048)
 - [rtpdtmfsrc: fix leak when shutting down mid-event](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7062)
 - [rtspsrc: fix invalid seqnum assertions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7034)
 - [rtspsrc: Various control URL handling fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6982)
 - [v4l2src: Interpret V4L2 report of sync loss as video signal loss](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7027)

#### gst-plugins-bad

 - [av1parse: Do not return error when expectedFrameId mismatch](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7052)
 - [av1dec: Don't treat decoding errors as fatal and print more error details](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7041)
 - [av1enc: Handle force-keyunit events properly by requesting keyframes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7022)
 - [codectimestamper: never set DTS to NONE](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7033)
 - [d3d12encoder: Do not print error log for not-supported feature](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6963)
 - [d3d12memory: Fix staging buffer alignment](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6973)
 - [d3d12videosink: Disconnect window signal handler on dispose as intended](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7014)
 - [dtlssrtpenc: Don't crash if no pad name is provided when requesting a new pad](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6994)
 - [glcolorconvert: update existing sync meta if outbuf has one](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6962)
 - [pcapparse: Parsing code assumes unaligned memory accesses are OK](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3602)
 - [pcapparse: Avoid unaligned memory access](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7037)
 - [tsdemux: Fix maximum PCR/DTS values](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7058)
 - [vtdec: Improve error handling in edge cases](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7044)
 - [vtdec, qtdemux: regression in 1.24.3 - internal data stream error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3603)
 - [uvcgadget: Use g_path_get_basename instead of libc basename](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7028)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [gtk4: update flatpak integration code](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1626)
 - [ndi: Add support for loading NDI SDK v6](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1615)
 - [reqwesthttpsrc: Fix race condition when unlocking](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1617)
 - [rtp: Don't restrict payload types for payloaders](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1595)
 - [rtp: av1pay: Correctly use N flag for marking keyframes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1628)
 - [rtp: av1depay: Parse internal size fields of OBUs and handle them](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1621)
 - [webrtcsink: Refactor value retrieval to avoid lock poisoning](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1598)
 - [webrtcsink: Add support for AV1](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1597)
 - [webrtc: Update to async-tungstenite 0.26](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1616)
 - [Fix various new clippy 1.79 warnings](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1627)
 - [meson: Fix various issues in dependency management, feature detection, some regressions, and add logging](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1614)

#### gst-libav

 - No changes

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - No changes

#### gst-devtools, gst-validate + gst-integration-testsuites

 - No changes

#### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.24.5

 - [osxrelocator: Fix RPATHs in deeply nested libraries](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1491)

#### Contributors to 1.24.5

Angelo Verlain, Chris Del Guercio, Corentin Damman, Edward Hervey,
Francisco Javier Velázquez-García, He Junyan, Jakub Adam, Jakub Vaněk,
Khem Raj, L. E. Segovia, Martin Nordholts, Mathieu Duponchelle, Nirbheek Chauhan,
Piotr Brzeziński, Samuel Thibault, Sebastian Dröge, Sergey Krivohatskiy,
Seungha Yang, Tim-Philipp Müller, Zach van Rijn,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.5

- [List of Merge Requests applied in 1.24.5](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.5)
- [List of Issues fixed in 1.24.5](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.5)

<a id="1.24.6"></a>

### 1.24.6

The sixth 1.24 bug-fix release (1.24.6) was released on 29 July 2024.

This release only contains bugfixes and it *should* be safe to update
from 1.24.x.

#### Highlighted bugfixes in 1.24.6

 - Fix compatibility with FFmpeg 7.0
 - qmlglsink: Fix failure to display content on recent Android devices
 - adaptivedemux: Fix handling of closed caption streams
 - cuda: Fix runtime compiler loading with old CUDA tookit
 - decodebin3 stream selection handling fixes
 - d3d11compositor, d3d12compositor: Fix transparent background mode with YUV output
 - d3d12converter: Make gamma remap work as intended
 - h264decoder: Update output frame duration for interlaced video when second field frame is discarded
 - macOS audio device provider now listens to audio devices being added/removed at runtime
 - Rust plugins: audioloudnorm, s3hlssink, gtk4paintablesink, livesync and webrtcsink fixes
 - videoaggregator: preserve features in non-alpha caps for subclasses with non-system memory sink caps
 - vtenc: Fix redistribute latency spam
 - v4l2: fixes for complex video formats
 - va: Fix strides when importing DMABUFs, dmabuf handle leaks, and blocklist unmaintained Intel i965 driver for encoding
 - waylandsink: Fix surface cropping for rotated streams
 - webrtcdsp: Enable multi_channel processing to fix handling of stereo streams
 - Various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [downloadbuffer: fix push mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7140)
 - [queue: queue2: multiqueue: Don't work with segment.position if buffers have no timestamps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7075)
 - [gst-inspect-1.0: Fix leak of plugin/feature](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7123)

#### gst-plugins-base

 - [decodebin3: Fix detection of selection done](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7074)
 - [glvideomixer: Fix critical when setting start-time-selection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7207)
 - [parsebin: accept-caps handling for elements with unusual sink pad names](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7257)
 - [subparse: Don't use jit for regular expressions when running in valgrind](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7124)
 - [subparse: put valgrind header availability define into config.h for subparse](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7129)
 - [videoaggregator: preserve features in non-alpha caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7198)
 - [videoscale: correct classification error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7235)
 - [meson: Fix invalid include flag in uninstalled gl pc file](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7143)
 - [Fix various memory leaks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7123)

#### gst-plugins-good

 - [adaptivedemux: Fix handling closed caption streams](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7105)
 - [qml/glsink: also support GLES2 needing shader 'precision' directives](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7125)
 - [v4l2object: use v4l2 reported width for padded_width when complex video formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7122)
 - [v4l2: meson: fix SIZEOF_OFF_T when cross-compiling with Meson >= 1.3.0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7218)

#### gst-plugins-bad

 - [svtav1enc: Fix segfault when flushing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7251)
 - [avfdeviceprovider: Fix debug category initialization](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7195)
 - [osxaudiodeviceprovider: Listen for audio devices being added/removed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7258/)
 - [avtp: Fixed Linux/Alpine 3.20 build](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7227)
 - [cuda: Fix runtime compiler loading with old CUDA tookit](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7223)
 - [d3d11compositor, d3d12compositor: Fix transparent background mode with YUV output](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7185)
 - [d3d11converter: Fix runtime compiled shader code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7138)
 - [d3d12converter: Make gamma remap work as intended](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7080)
 - [h264decoder: Update output frame duration when second field frame is discarded](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7175)
 - [isac: Work around upstream having no shared library support for MSVC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7206)
 - [lc3: remove bitstream comparison in the tests](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7142)
 - [qroverlay: redraw overlay when caps changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7234)
 - [qsv: Fix critical warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7252)
 - [rtmp2: guard against calling gst_amf_node_get_type() with NULL](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7110)
 - [srtsrc: fix case fallthrough of authentication param](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7127)
 - [va: Blocklist unmaintained i965 driver for encoding](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7186)
 - [va: Fix strides when importing DMABUFs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7196)
 - [va: Fix dmabuf handle leaks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7245)
 - [vadisplay: fix minor version check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7169)
 - [vkh265dec: Fix H.264 ref in logs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7147)
 - [vulkan: fix wrong stages or access in barriers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7202)
 - [vtenc: Fix redistribute latency spam](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7098)
 - [waylandsink: Fix surface cropping for rotated streams](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7160)
 - [webrtcdsp: Enable multi_channel processing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7104)

#### gst-plugins-ugly

 - [asfdemux: Be more lenient towards malformed header, fixes playback of files written by VLC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7216)

#### GStreamer Rust plugins

- [audioloudnorm: Fix limiter buffer index wraparound off-by-one for the last buffer](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1650)
- [aws: s3hlssink: Do not call abort before finishing uploads](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1657)
- [gtk4paintablesink: Support RGBx formats in SW paths](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1661)
- [gtk4paintablesink: default to `force-aspect-ratio=false` for Paintable](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1656)
- [livesync: Use the actual output buffer duration of gap filler buffers](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1648)
- [livesync: Allow queueing up to latency buffers, also sync on the first buffer and add sync property](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1643)
- [webrtcsink: fix property types for `rav1enc` AV1 encoder](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1668)

#### gst-libav

 - [Fix compatibility with ffmpeg 7](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7148)
 - [avauddec: Fix crash on stop()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7184)
 - [avmux: Fix crash when muxer doesn't get codecid](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7222)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [ges: Various leak fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7120)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [validate: Remove G_REGEX_OPTIMIZE usage, helps avoid valgrind issues](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7113)

#### gst-examples

 - No changes

#### Development build environment

 - [libgudev wrap: add fallback uri](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7228)
 - [liblc3 wrap: update to v1.1.1](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7135)

#### Cerbero build tool and packaging changes in 1.24.6

 - [meson: Backport fix for Glib including a GCC-only flag in the pkg-config file](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1528)
 - [libsoup: Workaround build error with GCC 14](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1526)
 - [libltc: Fix Windows build](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1525)
 - [webrtc-audio-processing: Fix MinGW build](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1524)
 - [libvpx: Also build a shared lib on macOS](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1517)
 - [glib: Fix Windows build](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1509)
 - [osxrelocator: Fix framework entrypoints being unable to load dylibs](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1508)
 - [gobject-introspection, recipe: Fix more fallout from the Meson dylib ID fixes](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1499)
 - [cargo-c.recipe: Ensure that we can change the id and rpath](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1498)

#### Contributors to 1.24.6

Chris Spoelstra, Edward Hervey, François Laignel, Guillaume Desmottes,
Jakub Adam, Jan Schmidt, Jordan Petridis, L. E. Segovia, Loïc Yhuel,
Matthew Waters, Nirbheek Chauhan, Piotr Brzeziński, Robert Mader,
Ruben Gonzalez, Sanchayan Maity, Sebastian Dröge, Sebastian Gross,
Seungha Yang, Shengqi Yu, Taruntej Kanakamalla, Tim-Philipp Müller,
tomaszmi, Víctor Manuel Jáquez Leal,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.6

- [List of Merge Requests applied in 1.24.6](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.6)
- [List of Issues fixed in 1.24.6](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.6)

<a id="1.24.7"></a>

### 1.24.7

The seventh 1.24 bug-fix release (1.24.7) was released on 21 August 2024.

This release only contains bugfixes and it *should* be safe to update
from 1.24.x.

#### Highlighted bugfixes in 1.24.7

 - Fix APE and Musepack audio file and GIF playback with FFmpeg 7.0
 - playbin3: Fix potential deadlock with multiple playbin3s with glimagesink used in parallel
 - qt6: various qmlgl6src and qmlgl6sink fixes and improvements
 - rtspsrc: expose property to force usage of non-compliant setup URLs for RTSP servers where the automatic fallback doesn't work
 - urisourcebin: gapless playback and program switching fixes
 - v4l2: various fixes
 - va: Fix potential deadlock with multiple va elements used in parallel
 - meson: option to disable gst-full for static-library build configurations that do not need this
 - cerbero: libvpx updated to 1.14.1; map 2022Server to Windows11; disable rust variant on Linux if binutils is too old
 - Various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [bin: Don't keep the object lock while setting a GstContext when handling NEED_CONTEXT](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7310)
 - [core: Log pad name, not just the pointer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7336)

#### gst-plugins-base

 - [pbutils: descriptions: use subsampling factor to get YUV subsampling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7359)
 - [rtspconnection: Handle invalid argument properly](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7309)
 - [urisourcebin: Actually drop EOS on old-school pad switch](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7376)
 - [urisourcebin: Don't hold lock when emitting about-to-finish](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7373)
 - [gst-launch deadlock with two playbin3s](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3707)
 - [xvimagesink: Fix crash in pool on error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7292)

#### gst-plugins-good

 - [qmlgl6src: Fix crash when use-default-fbo is not set](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7344)
 - [qt6glwindow: Fallback to GL_RGB on CopyTexImage2D error, fixing usage with eglfs backend](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7345)
 - [qt6glwindow: Only use GL_READ_FRAMEBUFFER when we do blits](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7295)
 - [qt6: glwindow: Don't leak previously rendered buffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7289)
 - [rtspsrc: expose property for forcing usage of non-compliant URLs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7346)
 - [v4l2object: fix ARIB_STD_B67 colorimetry unmatch issue](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7369)
 - [v4l2: Fix colorimetry mismatch for encoded format with RGB color-matrix](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7284)

#### gst-plugins-bad

 - [aom: av1enc: restrict allowed input width and height](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7328)
 - [h264parse: bypass check for length_size_minus_one](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7358)
 - [h265parse: Reject FD received before SPS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7296)
 - [msdk: replace strcmp with g_strcmp0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7349)
 - [msdkvc1dec crashes (segfault)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3721)
 - [rsvgoverlay: add debug category](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7281)
 - [va: don't use GST_ELEMENT_WARNING in set_context() vmethod to fix potential deadlock](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7379)
 - [va: deadlock when playing two videos at once](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3706)
 - [webrtc: Add missing G_BEGIN/END_DECLS in header for C++](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7313)
 - [wpe: initialize threading.ready before reading it](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7385)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [gtk4: Move the dmabuf cfg to the correct bracket level](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1686)

#### gst-libav

 - [avdemux: Fix deadlock with FFmpeg 7.x when serialized events are received from upstream while opening, such as e.g. APE files with tags](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7367)
 - [libav: return EOF when stream is out of data](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7299)
 - [avdemux: Never return 0 from read function, which would lead to infinite loops](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7391)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

- [vaapi: Fix sps_max_dec_pic_buffering_minus1 value in h265 decoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7298)

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [nlecomposition: Don't leak QoS events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7280)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [validate: Fix copying of action name](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7334)

#### gst-examples

 - No changes

#### Development build environment

 - [Add a meson option to disable gst-full for static-library build configurations that do not need this](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7343)

#### Cerbero build tool and packaging changes in 1.24.7

 - [Disable rust variant on Linux if binutils is too old](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1546)
 - [Added 2022Server to the Windows platform distro map as Windows11](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1541)
 - [libvpx: Update to 1.14.1](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1543)

#### Contributors to 1.24.7

David Rosca, Edward Hervey, Guillaume Desmottes, Hou Qi, Jan Schmidt,
Jesper Jensen, Jordan Petridis, Jordan Yelloz, L. E. Segovia, Lyra McMillan,
Mathieu Duponchelle, Max Romanov, Nicolas Dufresne, Nirbheek Chauhan,
Qian Hu (胡骞), Sebastian Dröge, Tim-Philipp Müller, Víctor Manuel Jáquez Leal,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.7

- [List of Merge Requests applied in 1.24.7](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.7)
- [List of Issues fixed in 1.24.7](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.7)

<a id="1.24.8"></a>

### 1.24.8

The eigth 1.24 bug-fix release (1.24.8) was released on 19 September 2024.

This release only contains bugfixes and it *should* be safe to update
from 1.24.x.

#### Highlighted bugfixes in 1.24.8

 - decodebin3: collection handling fixes
 - encodebin: Fix pad removal (and smart rendering in gst-editing-services)
 - glimagesink: Fix cannot resize viewport when video size changed in caps
 - matroskamux, webmmux: fix firefox compatibility issue with Opus audio streams
 - mpegtsmux: Wait for data on all pads before deciding on a best pad unless timing out
 - splitmuxsink: Override LATENCY query to pretend to downstream that we're not live
 - video: QoS event handling improvements
 - voamrwbenc: fix list of bitrates
 - vtenc: Restart encoding session when certain errors are detected
 - wayland: Fix ABI break in WL context type name
 - webrtcbin: Prevent crash when attempting to set answer on invalid SDP
 - cerbero: ship vp8/vp9 software encoders again, which went missing in 1.24.7; ship transcode plugin
 - Various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [clock: Fix unchecked overflows in linear regression code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7431)
 - [meta: Add missing include of gststructure.h](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7525)
 - [pad: Check data NULL-ness when probes are stopped](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7506)
 - [aggregator: Immediately return NONE from simple_get_next_time() on non-TIME segments](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7514)

#### gst-plugins-base

 - [decodebin3: Fix collection identity check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7402)
 - [encodebin: Fix pad removal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7523)
 - [glimagesink: Fix cannot resize viewport when video size changed in caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7450)
 - [video: Don't overshoot QoS earliest time by a factor of 2](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7518)
 - [meson: gst-play: link to libm](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7501)

#### gst-plugins-good

 - [jackaudiosrc: actually use the queried ports from JACK](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7488)
 - [matroskamux: Include end padding in the block duration for Opus streams, fixing firefox compatibility](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7517)
 - [osxaudio: Avoid dangling pointer on shutdown](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7451)
 - [splitmuxsink: Override LATENCY query to pretend to downstream that we're not live](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7515)
 - [v4l2bufferpool: actually queue back the empty buffer flagged LAST](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7485)
 - [v4l2videoenc: unref buffer pool after usage properly](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7478)
 - [v4l2: encoder: Add dynamic framerate support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7545)

#### gst-plugins-bad

 - [GstPlay: Name the different bus](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7471)
 - [GstPlay: check whether stream is seekable before seeking when state change](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7448)
 - [GstPlayer: Check GstPlayerSignalDispatcher type](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7398)
 - [mpegtsmux: Wait for data on all pads before deciding on a best pad unless timing out](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7516)
 - [mpegtsmux: Fix refcounting issue when selecting the best pad](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7539)
 - [uvcsink: fix caps event handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7484)
 - [v4l2codecs: h265: Minimize memory allocation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7546)
 - [voamrwbenc: fix list of bitrates](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7418)
 - [vtenc: Restart encoding session when certain errors are detected](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7449)
 - [wayland: Fix ABI break in WL context type name](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7494)
 - [webrtcbin: Prevent crash when attempting to set answer on invalid SDP](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7436)
 - [wpe: fix gst-launch example](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7397)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - No changes

#### gst-libav

 - No changes

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [discoverer-manager: Fix race leading to assertion when stopping](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7467)
 - [structured-interface: Fix memory leak of invalid fields GList](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7440)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [pad-monitor: Fix remaining pad function data handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7491)
 - [pad-monitor: Fix pad function data properly](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7470)

#### gst-examples

 - No changes

#### Development build environment

 - [meson: Update openjpeg wrap to 2.5.2, fixes a warning](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7490)

#### Cerbero build tool and packaging changes in 1.24.8

 - [No vp8 / vp9 encoders packaged (regression)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3765)
 - [libvpx: Fix codec detection to fix vp8enc/vp9enc elements not being shipped](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1561)
 - [gst-plugins-bad: Add missing transcode plugin](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1557)

#### Contributors to 1.24.8

Andoni Morales Alastruey, Arun Raghavan, Benjamin Gaignard, Carlos Bentzen,
Chao Guo, Edward Hervey, Francis Quiers, Guillaume Desmottes, Hou Qi,
Jan Schmidt,, L. E. Segovia, Michael Tretter, Nicolas Dufresne,
Nirbheek Chauhan, Peter Kjellerstedt, Philippe Normand, Piotr Brzeziński,
Randy Li (ayaka), Sebastian Dröge, Thibault Saunier, Tim-Philipp Müller,
Wim Taymans,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.8

- [List of Merge Requests applied in 1.24.8](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.8)
- [List of Issues fixed in 1.24.8](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.8)

<a id="1.24.9"></a>

### 1.24.9

The ninth 1.24 bug-fix release (1.24.9) was released on 30 October 2024.

This release only contains bugfixes and a [security fix][sa-2024-0004] and
it *should* be safe to update from 1.24.x.

[sa-2024-0004]: https://gstreamer.freedesktop.org/security/sa-2024-0004.html

#### Highlighted bugfixes in 1.24.9

 - gst-rtsp-server [security fix][sa-2024-0004]
 - GstAggregator start time selection and latency query fixes for force-live mode
 - audioconvert: fix dynamic handling of mix matrix, and accept custom upstream event for setting one
 - encodebin: fix parser selection for encoders that support multiple codecs
 - flvmux improvments for pipelines where timestamps don't start at 0
 - glcontext: egl: Unrestrict the support base DRM formats
 - kms: Add IMX-DCSS auto-detection in sink and fix stride with planar formats in allocator
 - macOS main application event loop fixes
 - mpegtsdemux: Handle PTS/DTS wraparound with ignore-pcr=true
 - playbin3, decodebin3, parsebin, urisourcebin: fix races, and improve stability and stream-collection handling
 - rtpmanager: fix early RTCP SR generation for sparse streams like metadata
 - qml6glsrc: Reduce capture delay
 - qtdemux: fix parsing of rotation matrix with 180 degree rotation
 - rtpav1depay: added wait-for-keyframe and request-keyframe properties
 - srt: make work with newer libsrt versions and don't re-connect on authentication failure
 - v4l2 fixes and improvement
 - webrtcsink, webrtcbin and whepsrc fixes
 - cerbero: fix Python 3.13 compatibility, g-i with newer setuptools, bootstrap on Arch Linux; iOS build fixes
 - Ship qroverlay plugin in binary packages - Various bug fixes, memory leak fixes, and other stability and reliability improvements
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [aggregator: fix start time selection first with force-live](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7778)
 - [aggregator: fix live query when force-live is TRUE](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7723)
 - [parse-launch: Make sure children are bins before recursing in](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7561)
 - [macos: Fix race conditions in cocoa/application main event loop](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7608)
 - [multiqueue: Do not unref the query we get in pad->query](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7796)

#### gst-plugins-base

 - [audioconvert: fix dynamic handling of mix matrix, accept custom upstream event for setting one](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7399)
 - [playback: Fix a variety of decodebin3/parsebin/urisourcebin races](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7682)
 - [playbin3: prevent crashing trying to play a corrupted mp4 file (WARNING : HIGH PITCHED CORRUPTED SOUND)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7605)
 - [urisourcebin: Ensure all stream-start are handled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7604)
 - [urisourcebin: Allow more cases for posting stream-collection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7603)
 - [decodebin3: Make update/posting of collection messages atomic](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7602)
 - [decodebin3: send selected stream message as long as not all the tracks can't select decoders](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7601)
 - [urisourcebin/parsebin: Improve collection creation and handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7764)
 - [encodebasebin: Miscellaneous fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7756)
 - [allocators: drmdumb: Fix bpp value for P010](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7596)
 - [gldownload: use gst_gl_sync_meta_wait_cpu()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7595)
 - [Revert "meson: Fix invalid include flag in uninstalled gl pc file"](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7606)
 - [gl: Fix configure error when libdrm is a subproject](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7761)
 - [glcontext: egl: Unrestrict the support base DRM formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7699)
 - [exiftag: Check the result of gst_date_time_new_local_time(), fixes criticals with malformed EXIF tags](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7713)

#### gst-plugins-good

 - [flvmux: Use first running time on the initial header instead of 0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7798)
 - [rtpmanager: skip RTPSources which are not ready in the RTCP generation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7777)
 - [rtppassthroughpay: Fix reading clock-rate and payload type from caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7552)
 - [qml6glsrc: Reduce capture delay](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7562)
 - [qtdemux: fix parsing of matrix with 180 rotation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7665)
 - [qtdemux: Check fourcc of a second CEA608 atom instead of assuming it's cdt2](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7583)
 - [qtdemux: Skip zero-sized boxes instead of stopping to look at further boxes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7565)
 - [twcc: Handle wrapping of reference time](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7792)
 - [v4l2object: append non colorimetry structure to probed caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7570)
 - [v4l2: Various fixes and improvement](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7563)

#### gst-plugins-bad

 - [avfdeviceprovider: Fix leak from the GstCaps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7577)
 - [codecparsers: add debug categories to bitwriters](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7667)
 - [codectimestamper: Fix gint wraparound in pts_compare_func](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7737)
 - [dvxa: Explicitly use cpp_std=c++11](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7661)
 - [GstPlay: message parsing and documentation improvements](https://gitlab.freedesktop.org/7779/gstreamer/-/gstreamer_merge/requests)
 - [h26xbitwriter: false have_space if aligning fails on aud](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7697)
 - [kmsallocator: fix stride with planar formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7571)
 - [kmssink: Add IMX-DCSS auto-detection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7695)
 - [mpegtsdemux: Handle PTS/DTS wraparound with ignore-pcr=true](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7763)
 - [rtmp2sink: Initialize base_ts / last_ts with the actual first observed timestamp](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7786)
 - [scenechange: fix memory leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7666)
 - [srtsink: Register SRT listen callback before binding socket](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7687)
 - [srt: Don't attempt to reconnect on authentication failures](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7797)
 - [tests: va: fix vapostproc test for DMABuf](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7654)
 - [tests: lc3: Allocate the same size for the buffer and the data](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7640)
 - [va: Fix libdrm include, plus meson and wrap changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7760)
 - [vaav1enc: Do not enable palette mode by default](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7696)
 - [vp8decoder: Fix resolution change handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7787)
 - [vtdec: add support for level 6 6.1 and 6.2](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7735)
 - [wayland: Add NV15 support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7789)
 - [webrtcbin: Clean up bin elements when datachannel is removed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7791)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

- [Build: turn lto off for dev profile for faster dev builds](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1817)
- [fmp4 hls_live example: Don't set header-update-mode=update, no need to update the header in live mode](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1802)
- [gtk4paintablesink: Don't check for a GL context when filtering dmabuf caps](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1842)
- [livesync: Log latency query results when handling latency query too](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1786)
- [onvifmetadatapay: Set output caps earlier, so upstream can send gap events earlier](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1787)
- [rtpav1depay: Add wait-for-keyframe and request-keyframe properties](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1824)
- [spotify: tweak dependencies](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1821)
- [transcriberbin: fix panic during gst-inspect-1.0 -u](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1783)
- [webrtcsink: fix segment format mismatch with remote offer](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1786)
- [webrtcsink: fix assertions when finalizing](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1784)
- [webrtcsink: Fix typo in "turn-servers" property description](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1780)
- [whepsrc: Fix incorrect default caps](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1782)

#### gst-libav

 - [avviddec: Unlock video decoder stream lock temporarily while finishing frames](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7584)

#### gst-rtsp-server

 - [rtsp-server: Remove pointless assertions that can happen if client provides invalid rates (security fix)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7738)

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [ges: Fix name of GESFrameCompositionMeta API type (which caused gobject-introspection failures at build time)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7556)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [validate: Ignore flaky dash playbin3 issue](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7734)
 - [validate: Blacklist more netsim tests](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7751)

#### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.24.9

 - [Fix Python 3.13 compatibility](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1586)
 - [gobject-introspection: Import patch to build against newer setuptools](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1580)
 - [Switch from wget to curl on Fedora 40 and newer](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1591)
 - [bootstrap: Add missing dependencies on Arch Linux](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1594)
 - [harfbuzz: Add CXXFLAGS to fix broken build on iOS](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1605)
 - [openssl.recipe: Stop using non-existent domain in primary tarball url](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1585)
 - [gst-plugins-bad: ship qroverlay plugin](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1575)

#### Contributors to 1.24.9

Andoni Morales Alastruey, Arun Raghavan, Benjamin Gaignard, Corentin Damman,
Dave Lucia, Edward Hervey, Elliot Chen, eri, Francisco Javier Velázquez-García,
Guillaume Desmottes, He Junyan, Hugues Fruchet, Jakub Adam, James Cowgill,
Jan Alexander Steffens (heftig), Jan Schmidt, Johan Sternerup, Jordan Petridis,
L. E. Segovia, Mathieu Duponchelle, Nick Steel, Nicolas Dufresne,
Nirbheek Chauhan, Ognyan Tonchev, Olivier Crête, Peter Stensson,
Philippe Normand, Piotr Brzeziński, Sanchayan Maity, Sebastian Dröge,
Shengqi Yu, Stéphane Cerveau, Théo Maillart, Thibault Saunier,
Tim-Philipp Müller, Víctor Manuel Jáquez Leal, Weijian Pan, Xavier Claessens,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.9

- [List of Merge Requests applied in 1.24.9](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.9)
- [List of Issues fixed in 1.24.9](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.9)

<a id="1.24.10"></a>

### 1.24.10

The tenth 1.24 bug-fix release (1.24.10) was released on 03 December 2024.

This release only contains bugfixes and [security fixes][security-overview].
It *should* be safe to update from 1.24.x and we would recommend you update
at your earliest convenience.

[security-overview]: https://gstreamer.freedesktop.org/security/

#### Highlighted bugfixes in 1.24.10

 - [More than 40 security fixes][security-overview] across a wide range of
   elements following an audit by the GitHub Security Lab, including the MP4,
   Matroska, Ogg and WAV demuxers, subtitle parsers, image decoders, audio
   decoders and the id3v2 tag parser.
 - avviddec: Fix regression that could trigger assertions about width/height mismatches
 - appsink and appsrc fixes
 - closed caption handling fixes
 - decodebin3 and urisourcebin fixes
 - glupload: dmabuf: Fix emulated tiled import
 - level: fix LevelMeta values outside of the stated range
 - mpegtsmux, flvmux: fix potential busy looping with high cpu usage in live mode
 - pipeline dot file graph generation improvements
 - qt(6): fix criticals with multiple qml(6)gl{src,sink}
 - rtspsrc: Optionally timestamp RTP packets with their receive times in TCP/HTTP mode to enable clock drift handling
 - splitmuxsrc: reduce number of file descriptors used
 - systemclock: locking order fixes
 - v4l2: fix possible v4l2videodec deadlock on shutdown; 8-bit bayer format fixes
 - x265: Fix build with libx265 version >= 4.1 after masteringDisplayColorVolume API change
 - macOS: fix rendering artifacts in retina displays, plus ptp clock fixes
 - cargo: Default to thin lto for the release profile (for faster builds with lower memory requirements)
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements
 - Translation updates

#### gstreamer

 - [allocator: Avoid integer overflow when allocating sysmem and avoid integer overflow in qtdemux theora extension parsing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8044)
 - [deviceprovider: fix leaking hidden providers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7915)
 - [gstreamer: prefix debug dot node names to prevent splitting](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7998)
 - [pad: Never push sticky events in response to a FLUSH_STOP](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8003)
 - [systemclock: Fix lock order violation and some cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8019)
 - [utils: improve gst_util_ceil_log2()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7905)
 - [ptp: use ip_mreq instead of ip_mreqn for macos](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7864)
 - [tracers: unlock leaks tracer if already tracking](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7960)

#### gst-plugins-base

 - [appsink: fix timeout logic for gst_app_sink_try_pull_sample()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7980)
 - [appsrc: Fix use-after-free when making buffer / buffer-lists writable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7806)
 - [audiostreamalign: Don't report disconts for every buffer if alignment-threshold is too small](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7906)
 - [decodebin3: Unify collection switching checks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7956)
 - [discoverer: Don't print channel layout for more than 64 channels](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8046)
 - [discoverer: Make sure the missing elements details array is NULL-terminated in a thread-safe way](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7986)
 - [discoverer: fix segfault in race condition adding a new uri](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7934)
 - [id3v2: Don't try parsing extended header if not enough data is available](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8045)
 - [glupload: dmabuf: Fix emulated tiled import](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7907)
 - [gl: cocoa: fix rendering artifacts in retina displays](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7834)
 - [gl: meson: Don't use libdrm_dep in cc.has_header()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7932)
 - [oggstream: fix invalid ogg_packet->packet accesses, address invalid writes CVE](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8050)
 - [opusdec: Set at most 64 channels to NONE position](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8049)
 - [playbin: Fix caps leak in get_n_common_capsfeatures()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7909)
 - [playbin3: ERROR when setting new HLS URI with instant-uri=true](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3957)
 - [sdp: Add debug categories for message and mikey modules](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7926)
 - [ssaparse: Search for closing brace after opening brace](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8048)
 - [splitmuxsrc: Convert part reader to a bin with a non-async bus](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7957)
 - [subparse: Check for NULL return of strchr() when parsing LRC subtitles](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8051)
 - [streamsynchronizer: Only send GAP events out of source pads](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7997)
 - [urisourcebin: Also use event probe for HLS use-cases](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7857)
 - [video-converter: Set TIME segment format on appsrc](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7842)
 - [vorbisdec: Set at most 64 channels to NONE position](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8047)
 - [Translation for gst-plugins-base 1.24.0 not sync-ed with Translation Project](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3940)
 - [Update translations](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7820)

#### gst-plugins-good

 - [avisubtitle: Fix size checks and avoid overflows when checking sizes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8055)
 - [flvmux: Don't time out in live mode if no timestamped next buffer is available](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7902)
 - [gdkpixbufdec: Check if initializing the video info actually succeeded](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8053)
 - [jpegdec: Directly error out on negotiation failures](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8052)
 - [level: Fix integer overflow when filling LevelMeta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8029)
 - [level: produces level value outside of Stated Range](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4068)
 - [matroskademux: header parsing fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8058)
 - [qtdemux: header and sample table parsing fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8060)
 - [qtdemux: avoid integer overflow in theora extension parsing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8044)
 - [qt(6)/material: ensure that we always update the context in setBuffer()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7978)
 - [rtspsrc: Optionally timestamp RTP packets with their receive times in TCP/HTTP mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8004)
 - [rtp: Fix precision loss in gst_rtcp_ntp_to_unix()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8022)
 - [rtpfunnel: Ensure segment events are forwarded after flushs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7835)
 - [rtpmanager: don't map READWRITE in twcc header ext](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7910)
 - [rtph264depay, rtph265depay: Fix various OOB reads / NULL pointer dereferences in parameter-set string handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7812)
 - [shout2send: Unref event at the end of the event function](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8006)
 - [udpsrc: protect cancellable from unlock/unlock_stop race](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7897)
 - [v4l2object: Fixed incorrect maximum value for int range](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7961)
 - [v4l2object: Remove little endian marker on 8 bit bayer format names](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7845)
 - [v4l2videodec: fix freeze race condition](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7987)
 - [wavparse: Fix various (missing) size checks and other parsing problems](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8054)

#### gst-plugins-bad

 - [ccconverter: Don't override in_fps_entry when trying to take output](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7862)
 - [ccutils fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7973)
 - [kmssink: Add mediatek auto-detection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8027)
 - [mpegtsmux: Don't time out in live mode if no timestamped next buffer is available (fixes busy loop with high cpu usage)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7901)
 - [mpegvideoparse: do not set delta unit flag on unknown frame type](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7876)
 - [mxfmux: Fix off-by-one in the month when generating a timestamp for now](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8018)
 - [timecodestamper: Don't fail the latency query in LTC mode if we have no framerate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7846)
 - [webrtc: don't crash on invalid bundle id](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7966)
 - [x265: Allow building with x265-4.1 (after masteringDisplayColorVolume API change)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7983)
 - [meson: Don't unconditionally invoke the libsoup subproject for tests](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7982)


#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

- cargo: Default to thin lto for the release profile (for faster builds with lower memory requirements)

#### gst-libav

 - [avcodecmap: Use avcodec_get_supported_config() instead of struct fields](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7833)
 - [libav: viddec: provide details if meta has the wrong resolution](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7925)
 - [avviddec: Unlock video decoder stream lock temporarily while finishing frames](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7921)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - No changes

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [validate: Fix leaks in ssim components](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7802)

#### gst-examples

 - No changes

#### Development build environment

 - [meson: Fix failing libva wrap file build](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7955)

#### Cerbero build tool and packaging changes in 1.24.10

 - [shell: fix TemporaryDirectory error with the with statement when ZSH](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1638)
 - [ci: update macos CI to 15 Sequoia](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1623)

#### Contributors to 1.24.10

Albert Sjolund, Alicia Boya García, Andoni Morales Alastruey, Antonio Morales,
Edward Hervey, Guillaume Desmottes, Jan Alexander Steffens (heftig),
Jan Schmidt, Jonas Rebmann, Jordan Petridis, Mathieu Duponchelle,
Matthew Waters, Nicolas Dufresne, Nirbheek Chauhan, Pablo Sun, Philippe Normand,
Robert Rosengren, Ruben Gonzalez, Sebastian Dröge, Seungmin Kim,
Stefan Riedmüller, Stéphane Cerveau, Taruntej Kanakamalla, Théo Maillart,
Thibault Saunier, Tim-Philipp Müller, Tomáš Polomský, Wilhelm Bartel, Xi Ruoyao,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.10

- [List of Merge Requests applied in 1.24.10](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.10)
- [List of Issues fixed in 1.24.10](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.10)

<a id="1.24.11"></a>

### 1.24.11

The eleventh 1.24 bug-fix release (1.24.11) was released on 06 January 2025.

This release only contains bugfixes and it *should* be safe to update from
1.24.x.

#### Highlighted bugfixes in 1.24.11

 - playback: Fix SSA/ASS subtitles with embedded fonts
 - decklink: add missing video modes and fix 8K video modes
 - matroskamux: spec compliance fixes for audio-only files
 - onnx: disable onnxruntime telemetry
 - qtdemux: Fix base offset update when doing segment seeks
 - srtpdec: Fix a use-after-free issue
 - (uri)decodebin3: Fix stream change scenarios, possible deadlock on shutdown
 - video: fix missing alpha flag in AV12 format description
 - avcodecmap: Add some more channel position mappings
 - cerbero bootstrap fixes for Windows 11
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - No changes

#### gst-plugins-base

 - [appsrc: Decrease log level for item drop](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8151)
 - [gl: raise WARNING instead of ERROR when no connector is connected](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8139)
 - [decodebin3: Free main input even if it is not part of the list of inputs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8232)
 - [urisourcebin: Avoid deadlock on shutdown](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8187)
 - [urisourcebin: Only rewrite stream-start event once](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8144)
 - [urisourcebin/(uri)decodebin3: Fix stream change scenarios](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8119)
 - [urisourcebin: Reference counting leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4088)
 - [playbin3: leak detected with A/V playback and window closed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4042)
 - [videodecoder: Gracefully handle missing data without prior input segment](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8206)
 - [videodecoder: set decode only flag by decode only buffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8148)
 - [video: fix AV12 format lacking the GST_VIDEO_FORMAT_FLAG_ALPHA flag.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8084)
 - [Fix SSA/ASS subtitles with embedded fonts](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4097)

#### gst-plugins-good

 - [matroskamux: Fix audio-only stream conditions and consider audio buffers as keyframes when writing out simpleblocks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8246)
 - [qtdemux: fix accumulated base offset in segment seeks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8244)
 - [rtppassthroughpay: ensure buffer is writable before mapping writable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8137)
 - [rtpsession: Fix twcc stats structure leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8115)
 - [v4l2: object: Add P010 format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8197)
 - [v4l2videodec: release decode only frame in input list](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8247)

#### gst-plugins-bad

 - [decklink: add missing video modes, fix 8K video modes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8122)
 - [onnx: disable onnxruntime telemetry](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8106)
 - [srtpdec: fix build when libsrtp1 is being used](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8207)
 - [srtpdec: Fix a use-after-free buffer issue](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8201)
 - [va: display: Optimize out some property indirection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8181)
 - [vp9parse/av1parse: Add video codec tag to the tag list](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8186)
 - [webrtc: Simplify fmtp handling in codec stats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8130)
 - [webrtcbin: Fix potential deadlock on bin elements cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8165)
 - [zxing: Replace deprecated DecodeHints with ReaderOptions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8085)
 - [meson: Also disable drm on GNU/Hurd](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8228)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - No changes

#### gst-libav

 - [avcodecmap: Add some more channel position mappings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8175)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - [meson: Re-added required: lines accidentally removed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8243)

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [ges: Fix some reference counting and error handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8161)
 - [ges-meta-container: Fix the GET_INTERFACE macro](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8150)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - No changes

#### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.24.11

 - [Fix bootstrap on Windows 11: Install WMIC when missing](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1665)

#### Contributors to 1.24.11

Armin Begovic, Benjamin Gräf, Cheung Yik Pang, Christian Meissl,
Daniel Morin, Dean Zhang (张安迪), Edward Hervey, Emil Ljungdahl,
Francisco Javier Velázquez-García, Guillaume Desmottes,
Jan Alexander Steffens (heftig), L. E. Segovia, Matthew Waters, Max Romanov,
Nicolas Dufresne, Philippe Normand, Robert Mader, Samuel Thibault,
Sebastian Dröge, Stéphane Cerveau, Thibault Saunier, Tim-Philipp Müller,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.11

- [List of Merge Requests applied in 1.24.11](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.11)
- [List of Issues fixed in 1.24.11](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.11)

<a id="1.24.12"></a>

### 1.24.12

The twelfth 1.24 bug-fix release (1.24.12) was released on 29 January 2025.

This release only contains bugfixes and it *should* be safe to update from
1.24.x.

#### Highlighted bugfixes in 1.24.12

 - d3d12: Fix shaders failing to compile with newer dxc versions
 - decklinkvideosink: Fix handling of caps framerate in auto mode; also a decklinkaudiosink fix
 - devicemonitor: Fix potential crash macOS when a device is unplugged
 - gst-libav: Fix crash in audio encoders like avenc_ac3 if input data has insufficient alignment
 - gst-libav: Fix build against FFmpeg 4.2 as in Ubuntu 20.04
 - gst-editing-services: Fix Python library name fetching on Windows
 - netclientclock: Don't store failed internal clocks in the cache, so applications can re-try later
 - oggdemux: Seeking and duration handling fixes
 - osxaudiosrc: Fixes for failing init/no output on recent iOS versions
 - qtdemux: Use mvhd transform matrix and support for flipping
 - rtpvp9pay: Fix profile parsing
 - splitmuxsrc: Fix use with decodebin3 which would occasionally fail with an assertion when seeking
 - tsdemux: Fix backwards PTS wraparound detection with ignore-pcr=true
 - video-overlay-composition: Declare the video/size/orientation tags for the meta and implement scale transformations
 - vtdec: Fix seeks occasionally hanging on macOS due to a race condition when draining
 - webrtc: Fix duplicate payload types with RTX and multiple video codecs
 - win32-pluginloader: Make sure not to create any windows when inspecting plugins
 - wpe: Various fixes for re-negotiation, latency reporting, progress messages on startup
 - x264enc: Add missing data to AvcDecoderConfigurationRecord in codec_data for high profile variants
 - cerbero: Support using ccache with cmake if enabled
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [device: Fix racy nullptr deref on macOS when a device is unplugged](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8323)
 - [iterator: Added error handling to filtered iterators](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8370)
 - [netclientclock: Don't ever store failed internal clocks in the cache](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8364)
 - [netclock-replay: use gst_c_args when building, fixing build failure on Solaris](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8264)
 - [pluginloader-win32: create no window](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8357)
 - [pluginloader-win32: fix use after free in find_helper_bin_location](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8356)
 - [sparsefile: ensure error is set when read_buffer() returns 0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8331)
 - [basetransform: fix incorrect logging inside gst_base_transform_query_caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8289)

#### gst-plugins-base

 - [oggdemux: fixes seeking in some cases by not overwriting a valid duration with CLOCK_TIME_NONE](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8368)
 - [video-overlay-composition: Declare the video/size/orientation tags for the meta & implement scale transformation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8344)
 - [Various fixes found from adding extra warning flags](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8293)

#### gst-plugins-good

 - [osxaudiosrc: Fixes for failing init/no output on recent iOS versions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8263)
 - [qtdemux: Use mvhd transform matrix and support for flipping](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8276)
 - [qtmux: fix critical warnings on negotiation error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8377)
 - [rtpvp9pay: fix profile parsing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8283)
 - [splitmuxsrc: Ensure only a single stream-start event is pushed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8284)
 - [splitmuxsrc: decodebin3 Fails with assertion in mq_slot_handle_stream_start when seeking](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4146)
 - [Various fixes found from adding extra warning flags](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8293)

#### gst-plugins-bad

 - [decklinkvideosink: Fix handling of caps framerate in auto mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8306)
 - [decklinkaudiosink: Don't crash if started without corresponding video sink](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8291)
 - [d3d12: Fix shaders failing to compile with newer dxc versions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8274)
 - [tsdemux: Fix backwards PTS wraparound detection with ignore-pcr=true](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8332)
 - [vtdec: fix seeks hangs due to a race condition draining](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8361)
 - [vtdec: seeks freeze the pipeline](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4179)
 - [wayland: Print table split when DMABuf format changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8277)
 - [webrtc: fix duplicate payload types with RTX and multiple video codecs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8294)
 - [wpevideosrc: Clear cached SHM buffers after caps re-negotiation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8266)
 - [wpe: Report latency and start-up progress messages](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8265)
 - [wpe: remove glFlush() when filling buffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8355)
 - [Fix build with gtk3 but not wayland](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8260)
 - [Various fixes found from adding extra warning flags](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8293)

#### gst-plugins-ugly

 - [x264enc: add missing data to AvcDecoderConfigurationRecord, and switch to GstByteWriter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8360)

#### GStreamer Rust plugins

 - No changes

#### gst-libav

 - [avaudenc: fix crash in avenc_ac3 if input buffers are insufficiently aligned](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8322)
 - [avcodecmap: Only use new channel positions when compiling against new enough ffmpeg](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8301)
 - [gst-libav: 1.24.11: Fails to build with minimum supported ffmpeg version](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4163)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [ges: Fix Python library name fetching on Windows](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8278)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - No changes

#### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.24.12

 - [cmake: Support using ccache if enabled](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1698)

#### Contributors to 1.24.12

Adrian Perez de Castro, Alan Coopersmith, Alexander Slobodeniuk,
Andoni Morales Alastruey, Andrew Yooeun Chun, Brad Hards, Carlos Bentzen,
Colin Kinloch, Edward Hervey, François Laignel, Guillaume Desmottes,
Jochen Henneberg, Jordan Yelloz, L. E. Segovia, Monty C, Nirbheek Chauhan,
Philippe Normand, Piotr Brzeziński, Rares Branici, Samuel Thibault,
Sebastian Dröge, Silvio Lazzeretti, Tim-Philipp Müller, Tomas Granath,
Will Miller,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.12

- [List of Merge Requests applied in 1.24.12](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.12)
- [List of Issues fixed in 1.24.12](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.12)

<a id="1.24.13"></a>

### 1.24.13

The thirteenth, and most likely final, 1.24 bug-fix release (1.24.13) was released on 11 June 2025.

This release only contains bugfixes as well as a number of [security fixes][security]
and it *should* be safe to update from 1.24.x.

The 1.24 stable series is no longer actively maintained and has been
superseded by the [GStreamer 1.26 stable series][gstreamer-1.26] now.

#### Highlighted bugfixes in 1.24.13

 - Various security fixes and playback fixes
 - MP4 demuxer atom parsing improvements and security fixes
 - H.265 decoder base class and caption inserter SPS/PPS handling fixes
 - Subtitle parser security fixes
 - Subtitle rendering and seeking fixes
 - Closed caption fixes
 - Matroska rotation tag support and v4 muxing support
 - Ogg seeking improvements in streaming mode
 - Windows plugin loading fixes
 - MIDI parser improvements for tempo changes
 - Video time code support for 119.88 fps and drop-frames-related conversion fixes
 - GStreamer editing services fixes for sources with non-1:1 aspect ratios
 - RTP session handling and RTSP server fixes
 - Thread-safety improvements for the Media Source Extension (MSE) library
 - macOS video capture improvements for external devices
 - Python bindings: Fix compatibility with PyGObject >= 3.52.0
 - cerbero: bootstrapping fixes on Windows, improved support for RHEL, and openh264 recipe update
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [Correctly handle whitespace paths when executing gst-plugin-scanner](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8722)
 - [buffer: Mark gst_buffer_extract() size parameter as in-parameter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8508)
 - [element: ref-sink the correct pad template when replacing an existing one](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9001)
 - [gstvalue: fix a couple of leaks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8527)
 - [pipeline: Store the actual latency even if no static latency was configured](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9009)
 - [pluginloader-win32: Fix helper executable path under devenv](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8762)
 - [pluginloader-win32: create no window](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8421)
 - [pluginloader: fix pending_plugins Glist use-after-free issue](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8850)

#### gst-plugins-base

 - [alsadeviceprovider: Fix leak of Alsa longname](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8635)
 - [appsink: fix initial pile-up of caps events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8261)
 - [audiobasesink: Fix custom slaving driftsamples calculation  and add custom audio clock slaving callback example](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8810)
 - [convertframe: Fix video crop meta handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8528)
 - [decodebin3: Don't avoid `parsebin` even if we have a matching decoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8645)
 - [gl: Implement basetransform meta transform function](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9048)
 - [glupload: Fix for wrongly recognized reconfigure condition](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8497)
 - [gstaudioutilsprivate: Fix gcc 15 compiler error with function pointer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8911)
 - [mikey: Avoid infinite loop while parsing MIKEY payload with unhandled payload types](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8948)
 - [oggdemux: Don't push new packets if there is a pending seek](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8835)
 - [oggdemux: Fix racy decode error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8411)
 - [pitch, playbin3: fix build error and wrong locking](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8575)
 - [smartencoder: Don't assert if the caps have unknown chroma-site](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8467)
 - [subparse: various subtitle text parsing fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9145)
 - [textoverlay: fix shading for RGBx / RGBA pixel format variants](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9113)
 - [uridecodebin3: Don't hold play items lock while activating source items](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8509)
 - [urisourcebin: Make parsebin activation more reliable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8623)
 - [videoconvertscale: Explicitly handle overlaycomposition meta caps feature](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8482)
 - [videoencoder: Use the correct segment and buffer timestamp in the chain function](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8844)
 - [videotimecode: Fix conversion of timecode to datetime with drop-frame timecodes and handle 119.88 fps correctly in all places](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8723)

#### gst-plugins-good

 - [adaptivedemux2: free cancellable when freeing transfer task](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9196)
 - [gl: Implement basetransform meta transform function](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9048)
 - [interleave: Don't hold object lock while querying caps downstream](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8935)
 - [Matroska mux v4 support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8733)
 - [matroska-demux: Prevent corrupt cluster duplication](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8858)
 - [matroska: Implement rotation tag support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8422)
 - [qtdemux: Check length of JPEG2000 colr box before parsing it](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8936)
 - [qtdemux: Fix stsc size check in qtdemux_merge_sample_table()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8720)
 - [qtdemux: Ignore non-zero values for UV/XY in transformation matrix](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8565)
 - [qtdemux: Use byte reader to parse mvhd box](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9144)
 - [qtdemux: unref simple caps after use](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8881)
 - [qtmux: Implement rotation tag support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8384)
 - [rtph264pay: Reject stream-format=avc without codec_data](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8960)
 - [rtpmanager: skip RTPSources if last_rtime is not set yet](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8471)
 - [rtpsession: Do not push events while holding SESSION_LOCK](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8782)
 - [v4l2: bufferpool: Fix buffer state after group release](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8462)
 - [wavparse: Ignore EOS when parsing the headers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8987)
 - [y4menc: handle frames with GstVideoMeta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8725)

#### gst-plugins-bad

 - [alphacombine: De-couple flush-start/stop events handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8634)
 - [analytics: objectdetectionoverlay: improve event handling for EOS and flush events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8580)
 - [avfvideosrc: Guess reasonable framerate values for some 3rd party devices](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8757)
 - [avtpsrc: Use GSocket to have cancellable wait](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8574)
 - [bayer2rgb: Fix RGB stride calculation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9164)
 - [cccombiner: Fix critical warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8495)
 - [cccombiner: Fix wrong caps and buffer ordering](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8477)
 - [dashsink: Make sure to use a non-NULL pad name when requesting a pad from splitmuxsink](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8724)
 - [docs: Do not try to generate cuda documentation when gir is not generated](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8383)
 - [h264parse: Force full timestamp on all timecode updates. Was invalid between midnight and 1am](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8401)
 - [h265decoder,h265ccinserter: Fix broken SPS/PPS link](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8727)
 - [h265parser: Fix num_long_term_pics bound check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8895)
 - [mediafoundation: Fix memory leak and codec profile check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8410)
 - [meson: fix building -bad tests with disabled soundtouch](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9193)
 - [midiparse: Consider tempo changes when calculating duration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8920)
 - [mpegts: Fix PCR Discontinuity handling for HLS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8481)
 - [mpegts: Take into account adaptation field discont](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8453)
 - [mpegtsdescriptor: Add (transfer none) annotation to out parameter of parse_registration()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8386)
 - [mpegtsmux: Fix deadlock when requesting pad for PID < 0x40](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8468)
 - [mse: Improved Thread Safety of API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8758)
 - [pitch, playbin3: fix build error and wrong locking](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8575)
 - [uvcgadget: Properly implement GET_INFO control responses](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8602)
 - [vacompositor: Add missing GST_VIDEO_CROP_META_API_TYPE](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8609)
 - [webrtc: fix pkg-config missing sdp dependency](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8439)
 - [webrtc: fix recursive G_BEGIN_DECLS and include missing sctptransport.h in webrtc.h](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8474)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [cargo: Default to thin lto for the release profile](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1924)
 - [webrtc: Require livekit-protocol < 0.3.4 due to uncoordinated breaking changes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2089)
 - [cargo_wrapper: Force log file to be written in utf-8](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2114)

#### gst-libav

 - [Only allocate extradata while decoding](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9112)

#### gst-rtsp-server

 - [Media: Fix locking in gst_rtsp_media_get_dscp_qos()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8553)
 - [Initial RTCP SR may contain incorrect RTP timestamp for streams with "irregular" frame rate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3918)

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - [Fix compatibility with PyGObject>=3.52.0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8721)

#### gst-editing-services

 - [Fix frame position for sources with par < 1](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8896)
 - [Fix video position for sources with pixel-aspect-ratio > 1](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8898)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - No changes

#### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.24.13

 - [Improve support for RHEL based distros](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1666)
 - [Various fixes for bootstrapping and building on Windows](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1802)
 - [Force-build our own cmake if it's too new](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1793)
 - [cdparanoia: configure.guess updated to the latest available version](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1702)
 - [m4.recipe: Fix build on Fedora 42](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1798)
 - [openh264: bump to 2.6.0 (1.24 branch)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1726)

#### Contributors to 1.24.13

Andoni Morales Alastruey, Biswapriyo Nath, Carlo Caione, Carlos Rafael Giani,
Corentin Damman, David Smitmanis, Denis Yuji Shimizu, Dongyun Seo, Doug Nazar,
Edward Hervey, Eli Mallon, eri, Gang Zhao, Glyn Davies, Guillaume Desmottes,
Jakub Adam, Jan Schmidt, Jochen Henneberg, Jordan Petridis, Jordan Yelloz,
Mart Raudsepp, Matteo Bruni, Nirbheek Chauhan, Ognyan Tonchev, Olivier Blin,
Olivier Crête, Philippe Normand, Piotr Brzeziński, Robert Mader, Ruben Gonzalez,
Sebastian Dröge, Sergey Radionov, Seungha Yang, Shengqi Yu (喻盛琪),
Stefan Andersson, Thibault Saunier, Tim-Philipp Müller,
Víctor Manuel Jáquez Leal, Wilhelm Bartel,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.24.13

- [List of Merge Requests applied in 1.24.13](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.24.13)
- [List of Issues fixed in 1.24.13](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.24.13)

## Schedule for 1.26

[GStreamer 1.26][gstreamer-1.26] was released on 29 May 2025.

- - -

*These release notes have been prepared by Tim-Philipp Müller with contributions from Edward Hervey, Matthew Waters, Nicolas Dufresne, Nirbheek Chauhan, Olivier Crête, Sebastian Dröge, Seungha Yang, Thibault Saunier, and Víctor Manuel Jáquez Leal.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
