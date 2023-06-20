# GStreamer 1.22 Release Notes

GStreamer 1.22.0 was originally released on 23 January 2023.

The latest bug-fix release in the stable 1.22 series is [1.22.4](#1.22.4) and was released on 20 June 2023.

See [https://gstreamer.freedesktop.org/releases/1.22/][latest] for the latest version of this document.

*Last updated: Tuesday 20 June 2023, 16:30 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.22/
[gitlog]: https://gitlab.freedesktop.org/gstreamer/www/commits/main/src/htdocs/releases/1.22/release-notes-1.22.md

## Introduction

The GStreamer team is proud to announce a new major feature release in the stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with many new features, bug fixes and other improvements.

## Highlights

 - AV1 video codec support improvements
 - New HLS, DASH and Microsoft Smooth Streaming adaptive streaming clients
 - Qt6 support for rendering video inside a QML scene
 - Minimal builds optimised for binary size, including only the individual elements needed
 - Playbin3, Decodebin3, UriDecodebin3, Parsebin enhancements and stabilisation
 - WebRTC simulcast support and support for Google Congestion Control
 - WebRTC-based media server ingestion/egress (WHIP/WHEP) support
 - New easy to use batteries-included WebRTC sender plugin
 - Easy RTP sender timestamp reconstruction for RTP and RTSP
 - ONVIF timed metadata support
 - New fragmented MP4 muxer and non-fragmented MP4 muxer
 - New plugins for Amazon AWS storage and audio transcription services
 - New gtk4paintablesink and gtkwaylandsink renderers
 - New videocolorscale element that can convert and scale in one go for better performance
 - High bit-depth video improvements
 - Touchscreen event support in navigation API
 - Rust plugins now shipped in macOS and Windows/MSVC binary packages
 - H.264/H.265 timestamp correction elements for PTS/DTS reconstruction before muxers
 - Improved design for DMA buffer sharing and modifier handling for hardware-accelerated video decoders/encoders/filters and capturing/rendering on Linux
 - Video4Linux2 hardware accelerated decoder improvements
 - CUDA integration and Direct3D11 integration and plugin improvements
 - New H.264 / AVC, H.265 / HEVC and AV1 hardware-accelerated video encoders for AMD GPUs using the Advanced Media Framework (AMF) SDK
 - applemedia: H.265 / HEVC video encoding + decoding support
 - androidmedia: H.265 / HEVC video encoding support
 - New "force-live" property for audiomixer, compositor, glvideomixer, d3d11compositor etc.
 - Lots of new plugins, features, performance improvements and bug fixes

## Major new features and changes

### AV1 video codec support improvements

AV1 is a royalty free next-generation video codec by AOMedia and a free alternative to H.265/HEVC.

While supported in earlier versions of GStreamer already, this release saw a lot of improvements across the board:

 - Support for hardware encoding and decoding via VAAPI/VA, AMF, D3D11, NVCODEC, QSV and Intel MediaSDK. Hardware codecs for AV1 are slowly becoming available in embedded systems and desktop GPUs (AMD, Intel, NVIDIA), and these can now be used via GStreamer.

 - New AV1 RTP payloader and depayloader elements.

 - New encoder settings in the AOM reference encoder-based `av1enc` element.

 - Various improvements in the AV1 parser and in the MP4/Matroska/WebM muxers/demuxers.

 - `dav1d` and `rav1e` based software decoder/encoder elements shipped as part of the binaries.

 - AV1 parser improvements and various bugfixes all over the place.

### Touchscreen event support in Navigation API

The [Navigation API][navigation-api] supports the sending of key press events and mouse events through a GStreamer pipeline. Typically these will be picked up by a video sink on which these events happen and then the event is transmitted into the pipeline so it can be handled by elements inside the pipeline if it wasn't handled by the application.

This has traditionally been used for DVD menu support, but can also be used to forward such inputs to source elements that render a web page using a browser engine such as WebKit or Chromium.

This API has now gained support for touchscreen events, and this has been implemented in various plugins such as the GTK, Qt, XV, and x11 video sinks as well as the `wpevideosrc` element.

[navigation-api]: https://gstreamer.freedesktop.org/documentation/video/gstnavigation.html?gi-language=c#gstnavigation-page

### GStreamer CUDA integration

- New [gst-cuda library][gst-cuda-lib]
- integration with D3D11 and NVIDIA dGPU NVMM elements
- new **cudaconvertscale** element

[gst-cuda-lib]: https://gstreamer.freedesktop.org/documentation/cuda/index.html?gi-language=c#cuda-library

### GStreamer Direct3D11 integration

- New gst-d3d11 public library
  - gst-d3d11 library is not integrated with GStreamer documentation system yet. Please refer to the [examples][gst-d3d11-examples]
- **d3d11screencapture**: Add Windows Graphics Capture API based capture mode, including Win32 application window capturing
- **d3d11videosink** and **d3d11convert** can support flip/rotation and crop meta
- **d3d11videosink**: New `emit-present` property and `present` signal so that applications can overlay an image on Direct3D11 swapchain's backbuffer via Direct3D/Direct2D APIs. See also [C++][gst-d3d11-present-cpp] and [Rust][gst-d3d11-present-rust] examples
- **d3d11compositor** supports YUV blending/composing without intermediate RGB(A) conversion to improve performance
- Direct3D11 video decoders are promoted to `GST_RANK_PRIMARY` or higher, except for the MPEG2 decoder

[gst-d3d11-examples]:
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/tree/main/subprojects/gst-plugins-bad/tests/examples/d3d11

[gst-d3d11-present-cpp]:
https://gitlab.freedesktop.org/gstreamer/gstreamer/-/blob/main/subprojects/gst-plugins-bad/tests/examples/d3d11/d3d11videosink-present.cpp

[gst-d3d11-present-rust]:
https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/-/blob/main/examples/src/bin/d3d11videosink.rs

### H.264/H.265 timestamp correction elements

- Muxers are often picky and need proper PTS/DTS timestamps set on the input buffers, but that can be a problem if the encoded input media stream comes from a source that doesn't provide proper signalling of DTS, such as is often the case for RTP, RTSP and WebRTC streams or Matroska container files. Theoretically parsers should be able to fix this up, but it would probably require fairly invasive changes in the parsers, so two new elements **h264timestamper** and **h265timestamper** bridge the gap in the meantime and can reconstruct missing PTS/DTS.

### Easy sender timestamp reconstruction for RTP and RTSP

- it was always possible to reconstruct and retrieve the original RTP sender timestamps in GStreamer, but required a fair bit of understanding of the internal mechanisms and the right property configuration and clock setup.

- rtspsrc and rtpjitterbuffer gained a new "add-reference-timestamp-meta" property that if set puts the original absolute reconstructed sender timestamps on the output buffers via a meta. This is particularly useful if the sender is synced to an NTP clock or PTP clock. The original sender timestamps are either based on the RTCP NTP times, NTP RTP header extensions ([RFC6051][rfc-6051]) or [RFC7273][rfc-7273]-style clock signalling.

[rfc-7273]: https://www.rfc-editor.org/rfc/rfc7273.html
[rfc-6051]: https://www.rfc-editor.org/rfc/rfc6051.html

### Qt6 support

- new **qml6glsink** element for Qt6 similar to the existing Qt5 element. Matching source and overlay elements will hopefully follow in the near future.

### OpenGL + Video library enhancements

- Support for new video formats (NV12_4L4, NV12_16L32S, NV12_8L128, NV12_10BE_8L128) and dmabuf import in more formats (Y410, Y212_LE, Y212_BE, Y210, NV21, NV61)

- Improved support for tiled formats with arbitrary tile dimensions, as needed by certain hardware decoders/encoders

- **glvideomixer**: New "crop-left, "crop-right, "crop-top" and "crop-bottom" pad properties for cropping inputs

- OpenGL support for `gst_video_sample_convert()`:
    - Used for video snapshotting and thumbnailing, to convert buffers retrieved from appsinks or sink "last-sample" properties in JPG/PNG thumbnails.
    - This function can now take samples and buffers backed by GL textures as input and will automatically plug a gldownload element in that case.

### High bit-depth support (10, 12, 16 bits per component value) improvements

- **compositor** can now handle any supported input format and also mix high-bitdepth (10-16 bit) formats (naively)

- **videoflip** has gained support for higher bit depth formats.

- **vp9enc**, **vp9dec** now support 12-bit formats and also 10-bit 4:4:4

### WebRTC

- Allow insertion of **bandwidth estimation** elements e.g. for **Google Congestion Control** (GCC) support

- Initial support for sending or receiving **simulcast** streams

- Support for **asynchronous host resolution for STUN/TURN servers**

- GstWebRTCICE was split into base classes and implementation to make it possible to plug **custom ICE implementations**

- **webrtcsink**: batteries-included WebRTC sender (Rust)

- **whipsink**: WebRTC HTTP ingest (WHIP) to a MediaServer (Rust)

- **whepsrc**: WebRTC HTTP egress (WHEP) from a MediaServer (Rust)

- Many other improvements and bug fixes

### New HLS, DASH and MSS adaptive streaming clients

A new set of "adaptive demuxers" to support HLS, DASH and MSS adaptive streaming protocols has been added. They provide improved performance, new features and better stream compatibility compared to the previous elements. These new elements require a "streams-aware" pipeline such as `playbin3`, `uridecodebin3` or `urisourcebin`.

The previous elements' design prevented implementing several use-cases and fixing long-standing issues. The new elements were re-designed from scratch to tackle those:

- **Scheduling** Only 3 threads are present, regardless of the number of streams selected. One in charge of downloading fragments and manifests, one in charge of outputting parsed data downstream, and one in charge of scheduling. This improves performance, resource usage and latency.

- **Better download control** The elements now directly control the scheduling and download of manifests and fragments using libsoup directly instead of depending on external elements for downloading.

- **Stream selection**, only the selected streams are downloaded. This improves bandwith usage. Switching stream is done in such a way to ensure there are no gaps, meaning the new stream will be switched to only once enough data for it has been downloaded.

- **Internal parsing**, the downloaded streams are parsed internally. This allows the element to fully respect the various specifications and offer accurate buffering, seeking and playback. This is especially important for HLS streams which require parsing for proper positioning of streams.

- **Buffering and adaptive rate switching**, the new elements handle buffering internally which allows them to have a more accurate visibility of which bandwith variant to switch to.

### Playbin3, Decodebin3, UriDecodebin3, Parsebin improvements

The "new" playback elements introduced in 1.18 (`playbin3` and its various components) have been refactored to allow more use-cases and improve performance. They are no longer considered experimental, so applications using the legacy playback elements (`playbin` and `(uri)decodebin`) can migrate to the new components to benefit from these improvements.

- **Gapless** The "gapless" feature allows files and streams to be fetched, buffered and decoded in order to provide a "gapless" output. This feature has been refactored extensively in the new components:
    - A single `(uri)decodebin3` (and therefore a single set of decoders) is used. This improves memory and cpu usage, since on identical codecs a single decoder will be used.
    - The "next" stream to play will be pre-rolled "just-in-time" thanks to the buffering improvements in `urisourcebin` (see below)
    - This feature is now handled at the `uridecodebin3` level. Applications that wish to have a "gapless" stream and process it (instead of just outputting it, for example for transcoding, retransmission, ...) can now use `uridecodebin3` directly. Note that a `streamsynchronizer` element is required in that case.

- **Buffering improvements** The `urisourcebin` element is in charge of fetching and (optionally) buffering/downloading the stream. It has been extended and improved:
    - When the `parse-streams` property is used (by default in `uridecodebin3` and `playbin3`), compatible streams will be demuxed and parsed (via `parsebin`) and buffering will be done on the elementary streams. This provides a more accurate handling of buffering. Previously buffering was done on a best-effort basis and was mostly wrong (i.e. downloading more than needed).
    - Applications can use `urisourcebin` with this property as a convenient way of getting elementary streams from a given URI.
    - Elements can handle buffering themselves (such as the new adaptive demuxers) by answering the `GST_QUERY_BUFFERING` query. In that case `urisourcebin` will not handle it.

- **Stream Selection** Efficient stream selection was previously only possible within `decodebin3`. The downside is that this meant that upstream elements had to provide all the streams from which to chose from, which is inefficient. With the addition of the `GST_QUERY_SELECTABLE` query, this can now be handled by elements upstream (i.e. sources)
    - Elements that can handle stream selection internally (such as the new adaptive demuxer elements) answer that query, and handle the stream selection events themselves.
    - In this case, `decodebin3` will always process all streams that are provided to it.

- **Instant URI switching** This new feature allows switching URIs "instantly" in `playbin3` (and `uridecodebin3`) without having to change states. This mimics switching channels on a television.
    - If compatible, decoders will be re-used, providing lower latency/cpu/memory than by switching states.
    - This is enabled by setting the `instant-uri` property to `true`, setting the URI to switch to immediately, and then disabling the `instant-uri` property again afterwards.

- **playbin3**, **decodebin3**, **uridecodebin3**, **parsebin**, and **urisourcebin** are **no longer experimental**
    - They were originally marked as 'technology preview' but have since seen extensive usage in production settings, so are considered ready for general use now.

### Fraunhofer AAC audio encoder HE-AAC and AAC-LD profile support

- **fdkaacenc**:
    - Support for encoding to HE-AACv1 and HE-AACv2 profile
    - Support for encoding to AAC Low Delay (LD) profile
    - Advanced bitrate control options via new "rate-control", "vbr-preset", "peak-bitrate", and "afterburner" properties

### RTP rapid synchronization support in the RTP stack (RFC6051)

RTP provides several mechanisms how streams can be synchronized relative to each other, and how absolute sender times for RTP packets can be obtained. One of these mechanisms is via RTCP, which has the disadvantage that the synchronization information is only distributed out-of-band and usually some time after the start.

GStreamer's RTP stack, specifically the `rtpbin`, `rtpsession` and `rtpjitterbuffer` elements, now also have support for retrieving and sending the same synchronization information in-band via RTP header extensions according to [RFC6051][rfc-6051] (Rapid Synchronisation of RTP Flows). Only 64-bit timestamps are supported currently.

This provides per packet synchronization information from the very beginning of a stream and allows accurate inter-stream, and (depending on setup) inter-device, synchronization at the receiver side.

### ONVIF XML Timed Metadata support

The ONVIF standard implemented by various security cameras also specifies a format for timed metadata that is transmitted together with the audio/video streams, usually over RTSP.

Support for this timed metadata is implemented in the MP4 demuxer now as well as the new fragmented MP4 muxer and the new non-fragmented MP4 muxer from the GStreamer Rust plugins. Additionally, the new `onvif` plugin ‒ which is part of the GStreamer Rust plugins ‒ provides general elements for handling the metadata and e.g. overlaying certain parts of it over a video stream.

As part of this support for absolute UTC times was also implemented according to the requirements of the ONVIF standards in the corresponding elements.

### MP3 gapless playback support

While MP3 can probably considered a legacy format at this point, a new feature was added with this release.

When playing back plain MP3 files, i.e. outside a container format, switches between files can now be completely gapless if the required metadata is provided inside the file. There is no standardized metadata for this, but the LAME MP3 encoder writes metadata that can be parsed by the `mpegaudioparse` element now and forwarded to decoders for ensuring removal of padding samples at the front and end of MP3 files.

### "force-live" property for audio + video aggregators

This is a quality of life fix for playout and streaming applications where it is common to have audio and video mixer elements that should operate in live mode from the start and produce output continuously.

Often one would start a pipeline without any inputs hooked up to these mixers in the beginning, and up until now there was no way to easily force these elements into live mode from the start. One would have to add an initial live video or audio test source as dummy input to achieve this.

The new "force-live" property makes these audio and video aggregators start in live mode without the need for any dummy inputs, which is useful for scenarios where inputs are only added after starting the pipeline.

This new property should usually be used in connection with the "min-upstream-latency" property, i.e. you should always set a non-0 minimum upstream latency then.

This is now supported in all GstAudioAggregator and GstVideoAggregator subclasses such as `audiomixer`, `audiointerleave`, `compositor`, `glvideomixer`, `d3d11compositor`, etc.


## New elements and plugins

- new **cudaconvertscale** element that can convert and scale in one pass

- new **gtkwaylandsink** element based on gtksink, but similar to waylandsink and uses Wayland APIs directly instead of rendering with Gtk/Cairo primitives. This approach is only compatible with Gtk3, and like gtksink this element only supports Gtk3.

- new **h264timestamper** and **h265timestamper** elements to reconstruct missing pts/dts from inputs that might not provide them such as e.g. RTP/RTSP/WebRTC inputs (see above)

- **mfaacdec**, **mfmp3dec**: Windows MediaFoundation AAC and MP3 decoders

- new **msdkav1enc** AV1 video encoder element

- new **nvcudah264enc**, **nvcudah265enc**, **nvd3d11h264enc**, and **nvd3d11h265enc** NVIDIA GPU encoder elements to support zero-copy encoding, via CUDA and Direct3D11 APIs, respectively

- new **nvautogpuh264enc** and **nvautogpuh265enc** NVIDIA GPU encoder elements: The auto GPU elements will automatically select a target GPU instance in case multiple NVIDIA desktop GPUs are present, also taking into account the input memory. On Windows CUDA or Direct3D11 mode will be determined by the elements automatically as well. Those new elements are useful if target GPU and/or API mode (either CUDA or Direct3D11 in case of Windows) is undeterminable from the encoder point of view at the time when pipeline is configured, and therefore lazy target GPU and/or API selection are required in order to avoid unnecessary memory copy operations.

- new **nvav1dec** AV1 NVIDIA desktop GPU decoder element

- new **qml6glsink** element to render video with Qt6

- **qsv**: New Intel OneVPL/MediaSDK (a.k.a Intel Quick Sync) based decoder and encoder elements, with gst-d3d11 (on Windows) and gst-va (on Linux) integration
  - Support multi-GPU environment, for example, concurrent video encoding using Intel iGPU and dGPU in a single pipeline
  - H.264 / H.265 / VP9 and JPEG decoders
  - H.264 / H.265 / VP9 / AV1 / JPEG encoders with dynamic encoding bitrate update
  - New plugin does not require external SDK for building on Windows

- **vulkanoverlaycompositor**: new vulkan overlay compositor element to overlay upstream `GstVideoOverlayCompositonMeta` onto the video stream.

- **vulkanshaderspv**: performs operations with SPIRV shaders in Vulkan

- **win32ipcvideosink**, **win32ipcvideosrc**: new shared memory videosrc/sink elements for Windows

- **wicjpegdec**, **wicpngdec**: Windows Imaging Component  (WIC) based JPEG and PNG decoder elements.

- Many exciting **new Rust elements**, see Rust section below

## New element features and additions

- **audioconvert**: Dithering now uses a slightly slower, less biased PRNG which results in better quality output. Also dithering can now be enabled via the new "dithering-threshold" property for target bit depths of more than 20 bits.

- **av1enc**: Add "keyframe-max-dist" property for controlling max distance between keyframes, as well as "enc-pass", "keyframe-mode", "lag-in-frames" and "usage-profile" properties.

- **cccombiner**: new "output-padding" property

- **decklink**: Add support for 4k DCI, 8k/UHD2 and 8k DCI modes

- **dvbsubenc**: Support for >SD resolutions is working correctly now.

- **fdkaacenc**: Add HE-AAC / HE-AACv2 profile support

- **glvideomixer**: New "crop-left, "crop-right, "crop-top" and "crop-bottom" pad properties for cropping inputs

- **gssink**: new 'content-type' property. Useful when one wants to upload a video as `video/mp4` instead of 'video/quicktime` for example.

- **jpegparse**: Rewritten using the common parser library

- **msdk**:
  - new **msdkav1enc** AV1 video encoder element
  - **msdk decoders**: Add support for Scaler Format Converter (SFC) on supported Intel platforms for hardware accelerated conversion and scaling
  - **msdk encoders**: support import of dmabuf,  va memory and D3D11 memory
  - **msdk encoders**: add properties for low delay bitrate control and max frame sizes for I/P frames
  - **msdkh264enc**, **msdkh265enc**: more properties to control intra refresh
  - note that on systems with multi GPUs the Windows D3D11 integration might only work reliably if the Intel GPU is the primary GPU

- **mxfdemux**: Add support for Canon XF-HEVC

- **openaptx**: Support the freeaptx library

- **qroverlay**:
    - new "qrcode-case-sensitive" property allows encoding case sensitive strings like wifi SSIDs or passwords.
    - added the ability to pick up data to render from an upstream-provided custom GstQROverlay meta

- **qtdemux**: Add support for ONVIF XML Timed MetaData and AVC-Intra video

- **rfbsrc** now supports the uri handler interface, so applications can use RFB/VNC sources in uridecodebin(3) and playbin, with e.g. `rfb://:password@10.1.2.3:5903?shared=1`

- **rtponviftimestamp**: Add support for using reference timestamps

- **rtpvp9depay** now has the same keyframe-related properties as rtpvp8depay and rtph264depay: "request-keyframe" and "wait-for-keyframe"

- **rtspsrc**: Various RTSP servers are using invalid URL operations for constructing the control URL. Until GStreamer 1.16 these worked correctly because GStreamer was just appending strings itself to construct the control URL, but starting version 1.18 the correct URL operations were used. With GStreamer 1.22, `rtspsrc` now first tries with the correct control URL and if that fails it will retry with the wrongly constructed control URL to restore support for such servers.

- **rtspsrc** and **rtpjitterbuffer** gained a new **"add-reference-timestamp-meta"** property that makes them put the unmodified original sender timestamp on output buffers for NTP or PTP clock synced senders

- **srtsrc**, **srtsink**: new "auto-reconnect" property to make it possible to disable automatic reconnects (in caller mode) and make the elements post an error immediately instead; also stats improvements

- **srtsrc**: new "keep-listening" property to avoid EOS on disconnect and keep the source running while it waits for a new connection.

- **videocodectestsink**: added YUV 4:2:2 support

- **wasapi2src**: Add support for process loopback capture

- **wpesrc**: Add support for modifiers in key/touch/pointer events

## Plugin and library moves

- The **xingmux** plugin has been moved from gst-plugins-ugly into gst-plugins-good.

- The various Windows **directshow** plugins in gst-plugins-bad have been unified into a single directshow plugin.

## Plugin removals

- The `dxgiscreencapsrc` element has been removed, use `d3d11screencapturesrc` instead

## Miscellaneous API additions

- `GST_AUDIO_FORMAT_INFO_IS_VALID_RAW()` and `GST_VIDEO_FORMAT_INFO_IS_VALID_RAW()` can be used to check if a GstAudioFormatInfo or GstVideoFormatInfo has been initialised to a valid raw format.

- Video SEI meta: new [`GstVideoSEIUserDataUnregisteredMeta`][sei-meta] to carry H.264 and H.265 metadata from SEI User Data Unregistered messages.

- vulkan: Expose `gst_vulkan_result_to_string()`

[sei-meta]: https://gstreamer.freedesktop.org/documentation/video/gstvideosei.html?gi-language=c#GstVideoSEIUserDataUnregisteredMeta

## Miscellaneous performance, latency and memory optimisations

- liborc 0.4.33 adds support for aarch64 (64-bit ARM) architecture (not enabled by default on Windows yet though) and improvements for 32-bit ARM and should greatly enhance performance for certain operations that use ORC.

- as always there have been plenty of performance, latency and memory optimisations all over the place.

## Miscellaneous other changes and enhancements

- the audio/video decoder base classes will not consider decoding errors a hard error by default anymore but will continue trying to decode. Previously more than 10 consecutive errors were considered a hard error but this caused various partially broken streams to fail. The threshold is configurable via the "max-errors" property.

- compatibility of the GStreamer PTP clock implementation with different PTP server implementations was improved, and synchronization is achieved successfully in various scenarios that failed before.

## Tracing framework and debugging improvements

### New tracers

- **buffer-lateness**: Records lateness of buffers and the reported latency for each pad in a CSV file. Comes with a script for visualisation.

- **pipeline-snapshot**: Creates a .dot file of all pipelines in the application whenever requested via `SIGUSR1` (on UNIX systems)

- **queue-levels**: Records queue levels for each queue in a CSV file. Comes with a script for visualisation.

### Debug logging system improvements

- **new log macros** `GST_LOG_ID`, `GST_DEBUG_ID`, `GST_INFO_ID`, `GST_WARNING_ID`, `GST_ERROR_ID`, and `GST_TRACE_ID` allow passing a string identifier instead of a GObject. This makes it easier to log non-gobject-based items and also has performance benefits.

## Tools

- `gst-play-1.0` gained a `--no-position` command line option to suppress position/duration queries, which can be useful to reduce debug log noise.

## GStreamer FFMPEG wrapper

- Fixed bitrate management and timestamp inaccuracies for video encoders

- Fix synchronization issues and errors created by the (wrong) forwarding of upstream segment events by ffmpeg demuxers.

- Clipping meta support for gapless mp3 playback

## GStreamer RTSP server

- Add [RFC5576][rfc-5576] Source-specific media attribute to the SDP media for signalling the CNAME

- Add support for adjusting request response on pipeline errors
    - Give the application the possibility to adjust the error code when responding to a request. For that purpose the pipeline's bus messages are emitted to subscribers through a "handle-message" signal. The subscribers can then check those messages for errors and adjust the response error code by overriding the virtual method `GstRTSPClientClass::adjust_error_code()`.

- Add `gst_rtsp_context_set_token()` method to make it possible to set the RTSPToken on some RTSPContext from bindings such as the Python bindings.

- **rtspclientsink** gained a "publish-clock-mode" property to configure whether the pipeline clock should be published according to [RFC7273][rfc-7273] (RTP Clock Source Signalling), similar to the same API on `GstRTSPMedia`.

[rfc-5576]: https://www.rfc-editor.org/rfc/rfc5576.html

## GStreamer VA-API support

- Development activity has shifted towards the new [**va plugin**][va-plugin], with gstreamer-vaapi now basically in maintenance-only mode. Most of the below refers to the **va plugin** (not gstreamer-vaapi).

- new [**gst-va library**][va-lib] for GStreamer VA-API integration

- **vajpegdec**: new JPEG decoder

- **vah264enc**, **vah265enc**: new H.264/H.265 encoders

- **vah264lpenc**, **vah265lpenc**: new low power mode encoders

- **vah265enc**: Add extended formats support such as 10/12 bits, 4:2:2 and 4:4:4

- Support **encoder reconfiguration**

- **vacompositor**: Add new compositor element using the VA-API VPP interface

- **vapostproc**:
  - new "scale-method" property
  - Process HDR caps if supported
  - parse video orientation from tags

[va-plugin]: https://gstreamer.freedesktop.org/documentation/va/index.html?gi-language=c#plugin-va
[va-lib]: https://gstreamer.freedesktop.org/documentation/valib/index.html?gi-language=c

- **vaapipostproc**: Enable the use of DMA-Buf import and export (gstreamer-vaapi)

## GStreamer Video4Linux2 support

- Added support for Mediatek Stateless CODEC (VP8, H.264, VP9)

- Stateless H.264 interlaced decoder support

- Stateless H.265 decoder support

- Stateful decoder support for driver resolution change events

- Stateful decoding support fixes for NXP/Amphion driver

- Support for hardware crop in v4l2src

- Conformance test improvement for stateful decoders

- Fixes for Raspberry Pi CODEC

## GStreamer OMX

- There were no changes in this module

## GStreamer Editing Services and NLE

- Handle compositors that are bins around the actual compositor implementation (like glvideomixers which wraps several elements)

- Add a mode to disable timeline editing API so the user can be in full control of its layout (meaning that the user is responsible for ensuring its validity/coherency)

- Add a new `fade-in` transition type

- Add support for non-1/1 PAR source videos

- Fix frame accuracy when working with very low framerate streams

## GStreamer validate

- Clean up and stabilize API so we can now generate rust bindings

- Enhance the `appsrc-push` action type allowing to find tune the buffers more in details

- Add an action type to verify currently configured pad caps

- Add a way to run checks from any thread after executing a 'wait' action. This is useful when waiting on a signal and want to check the value of a property right when it is emited for example.

## GStreamer Python Bindings

- Add a `Gst.init_python()` function to be called from plugins which will initialise everything needed for the GStreamer Python bindings but not call `Gst.init()` again since this will have been called already.

- Add support for the `GstURIHandlerInterface` that allows elements to advertise what URI protocols they support.

## GStreamer C# Bindings

- Fix AppSrc and AppSink constructors

- The C# bindings have yet to be updated to include new 1.22 API, which requires improvements in various places in the bindings / binding generator stack. See [issue #1718](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1718) in GitLab for more information and to track progress.

## GStreamer Rust Bindings and Rust Plugins

The GStreamer Rust bindings are released separately with a different release cadence that's tied to `gtk-rs`, but the latest release has already been updated for the new GStreamer 1.22 API. Check the [bindings release notes](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/-/blob/0.19/gstreamer/CHANGELOG.md) for details of the changes since 0.18, which was released around GStreamer 1.20.

`gst-plugins-rs`, the module containing GStreamer plugins written in Rust, has also seen lots of activity with many new elements and plugins. A list of all Rust plugins and elements provided with the 0.9 release can be found in the [repository](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/0.9/README.md).

- **33% of GStreamer commits are now in Rust** (bindings + plugins), and the Rust plugins module is also where most of the new plugins are added these days.

- The Rust plugins are now shipped as part of the Windows MSVC + macOS binary packages. See below for the list of shipped plugins and the status of Rust support in cerbero.

- The Rust plugins are also part of the [documentation](https://gstreamer.freedesktop.org/documentation/) on the GStreamer website now.

- Rust plugins can be used from any programming language. To the outside they look just like a plugin written in C or C++.

## New Rust plugins and elements

- **rtpav1pay** / **rtpav1depay**: RTP (de)payloader for the AV1 video codec
- **gtk4paintablesink**: a GTK4 video sink that provides a `GdkPaintable` for rendering a video in any place inside a GTK UI. Supports zero-copy rendering via OpenGL on Linux and macOS.
- **ndi**: source, sink and device provider for NewTek NDI protocol
- **onvif**: Various elements for parsing, RTP (de)payloading, overlaying of ONVIF timed metadata.
- **livesync**: Element for converting a live stream into a continuous stream without gaps and timestamp jumps while preserving live latency requirements.
- **raptorq**: Encoder/decoder elements for the RaptorQ FEC mechanism that can be used for RTP streams (RFC6330).

### WebRTC elements

- **webrtcsink**: a WebRTC sink (batteries included WebRTC sender with specific signalling)
- **whipsink**: WebRTC HTTP ingest (WHIP) to MediaServer
- **whepsrc**: WebRTC HTTP egress (WHEP) from MediaServer
- **rtpgccbwe**: RTP bandwidth estimator based on the Google Congestion Control algorithm (GCC), used by webrtcsink

### Amazon AWS services

- **awss3src** / **awss3sink**: A source and sink element to talk to the Amazon S3 object storage system.
- **awss3hlssink**: A sink element to store HLS streams on Amazon S3.
- **awstranscriber**: an element wrapping the AWS Transcriber service.
- **awstranscribeparse**: an element parsing the packets of the AWS Transcriber service.

### Video Effects (videofx)

- **roundedcorners**: Element to make the corners of a video rounded via the alpha channel.
- **colordetect**: A pass-through filter able to detect the dominant color(s) on incoming frames, using [color-thief](https://github.com/RazrFalcon/color-thief-rs).
- **videocompare**: Compare similarity of video frames. The element can use different hashing algorithms like [Blockhash](https://github.com/commonsmachinery/blockhash-rfc), [DSSIM](https://kornel.ski/dssim), and others.

### New MP4 muxer + Fragmented MP4 muxer

- **isofmp4mux**, **cmafmux**, **dashmp4mux**, **onviffmp4mux**: New fragmented MP4/ISOBMFF/CMAF muxer for generating e.g. DASH/HLS media fragments.
- **isomp4mux**, **onvifmp4mux**: New non-fragmented, normal MP4 muxer.

Both plugins provides elements that replace the existing `qtmux`/`mp4mux` element from `gst-plugins-good`. While not feature-equivalent yet, the new codebase and using separate elements for the fragment and non-fragmented case allows for easier extensability in the future.

## Cerbero Rust support

- Starting this release, cerbero has support for building and shipping Rust code on Linux, Windows (MSVC) and macOS. The Windows (MSVC) and macOS binaries also ship the GStreamer Rust plugins in this release. Only dynamic plugins are built and shipped currently.

- Preliminary support for Android, iOS and Windows (MinGW) exists but more work is needed. Check the [tracker issue](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/381) for more details about future work.

- The following plugins are included currently: audiofx, aws, cdg, claxon, closedcaption, dav1d, fallbackswitch, ffv1, fmp4, gif, hlssink3, hsv, json, livesync, lewton, mp4, ndi, onvif, rav1e, regex, reqwest, raptorq, png, rtp, textahead, textwrap, threadshare, togglerecord, tracers, uriplaylistbin, videofx, webrtc, webrtchttp.

## Build and Dependencies

- meson 0.62 or newer is required

- GLib >= 2.62 is now required (but GLib >= 2.64 is strongly recommended)

- libnice >= 0.1.21 is now required and contains important fixes for GStreamer's WebRTC stack.

- liborc >= 0.4.33 is recommended for 64-bit ARM support and 32-bit ARM improvements

- onnx: OnnxRT >= 1.13.1 is now required

- openaptx: can now be built against libfreeaptx

- opencv: allow building against any 4.x version

- shout: libshout >= 2.4.3 is now required

- gstreamer-vaapi's Meson build options have been switched from a custom combo type (yes/no/auto) to the built-in Meson feature type (enabled/disabled/auto)

- The [GStreamer Rust plugins module `gst-plugins-rs`][rust-plugins] is now considered an essential part of the GStreamer plugin offering and packagers and distributors are strongly encouraged to package and ship those plugins alongside the existing plugin modules.

[rust-plugins]: https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs

- we now make use of [Meson's *install tags* feature][meson-install-tags] which allows selective installation of installl components and might be useful for packagers.

[meson-install-tags]: https://mesonbuild.com/Installing.html#installation-tags

### Monorepo build (gst-build)

- new "orc-source" build option to **allow build against a system-installed liborc** instead of forcing the use of orc as a subproject.

- GStreamer command line tools can now be linked to the gstreamer-full library if it's built

### Cerbero

Cerbero is a meta build system used to build GStreamer plus dependencies on platforms where dependencies are not readily available, such as Windows, Android, iOS, and macOS.

#### General improvements

- Rust support was added for all support configurations, controlled by the `rust` variant; [see above](#Cerbero-Rust-support) for more details
- All pkgconfig files are now reliably relocatable without requiring `pkg-config --define-prefix`. This also fixes statically linking with GStreamer plugins using the corresponding pkgconfig files.
- New documentation on how to build a custom GStreamer repository using Cerbero, please [see the README](https://gitlab.freedesktop.org/gstreamer/cerbero/-/blob/1.22/README.md#how-to-build-a-custom-gstreamer-repository-or-branch)
- HTTPS certificate checking is enabled for downloads on all platforms now
- Fetching now automatically retries on error for robustness against transient errors
- Support for building the new Qt6 plugin was added
- pkgconfig files for various recipes were fixed
- Several recipes were updated to newer versions
- New plugins: `adaptivedemux2` `aes` `codectimestamper` `dav1d`
- New libraries: `cuda` `webrtcnice`

#### macOS / iOS

- Added support for running Cerbero on ARM64 macOS
- GStreamer.framework and all libraries in it are now relocatable, which means they use `LC_RPATH` entries to find dependencies instead of using an absolute path. If you link to GStreamer using the pkgconfig files, no action is necessary.
  However, if you use the framework directly or link to the libraries inside the framework by hand, then you need to pass `-Wl,-rpath,<path_to_libdir>` to the linker.
- Apple bitcode support was dropped, since Apple has deprecated it
- macOS installer now correctly advertises support for both x86_64 and arm64
- macOS framework now ships the `gst-rtsp-server-1.0` library
- Various fixes were made to make static linking to gstreamer libraries and plugins work correctly on macOS
- When statically linking to the `applemedia` plugin using Xcode 13, you will need to pass `-fno-objc-msgsend-selector-stubs` which works around a backwards-incompatible change in Xcode 14. This is not required for the rest of GStreamer at present, but will be in the future.
- macOS installer now shows the GStreamer logo correctly

#### Windows

- MSVC is now required by default on Windows, and the Visual Studio variant is enabled by default
  - To build with MinGW, use the `mingw` variant
- Visual Studio props files were updated for newer Visual Studio versions
- Visual Studio 2015 support was dropped
- MSYS2 is now supported as the base instead of MSYS. Please see [the README](https://gitlab.freedesktop.org/gstreamer/cerbero/-/blob/1.22/README.md#windows-setup) for more details. Some advantages include:
  - Faster build times, since parallel make works
  - Faster bootstrap, since some tools are provided by MSYS2
  - Other speed-ups due to using MSYS2 tools instead of MSYS
- Faster download by using powershell instead of hand-rolled Python code
- Many recipes were ported from Autotools to Meson, speeding up the build
- Universal Windows Platform is no longer supported, and binaries are no longer shipped for it
- New documentation on how to force a specific Visual Studio installation in Cerbero, please [see the README](https://gitlab.freedesktop.org/gstreamer/cerbero/-/blob/1.22/README.md#how-to-force-a-specific-visual-studio-versionh)
- New plugins: `qsv` `wavpack` `directshow` `amfcodec` `wic` `win32ipc`
- New libraries: `d3d11`

#### Windows MSI installer

- Universal Windows Platform prebuilt binaries are no longer available

#### Linux

- Various fixes for RHEL/CentOS 7 support
- Added support for running on Linux ARM64

#### Android

- Android support now requires Android API version 21 (Lollipop)
- Support for Android Gradle plugin 7.2

## Platform-specific changes and improvements

### Android

- Android SDK 21 is required now as minimum SDK version

- androidmedia: Add H.265 / HEVC video encoder mapping

- Implement `JNI_OnLoad()` to register static plugins etc. automatically in case GStreamer is loaded from Java using `System.loadLibrary()`, which is also useful for the `gst-full` deployment scenario.

### Apple macOS and iOS

- The GLib version shipped with the GStreamer binaries does not initialize an `NSApp` and does not run a `NSRunLoop` on the main thread anymore. This was a custom GLib patch and caused it to behave different from the GLib shipped by Homebrew or anybody else.

  The change was originally introduced because various macOS APIs require a `NSRunLoop` to run on the main thread to function correctly but as this change will never get merged into GLib and it was reverted for 1.22. Applications that relied on this behaviour should move to the new `gst_macos_main()` function, which also does not require the usage of a `GMainLoop`.

  See e.g. [gst-play.c](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/blob/64c4bfdf7e671f415a260eed78ef31489bbdf110/subprojects/gst-plugins-base/tools/gst-play.c#L1830-1839) for an example for the usage of `gst_macos_main()`.

- GStreamer.framework and all libraries in it are now relocatable, which means they use `LC_RPATH` entries to find dependencies instead of using an absolute path. If you link to GStreamer using the pkgconfig files, no action is necessary.
  However, if you use the framework directly or link to the libraries inside the framework by hand, then you need to pass `-Wl,-rpath,<path_to_libdir>` to the linker.

- **avfvideosrc**: Allow specifying crop coordinates during screen capture

 - **vtenc**, **vtdec**: H.265 / HEVC video encoding + decoding support

- **osxaudiosrc**: Support a device as both input and output
    - osxaudiodeviceprovider now probes devices more than once to determine if the device can function as both an input AND and output device. Previously, if the device provider detected that a device had any output capabilities, it was treated solely as an Audio/Sink.  This caused issues for devices that have both input and output capabilities (for example, USB interfaces for professional audio have both input and output channels). Such devicesare now listed as both an Audio/Sink as well as an Audio/Source.

- **osxaudio**: support hidden devices on macOS
    - These are devices that will not be shown in the macOS UIs and that cannot be retrieved without having the specific UID of the hidden device. There are cases when you might want to have a hidden device, for example when having a virtual speaker that forwards the data to a virtual hidden input device from which you can then grab the audio. The blackhole project supports these hidden devices and this change provides a way that if the device id is a hidden device it will use it instead of checkinf the hardware list of devices to understand if the device is valid.

### Windows

- **win32ipcvideosink**, **win32ipcvideosrc**: new shared memory videosrc/sink elements

- **wasapi2**: Add support for process loopback capture for a specified PID (requires Windows 11/Windows Server 2022)

- The Windows universal UWP build is currently non-functional and will
  need updating after the recent GLib upgrade. It is unclear if anyone
  is using these binaries, so if you are please make yourself known.

- **wicjpegdec**, **wicpngdec**: Windows Imaging Component  (WIC) based JPEG and PNG decoder elements.

- **mfaacdec**, **mfmp3dec**: Windows MediaFoundation AAC and MP3 decoders

- The uninstalled development environment supports PowerShell 7 now

### Linux

 - **Improved [design][dmabuf-design] for DMA buffer sharing and modifier handling** for hardware-accelerated video decoders/encoders/filters and capture/rendering on Linux and Linux-like system.

- **kmssink**
    - new "fd" property which allows an application to provide their own opened DRM device fd handle to kmssink. That way an application can lease multiple fd's from a DRM master to display on different CRTC outputs at the same time with multiple kmssink instances, for example.
    - new "skip-vsync" property to achieve full framerate with legacy emulation in drivers.
    - HDR10 infoframe support

- **va** plugin and gstreamer-vaapi improvements (see above)

- **waylandsink**: Add "rotate-method" property and "render-rectangle" property

- new **gtkwaylandsink** element based on gtksink, but similar to waylandsink and uses Wayland APIs directly instead of rendering with Gtk/Cairo primitives. This approach is only compatible with Gtk3, and like gtksink this element only supports Gtk3.

[dmabuf-design]: https://gstreamer.freedesktop.org/documentation/additional/design/dmabuf.html?gi-language=c

## Documentation improvements

- The [GStreamer Rust plugins][rust-plugins] are now included and documented in the [plugin documentation][plugin-docs].

[plugin-docs]: https://gstreamer.freedesktop.org/documentation/plugins_doc.html?gi-language=c

## Possibly Breaking Changes

- the Opus audio RTP payloader and depayloader no longer accept the lower case `encoding-format=multiopus` but instead produce and accept only the upper case variant `encoding-format=MULTIOPUS`, since those should always be upper case in GStreamer (caps fields are always case sensitive). This should hopefully only affect applications where RTP caps are set manually and multi-channel audio (>= 3 channels) is used.

- **wpesrc**: the URI handler protocols changed from `wpe://` and `web://` to `web+http://`, `web+https://`, and `web+file://` which means URIs are RFC 3986 compliant and the source can simply strip the prefix from the protocol.

- The Windows screen capture element `dxgiscreencapsrc` has been removed, please use `d3d11screencapturesrc` instead.

- On Android the minimum supported Android API version is now version 21 and has been increased from 16.

- On macOS, the GLib version shipped with the GStreamer binaries will no longer initialize an `NSApp` or run an `NSRunLoop` on the main thread. See macOS/iOS section above for details.

- **decklink**: The decklink plugin is now using the 12.2.2 version of the SDK and will not work with drivers older than version 12.

- On iOS Apple Bitcode support was removed from the binaries. This feature is deprecated since XCode 14 and not used on the App Store anymore.

- The MP4/Matroska/WebM muxers now require the "stream-format" to be provided as part of the AV1 caps as only the original "obu-stream" format is supported in these containers and not the "annexb" format.

## Known Issues

- The Windows UWP build in Cerbero needs fixing after the recent GLib upgrade (see above)

- The C# bindings have not been updated to include new 1.22 API yet (see above)

## Statistics

- 4072 commits
- 2224 Merge Requests
- 716 Issues
- 200+ Contributors
- ~33% of all commits and Merge Requests were in Rust modules

- 4747 files changed
- 469633 lines added
- 209842 lines deleted
- 259791 lines added (net)

## Contributors

Ádám Balázs, Adam Doupe, Adrian Fiergolski, Adrian Perez de Castro,
Alba Mendez, Aleix Conchillo Flaqué, Aleksandr Slobodeniuk,
Alicia Boya García, Alireza Miryazdi, Andoni Morales Alastruey,
Andrew Pritchard, Arun Raghavan, A. Wilcox, Bastian Krause, Bastien Nocera,
Benjamin Gaignard, Bill Hofmann, Bo Elmgreen, Boyuan Zhang, Brad Hards,
Branko Subasic, Bruce Liang, Bunio FH, byran77, Camilo Celis Guzman,
Carlos Falgueras García, Carlos Rafael Giani, Célestin Marot,
Christian Wick, Christopher Obbard, Christoph Reiter, Chris Wiggins,
Chun-wei Fan, Colin Kinloch, Corentin Damman, Corentin Noël,
Damian Hobson-Garcia, Daniel Almeida, Daniel Morin, Daniel Stone,
Daniels Umanovskis, Danny Smith, David Svensson Fors, Devin Anderson,
Diogo Goncalves, Dmitry Osipenko, Dongil Park, Doug Nazar, Edward Hervey,
ekwange, Eli Schwartz, Elliot Chen, Enrique Ocaña González, Eric Knapp,
Erwann Gouesbet, Evgeny Pavlov, Fabian Orccon, Fabrice Fontaine, Fan F He,
F. Duncanh, Filip Hanes, Florian Zwoch, François Laignel, Fuga Kato,
George Kiagiadakis, Guillaume Desmottes, Gu Yanjie, Haihao Xiang, Haihua Hu,
Havard Graff, Heiko Becker, He Junyan, Henry Hoegelow, Hiero32, Hoonhee Lee,
Hosang Lee, Hou Qi, Hugo Svirak, Ignacio Casal Quinteiro, Ignazio Pillai,
Igor V. Kovalenko, Jacek Skiba, Jakub Adam, James Cowgill, James Hilliard,
Jan Alexander Steffens (heftig), Jan Lorenz, Jan Schmidt, Jianhui Dai,
jinsl00000, Johan Sternerup, Jonas Bonn, Jonas Danielsson, Jordan Petridis,
Joseph Donofry, Jose Quaresma, Julian Bouzas, Junsoo Park, Justin Chadwell,
Khem Raj, Krystian Wojtas, László Károlyi, Linus Svensson, Loïc Le Page,
Ludvig Rappe, Marc Leeman, Marek Olejnik, Marek Vasut, Marijn Suijten,
Mark Nauwelaerts, Martin Dørum, Martin Reboredo, Mart Raudsepp,
Mathieu Duponchelle, Matt Crane, Matthew Waters, Matthias Clasen,
Matthias Fuchs, Mengkejiergeli Ba, MGlolenstine, Michael Gruner,
Michiel Konstapel, Mikhail Fludkov, Ming Qian, Mingyang Ma, Myles Inglis,
Nicolas Dufresne, Nirbheek Chauhan, Olivier Crête, Pablo Marcos Oltra,
Patricia Muscalu, Patrick Griffis, Paweł Stawicki, Peter Stensson,
Philippe Normand, Philipp Zabel, Pierre Bourré, Piotr Brzeziński,
Rabindra Harlalka, Rafael Caricio, Rafael Sobral, Rafał Dzięgiel,
Raul Tambre, Robert Mader, Robert Rosengren, Rodrigo Bernardes,
Rouven Czerwinski, Ruben Gonzalez, Sam Van Den Berge, Sanchayan Maity,
Sangchul Lee, Sebastian Dröge, Sebastian Fricke, Sebastian Groß,
Sebastian Mueller, Sebastian Wick, Sergei Kovalev, Seungha Yang,
Seungmin Kim, sezanzeb, Sherrill Lin, Shingo Kitagawa, Stéphane Cerveau,
Talha Khan, Taruntej Kanakamalla, Thibault Saunier, Tim Mooney,
Tim-Philipp Müller, Tomasz Andrzejak, Tom Schuring, Tong Wu, toor,
Tristan Matthews, Tulio Beloqui, U. Artie Eoff, Víctor Manuel Jáquez Leal,
Vincent Cheah Beng Keat, Vivia Nikolaidou, Vivienne Watermeier, WANG Xuerui,
Wojciech Kapsa, Wonchul Lee, Wu Tong, Xabier Rodriguez Calvar,
Xavier Claessens, Yatin Mann, Yeongjin Jeong, Zebediah Figura, Zhao Zhili,
Zhiyuaniu, مهدي شينون (Mehdi Chinoune),


... and many others who have contributed bug reports, translations, sent
suggestions or helped testing.

## Stable 1.22 branch

After the 1.22.0 release there will be several 1.22.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.22.x bug-fix releases will be made from the git 1.22 branch,
which will be a stable branch.

<a id="1.22.0"></a>

### 1.22.0

1.22.0 was originally released on 23 January 2023.

<a id="1.22.1"></a>

### 1.22.1

The first 1.22 bug-fix release (1.22.1) was released on 04 March 2023.

This release only contains bugfixes and it *should* be safe to update
from 1.22.0.

#### Highlighted bugfixes in 1.22.1

 - audio channel-mix: allow up to 64 channels (instead of up to 63 channels)
 - avfvideosrc: Don't wait on main thread for permissions request
 - avvidenc: avoid generating inaccurate output timestamps, especially with variable framerate streams
 - AV1 video codec caps signalling improvements in various elements
 - codectimestamper: Fix timestamping on sequence update
 - d3d11overlaycompositor: fix texture width and height
 - d3d11videosink: Fix rendering on external handle
 - dashdemux2: fix seek operation taking a log time to finish for some streams 
 - nvencoder: Fix B-frame encoding on Linux and min buffers in auto GPU mode
 - playbin3: fixing buffering for live pipelines
 - playbin: fix potential deadlock when stopping stream with subtitles visible
 - redenc: fix setting of extension ID for twcc
 - rtspsrc: improved compatibility with more broken RTSP servers
 - v4l2h264dec: Fix Raspberry Pi4 will not play video in application
 - vtdec: fix jittery playback of H.264 Level 4.1 movies in macOS
 - vtdec: Fix non-deterministic frame output after flushing seeks
 - vtenc: fix handling of interlaced ProRes on Apple M1 hardware
 - vtenc: don't advertise ARGB/RGBA64 input caps on M1 Pro/Max with macOS <13
 - wasapi2src: Fix loopback capture on Windows 10 Anniversary Update
 - tools: better handling of non-ASCII command line arguments on Windows
 - gst-libav: fix build against newer ffmpeg versions
 - gst-python: Use arch-specific install dir for gi overrides
 - cerbero: Fix setuptools site.py breakage in Python 3.11
 - macOS packages: Fix broken binaries on macos < 11.0
 - various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [buffer: fix copy meta reference debug log formatting](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4038)
 - [bin: Don't unlock unlocked mutex in `gst_bin_remove_func()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3910)
 - [pad: Don't leak user_data in `gst_pad_start_task()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3925)
 - [aggregator: Always lock aggpad around update_time_level](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3819)
 - [inputselector: Avoid potential deadlock when shutting down, e.g. playbin with subtitles](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4099)
 - [multiqueue: Handle use-interleave latency live pipelines, fixing buffering for live pipelines in playbin3](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3810)
 - [GstBaseSrc: fix transfer annotation for `fixate()` virtual method](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3839)
 - [GstBaseSrc, GstPushSrc: add nullable annotations to virtual methods](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3833)
 - [tools: Make sure UTF-8 encoded command line arguments on Windows](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4072)

#### gst-plugins-base

 - [alsasink: Fix stall when going from PLAYING to NULL (stucked at PAUSED) with uac1 gadget](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4104)
 - [appsrc: Don't chain up `BaseSrc::negotiate()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4020)
 - [audio: channel-mix: Fix channel count limit to be able to equal 64](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3958)
 - [gldisplay: Mark `gst_gl_display_create_context()` `other_context` parameter as nullable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3835)
 - [gldisplay: Remove unused code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4091)
 - [gstglwindow_x11.c: Fix colormap leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4054)
 - [gl/cocoa: Return a strong ref to the parent GstGLContext](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3885)
 - [rtspconnection: Annotate RTSP message and RTSP events parameters correctly](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4061)
 - [sdp, typefind: Fix some annotations](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3814)
 - [sdp: gstmikey: gst_mikey_message_to_caps: extract ROC from first crypto session](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3818)
 - [subparse: Properly forward segment seqnum](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3917)
 - [uridecodebin: Set source element to READY before querying it](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4016)
 - [uritranscodebin: Fix unref of NULL](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3837)
 - [gst-play-1.0: Don't force accurate seeking](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4017)

#### gst-plugins-good

 - [adaptivedemux2: Fix buffering threshold initialization](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4105)
 - [dashdemux2: the seek operation takes a log time to finish for some streams](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2064)
 - [glvideomixer: Keep a reference to the underlying pad](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3963)
 - [qtdemux: Don't emit GstSegment correcting start time when in MSE mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3990)
 - [qtdemux: Handle moov atom length=0 case by reading until the end](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3938)
 - [qtdemux, qtmux: Drop av1C version 0 parsing and implement version 1 parsing/writing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4027)
 - [qtmux: Fix assertion on caps update](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4055)
 - [redenc: fix setting of extension ID for twcc](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3812)
 - [rtspsrc: Use the correct vfunc for the `push-backchannel-sample` action signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4056)
 - [rtpssrcdemux: set different stream-id on each src pad](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3866)
 - [udpsrc: GstSocketTimestampMessage only for SCM_TIMESTAMPNS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3797)
 - [v4l2h264dec: Fix Raspberry Pi4 will not play video in application](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3815)
 
#### gst-plugins-bad

 - [aom: Include stream-format and alignment in the AV1 caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3873)
 - [av1parser, h265parser: Fix some code defects](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4003)
 - [av1parser: Don't consider unknown metadata OBUs a bitstream error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3924)
 - [avfvideosrc: Don't wait on main thread for permissions request](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4096)
 - [ccconverter: don't debug a potentially freed filter caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4013)
 - [codectimestamper: Fix timestamping on sequence update](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3987)
 - [codecparsers: {h264, h265}bitwriter: Remove redundant condition checks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3978)
 - [codecs: decoders: fail early if no input caps have been provided for all new decoder base classes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4066)
 - [closedcaption: Don't leak caps event](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3906)
 - [curlhttpsrc: Add curl anyauth option](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4065)
 - [d3d11overlaycompositor: fix texture width and height](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4053)
 - [d3d11videosink: Fix rendering on external handle](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4010)
 - [h265parse: Always set profile on src caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4068)
 - [msdkav1enc: fix the category for msdkav1enc debug](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3991)
 - [nvcodec: improve error reporting on plugin init](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3813)
 - [nvencoder: Fix b-frame encoding on Linux](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4008)
 - [nvencoder: Fix min buffers parameter of allocation query in auto GPU mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3891)
 - [nvvp9dec: Fix return value](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3874)
 - [qsvav1enc, amfav1enc: Set stream-format on caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3961)
 - [vtdec: Jittery playback of H.264 Level 4.1 movies in macOS (both x86_64 and arm64)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1503)
 - [vtdec: Fix DPB size calculations not taking values from SPS into account](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4110)
 - [vtdec: Fix not waiting for async frames when flushing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3937)
 - [vtenc: Disable ARGB/RGBA64 caps on M1 Pro/Max with macOS <13](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3962)
 - [vtenc: Fix checking for certain CPU variants when running in VMs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4082)
 - [vtenc: Disable HW acceleration for interlaced ProRes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3878)
 - [va: Avoid the array index overflow when filling 8x8 scaling list.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3877)
 - [va: Fix some code defects](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4007)
 - [vah265enc: Use helper to update properties.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4009)
 - [vulkan: memory: Flush non coherent memory after write.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3817)
 - [wasapi2src: Fix loopback capture on Windows 10 Anniversary Update](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3820)
 - [webrtcbin: small stats improvements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3994)
 - [win32ipcutils: Add missing include](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3936)
 - [wpe: Logging fixes for the WebExtension](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4022)

#### gst-plugins-ugly

 - [mpegpsdemux: Ignore DTS if PTS < DTS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3836)

#### gst-libav

 - [avauddec, avviddec: Free packet side data after usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4078)
 - [avviddec: change AV_CODEC_CAP_AUTO_THREADS->AV_CODEC_CAP_OTHER_THREADS to fix build against newer ffmpeg versions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3964)
 - [Memory leak in ' av_packet_add_side_data' in /lib/x86_64-linux-gnu/libavcodec.so reading the file clock_odd_size_RLE_g1597902.avi](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2006)
 - [avvidenc: Don't take ffmpeg timestamps verbatim but only use them to calculate DTS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3808)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - [vaapi: Skip plugin pc file for shared plugins](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3800)

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - [gst-python: Use arch-specific install dir for gi overrides](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4093)

#### gst-editing-services

 - No changes

#### gst-validate + gst-integration-testsuites

 - [validate:scenario: sink refs when building](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4097)
 - [tests: Fix known issue definition location for unit tests and how we handle them in validate launcher](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3986)
 - [tests: mark elements_srtp.test_play test as flaky](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3970)
 - [Fix gstreamer-validate-1.0 dependency name](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3872)
 - [validate-scenario: fix g-i warning in annotation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3842)
 - [validate: Fix gst_validate_execute_action annotation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3838)

### gst-examples

 - [webrtc examples: Use webrtc.gstreamer.net](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3892)
 - [webrtc_sendrecv.py: Various fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3816)

#### Development build environment

 - [gst-env: Handle installing python modules to dist-packages](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3848)
 - [meson: Allow sysdeps to be forced as fallback subprojects](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3905)
 - [meson: Switch dav1d wrap to a tarball and update to dav1d 1.1.0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4069)

#### Cerbero build tool and packaging changes in 1.22.1

 - [macos: Fix broken binaries on macos < 11.0](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1120)
 - [orc: Update pthread_jit_write_protect fix for macOS/iOS](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1121)
 - [dav1d: Update to 1.1.0](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1123)
 - [libsrtp: update to v2.5.0](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1122)
 - [rustup: Update to 1.25.2](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1106)
 - [rust: Update to 1.67; cargo-c to 0.9.16](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1099)
 - [cerbero: Don't error out if bindir already exists](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1101)
 - [Fix setuptools site.py breakage in Python 3.11, bump gobject-introspection, bump windows image](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1100)
 - [cerbero: Retry if cargo update fails on macOS](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1098)
 - [gst-plugins-rs: Build glib/gio bindings with 2.74 API support](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1089)

#### Contributors to 1.22.1

Alessandro Bono, Arun Raghavan, Bart Van Severen, Carlos Falgueras García,
Célestin Marot, David Svensson Fors, Edward Hervey, Enrique Ocaña González,
Frank Dana, Guillaume Desmottes, He Junyan, James Hilliard,
Jan Alexander Steffens (heftig), Jan Schmidt, Jordan Petridis,
Mathieu Duponchelle, Matthew Waters, medithe, Mengkejiergeli Ba,
Nicolas Beland, Nirbheek Chauhan, Patricia Muscalu, Pawel Stawicki,
Philippe Normand, Piotr Brzeziński, Rajneesh Soni, Robert Rosengren,
Sanchayan Maity, Sebastian Dröge, Seungha Yang, Simon Himmelbauer,
Thibault Saunier, Tim-Philipp Müller, Tristan van Berkom, U. Artie Eoff,
Víctor Manuel Jáquez Leal, Vivia Nikolaidou, Xuchen Yang, Yinhang Liu,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.22.1

- [List of Merge Requests applied in 1.22.1](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.22.1)
- [List of Issues fixed in 1.22.1](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.22.1)

<a id="1.22.2"></a>

### 1.22.2

The second 1.22 bug-fix release (1.22.2) was released on 11 April 2023.

This release only contains bugfixes and it *should* be safe to update
from 1.22.x.

#### Highlighted bugfixes in 1.22.2

 - avdec_h264: fix decoder deadlocks with FFmpeg 6.0
 - rtspsrc: fix regression with URI protocols in OPTIONS requests for RTSP over TLS
 - rtspsrc: improved control url handling compatibility for broken servers
 - decklink: fix 10 bit RGB (r210) format auto detection for capture and fix playout if video caps are configured before audio caps
 - d3d11videosink: Fix tearing in case of fullscreen mode
 - playbin: fix deadlock when stopping stream with subtitles visible (even more)
 - typefinding: fix regression not detecting application/dash+xml in some corner cases
 - osxvideosink: fix broken aspect ratio and frame drawing region
 - decodebin3, parsebin: Improve elementary stream handling when decoders are not present and fix hang when removing a failing stream
 - urisourcebin: Propagate sticky events from parsebin, so that the `STREAM_START` event with the `GstStream` info is always available when pads get exposed
 - v4l2: Add support for YVU420M format; mark JPEG content as parsed
 - h264decoder, h265decoder: DPB bumping process and latency reporting fixes
 - Opus: Fix reading of extended channel config in MPEG-TS and fix missing sample rate when remuxing from RTP to Matroska
 - zxing: add support for building against zxing-c++ 2.0
 - cerbero: Fix packaging of Rust plugins on Android; fix modern Gentoo distro detection
 - various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [datetime: Return `G_MAXFLOAT` instead of `G_MAXDOUBLE` for no timezone offset](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4285)
 - [inputselector: Wake up streaming thread before PLAYING_TO_PAUSED transition](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4196)
 - [tools: fix potential crash when passing command-line options on Windows](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4322)

#### gst-plugins-base

 - [alsasink: Fix for being stuck in `stop_streaming_threads` state](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4321)
 - [decodebin3: fix hang when removing a failing stream](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4284)
 - [gl: wayland: cleanup on close](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4355)
 - [parsebin: Improve elementary stream handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4237)
 - [playbin: fix deadlock when stopping stream with subtitles visible even more](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1772)
 - [sdp: Skip source-specific caps fields when creating an SDP media from caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4344)
 - [urisourcebin: Propagate sticky events from parsebin](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4218)
 - [urisourcebin: Activate pad before transferring sticky events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4233)
 - [typefinding: fix failure to recognize application/dash+xml in some cases](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4302)

#### gst-plugins-good

 - [osxvideosink: fix broken aspect ratio and frame drawing region](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4346)
 - [qtdemux: Fix seek adjustment with `SNAP_AFTER` flag](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4251)
 - [rtpopusdepay, matroskamux: Fix invalid rate while muxing Opus in Matroska](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4172)
 - [rtpmanager: twcc: Fix duplicate packet handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4378)
 - [rtsp: url: fix incorrect request URI scheme for TLS transport methods (regression)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4294)
 - [rtspsrc: Consider "451: Parameter Not Understood" when handling broken control urls](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4129)
 - [rtspsrc: fix behavior change with URI protocols in OPTIONS requests](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2412)
 - [rtspsrc: Skip PTs with caps incompatible to the global caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4343)
 - [rtpjpegdepay: fix logic error when checking if an end of image (EOI) tag is present](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4269)
 - [v4l2: Add support for YVU420M format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4318)
 - [v4l2: mark JPEG as parsed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4247)
 
#### gst-plugins-bad

 - [cea708overlay: fix HCR interpretation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4141)
 - [d3d11bufferpool: Fix invalid access in debug print loop](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4258)
 - [d3d11compositor: Fix composition error on release_pad()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4186)
 - [d3d11converter: Fix conversion backend selection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4189)
 - [d3d11videosink: Fix tearing in case of fullscreen mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4188) - d3d11bufferpool: Fix invalid access in debug print loop
 - [d3d11window: fix memory leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4382)
 - [decklink: fix 10 bit RGB (r210) format auto detection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4342)
 - [decklinkaudiosink: Fix playback when video caps is configured before audio](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4368)
 - [decklinkvideosrc:  RGB 4:4:4 doesn't work after GStreamer upgrade (regression)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2391)
 - [decklinkvideosrc: unable to show HDMI stream that Blackmagic's Media Express is able to see](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1769)
 - [debugqroverlay: fix string leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4380)
 - [gtkwaylandsink: Destroy GstWlWindow when parent GtkWindow is destroyed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4312)
 - [gtkwaylandsink: Fix crash when rendering after the window is closed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4238)
 - [ksvideo, directshow: Fix reference leaks in device providers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4227)
 - [h264decoder: Fix DPB bumping process](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4219)
 - [h264decoder, h265decoder: Latency reporting related fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4383)
 - [h264parse: Validate VUI framerate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4131)
 - [jpegparse: reset parse state when the SOI is not the first marker](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4130)
 - [nvencoder: Fix CQP option setting](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4217)
 - [nvh264encoder: Fix template caps to include progressive mode as well](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4253)
 - [openjpegdec: allow multithread decoding only in subframe mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4275)
 - [tsdemux: Fix reading of extended Opus channel configuration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4221)
 - [vulkan: fix validation layer issues](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4311)
 - [vulkanoverlaycompositor: fix potential use after free](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4147)
 - [vulkanswapper: correctly handle force-aspect-ratio=false](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4290)
 - [wasapi2: Fix potential crash on device activation failure](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4207)
 - [webrtc: Fix segfault traversing ice transports](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4213)
 - [webrtc: patch leak caused by early return](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4206)
 - [zxing: add support for zxing-c++ 2.0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4148)

#### gst-plugins-ugly

 - No changes

#### gst-libav

 - [avdec_h264 pipeline freeze with FFmpeg6](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2383)
 - [avdeinterlace, avmux: fix element reference leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4385)
 - [avviddec: Drop decoder stream lock when calling send_packet](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4187)

#### gst-rtsp-server

 - [rtsp-server: fix deadlock on shutdown with non-live pipeline if media isn't playing/prerolled yet and eos-shutdown is enabled for the media](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4345)

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

#### gst-validate + gst-integration-testsuites

 - No changes

### gst-examples

 - No changes

#### Development build environment

 - [git: prevent CRLF line ending conversion for patches to fix pango subproject patching issues on Windows](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4314)

#### Cerbero build tool and packaging changes in 1.22.2

 - [build: retry rust build on SIGBUS errors too](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1155)
 - [Fix packaging of rust plugins on Android](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1141)
 - [﻿Modern Gentoo distro adaptation](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1160)
 - [sbc: update to 2.0](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1135)
 - [speex: update to 1.2.1](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1142)

#### Contributors to 1.22.2

Adrien De Coninck, Albert Sjölund, Alexande B, Antonio Rojas,
Arun Raghavan, Bart Van Severen, Carlo Cabrera, Colin Kinloch, Edward Hervey,
Guillaume Desmottes, Haihua Hu, He Junyan, Ilie Halip, Jordan Petridis,
Josef Kolář, Lily Foster, Mathieu Duponchelle, Matt Feury, Matthew Waters,
Maxim P. Dementyev, Michael Tretter, Nicolas Dufresne, Nirbheek Chauhan,
Piotr Brzeziński, Robert Rosengren, Rouven Czerwinski, Sebastian Dröge,
Seungha Yang, Shengqi Yu, Stéphane Cerveau, Talha Khan, Thibault Saunier,
Tim-Philipp Müller, Víctor Manuel Jáquez Leal, Vivia Nikolaidou,
Wang Chuan, Wojciech Kapsa,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.22.2

- [List of Merge Requests applied in 1.22.2](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.22.2)
- [List of Issues fixed in 1.22.2](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.22.2)

<a id="1.22.3"></a>

### 1.22.3

The third 1.22 bug-fix release (1.22.3) was released on 19 May 2023.

This release only contains bugfixes and it *should* be safe to update
from 1.22.x.

#### Highlighted bugfixes in 1.22.3

 - avdec: fix occasional video decoder deadlock on seeking with FFmpeg 6.0
 - decodebin3: fix regression handling input streams without CAPS or TIME segment such as e.g. `udpsrc` or `pushfilesrc
 - bluez: a2dpsink: fix Bluetooth SIG Certification test failures
 - osxvideosink: fix deadlock upon closing output window
 - qtdemux: fix edit list handling regression and AV1 codec box parsing
 - qtmux: fix extraction of CEA608 closed caption data from S334-1A packets
 - rtspsrc: Fix handling of `*` control path
 - splitmux: timestamp handling improvements
 - v4l2videodec: Rework dynamic resolution change handling (needed for IMX6 mainline codec)
 - videoflip: fix regression with automatically rotating video based on tags
 - d3d11: many d3d11videosink and d3d11compositor fixes
 - webrtc, rtp: numerous data race fixes and stability fixes
 - various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [tracing: Initialize tracing infrastructure even if the debug system is not compiled in](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4424)
 - [parse-launch: fix missing unref of looked-up child element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4624)
 - [gstutils: Add category and object to most logging messages](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4615)

#### gst-plugins-base

 - [allocators: Fix fdmem unit test with recent GLib versions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4422)
 - [audiotestsrc: Initialize all samples in wave=ticks mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4476)
 - [decodebin3: Handle input streams without CAPS or TIME segment such as e.g. `udpsrc` or `pushfilesrc`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4499)
 - [decodebin3: fix regression handling streams without caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2521)
 - [decodebin3: fix random hang when remove failing stream](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4656)
 - [uridecodebin3: Ensure atomic urisourcebin state change](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4620)
 - [glvideoflip: fix leaked caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4420)
 - [glcontext_wgl: fix missing unref](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4419)
 - [playsink: Fix volume leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4463)

#### gst-plugins-good

 - [adaptivedemux2: fix critical when using an unsupported URI](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4421)
 - [dashdemux2: mpdclient: fix divide by 0 if segment has no duration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4441)
 - [imagesequencesrc: Properly set default location](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4425)
 - [multifile: error out if no filename was set](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4429)
 - [osxvideosink: fix deadlock upon closing output window](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4627)
 - [rtpmanager: rtpsession: data race leading to critical warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4585)
 - [rtpmanager: rtpsession: race conditions leading to critical warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4532)
 - [rtspsrc: Fix handling of `*` control path](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4503)
 - [splitmuxsink: Catch invalid DTS to avoid running into problems later](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4515)
 - [splitmuxsrc: Make PTS contiguous by preference](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4660)
 - [qtdemux: emit no-more-pads after pruning old pads](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4557)
 - [Revert "qtdemux: fix conditions for end of segment in reverse playback" to fix edit list regression](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4605)
 - [qtdemux: Fix av1C parsing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4435)
 - [qtmux: Fix extraction of CEA608 data from S334-1A packets](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4645)
 - [qtwindow: unref caps in destructor](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4418)
 - [v4l2: device provider: Fix GMainLoop leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4539)
 - [v4l2: videodec: Rework dynamic resolution change handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4525)
 - [v4l2: videodec: Prefer acquired caps over anything downstream](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4426)
 - [videoflip: fix setting of method property at construction time](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4551)
 - [videoflip 1.22.2 not rotating video when extracting frames](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2529)
 
#### gst-plugins-bad

 - [a2dpsink: Fails many tests in Bluetooth SIG Certification](https://gitlab.freedesktop.org/gstreamer/gst-plugins-bad/-/issues/1698)
 - [avdtputil: Use int instead of int range for fixed bitpool values](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4655)
 - [ccconverter: reintroduce frame count reset on cycle completion](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4453)
 - [ccconverter: integer overflow & crashing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2500)
 - [codectimestamper: remove PC file generation from plugin's own meson.build](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4520)
 - [cudamemory: Fix for semi planar YUV memory size decision](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4506)
 - [d3d11compositor: Reconfigure resource only when output caps is changed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4440)
 - [d3d11compositor: Skip zero alpha input](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4456)
 - [d3d11convert: Fix for runtime property update](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4652)
 - [d3d11memory: Don't clear wrapped texture memory](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4558)
 - [d3d11videosink: Fix for ignored initial render rectangle](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4496)
 - [d3d11videosink: fix race condition in window unprepare](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4417)
 - [d3d11videosink: Enhancement for initial window size decision](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4416)
 - [d3d11videosink: Don't clear prepared buffer on unlock_stop()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4596)
 - [dashdemux: mpdclient: fix divide by 0 if segment has no duration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4441)
 - [dtlstransport: Keep strong ref of dtls encoder/decoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4526)
 - [GstPlay: avoid getting property of playbin2 if subtitle_sid is null](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4661)
 - [GstPlay: fix critical log when using playbin3](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4666)
 - [h264decoder: Drop nonexisting picture silently without error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4586)
 - [dtmf: element classification improvements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4584)
 - [mfvideoenc: Allow only even resolution numbers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4548)
 - [sctpenc: Fix potential shutdown deadlock](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4636)
 - [srtpdec: fix "srtp-key" check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4423)
 - [tests: disable dtls test if openssl is not present](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4483)
 - [tsdemux: Set number of channels to 2 for dual mono Opus](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4446)
 - [va: Various fixes for defects found with MSVC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4614)
 - [wasapi2: Allows process loopback capture on Windows 10](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4517)
 - [webrtcdatachannel: Bind to parent webrtcbin using a weak reference](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4580)
 - [webrtcbin: Fix potential deadlock when closing before any data was sent](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4533)
 - [webrtc: Plug leaks of resolved ICE addresses](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4482)
 - [webrtc: do not tear down data channel before data is flushed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4633)

#### gst-plugins-ugly

 - [mpegpsdemux: Rework gap sending](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4623)

#### gst-libav

 - [avviddec: Temporarily unlock stream lock while flushing buffers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4625)
 - [Random freeze and deadlock in ffmpegviddec flush and get_buffer while seeking](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2558)

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

 - [ges: base-xml-formatter: Don't pass non-GObject pointers to GST_DEBUG_OBJECT](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4444)

#### gst-validate + gst-integration-testsuites

 - No changes

### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.22.3

 - [glib: Ship Windows process spawning helpers](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1178)
 - [recipes: add recipe for libltc for timecodestamper element](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1176)
 - [Add support for RHEL9 and Rocky Linux](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1172)

#### Contributors to 1.22.3

Aleksandr Slobodeniuk, Antonio Kevo, Arun Raghavan, Carlos Rafael Giani,
Daniel Moberg, Edward Hervey, Elliot Chen, François Laignel,
Guillaume Desmottes, Haihua Hu, Jan Alexander Steffens (heftig), Jan Beich,
Jan Schmidt, Johan Sternerup, John King, Jordan Petridis, Juan Navarro,
Lily Foster, Martin Nordholts, Mathieu Duponchelle, Matthew Waters,
Matthias Fuchs, Michael Olbrich, Mihail Ivanchev, Nick Steel,
Nicolas Dufresne, Nirbheek Chauhan, Patricia Muscalu, Philippe Normand,
Piotr Brzeziński, Sanchayan Maity, Sebastian Dröge, Seungha Yang,
Stéphane Cerveau, Thibault Saunier, Tim-Philipp Müller,
Xabier Rodriguez Calvar,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.22.3

- [List of Merge Requests applied in 1.22.3](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.22.3)
- [List of Issues fixed in 1.22.3](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.22.3)

<a id="1.22.4"></a>

### 1.22.4

The fourth 1.22 bug-fix release (1.22.4) was released on 20 June 2023.

This release only contains bugfixes and security fixes and it *should* be safe
to update from 1.22.x.

#### Highlighted bugfixes in 1.22.4

 - [Security fixes](gstreamer.freedesktop.org/security/) for flacparse, dvdspu, and subparse
 - d3d11videosink: Fix error on pause and play
 - decklink: Correctly handle SDK strings on macOS and free strings after usage on Linux
 - filesink: Fix buffered mode writing of buffer lists and buffers with multiple memories
 - gldownload: handle passthrough without a critical
 - h265parse: Fix framerate handling regression
 - oggdemux: vp8 fixes
 - mp4mux, qtmux, qtdemux: Opus audio mapping fixes
 - pngdec: Fix wrong colours output from 16bit RGB images
 - ptp clock: Work around ptpd bug in default configuration
 - srtpdec: fix critical warnings on shutdown
 - v4l2src: fix support for bayer format
 - v4l2videoenc: support force-keyframe event in v4l2 encoder
 - vtenc: apply DTS offset to ensure DTS <= PTS
 - gst-python: allow more functions to be called before gst_init()
 - cerbero: fix vaapi variant; add qt6 build on windows; ensure errors on unguarded use of new APIs, require macOS 10.13
 - packages: ship codecalpha, rtponvif, dvbsubenc, switchbin, videosignal plugins; fix pango crash on 32-bit windows
 - various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [filesink: Fix buffered mode writing of buffer lists and buffers with multiple memories](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4817)
 - [basesink: Clear EOS flag on STREAM-START event](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4797)
 - [typefindhelper: downgrade bogus error level debug log message](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4859)
 - [ptp: Correctly parse clock ID from the commandline parameters in the helper](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4813)
 - [ptp: Work around bug in ptpd in default configuration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4683)

#### gst-plugins-base

 - [alsasink: Fix stall for transition from PAUSED to READY with USB speakerphone.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4699)
 - [appsink: unref buffer in prev sample early so buffers from v4l2 can be released properly](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4820)
 - [basetextoverlay: Fix typo in "text-y" property description](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4827)
 - [gldownload: handle passthrough without a critical](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4800)
 - [glfilter: add parent meta to output buffer for input buffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4846)
 - [oggdemux: vp8: Push headers downstream and detect keyframe packets](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4745)
 - [opus: Fix potential crash when getting unexpected channel position](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4843)
 - [streamsynchronizer: reset eos on STREAM_START](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4755)
 - [subparse: Look for the closing `>` of a tag after the opening `<`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4898)
 - [video: convertframe: Add D3D11 specific conversion path](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4689)
 - [videometa: Only validate the alignment only when it contains some info](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4704)
 - [video-blend: Fix linking error with C++](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4735)

#### gst-plugins-good

 - [flacparse: Avoid integer overflow in available data check for image tags](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4897)
 - [flvmux: use the correct timestamp to calculate wait times](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4734)
 - [isomp4: Fix (E)AC-3 channel count handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4773)
 - [jpegdec: fixes related to interlaced jpeg](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4717)
 - [pngdec: Fix wrong colours output from 16bit RGB images](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4759)
 - [qtmux, qtdemux: fix byte order for opus extension](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4891)
 - [rtspsrc: Do not try send dropped get/set parameter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4799)
 - [qt5, qt6: Add more meson options and eliminate all automagic](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4776)
 - [qt: glrenderer: don't attempt to use QWindow from non-Qt main thread](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4744)
 - [qml6glsink: Support building on win32](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4762)
 - [v4l2src: fix support for bayer format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4867)
 - [v4l2: Change to query only up to V4L2_CID_PRIVATE_BASE+V4L2_CID_MAX_CTRLS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4851)
 - [v4l2videodec: treat MPEG-1 format as MPEG-2](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4787)
 - [v4l2videoenc: support force keyframe event in v4l2 encoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4702)
 - [tests: rtpbin_buffer_list: fix possible unaligned write/read on 32-bit ARM](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4855)

#### gst-plugins-bad

 - [asfmux: fix possible unaligned write on 32-bit ARM](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4855)
 - [d3d11videosink: Fix error on pause and play](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4714)
 - [d3dvideosink: Fix navigation event leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4868)
 - [decklink: Correctly handle SDK strings on macOS and free strings after usage on Linux](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4786)
 - [dvdspu: Make sure enough data is allocated for the available data](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4899)
 - [fdkaacdec: Support up to 5 rear channels](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4740)
 - [h265parse: Fix framerate handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4352)
 - [kmssink: Add STM32 LTDC and NXP i.MX8M Plus LCDIFv3 auto-detection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4872)
 - [sdpdemux: ensure that only one srcpad is created per stream](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4873)
 - [srtpdec: fix critical warnings on shutdown](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4860)
 - [testsrcbin: Remove spurious caps unref](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4685)
 - [va: map the mbbrc to correct enum value in get_property()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4870)
 - [vtenc: apply DTS offset to ensure DTS <= PTS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4282)
 - [vtdec: time glitches on h264 playback](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2357)
 - [waylandsink: Emit "map" signal boarder surface is ready](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4754)

#### gst-plugins-ugly

 - No changes

#### gst-libav

 - No changes

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - [vaapidecodebin: don't load vaapipostproc if not available](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4871)

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - [python: More functions can be called before gst_init()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4763)
 
#### gst-editing-services

 - [ges: launcher: Never put sinks in a GstPipeline](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4743)

#### gst-validate + gst-integration-testsuites

 - No changes

### gst-examples

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.22.4

 - [Ship codecalpha, rtponvif, dvbsubenc, switchbin, videosignal plugins](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1189)
 - [pango: Fix crash on Windows 32bit build](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1184)
 - [qml6: Add support for building the qml6 plugin on Windows and bump meson to 1.1.1](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1200)
 - [vaapi: update vaapi variant/recipe for meson option changes](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1195)
 - [packages: Put libass in the same category as assrender](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1202)
 - [cerbero: Don't extract if already extracted in fetch](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1199)
 - [darwin: Ensure errors on unguarded use of new APIs, require macOS 10.13](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1117)

#### Contributors to 1.22.4

Andoni Morales Alastruey, Arun Raghavan, Colin Kinloch, Daniel Morin,
Edward Hervey, ekwange, Elliot Chen, François Laignel, Guillaume Desmottes,
Haihua Hu, He Junyan, Hou Qi, Jan Alexander Steffens (heftig),
Jochen Henneberg, Jordan Petridis, Kevin Song, Maksym Khomenko, Marek Vasut,
Mathieu Duponchelle, Matthew Waters, Mengkejiergeli Ba, Michael Olbrich,
Nicolas Beland, Nicolas Dufresne, Nirbheek Chauhan, Philippe Normand,
Piotr Brzeziński, Sebastian Dröge, Seungha Yang, Thibault Saunier,
Tim-Philipp Müller, Víctor Manuel Jáquez Leal, William Manley,
Xavier Claessens, Yuri Fedoseev,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.22.4

- [List of Merge Requests applied in 1.22.4](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.22.4)
- [List of Issues fixed in 1.22.4](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.22.4)

## Schedule for 1.24

Our next major feature release will be 1.24, and 1.23 will be the unstable
development version leading up to the stable 1.24 release. The development
of 1.23/1.24 will happen in the git `main` branch of the GStreamer mono
repository.

The plan for the 1.24 development cycle is yet to be confirmed.

1.24 will be backwards-compatible to the stable 1.22, 1.20, 1.18, 1.16, 1.14, 1.12, 1.10, 1.8, 1.6, 1.4, 1.2 and 1.0 release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller with contributions from Edward Hervey, Matthew Waters, Nicolas Dufresne, Nirbheek Chauhan, Olivier Crête, Sebastian Dröge, Seungha Yang, and Thibault Saunier.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
