# GStreamer 1.26 Release Notes

GStreamer 1.26.0 was originally released on 11 March 2025.

The latest bug-fix release in the stable 1.26 series is [1.26.5](#1.26.5) and was released on 07 August 2025.

See [https://gstreamer.freedesktop.org/releases/1.26/][latest] for the latest version of this document.

*Last updated: Thursday 07 August 2025, 18:00 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.26/
[gitlog]: https://gitlab.freedesktop.org/gstreamer/www/commits/main/src/htdocs/releases/1.26/release-notes-1.26.md
 
<a id="introduction"></a>
## Introduction

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with many new features, bug fixes, and other improvements.

<a id="highlights"></a>
## Highlights

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

<a id="major-changes"></a>
## Major new features and changes

<a id="h266-vvc"></a>
### H.266 Versatile Video Coding (VVC) codec support

- The H.266 / VVC video codec is a successor to H.265 / HEVC and is
  standardised in ISO/IEC 23090-3.

- A **new h266parse element** was added, along with parsing API, typefinding
  support and some codec utility functions in the gst-plugins-base utility
  library.

- A **H.266 decoder base class for hardware-accelerated decoders** was added
  and used to implement a **VA-API-based hardware-accelerated H.266 decoder**.

- The **FFmpeg H.266 decoder** is exposed now (from FFmpeg 7.0 onwards).

- **H.266 / VVC muxing and demuxing support was implemented for MP4, Matroska**
  **and MPEG-TS** containers.

- A **VVdeC-based H.266 decoder element** was added to the Rust plugins,
  based on the Fraunhofer Versatile Video Decoder library.

<a id="jpeg-xs"></a>
### JPEG XS image codec support

- [JPEG XS][jpeg-xs] is a visually lossless, low-latency, intra-only video
  codec for video production workflows, standardised in ISO/IEC 21122.

- **JPEG XS encoder and decoder elements** based on the [SVT JPEG XS library][svt-jpeg-xs]
  were added, including support for **muxing JPEG XS into MPEG-TS** and
  demuxing it. Both interlaced and progressive modes are supported.

[jpeg-xs]: https://en.wikipedia.org/wiki/JPEG_XS
[svt-jpeg-xs]: https://github.com/OpenVisualCloud/SVT-JPEG-XS/

<a id="lvecv"></a>
### Low Complexity Enhancement Video Coding (LCEVC) support

- [LCEVC][lcevc] is a codec that provides an enhancement layer on top of
  another codec such as H.264 for example. It is standardised as MPEG-5 Part 2.

- **LCEVC encoder and decoder elements** based on V-Nova's SDK libraries
  were added, including support in `h264parse` for **extracting the enhancement**
  **layer from H.264 and decoding it** via a `lcevch264decodebin` element.

[lcevc]: https://www.lcevc.org

<a id="closedcaptions"></a>
### Closed captions improvements

- New **H.264 and H.265 closed captions extractor and inserter elements**.

  - These extractor elements don't actually extract captions from the bitstream,
    but rely on parser elements to do that and add them to buffers in form of
    caption metas. The problem is that streams might contain B-frames, in which
    case the captions in the bitstream will not be in presentation order and
    extracting them requires frame-reordering in the same way that a decoder
    would do. These new elements will do exactly that and allow you to extract
    captions in presentation order without having to decode the stream.

  - The inserter elements do something similar and insert caption SEIs into
    the H.264 or H.265 bitstream, taking into account frame ordering.

  - This is useful if one wants to extract, process and re-insert captions
    into an existing video bitstream without decoding and re-encoding it
    (in which case the decoder and encoder would handle the caption reordering).

- **cdpserviceinject**: New element for injecting a CDP service descriptor
  into closed caption CDP packets

- **cea708overlay**: New element for overlaying CEA608 / CEA708 closed
  captions over video streams.

- The **cc708overlay element has been deprecated in favour of the**
  **cea708overlay element** from the Rust plugins set.

- **cea608mux** gained a `"force-live"` property to make it always 
  in live mode and aggregate on timeout regardless of whether any live
  sources are linked upstream.

- **cea708mux**: New element that allows to mux multiple CEA708 services
  into a single stream.

- **cccombiner** has two new properties:

  - `"input-meta-processing"` controls how input closed caption metas are
    processed and can be used to e.g. discard closed captions from the input
    pad if the matching video buffer already has closed caption on it.

  - `"schedule-timeout"` to support timing out captions without EOS

- **tttocea708**: New element for converting timed-text to CEA708 closed captions

- Miscellaneous improvements and spec compliance fixes

<a id="stt-translations-and-speech-synthesis"></a>
### Speech to Text, Translation and Speech Synthesis

- **awstranscriber2**, **awstranslate**: New elements around the
  AWS transcription and translation services.

- **polly**: New element around the AWS text-to-speech polly services

- **speechmatics**: New transcriber / speech-to-text and translation element

- **translationbin**: Helper bin around translation elements, similar to the
  already existing `transcriberbin` for transcriptions.

<a id="adaptive-streaming"></a>
### HLS DASH adaptive streaming improvements

- The **adaptivedemux2 client** implementation gained support for file:// URIs
  and as such the **ability to play HLS and DASH from local files**. It also no
  longer sends spurious flush events when it loses sync in live streams, as
  that is unexpected and will be handled poorly in non-playback scenarios.
  Lastly, **support for HTTP request retries** was added via the `"max-retries"`
  property, along with some exponential backoff logic which can be fine-tuned
  via properties.

- **dashsink** has received period duration fixes for dynamic MPDs and
  some memory leak fixes.

- **hlscmafsink**, **hlssink3**: New single-variant HLS sink elements that
  can output CMAF (fMP4) or MPEG-TS fragments.

- **hlsmultivariantsink**: New sink element that can output an HLS stream
  with multiple variants

<a id="splitmux"></a>
### splitmuxsrc, splitmuxsink: lazy loading and dynamic fragment addition

- **splitmuxsrc** and **splitmuxsink** were originally designed to handle a small
  number of large file fragments, e.g. for situations where one doesn't want
  to exceed a certain file size when recording to legacy file systems. It was
  also designed for playing back a static set of file fragments that have been
  created by an earlier recording session and no longer changes. Over time
  people have found more applications and use cases for the splitmux elements
  and have been deploying them in different scenarios, exposing the limits of
  the current implementation.
  
- In this release, **splitmuxsink** and **splitmuxsrc** gained new abilities aimed at
  improving **support for recordings with a large number of files**, and for
  **adding fragments on the fly to allow playback of ongoing recordings**:

  - You can now add fragments directly to **splitmuxsrc** and provide the offset
    and duration in the stream:

     - Providing offset and duration means **splitmuxsrc** doesn't need to scan the
       file to measure it and calculate it. That makes for much faster startup.

     - The new `"add-fragment"` signal can be used to add files to the set
       dynamically - allowing to be playing an ongoing recording and adding
       files to the playback set as they are finished.

  - **splitmuxsrc** no longer keeps all files open, but instead only keeps
     100 files open by default, configurable with the `"num-open-fragments"`
     property.

  - There is a new `"num-lookahead"` property on **splitmuxsrc** to trigger
    (re)opening files a certain distance ahead of the play position.

  - **splitmuxsink** will report fragment offset and fragment duration via
    a message on the bus when closing a file. This information can then be
    used to add the new fragment to a **splitmuxsrc**.

<a id="mpeg-ts"></a>
### MPEG-TS container format improvements

- The **MPEG-TS muxer and demuxer** gained support for
  - **H.266 / VVC video** muxing and demuxing
  - **JPEG-XS video** muxing and demuxing
  - **VP9 video** muxing and demuxing (using a [custom mapping][mpegts-vp9])
  - **AV1 video** muxing and demuxing (using a [custom mapping][mpegts-av1], since
    the work-in-progress specification effort doesn't seem to be going anywhere
    anytime soon)
  - **SMPTE ST-2038 ancillary metadata streams** (see section above)

- **mpegtsmux** gained support for **muxing ID3 metadata** into the TS stream,
  as well as **SMPTE 302M audio**.

- It's also possible to **disable sending SCTE-35 null (heartbeat) packets**
  now in **mpegtsmux** by setting the `"scte-35-null-interval"` to 0. 

- **tsparse** now handles 192-byte M2TS packets

- **mpegtslivesrc**: New source element that can wrap a live MPEG-TS source
  (e.g. SRT or UDP source) and provides a clock based on the PCR.

[mpegts-vp9]: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/commit/244b00ac089a6ae1ac8ca444d5fc6a0679b72154
[mpegts-av1]: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/commit/19cea52dbd8c49cf273a23b5c7a2647e56278787

<a id="matroska"></a>
### Matroska container format improvements

- **H.266 / VVC video** muxing and demuxing support

- **matroskamux**
  - was ported to the `GstAggregator` base class, ensuring **defined-latency**
    **muxing in live streaming pipelines**.
  - gained **rotation tag support**

- **matroskademux** now also supports seeks with a stop position in push mode.

<a id="isomp4"></a>
### ISO MP4 container format improvements

- can **mux and demux H.266 / VVC in MP4** now

- can **demux Hap video** now, as well as **Lagarith lossless video**
  and **ISO/IEC 23003-5 raw PCM audio**.

- **qtdemux** handles keyunit-only trick mode also in push mode now

- support for **ISO/IEC 23001-17 raw video in MP4** in **qtdemux** and
  **isomp4mux**.

- support for rotation tags in the muxers and demuxers was improved to correctly
  handle per-media and per-track rotations, and support for flips was added as well.

### SMPTE 2038 ancillary data streams

- [SMPTE 2038 (pdf)][smpte-2038-pdf] is a generic system to put VBI-style
  ancillary data into an MPEG-TS container. This could include all kinds of
  metadata such as scoreboard data or game clocks, and of course also closed
  captions, in this case in form of a distinct stream completely separate
  from any video bitstream.

- A number of new elements in the [GStreamer Rust closedcaption plugin][rsclosedcaption-plugin]
  add support for this, along with mappings for it in the MPEG-TS muxer and
  demuxer. The new elements are:

  - **st2038ancdemux**: splits SMPTE ST-2038 ancillary metadata (as received
    from `tsdemux`) into separate streams per DID/SDID and line/horizontal_offset.
    Will add a sometimes pad with details for each ancillary stream. Also has an
    always source pad that just outputs all ancillary streams for easy forwarding
    or remuxing, in case none of the ancillary streams need to be modified or
    dropped.

  - **st2038ancmux**: muxes SMPTE ST-2038 ancillary metadata streams into a
    single stream for muxing into MPEG-TS with `mpegtsmux`. Combines ancillary
    data on the same line if needed, as is required for MPEG-TS muxing. Can
    accept individual ancillary metadata streams as inputs and/or the combined
    stream from `st2038ancdemux`.

    If the video framerate is known, it can be signalled to the ancillary
    data muxer via the output caps by adding a capsfilter behind it, with
    e.g. `meta/x-st-2038,framerate=30/1`.

    This allows the muxer to bundle all packets belonging to the same frame (with
    the same timestamp), but that is not required. In case there are multiple
    streams with the same DID/SDID that have an ST-2038 packet for the same
    frame, it will prioritise the one from more recently created request pads
    over those from earlier created request pads (which might contain a
    combined stream for example if that's fed first).

  - **st2038anctocc**: extracts closed captions (CEA-608 and/or CEA-708) from
    SMPTE ST-2038 ancillary metadata streams and outputs them on the respective
    sometimes source pad (`src_cea608` or `src_cea708`). The data is output as
    a closed caption stream with caps `closedcaption/x-cea-608,format=s334-1a`
    or `closedcaption/x-cea-708,format=cdp` for further processing by other
    GStreamer closed caption processing elements.

  - **cctost2038anc**: takes closed captions (CEA-608 and/or CEA-708) as produced
    by other GStreamer closed caption processing elements and converts them into
    SMPTE ST-2038 ancillary data that can be fed to `st2038ancmux` and then to
    `mpegtsmux` for splicing/muxing into an MPEG-TS container. The `line-number`
    and `horizontal-offset` properties should be set to the desired line number
    and horizontal offset.

[rsclosedcaption-plugin]: https://gstreamer.freedesktop.org/documentation/rsclosedcaption/index.html?gi-language=c#plugin-rsclosedcaption
[smpte-2038-pdf]: https://pub.smpte.org/pub/st2038/st2038-2021.pdf

<a id="analytics"></a>
### Analytics

- Added a **GstTensorMeta**: This meta is designed to carry tensors from the
  inference element to the model-specific tensor decoder. This also includes
  a basic `GstTensor` class containing a single tensor. The actual tensor data
  is a `GstBuffer`.

- Add **`N_TO_N` relationship to GstAnalyticsRelationMeta**: This makes it
  possible to describe N-to-N relationships. For example, between classes
  and regions in an instance segmentation.

- Add a new **analytics Mtd to carry segmentation masks**: Being part of the
  `GstAnalyticsMeta`, it can be in relationship with the other Mtd, such as
  the classification and object detection bounding boxes.

- **onvifmetadataextractor**: New element that can extract ONVIF metadata
  from `GstMeta`s into a separate stream

- **originalbuffer**: New plugin with `originalbuffersave` / `originalbufferrestore`
  elements that allow saving an original buffer, modifying it for analytics,
  and then restoring the original buffer content while keeping any additional
  metadata that was added.

- **relationmeta**: New plugin with elements converting between
  `GstRelationMeta` and ONVIF XML metadata.

- **Improved Python bindings** for a more Pythonic interface when iterating
  over `GstRelationMeta`'s mtd

<a id="vulkan"></a>
### Vulkan integration enhancements

- Vulkan Integration Improvements:

  - **Memory Management**: Non-coherent memory is now invalidated when mapping
    for read in vkmemory.

  - **Color Space Selection**: The `vkswapper` component now chooses the correct
    color space based on the format.

  - **Vulkan Plugin Compatibility**: Support added for cases where `glslc` is
    not available for building Vulkan plugins, along with GLSL compiler support
    for glslang.

  - **Fullscreen Quad Updates**: Improved support for setting NULL input/output
    buffers and added checks for unset video info.

  - **Vulkan Buffer Pool Enhancements**: Buffer pool access flags and usage
    configurations have been refined, offering **better performance for video**
    **decoding and encoding**.

- Decoder/Encoder Improvements:

  - **H264 Decoder**: Enhancements to the vkh264dec component for **better**
    **support of extended profiles and interlaced content decoding**.

  - **H265 Decoder** fixes: **vkh265dec** updated for **proper handling of VPS/SPS**
    **on demand**, along with fixes to PicOrderCntVal.

  - **Encoder Performance**: Various internal optimizations to the Vulkan encoder,
    including removal of redundant references and better management of the DPB view.

- Vulkan Instance and Device Management:

  - **Device Handling**: Added new utility functions for managing Vulkan device
    instances, including `gst_vulkan_instance_create_device_with_index` and
    `gst_vulkan_ensure_element_device`.

  - **Device Context Management**: Updates to manage Vulkan context handling
    more effectively within the application.

<a id="opengl"></a>
### OpenGL integration enhancements

- **glcolorconvert** gained support for more formats and conversions:

  - Planar YUV <-> planar YUV conversions
  - Converting to and from `v210` in general
  - `v210` <-> planar YUV
  - `UYVY` and `YUY2` <-> planar YUV
  - `v210` <-> `UYVY` and `YUY2`
  - Support for `Y444_10`, `Y444_16`, `I422_10`, `I422_12` pixel formats
    (both little endian and big endian variants)

- **gldownload** can import DMABufs from a downstream pool

- **glupload** gained a DRM raw uploader

<a id="qt"></a>
### Qt5 + Qt6 QML integration improvements

- **qmlglsink**, **qml6glsink** now support `external-oes` textures, which
  allows direct DMABuf import from hardware decoders. Both also support `NV12`
  as an input format now.

- **qmlglsink** gained support for `RGB16`/`BGR16` as input format

- **qmlgl6src** can now use a downstream buffer pool when available

- **qmlgloverlay** make the depth/stencil buffer optional, which reduces
  memory bandwidth on Windows.

<a id="cuda-nvcodec"></a>
### CUDA / NVCODEC integration and feature additions

- Added **AV1 video encoder** **nvav1enc**

- CUDA mode `nvcuda{CODEC}enc` **encode elements are renamed** to `nv{CODEC}enc`
  and old `nv{CODEC}enc` implementations are removed

- Added **support for CUDA Stream-Ordered allocator**

- Added **cudacompositor element** which is equivalent to the software `compositor`
  element but uses CUDA

- Added support for **CUDA kernel precompile at plugin build time** using `nvcc`
  and NVCODEC plugin can cache/reuse compiled CUDA CUBIN/PTX

- **cudaupload and cudadownload elements can support Jetson platform’s NVMM memory**
  in addition to already supported desktop NVMM memory

- Introduced **nvdswrapper** plugin which uses NVIDIA DeepStream SDK APIs with
  `gst-cuda` in an integrated way:
  - **nvdsdewarp**: NVIDIA `NVWarp360` API based **dewarping element**

<a id="d3d12"></a>
### GStreamer Direct3D12 integration

- **New gst-d3d12 public library**. The following elements are integrated with the `gst-d3d12` library:
  - NVIDIA `NVCODEC` decoders and encoders can support D3D12 memory
  - Intel `QSV` encoders can accept D3D12 memory
  - All elements in `dwrite` plugin can support D3D12 memory

- The `d3d12` library and plugin can be built with **MinGW toolchain** now
  (in addition to MSVC)

- D3D12 video decoders and **d3d12videosink** are promoted to have higher rank than D3D11 elements

- Added **support for multiple mip-levels D3D12 textures**:

  - Newly added **d3d12mipmapping element** can generate D3D12 textures
    with multiple mip-levels

  - `max-mip-levels` property is added to **d3d12convert****, d3d12video**sink,
    and **d3d12swapchainsink** element, so that the elements can generate an
    intermediate texture with multiple mip-levels in order to reduce downscale
    aliasing artifacts

- **d3d12convert**, **d3d12videosink**, and **d3d12swapchainsink** support
   the `GstColorBalanceInterface` to offer **color balancing functions**
   **such as hue, saturation, and brightness adjustment**

- Added **d3d12ipcsink** and **d3d12ipcsrc** elements for **zero-copy GPU memory**
  **sharing between processes**

- **d3d12upload** and **d3d12download** support **direct GPU memory copy between**
  **D3D12 and D3D12 resources**

- Added **d3d12swapchainsink element to support `DirectComposition`**
  **or `UWP/WinUI3 SwapChainPanel` based applications**

- Added **d3d12deinterlace** element which performs **deinterlacing using a**
  **GPU vendor agnostic compute shader**.

- **d3d12screencapturesrc** element can **capture HDR enabled desktop correctly**
  **in DDA mode (DXGI Desktop Duplication API)**

<a id="aja-decklink"></a>
### Capture and playout cards support

- **ajasrc**: Improve clock handling, frame counting, capture timestamping,
  and signal loss recovery

- The **Blackmagic Decklink** plugin gained support

  - for **HDR output and input (PQ + HLG static metadata)**
  
  - all modes of **Quad HDMI recorder**

  - **scheduling frames** before they need to be displayed in decklinkvideosink

<a id="rtp"></a>
### RTP and RTSP stack improvements

- **rtspsrc** now supports **client-managed MIKEY key management**.
  Some RTSP servers (e.g. Axis cameras) expect the client to propose the
  encryption key(s) to be used for SRTP / SRTCP. This is required to allow
  re-keying. This mode can be enabled by enabling the `"client-managed-mikey-mode"`
  property and comes with a number of new signals (`"request-rtp-key"` and
  `"request-rtcp-key"`), action signals (`"set-mikey-parameter"` and `"remove-key"`)
  and properties (`"hard-limit"` and `"soft-limit"`).

- **rtpbin**: Add **new "never" and "ntp" RTCP sync modes**
  - Never is useful for some RTSP servers that report plain garbage both via
    RTCP SR and RTP-Info, for example.
  - NTP is useful if synchronization should only ever happen based on RTCP
    SR or NTP-64 RTP header extensions.

  This is part of a bigger **refactoring of the synchronization / offsetting**
  code in `rtpbin`, which also makes it regularly emit the sync signal even if
  no new synchronisation information is available, controlled by the new
  `"min-sync-interval"` property.

- **rtpjitterbuffer**: add RFC7273 active status to jitterbuffer stats so
  applications can easily check whether RFC7273 sync is active.

- **rtph265depay**: Add `"wait-for-keyframe"` `"request-keyframe"` properties and improve request keyframe logic

- **rtppassthroughpay** gained the ability to regenerate RTP timestamps from
  buffer timestamps via the new `"retimestamp-mode"` property. This is useful
  in a relay RTSP server if one wants to do full drift compensation and ensure
  that the stream coming out of gst-rtsp-server is not drifting compared to the
  pipeline clock and also not compared to the RTCP NTP times.

- New **Rust RTP payloaders and depayloaders** for AC3, AMR, JPEG, KLV,
  MPEG-TS (MP2T), MPEG-4 (MP4A, MP4G), Opus, PCMU (uLaw), PCMA (aLaw), VP8, VP9.

- New **rtpbin2** based on separate **rtprecv** and **rtpsend** elements

<a id="webrtc"></a>
### WebRTC improvements

- **webrtcbin** improvements

  - **Make basic rollbacks work**

  - Add **`"reuse-source-pads"` property**: When set to FALSE, if a transceiver
    becomes send-only or inactive then pre-existing source pads will receive
    an EOS event and no further traffic even after further renegotiation.
    When TRUE, pads will simply not receive any output when the negotiated
    transceiver state doesn't have incoming traffic. If renegotiated later,
    the pad will receive data again.

  - **Early CNAME support** (RFC5576): Have CNAME available to the jitterbuffer
    before the the first RTCP SR is received, for rapid synchronization.

  - New **`"post-rtp-aux-sender"` signal** to allow for placement of an object
    after rtpbin, before sendbin. This is useful for objects such as congestion
    control elements, that don't want to be burdened by the synchronization
    requirements of rtpsession.

  - Create and associate transceivers earlier in negotiation, and other
    **spec compliance improvements**

  - **Statistics generation improvements for bundled streams**

- **webrtcsink** improvements:

  - Support for more encoders: **nvv4l2av1enc**, **vpuenc_h264** (for imx8mp),
    **nvav1enc**, **av1enc**, **rav1enc** and **nvh265enc**.

  - The new `"define-encoder-bitrates"` signal allows applications to
    **fine-tune the bitrate allocation for individual streams** in cases
    where there are multiple encoders. By default the bitrate is split
    equally between encoders.

  - A generic mechanism was implemented to forward metas over the control channel.

  - Added a mechanism for **SDP munging to handle server-specific quirks**.

  - Can expose a **built-in web server and signalling server** for prototyping
    and debugging purposes.

- **webrtcsink** and **webrtcsrc** enhancements:

  - Support for raw payloads, i.e. **uncompressed audio and video**

  - **NTP & PTP clock signalling and synchronization support** (RFC 7273)

  - Generic data channel control mechanism for sending upstream events back
    to the sender (webrtcsink)

- **webrtcsrc** now has support for multiple producers

<a id="new-plugins"></a>
## New elements and plugins

- Many exciting **new Rust elements**, see Rust section below.

- **webview2src**: new **Microsoft WebView2 based web browser source** element

- **h264ccextractor**, **h264ccinserter**: H.264 closed caption extractor / inserter

- **h265ccextractor**, **h265ccinserter**: H.265 closed caption extractor / inserter

- **h266parse**

- **lcevch264decodebin**

- New VA elements (see below): **vah266dec**, **vavp8enc**, **vajpegenc**,
  **vavp8alphadecodebin**, **vavp9alphadecodebin**

- **svtjpegxsdec**, **svtjpegxsenc**: SVT JPEG XS decoder/encoder

- Many other new elements mentioned in other sections (e.g. CUDA, NVCODEC, etc.)

<a id="new-element-features"></a>
## New element features and additions

- **audioconvert** enhancements:

  - Add **possibility to reorder input channels** when audioconvert has
    unpositionned audio channels as input. It can now use reordering
    configurations to automatically position those channels via the new
    `"input-channels-reorder"` and `"input-channels-reorder-mode"` properties.

  - Better handling of setting of the mix matrix at run time

  - handles new `GstRequestMixMatrix` custom upstream event

- **audiorate**: Take the tolerance into account when filling gaps; better
  accounting of the number of samples added or dropped.

- **av1enc**: Add `"timebase"` property to allow configuring a specific
  time base, in line with what exists for vp8enc and vp9enc already.

- **av1parse** can parse annexb streams now, and typefinding support has
  been added for annexb streams as well.

- The **GTK3 plugin** has gained support for OpenGL/WGL on Windows

- **fdsrc** has a new `"is-live"` property to make it act like a live source
  and timestamp the received data with the clock running time.

- **imagefreeze**: Add support for JPEG and PNG

- **kmssink**: Extended the functionality to support buffers with DRM formats
  along with non-linear buffers

- **pitch** now supports reverse playback

- **queue** can emit the `notify` signal on queue level changes if the
  `"notify-levels"` property has been set.

- **qroverlay**: the `"pixel-size"` property has been removed in favour of
  a new `"size"` property with slightly different semantics, where the size
  of the square is expressed in percent of the smallest of width and height.

- **rsvgdec**: Negotiate resolution with downstream and scale accordingly

- **rtmp2**: server authentication improvements

  - Mimic librtmp's behaviour and support **additional connection parameters** for
    the connect packet, which are commonly used **for authentication**, via the
    new `"extra-connect-args"` property.

  - Add support for **Limelight CDN (llnw) authentication**

- **scaletempo** has gained support for a **"fit-down" mode**: In `fit-down`
    mode only 1.0 rates are supported, and the element will fit audio data in
    buffers to their advertised duration. This is useful in speech synthesis
    cases, where elements such as `awspolly` will generate audio data from text,
    and assign the duration of the input text buffers to their output buffers.
    Translated or synthesised audio might be longer than the original inputs,
    so this makes sure the audio will be sped up to fit the original duration,
    so it doesn't go out of sync.

- **souphttpsrc**: Add the notion of `"retry-backoff"` and retry on
  503 (service unavailable) and 500 (internal server error) http errors.

- **taginject** now modifies existing tag events of the selected scope, with
  the new `"merge-mode"` property allowing finer control.

- **timecodestamper** gained a new `running-time` source mode that converts
  the buffer running time into timecodes.

- **playbin3**, **uridecodebin3**, **parsebin**
  - lots of stream-collection handling and stability/reliability fixes
  - error/warning/info message now include the URI (if known) and stream-id
  - missing plugin messages include the stream-id

- **videocodectestsink** gained support for **GBR_10LE**, `GRAY8` and
  `GRAY10_LE{16,32}` pixel formats

- **videoflip** gained support for the `Y444_16LE` and `Y444_16BE` pixel formats

- **videoconvertscale**:
  - Handle pixel aspect ratios with large numerators or denominators
  - Explicitly handle the overlaycomposition meta caps feature, so it doesn't
    get dropped unnecessarily

- **waylandsink** prefers DMABuf over system memory now

- **x264enc** has a new `"nal-hrd"` property to make the encoder signal
  HRD information, which is required for Blu-ray streams, television broadcast
  and a few other specialist areas. It can also be used to force true CBR, and
  will cause the encoder to output null padding packets.

- **zbar**: add support for binary mode and getting symbols as raw bytes instead of a text string.

<a id="plugin-library-moves"></a>
## Plugin and library moves

- macOS: **atdec** was moved from the `applemedia` plugin in -bad to the `osxaudio`
  plugin in -good, in order to be able to share audio-related helper methods.

<a id="plugin-element-removals"></a>
## Plugin and element removals

- None in this cycle

<a id="new-api"></a>
## Miscellaneous API additions

<a id="core-api"></a>
### GStreamer Core

- `gst_meta_api_type_set_params_aggregator()` allows setting an
  `GstAllocationMetaParamsAggregator` function for metas, which has been
  implemented for `GstVideoMeta` and is used to aggregate alignment
  requirements of multiple tee branches.

- `gst_debug_print_object()` and `gst_debug_print_segment()` have been made
  public API. The can be used to easily get string representations of various
  types of (mini)objects in custom log handlers.

- Added `gst_aggregator_push_src_event()`, so subclasses don't just push events
  directly onto the source pad bypassing the base class without giving it the
  chance to send out any pending serialised events that should be sent out
  before.

- `GstMessage` has gained APIs to generically add "details" to messages:
   - `gst_message_set_details()`
   - `gst_message_get_details()`
   - `gst_message_writable_details()`
   - `gst_message_parse_error_writable_details()`
   - `gst_message_parse_warning_writable_details()`
   - `gst_message_parse_info_writable_details()`
   This is used in `uridecodebin3` to add the triggering URI to any INFO,
   WARNING or ERROR messages posted on the bus, and in `decodebin3` to add
   the stream ID to any missing plugin messages posted on the bus.

- `gst_util_floor_log2()` returns smallest integral value not bigger than log2(v).

- `gst_util_fraction_multiply_int64()` is a 64-bit variant of `gst_util_fraction_multiply()`.

<a id="idstr"></a>
#### GstIdStr replaces GQuark in structure and caps APIs

- `GQuark`s are integer identifiers for strings that are inserted into a
  global hash table, allowing in theory for cheap equality comparisons. In
  GStreamer they have been used to represent `GstStructure` names and field
  names. The problem is that these strings once added to the global string table
  can never be freed again, which can lead to ever-increasing memory usage
  for processes where such name identifiers are created based on external
  input or on locally-created random identifiers. 

- `GstIdStr` is a new data structure made to replace quarks in our APIs.
  It can hold a short string inline, a static string, or a reference to a
  heap-allocated longer string, and allows for cheap storage of short strings
  and cheap comparisons. It does not involve access to a global hash table
  protected by a global lock, and as most strings used in GStreamer structures
  are very short, it is actually more performant than quarks in many scenarios.

- `GQuark`-using APIs in `GstStructure` or `GstCaps` have been deprecated and
  equivalent APIs using `GstIdStr` have been added instead. For more details
  about this change watch Sebastian's GStreamer Conference presentation
  ["GQuark in GStreamer structures - what nonsense!"](https://gstconf.ubicast.tv/videos/gquark-in-gstreamer-structures-what-nonsense/).
  
- Most applications and plugins will have been using the plain string-based
  APIs which are not affected by this change.

<a id="vecdeque"></a>
#### GstVecDeque

- Moved `GstQueueArray` as `GstVecDeque` into core for use in `GstBus`,
  the ringbuffer logger and in `GstBufferPool`, where an overly complicated
  signaling mechanism using `GstAtomicQueue` and `GstPoll` was replaced with
  `GstVecDeque` and a simple mutex/cond.

- `GstQueueArray` in libgstbase was deprecated in favour of `GstVecDeque`.

- `GstAtomicQueue` will be deprecated once all users in GStreamer have been
  moved over to `GstVecDeque`.

<a id="gstaudio"></a>
### Audio Library

- Added **`gst_audio_reorder_channels_with_reorder_map()`** which allows
  reordering the samples with a pre-calculated reorder map instead of
  re-calculating the reorder map every time.

- Add **top-surround-left and top-surround-right channel positions**

- `GstAudioConverter` now supports more numerical types for the mix matrix,
  namely double, int, int64, uint, and uint64 in addition to plain floats.

<a id="gstpbutils"></a>
### Plugins Base Utils Library

- New **AV1 caps utility functions for AV1 Codec Configuration Record**
  **`codec_data` handling**

- The **`GstEncodingProfile` (de)serialization functions** are now public

- **`GstEncodingProfile` gained a way to specify a factory-name when specifying**
   **caps**. In some cases you want to ensure that a specific element factory is
   used while requiring some specific caps, but this was not possible so far.
   You can now do e.g. `qtmux:video/x-prores,variant=standard|factory-name=avenc_prores_ks`
   to ensure that the `avenc_prores_ks` factory is used to produce the
   variant of prores video stream.

<a id="gsttag"></a>
### Tag Library

- **EXIF** handling now support the **`CAPTURING_LIGHT_SOURCE`** tag

- **Vorbis** tag handling gained support for the **`LYRICS`** tag

<a id="gstvideo"></a>
### Video Library and OpenGL Library

- `gst_video_convert_sample()`, `gst_video_convert_sample_async()` gained
  support for **D3D12 conversion**.

- `GstVideoEncoder`: `gst_video_encoder_release_frame()` and
  `gst_video_encoder_drop_frame()` have been made available as public API.

- Navigation: gained **mouse double click event** support

- **Video element QoS handling was improved** so as to not overshoot the QoS
  earliest time by a factor of 2. This was fixed in the video decoder, encoder,
  aggregator and audiovisualizer base classes, as well as in the adaptivedemux,
  deinterlace, monoscope, shapewipe, and (old) videomixer elements.

- `GstVideoConverter` gained **fast paths for `v210` to/from `I420_10` / `I422_10`**

- New `gst_video_dma_drm_format_from_gst_format()` helper function that
  converts a video format into a dma drm fourcc / modifier pair, plus
  `gst_video_dma_drm_format_to_gst_format()` which will do the reverse.

- In the same vein `gst_gl_dma_buf_transform_gst_formats_to_drm_formats()` and
  `gst_gl_dma_buf_transform_drm_formats_to_gst_formats()` have been added to
  the GStreamer OpenGL support library.

- GLDisplay/EGL: Add API (`gst_gl_display_egl_set_foreign()`) for overriding
  foreign-ness of the EGLDisplay in order to control whether GStreamer should
  call `eglTerminate()` or not.

- Additional DMA DRM format definitions/mappings:
  - `NV15`, `NV20`, `NV30`
  - `NV12_16L32S`, `MT2110T`, `MT2110R` as used on Meditek SoCs
  - `NV12_10LE40`
  - `RGB15`, `GRAY8`, `GRAY16_LE`, `GRAY16_BE`
  - plus support for big endian DRM formats and DRM vendor modifiers

#### New Raw Video Formats

- Packed 4:2:2 YUV with 16 bits per channel:
  - `Y216_LE`, `Y216_BE`

- Packed 4:4:4:4 YUV with alpha, with 16 bits per channel:
  - `Y416_LE`, `Y416_BE`

- 10-bit grayscale, packed into 16-bit words with left padding:
  - `GRAY10_LE16`

<a id="gstplay"></a>
### GstPlay Library

- Add **stream-id based selection of streams** to better match playbin3's API:
  - Add accessors for the stream ID and selection API based on the stream ID:
    - `gst_play_stream_info_get_stream_id()`
    - `gst_play_set_audio_track_id()`
    - `gst_play_set_video_track_id()`
    - `gst_play_set_subtitle_track_id()`
    - `gst_play_set_track_ids()`
  - Deprecate the old index-based APIs:
    - `gst_play_stream_info_get_index()`
    - `gst_play_set_audio_track()`
    - `gst_play_set_video_track()`
    - `gst_play_set_subtitle_track()`
  - Remove old playbin support
  - Implement the track enable API based on stream selection

- **Distinguish missing plugin errors and include more details**
  (uri, and stream-id if available) in error/warning messages:
  - `gst_play_message_get_uri()`
  - `gst_play_message_get_stream_id()`
  - `GST_PLAY_ERROR_MISSING_PLUGIN`
  - `gst_play_message_parse_error_missing_plugin()`
  - `gst_play_message_parse_warning_missing_plugin()`

- **Improve play message API inconsistencies**:
  - Consistently name parse functions according to their message type:
    - `gst_play_message_parse_duration_changed()`
    - `gst_play_message_parse_buffering()`
  - Deprecate the misnamed functions:
    - `gst_play_message_parse_duration_updated()`
    - `gst_play_message_parse_buffering_percent()`
  - Add missing parse functions:
    - `gst_play_message_parse_uri_loaded()`
    - `gst_play_message_parse_seek_done()`

- Support disabling the selected track at startup

<a id="optimisations"></a>
## Miscellaneous performance, latency and memory optimisations

- **dvdspu**: use multiple minimal sized PGS overlay rectangles instead of
  a single large one to minimise the total blitting surface in case of
  disjointed rectangles.

- video-frame: reduce number of `memcpy()` calls on frame copies if possible

- video-converter: added fast path conversions between `v210` and `I420_10` / `I422_10`

- As always there have been plenty of performance, latency and memory optimisations
  all over the place.

<a id="misc-changes"></a>
## Miscellaneous other changes and enhancements

- **netclientclock**: now also emits the clock synced signal when corrupted
  to signal that sync has been lost.

- `GstValue`, `GstStructure`: can now (de)serialize string arrays (`G_TYPE_STRV`)

<a id="tracing"></a>
## Tracing framework and debugging improvements

- dot files (pipeline graph dumps) are now written to disk atomically

- tracing: add hooks for `gst_pad_send_event_unchecked()` and GstMemory init/free

- tracers: Simplify params handling using GstStructure and object properties
  and move tracers over to property-based configuration (leaks, latency).

- **textoverlay**, **clockoverlay**, **timeoverlay**: new `"response-time-compensation"`
  property that makes the element render the text or timestamp twice: Once in
  the normal location and once in a different sequentially predictable location
  for every frame. This is useful when measuring video latency by taking a photo
  with a camera of two screens showing the test video overlayed with timeoverlay
  or clockoverlay. In these cases, you will often see ghosting if the display's
  pixel response time is not great, which makes it difficult to discern what the
  current timestamp being shown is. Rendering in a different location for each
  frame makes it easy to tell what the latest timestamp is. In addition, you
  can also use the fade-time of the previous frame to measure with sub-framerate
  accuracy when the photo was taken, not just clamped to the framerate, giving
  you a higher precision latency value.

### New tracers

- **memory-tracer**: New tracer that can **track memory usage over time**

- **pad-push-timings**: New tracer for **tracing pad push timings**

- **pcap-writer**: New tracer that can **store the buffers flowing through a pad as PCAP file**

#### Dot tracer/viewer

- New **dots** tracer that simplifies the pipeline visualization workflow:
  - Automatically configures dot file directory and cleanup
  - Integrates with the `pipeline-snapshot`S tracer to allow dumping pipeline on demand
    from the `gst-dots-viewer` web interface
  - Uses `GST_DEBUG_DUMP_DOT_DIR` or falls back to $XDG_CACHE_HOME/gstreamer-dots

- New **gst-dots-viewer** web tool for real-time pipeline visualization
  - Provides interface to browse and visualize pipeline dot files
  - Features on-demand pipeline snapshots via "Dump Pipelines" button
  - WebSocket integration for live updates
  - Uses `GST_DEBUG_DUMP_DOT_DIR` or falls back to $XDG_CACHE_HOME/gstreamer-dots

- Simple usage:
  - `gst-dots-viewer` (starts server)
  - `GST_TRACERS=dots gst-launch-1.0 videotestsrc ! autovideosink` (runs with tracer)
  - View at http://localhost:3000

### Debug logging system improvements

- Nothing major in this cycle.

<a id="tools"></a>
## Tools

- **gst-inspect-1.0** documents tracer properties now and shows element flags

- **gst-launch-1.0** will show error messages posted during pipeline construction

<a id="ffmpeg"></a>
## GStreamer FFmpeg wrapper

- Add support for **H.266/VVC decoder**

- Add mappings for the **Hap video codec**, the **Quite OK Image codec (QOI)**
  and the **M101 Matrox uncompressed SD video codec**.

- Don't register elements for which we have no caps and which were
  non-functional as a result (showing unknown/unknown caps).

- The **S302M audio encoder now supports up to 8 channels**.

- Various **tag handling improvements in the avdemux wrappers**, especially
  when there are both upstream tags and additional local tags.

- Support for 10-bit grayscale formats

<a id="rtsp"></a>
## GStreamer RTSP server

- `GstRTSPOnvifMediaFactoryClass` gained a `::create_backchannel_stream()` vfunc.
  This allows subclasses to delay creation of the backchannel to later in the
  sequence, which is useful in scenarios where the RTSP server acts as a relay
  and the supported caps depend on the upstream camera, for example.

- The ONVIF backchannel example now features support for different codecs,
  including AAC.

<a id="vaapi"></a>
## VA-API integration

### VA plugin

- New VA elements:
  - **H.266 / VVC video decoder**
  - **VP8 video encoder**
  - **JPEG encoder**
  - **VP9 + VP8 alpha decodebin**

  Remember that the availability of these elements depends on your platform and
  driver.

- There are a lot of improvements and bug fixes, to hightlight some of them:
  - **Improved B pyramid mode** for both H264 and HEVC encoding when reference
    frame count exceeds 2, optimizing pyramid level handling.
  - Enabled **ICQ and QVBR modes for several encoders**, including H264, H265,
    VP9 and AV1.
  - **Updated rate control features** by setting the quality factor parameter,
    while improving bitrate change handling.
  - Improved VP9 encoder’s ability to avoid reopening or renegotiating encoder
    settings when parameters remain stable.
  - Added **functionality to adjust the trellis parameter** in encoders.
  - **Optimize encoders throughput** with the introduction of output delay.
  - Added **support for new interpolation methods for scaling**
    and **improvements for handling interlace modes**.

### GStreamer-VAAPI is now deprecated

- **gstreamer-vaapi has been deprecated and is no longer actively maintained**.
  Users who rely on gstreamer-vaapi are encouraged to migrate to the `va`
  plugin's elements at the earliest opportunity.

- `vaapi*enc` encoders have been demoted to a rank of None, so will no longer
  be autoplugged in `encodebin`. They have also no longer advertise dmabuf caps
  or unusual pixel formats on their input pad template caps.

<a id="v4l2"></a>
## GStreamer Video4Linux2 support

- Implemented **`DMA_DRM` caps negotiation**

- Framerate negotiation improvements

- Support for `P010` and `BGR10A2_LE` pixel formats

- The **V4L2 stateless decoders** now support **inter-frame resolution changes for AV1 and VP9**

- The **V4L2 stateful encoders** can now handle **dynamic frame rates** (0/1),
  and colorimetry negotiation was also improved.

<a id="ges"></a>
## GStreamer Editing Services and NLE

- Added support for **reverse playback** with a new `reverse` property on
  `nlesource` which is exposed child property on `GESClip`

- Input channels reordering for **flexible audio channel mapping**

- Added support for transition in the `ges-launch-1.0` timeline description
  format

- Added support for **`GstContext` sharing in `GESTimeline`**

- Added basic support for duplicated children property in `GESTimelineElement`

- validate: Add an action type to group clips

<a id="validate"></a>
## GStreamer validate

- Added **new action types**:
  - **`start-http-server`**: Start a new instance of our HTTP test server
  - **`http-requests`**: Send an HTTP request to a server, designed to work
    with our test http server

- **HTTP server control endpoints** to allow scenarios to control the server
  behavior, allowing **simulating server failures from tests**

- Improved the `select-streams` action type, adding **support for selecting**
  **the same streams** several times

- Added support for forcing monitoring of all pipelines in validatetest files

- Enhanced support for expected Error messages on the bus

- Added ways to retrieve HTTP server port in .validatetest files

- Added support for `lldb` in the `gst-validate-launcher`

<a id="python"></a>
## GStreamer Python Bindings

gst-python is an extension of the regular GStreamer Python bindings based on
gobject-introspection information and PyGObject, and provides "syntactic sugar"
in form of overrides for various GStreamer APIs that makes them easier to use
in Python and more pythonic; as well as support for APIs that aren't available
through the regular gobject-introspection based bindings, such as e.g.
GStreamer's fundamental GLib types such as `Gst.Fraction`, `Gst.IntRange` etc.

- The `python` Meson build option has been renamed to `python-exe` (and will
  yield to the monorepo build option of the same name if set, in a monorepo
  build context).

- Added an **iterator for `AnalyticsRelationMeta`**

- Implement `__eq__` for Mtd classes

- Various build fixes and Windows-related fixes.

<a id="csharp"></a>
## GStreamer C# Bindings
  
- The C# bindings have been updated for the latest GStreamer 1.26 API

<a id="rust"></a>
## GStreamer Rust Bindings and Rust Plugins

The GStreamer Rust bindings and plugins are released separately with a different
release cadence that's tied to the gtk-rs release cycle.

The latest release of the bindings (0.23) has already been updated for the new
GStreamer 1.26 APIs, and works with any GStreamer version starting at 1.14.

`gst-plugins-rs`, the module containing GStreamer plugins written in Rust,
has also seen lots of activity with many new elements and plugins. The GStreamer
1.26 binaries will be tracking the `main` branch of `gst-plugins-rs` for
starters and then track the 0.14 branch once that has been released (around
summer 2025). After that, fixes from newer versions will be backported as
needed to the 0.14 branch for future 1.26.x bugfix releases.

Rust plugins can be used from any programming language. To applications
they look just like a plugin written in C or C++.

<a id="rust-elements"></a>
### New Rust elements

- **awstranscriber2**, **awstranslate**: New elements around the
  AWS transcription and translation services.

- **cea708mux**: New element that allows to mux multiple CEA708 services
  into a single stream.

- **cdpserviceinject**: New element for injecting a CDP service descriptor
  into closed caption CDP packets

- **cea708overlay**: New element for overlaying CEA608 / CEA708 closed
  captions over video streams.

- **gopbuffer**: New element that can buffer a minimum duration of data
  delimited by discrete GOPs (Group of Picture)

- **hlscmafsink**, **hlssink3**: New single-variant HLS sink elements that
  can output CMAF (fMP4) or MPEG-TS fragments.

- **hlsmultivariantsink**: New sink element that can output an HLS stream
  with multiple variants

- **mpegtslivesrc**: New source element that can wrap a live MPEG-TS source
  (e.g. SRT or UDP source) and provides a clock based on the PCR.

- **onvifmetadataextractor**: New element that can extract ONVIF metadata
  from `GstMeta`s into a separate stream

- **originalbuffer**: New plugin with `originalbuffersave` / `originalbufferrestore`
  elements that allow saving an original buffer, modifying it for analytics,
  and then restoring the original buffer content while keeping any additional
  metadata that was added.

- **polly**: New element around the AWS text-to-speech polly services

- **quinn**: New plugin that contains various QUIC-based elements for working
  with raw QUIC streams, RTP-over-QUIC (RoQ) and WebTransport.

- **relationmeta**: New plugin with elements converting between
  `GstRelationMeta` and ONVIF XML metadata.

- New **Rust RTP payloaders and depayloaders** for AC3, AMR, JPEG, KLV,
  MPEG-TS (MP2T), MPEG-4 (MP4A, MP4G), Opus, PCMU (uLaw), PCMA (aLaw), VP8, VP9.

- New **rtpbin2** based on **rtprecv** / **rtpsend** elements

- **speechmatics**: New transcriber / speech-to-text and translation element

- New **spotifylyricssrc** element for grabbing lyrics from Spotify.

- **streamgrouper**: New element that takes any number of streams as input
  and adjusts their stream-start events in such a way that they all belong
  to the same stream group.

- **translationbin**: Helper bin around translation elements, similar to the
  already existing `transcriberbin` for transcriptions.

- **tttocea708**: New element for converting timed-text to CEA708 closed captions

- A **VVdeC-based H.266 decoder element** was added to the Rust plugins,
  based on the Fraunhofer Versatile Video Decoder library.

<!--
<a id="rust-other-improvements"></a>
### Other improvements

- to be filled in
-->

For a full list of changes in the Rust plugins see the
[gst-plugins-rs ChangeLog][rs-changelog] between versions 0.12
(shipped with GStreamer 1.24) and 0.14.x (shipped with GStreamer 1.26).

Note that at the time of GStreamer 1.26.0 gst-plugins-rs 0.14 was not
released yet and the git `main` branch was included instead (see above).
As such, the ChangeLog also did not contain the changes between the latest
0.13 release and 0.14.0.

[rs-changelog]: https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/main/CHANGELOG.md

<a id="build-and-deps"></a>
## Build and Dependencies

- Meson >= 1.4 is now required for all modules

- liborc >= 0.4.41 is strongly recommended

- libnice >= 0.1.22 is strongly recommended, as it is required
  for WebRTC **ICE consent freshness** (RFC 7675).

- The **ASIO plugin** dropped its external SDK header dependency,
  so it can always be built and shipped more easily.

- Require tinyalsa >= 1.1.0 when building the tinyalsa plugin

- The srtp plugin now requires libsrtp2, support for libsrtp1 was dropped.

### Monorepo build

- The FFmpeg subproject wrap was updated to 7.1

- Many other wrap updates

### gstreamer-full

- No major changes

### Development environment

- Local pre-commit checks via git hooks have been moved over to `pre-commit`,
  including the code indentation check.

- Code indentation checking no longer relies on a locally installed copy of
  GNU indent (which had different outcomes depending on the exact version
  installed). Instead pre-commit will automatically install the gst-indent-1.0
  indentation tool through pip, which also works on Windows and macOS.

- A pre-commit hook has been added to check documentation cache updates and
  since tags.

- Many meson wrap updates, including to FFmpeg 7.1

- The uninstalled development environment should work better on macOS now,
  also in combination with homebrew (e.g. when libsoup comes from homebrew).

- New `python-exe` Meson build option to override the target Python installation
  to use. This will be picked up by the `gst-python` and `gst-editing-sevices`
  subprojects.

<a id="platform-specific"></a>
## Platform-specific changes and improvements

<a id="android"></a>
### Android

- The recommended mechanism to build Android apps has changed from
  Android.mk to CMake-in-Gradle using `FindGStreamerMobile.cmake`.
  `Android.mk` support has been deprecated and will be removed in the
  next stable release. For more information, see below, in the [Cerbero](#cerbero-android) section.
- **More H.264/H.265 profiles and levels** have been added to the androidmedia
  **hardware-accelerated video encoder and decoder elements**, along with
  mappings for a number of additional pixel formats for P010, packed 4:2:0
  variants and RGBA layouts, which fixes problems with android decoders
  refusing to output raw video frames with decoders that announce support
  for these common pixel formats and only allow the 'hardware surfaces output'
  path.

<a id="apple"></a>
### Apple macOS and iOS

- **atenc**: added an **Apple AAC audio encoder**

- **atdec** can now decode audio with more than two channels

- **vtenc** has received various bug fixes as well as a number of new features:
  - Support for **HEVC with alpha encoding** via the new `vtenc_h265a` element
  - additional rate control options for **constant bitrate encoding** (only
    supported on macOS 13.0+ and iOS 16.0+ on Apple Silicon), setting data
    rate limits, and emulating CBR mode via data rate limits where CBR is not
    supported.
  - **HLG color transfer** support
  - new `"max-frame-delay"` property (for ProRes)

- **Better macOS support for gst-validate tools** which now use `gst_macos_main()` and support lldb

- The **osxaudio device provider** exposes more properties including a unique id

- **osxaudio** will automatically set up AVAudioSession on iOS and always
  expose the maximum number of channels a device supports with an unpositioned
  layout.

- The monorepo development environment should work better on macOS now

- CMake apps that build macOS and iOS apps can consume GStreamer more easily now,
  using FindGStreamer.cmake or FindGStreamerMobile.cmake respectively.

- In the near future, CMake in Xcode will be the preferred way of building the
  iOS tutorials. See below, in the [Cerbero](#cerbero-ios) section.

<a id="windows"></a>
### Windows

- `webview2src`: new **Microsoft WebView2 based web browser source** element

- The **mediafoundation** plugin can also be built with MinGW now.

- The **GTK3 plugin** has gained support for OpenGL/WGL on Windows

- **qsv**: Add support for d3d12 interop in encoder, via D3D11 textures

<!--

<a id="linux"></a>
### Linux

- Many improvements which are described in other sections.

-->


<a id="cerbero"></a>
### Cerbero

Cerbero is a meta build system used to build GStreamer plus dependencies
on platforms where dependencies are not readily available, such as Windows,
Android, iOS, and macOS.

#### General improvements

- **New features:**

  - **Python bindings support** has been re-introduced and now supports Linux,
    Windows (MSVC) and macOS. Simply downloading the official binaries and setting
    `PYTHONPATH` to the appropriate directory is sufficient.

    - This should make it easier for macOS and Windows users to use Python libraries,
      frameworks, and projects that use GStreamer such as Pitivi and gst-python-ml.

  - **Introspection support** has been re-introduced on Linux, Windows (MSVC), and macOS.

  - **New variants `assert` and `checks` to disable GLib assertions and runtime checks**
    for performance reasons. Please note that these are **not recommended** because they
    have significant behavioural side-effects, make debugging harder, and should only be
    enabled when targeting extremely resource-constrained platforms.

- **API/ABI changes:**

  - Libsoup has been upgraded from 2.74 to 3.6, which is an API and ABI breaking change.
    The `soup` and `adaptivedemux2` plugins are unchanged, but your applications may need
    updating since `libsoup-2.4` and `libsoup-3.0` cannot co-exist in the same process.

  - OpenSSL has been updated from 1.1.1 to 3.4, which is an ABI and API breaking change.
    Plugins are unchanged, but your applications may need updating.

- **Plugins added:**

  - The `svt-av1` plugin is now shipped in the binary releases for all platforms.

  - The `svt-jpeg-xs` plugin is now shipped in the binary releases for all platforms.

  - The `x265` plugin is now shipped in the binary releases for all platforms.

  - All gst-plugins-rs elements are now shipped in the binary releases for all
    platforms, except those that have C/C++ system-deps like GTK4. For a full
    list, see the [Rust section above](#rust-elements).

- **Plugins changed:**

  - The `rsvg` plugin now uses librsvg written in Rust. The only side-effects of
    this should be better SVG rendering and slightly larger plugin size.

  - The `webrtc` Rust plugin now also supports aws and livekit integrations .

- **Plugins removed:**

  - webrtc-audio-processing has been updated to 2.0, which means the `isac` plugin is
    no longer shipped.

- **Development improvements**:

  - Support for the `shell` command has been added to cross-macos-universal, since the
    prefix is executable despite being a cross-compile target

  - More recipes have been ported away from Autotools to Meson and CMake, speeding up
    the build and increasing platform support.

<a id="cerbero-macos"></a>
#### macOS

- Python bindings support on macOS only supports using the Xcode-provided Python 3

- MoltenVK support in the `applemedia` plugin now also works on arm64 when
  doing a cross-universal build.

<a id="cerbero-ios"></a>
#### iOS

- CMake inside Xcode will soon be the recommended way to consume GStreamer when
  building iOS apps, similar to Android apps.

  - FindGStreamerMobile.cmake is the recommended way to consume GStreamer now

  - Tutorials and examples still use Xcode project files, but CMake support will
    be the active focus going forward

<a id="cerbero-windows"></a>
#### Windows

- The minimum supported OS version is now Windows 10.

  - GStreamer itself can still be built for an older Windows, so if your
    project is majorly impacted by this, please [open an issue](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/new)
    with details.

- The Windows MSI installers are now based on WiX v5, with several improvements
  including a much faster MSI creation process, improved naming in Add/Remove Programs,
  and more.

  - **Windows installer packages**: Starting with 1.26, due to security reasons, the
    default installation directory has changed from `C:\gstreamer` to the Program Files
    folder, e.g. `C:\Program Files (x86)\gstreamer` for the 32-bit package on 64-bit
    Windows. If you upgrade from 1.24 or older versions, the 1.26 installers will
    ***NOT*** keep using the existing folder. Nevertheless if you were using
    `C:\gstreamer` we strongly recommend you double-check the install location.

  - **Note for MSI packagers**: Starting with 1.26, the installers were ported to WiX 5.0.
    As part of this, the property for setting the installation directory has been changed
    to `INSTALLDIR`, and it now requires a full path to the desired directory, e.g.
    `C:\gstreamer` instead of `C:\`.

  - Cross-MinGW build no longer supports the creation of MSIs. Please use tarballs.

- **MinGW:**

  - MinGW toolchain has been updated from GCC 8.2 → 14.2 and MinGW 6.0 → 12.0

  - The `mediafoundation` plugin is also shipped in the MinGW packages now.

  - The `d3d12` plugin is also shipped in the MinGW packages now.

  - Rust support has been enabled on MinGW 64-bit. Rust support cannot work on 32-bit MinGW
    due to differences in exception handling between our 32-bit MinGW toolchain and that
    used by the Rust project

- The `asio` plugin is shipped now, since it no longer has a build-time dependency on the ASIO SDK.

- The new plugin `webview2` is shipped with MSVC. It requires the relevant component shipped with Windows.

<a id="cerbero-linux"></a>
#### Linux

- Preliminary support for Alma Linux has been added.

- RHEL distro support has been improved.

- Cerbero CI now tests the build on Ubuntu 24.04 LTS.

- `curl` is used for downloading sources on Fedora instead of `wget`, since they have moved to
  `wget2` [despite show-stopper regressions](https://gitlab.com/gnuwget/wget2/-/issues/661) such
  as returning a success error code on download failure.

<a id="cerbero-android"></a>
#### Android

- CMake inside Gradle is now the recommended way to consume GStreamer when building Android apps

  - FindGStreamerMobile.cmake is the recommended way to consume GStreamer now

  - 1.26 will support both CMake and Make inside Gradle, but the Make support
    will likely be removed in 1.28

  - Documentation updates are still a work-in-progress, help is appreciated

- Android tutorials and examples are now built with `gradle` + `cmake`
  instead of `gradle` + `make` on the CI

<a id="docs"></a>
## Documentation improvements

- Tracer objects information is now included in the documentation

<a id="breaking-changes"></a>
## Possibly Breaking Changes

- **qroverlay**: the `"pixel-size"` property has been removed in favour of
  a new `"size"` property with slightly different semantics, where the size
  of the square is expressed in percent of the smallest of width and height.

- **svtav1enc**: The SVT-AV1 3.0.0 API exposes a different mechanism to
  configure the level of parallelism when encoding, which has been exposed as
  a new `"level-of-parallelism"` property. The old `"logical-processors"`
  property is no longer functional if the plugin has been compiled against
  the new API, which might affect encoder performance if application code
  setting it is not updated.

- **udpsrc**: now disables allocated port reuse for unicast to avoid unexpected
  side-effects of `SO_REUSEADDR` where the kernel allocates the same listening
  port for multiple udpsrc.

- **uridecodebin3** remove non-functional ``"source"`` property that doesn't
  make sense and always returned NULL anyway.

<a id="known-issues"></a>
## Known Issues

- `GstBuffer` now uses C11 atomics for 64 bit atomic operations if available,
  which may require linking to libatomic on some systems, but this is not
  done automatically yet, [see issue #4177](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4177).

<a id="statistics"></a>
## Statistics

- 4496 commits
- 2203 Merge requests merged
- 794 Issues closed
- 215+ Contributors

- ~33% of all commits and Merge Requests were in Rust modules/code

- 4950 files changed
- 515252 lines added
- 201503 lines deleted
- 313749 lines added (net)

<a id="contributors"></a>

## Contributors

Aaron Boxer, Adrian Perez de Castro, Adrien De Coninck, Alan Coopersmith,
Albert Sjolund, Alexander Slobodeniuk, Alex Ashley, Alicia Boya García,
Andoni Morales Alastruey, Andreas Wittmann, Andrew Yooeun Chun,
Angelo Verlain, Aniket Hande, Antonio Larrosa, Antonio Morales,
Armin Begovic, Arnaud Vrac, Artem Martus, Arun Raghavan, Benjamin Gaignard,
Benjamin Gräf, Bill Nottingham, Brad Hards, Brad Reitmeyer, Branko Subasic,
Carlo Caione, Carlos Bentzen, Carlos Falgueras García, cdelguercio,
Chao Guo, Cheah, Cheung Yik Pang, chitao1234, Chris Bainbridge,
Chris Spencer, Chris Spoelstra, Christian Meissl, Christopher Degawa,
Chun-wei Fan, Colin Kinloch, Corentin Damman, Daniel Morin, Daniel Pendse,
Daniel Stone, Dan Yeaw, Dave Lucia, David Rosca, Dean Zhang (张安迪),
Denis Yuji Shimizu, Detlev Casanova, Devon Sookhoo, Diego Nieto, Dongyun Seo,
dukesook, Edward Hervey, eipachte, Eli Mallon, Elizabeth Figura, Elliot Chen,
Emil Ljungdahl, Emil Pettersson, eri, F. Duncanh, Fotis Xenakis,
Francisco Javier Velázquez-García, Francis Quiers, François Laignel,
George Hazan, Glyn Davies, Guillaume Desmottes, Guillermo E. Martinez,
Haihua Hu, Håvard Graff, He Junyan, Hosang Lee, Hou Qi, Hugues Fruchet,
Hyunwoo, iodar, jadarve, Jakub Adam, Jakub Vaněk, James Cowgill,
James Oliver, Jan Alexander Steffens (heftig), Jan Schmidt, Jeffery Wilson,
Jendrik Weise, Jerome Colle, Jesper Jensen, Jimmy Ohn, Jochen Henneberg,
Johan Sternerup, Jonas K Danielsson, Jonas Rebmann, Jordan Petridis,
Jordan Petridіs, Jordan Yelloz, Jorge Zapata, Joshua Breeden, Julian Bouzas,
Jurijs Satcs, Kévin Commaille, Kevin Wang, Khem Raj, kingosticks,
Leonardo Salvatore, L. E. Segovia, Liam, Lim, Loïc Le Page, Loïc Yhuel,
Lyra McMillan, Maksym Khomenko, Marc-André Lureau, Marek Olejnik,
Marek Vasut, Marianna Smidth Buschle, Marijn Suijten, Mark-André Schadow,
Mark Nauwelaerts, Markus Ebner, Martin Nordholts, Mart Raudsepp,
Mathieu Duponchelle, Matthew Waters, Maxim P. DEMENTYEV, Max Romanov,
Mengkejiergeli Ba, Michael Grzeschik, Michael Olbrich, Michael Scherle,
Michael Tretter, Michiel Westerbeek, Mikhail Rudenko, Nacho Garcia,
Nick Steel, Nicolas Dufresne, Niklas Jang, Nirbheek Chauhan, Ognyan Tonchev,
Olivier Crête, Oskar Fiedot, Pablo García, Pablo Sun, Patricia Muscalu,
Paweł Kotiuk, Peter Kjellerstedt, Peter Stensson, pgarciasancho,
Philippe Normand, Philipp Zabel, Piotr Brzeziński, Qian Hu (胡骞),
Rafael Caricio, Randy Li (ayaka), Rares Branici, Ray Tiley,
Robert Ayrapetyan, Robert Guziolowski, Robert Mader, Roberto Viola,
Robert Rosengren, RSWilli,Ruben González, Ruijing Dong, Sachin Gadag,
Sam James, Samuel Thibault, Sanchayan Maity, Scott Moreau, Sebastian Dröge,
Sebastian Gross, Sebastien Cote, Sergey Krivohatskiy, Sergey Radionov,
Seungha Yang, Seungmin Kim, Shengqi Yu, Sid Sethupathi, Silvio Lazzeretti,
Simonas Kazlauskas, Stefan Riedmüller, Stéphane Cerveau, Tamas Levai,
Taruntej Kanakamalla, Théo Maillart, Thibault Saunier, Thomas Goodwin,
Thomas Klausner, Tihran Katolikian, Tim Blechmann, Tim-Philipp Müller,
Tjitte de Wert, Tomas Granath, Tomáš Polomský, tomaszmi, Tom Schuring,
U. Artie Eoff, valadaptive, Víctor Manuel Jáquez Leal, Vivia Nikolaidou,
W. Bartel, Weijian Pan, William Wedler, Will Miller, Wim Taymans,
Wojciech Kapsa, Xavier Claessens, Xi Ruoyao, Xizhen, Yaakov Selkowitz,
Yacine Bandou, Zach van Rijn, Zeno Endemann, Zhao, Zhong Hongcheng,

... and many others who have contributed bug reports, translations,
sent suggestions or helped testing. Thank you all!

## Stable 1.26 branch

After the 1.26.0 release there will be several 1.26.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.26.x bug-fix releases will be made from the git 1.26 branch,
which is a stable release series branch.

<a id="1.26.1"></a>

### 1.26.1

The first 1.26 bug-fix release (1.26.1) was released on 24 April 2025.

This release only contains bugfixes and security fixes and it *should* be safe
to update from 1.26.0.

#### Highlighted bugfixes in 1.26.1

 - awstranslate and speechmatics plugin improvements
 - decodebin3 fixes and urisourcebin/playbin3 stability improvements
 - Closed captions: CEA-708 generation and muxing fixes, and H.264/H.265 caption extractor fixes
 - dav1d AV1 decoder: RGB support, plus colorimetry, renegotiation and buffer pool handling fixes
 - Fix regression when rendering VP9 with alpha
 - H.265 decoder base class and caption inserter SPS/PPS handling fixes
 - hlssink3 and hlsmultivariantsink feature enhancements
 - Matroska v4 support in muxer, seeking fixes in demuxer
 - macOS: framerate guessing for cameras or capture devices where the OS reports silly framerates
 - MP4 demuxer uncompressed video handling improvements and sample table handling fixes
 - oggdemux: seeking improvements in streaming mode
 - unixfdsrc: fix gst_memory_resize warnings
 - Plugin loader fixes, especially for Windows
 - QML6 GL source renegotiation fixes
 - RTP and RTSP stability fixes
 - Thread-safety improvements for the Media Source Extension (MSE) library
 - v4l2videodec: fix A/V sync issues after decoding errors
 - Various improvements and fixes for the fragmented and non-fragmented MP4 muxers
 - Video encoder base class segment and buffer timestamp handling fixes
 - Video time code support for 119.88 fps and drop-frames-related conversion fixes
 - WebRTC: Retransmission entry creation fixes and better audio level header extension compatibility
 - YUV4MPEG encoder improvments
 - dots-viewer: make work locally without network access
 - gst-python: fix compatibility with PyGObject >= 3.52.0
 - Cerbero: recipe updates, compatibility fixes for Python < 3.10; Windows Android cross-build improvements
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [Correctly handle whitespace paths when executing gst-plugin-scanner](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8686)
 - [Ensure properties are freed before (re)setting with g_value_dup_string() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8714)
 - [cmake: Fix PKG_CONFIG_PATH formatting for Windows cross-builds](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8779)
 - [macos: Move macos function documentation to the .h so the introspection has the information](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8886)
 - [meson.build: test for and link against libatomic if it exists](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8647)
 - [pluginloader-win32: Fix helper executable path under devenv](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8761)
 - [pluginloader: fix pending_plugins Glist use-after-free issue](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8849)
 - [unixfdsrc: Complains about resize of memory area](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4347)
 - [tracers: dots: fix debug log](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8712)

#### gst-plugins-base

 - [Ensure properties are freed before (re)setting with g_value_dup_string() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8714)
 - [alsadeviceprovider: Fix leak of Alsa longname](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8632)
 - [audioaggregator: fix error added in !8416 when chaining up](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8743)
 - [audiobasesink: Fix custom slaving driftsamples calculation  and add custom audio clock slaving callback example](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8811)
 - [decodebin3: Don't avoid `parsebin` even if we have a matching decoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8643)
 - [decodebin3: Doesn't plug parsebin for AAC from tsdemux](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4308)
 - [gl: eglimage: warn the reason of export failure](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8713)
 - [glcolorconvert: fix YUVA<->RGBA conversions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8769)
 - [glcolorconvert: regression when rendering alpha vp9](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4339)
 - [gldownload: Unref glcontext after usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8813)
 - [meson.build: test for and link against libatomic if it exists](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8647)
 - [oggdemux: Don't push new packets if there is a pending seek](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8834)
 - [urisourcebin: Make parsebin activation more reliable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8622)
 - [urisourcebin: deadlock between parsebin and typefind](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4225)
 - [videoencoder: Use the correct segment and buffer timestamp in the chain function](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8843)
 - [videotimecode: Fix conversion of timecode to datetime with drop-frame timecodes and handle 119.88 fps correctly in all places](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8704)

#### gst-plugins-good

 - [Ensure properties are freed before (re)setting with g_value_dup_string() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8714)
 - [gst-plugins-good: Matroska mux v4 support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8732)
 - [matroska-demux: Prevent corrupt cluster duplication](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8856)
 - [qml6glsrc: update buffer pool on renegotiation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8705)
 - [qt6: Add a missing newline in unsupported platform message](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8715)
 - [qtdemux: Fix stsc size check in qtdemux_merge_sample_table()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8684)
 - [qtdemux: Next Iteration Of Uncompressed MP4 Decoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8780)
 - [qtdemux: unref simple caps after use](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8880)
 - [rtspsrc: Do not emit signal 'no-more-pads' too early](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8836)
 - [rtspsrc: Don't error out on not-linked too early](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8816)
 - [rtpsession: Do not push events while holding SESSION_LOCK](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8781)
 - [rtpsession: deadlock when gst_rtp_session_send_rtcp () is forwarding eos](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4328)
 - [v4l2: drop frame for frames that cannot be decoded](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8869)
 - [v4l2videodec: AV unsync for streams with many frames that cannot be decoded](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/3031)
 - [v4l2object: fix memory leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8706)
 - [v4l2object: fix type mismatch when ioctl takes int](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8642)
 - [y4menc: fix Y41B format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8796)
 - [y4menc: handle frames with GstVideoMeta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8716)

#### gst-plugins-bad

 - [Add missing Requires in pkg-config](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8708)
 - [Ensure properties are freed before (re)setting with g_value_dup_string() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8714)
 - [Update docs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8778)
 - [aja: Use the correct location of the AJA NTV2 SDK in the docs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8875)
 - [alphacombine: De-couple flush-start/stop events handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8629)
 - [alphadecodebin: use a multiqueue instead of a couple of queues](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8790)
 - [avfvideosrc: Guess reasonable framerate values for some 3rd party devices](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8756)
 - [codecalpha: name both queues](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8750)
 - [d3d12converter: Fix cropping when automatic mipmap is enabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8853)
 - [dashsink: Make sure to use a non-NULL pad name when requesting a pad from splitmuxsink](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8711)
 - [docs: Fix GstWebRTCICE* class documentation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8771)
 - [h264ccextractor, h265ccextractor: Handle gap with unknown pts](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8752)
 - [h265decoder, h265ccinserter: Fix broken SPS/PPS link](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8707)
 - [h265parser: Fix num_long_term_pics bound check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8885)
 - [Segmentation fault in H265 decoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4323)
 - [h266decoder: fix leak parsing SEI messages](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8817)
 - [meson.build: test for and link against libatomic if it exists](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8647)
 - [mse: Improved Thread Safety of API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8751)
 - [mse: Revert ownership transfer API change in gst_source_buffer_append_buffer()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8864)
 - [tensordecoders: updating element classification](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8839)
 - [unixfd: Fix wrong memory size when offset > 0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8770)
 - [uvcsink: Respond to control requests with proper error handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8760)
 - [v4l2codecs: unref frame in all error paths of end_picture](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8804)
 - [va: Skip codecs that report maximum width or height lower than minimum](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8737)
 - [vapostproc: fix wrong video orientation after restarting the element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8872)
 - [vavp9enc: fix mem leaks in _vp9_decide_profile](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8876)
 - [vkformat: fix build error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8749)
 - [vtenc: Avoid deadlocking when changing properties on the fly](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8644)
 - [vulkan: fix memory leak at dynamic registering](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8650)
 - [webrtc: enhance rtx entry creation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8742)
 - [webrtcbin: add missing warning for caps missmatch](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8784)
 - [ZDI-CAN-26596: New Vulnerability Report (Security)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4285)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [Bump MSRV to 1.83](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2203)
 - [Allow any windows-sys version >= 0.52 and <= 0.59](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2201)
 - [aws/polly: add GstScaletempoTargetDurationMeta to output buffers](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2012)
 - [awstranslate: improve message posted on bus](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2073)
 - [cdg: typefind: Division by zero fix](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2137)
 - [cea708mux: Improve support for overflowing input captions](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2183)
 - [colordetect: Change to videofilter base class](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2131)
 - [dav1ddec: Drain decoder on caps changes if necessary](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2136)
 - [dav1ddec: Only update unknown parts of the upstream colorimetry and not all of it](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2132)
 - [dav1ddec: Support RGB encoded AV1](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2170)
 - [dav1ddec: Use downstream buffer pool for copying if video meta is not supported](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2134)
 - [dav1ddec: Use max-frame-delay value from the decoder instead of calculating it](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2185)
 - [dav1ddec: Use max-frame-delay value from the decoder instead of calculating it](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2189)
 - [doc: Update to latest way of generating hotdoc config files](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2107)
 - [Fix gtk4 compile](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2166)
 - [Fix various clippy 1.86 warnings and update gstreamer-rs / gtk-rs dependencies](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2174)
 - [fmp4mux: Add a couple of minor new features](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2193)
 - [fmp4mux: Add manual-split mode that is triggered by serialized downstream events](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2182)
 - [fmp4mux: Add send-force-keyunit property](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2177)
 - [fmp4mux: Fix latency configuration for properties set during construction](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2179)
 - [fmp4mux: Improve split-at-running-time handling](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2178)
 - [fmp4mux/mp4mux: Handle the case of multiple tags per taglist correctly](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2204)
 - [fmp4mux: Write a v0 tfdt box if the decode time is small enough](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2184)
 - [gstwebrtc-api: Add TypeScript type definitions, build ESM for broader compatibility, improve JSDocs](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2049)
 - [hlsmultivariantsink: Allow users to specify playlist and segment location](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2062)
 - [hlssink3 - Add Support for NTP timestamp from buffer](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2017)
 - [livesync: Notify in/out/drop/duplicate properties on change](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2200)
 - [livesync: Only notify drop/duplicate properties](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2207)
 - [meson: Require gst 1.18 features for dav1d](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2135)
 - [mp4mux: Don't write composition time offsets if they're all zero](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2168)
 - [mp4mux, fmp4mux: Use correct timescales for edit lists](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2167)
 - [mpegtslivesrc: increase threshold for PCR <-> PTS DISCONT](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2171)
 - [mpegtslivesrc: Use a separate mutex for the properties](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2128)
 - [mux: use smaller number of samples for testing](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2130)
 - [net/aws: punctuation-related improvements to our span_tokenize_items function](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2126)
 - [pcap_writer: Mark target-factory and pad-path props as construct-only](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2209)
 - [speechmatics: Handle multiple stream-start event](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2205)
 - [tracers: buffer-lateness: don't panic on add overflow + reduce graph legend entry font size a bit](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2149)
 - [tracers: Update to etherparse 0.17](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2213)
 - [transcriberbin: make auto passthrough work when transcriber is a bin](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2165)
 - [ts-jitterbuffer: improve scheduling of lost events](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/756)
 - [tttocea708: fix origin-row handling for roll-up in CEA-708](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2191)
 - [Update Cargo.lock to remove old windows-targets 0.48.5](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2199)
 - [Update dependencies](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2176)
 - [Update gtk-rs / gstreamer-rs dependencies and update for API changes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2141)
 - [Update to bitstream-io 3](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2211)
 - [uriplaylistbin: skip cache test when offline](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2140)
 - [webrtc: Port to reqwest 0.12](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2148)
 - [webrtcsink: Fix compatibility with audio level header extension](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2116)

#### gst-libav

 - No changes

#### gst-rtsp-server

 - [Ensure properties are freed before (re)setting with g_value_dup_string() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8714)

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-python

 - [gst-python: fix compatibility with PyGObject >= 3.52.0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8685)
 - [gst-python: Segmentation Fault since PyGObject >= 3.52.0 due to missing _introspection_module attribute](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4314)

#### gst-editing-services

 - [Ensure properties are freed before (re)setting with g_value_dup_string() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8714)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [Add missing Requires in pkg-config](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8708)
 - [devtools: dots-viewer: Bundle js dependencies using webpack](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8847)
 - [devtools: dots-viewer: Update dependencies and make windows dependencies conditional](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8631)

#### gst-examples

 - [examples: Update Rust dependencies](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8633)
 - [examples: webrtc: rust: Move from async-std to tokio](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8703)

#### gstreamer-docs

 - [Update docs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8778)

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.26.1

 - [FindGStreamerMobile: Override pkg-config on Windows -> Android cross builds](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1776)
 - [Fix BuildTools not using recipes_remotes and recipes_commits](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1774)
 - [bootstrap, meson: Use pathlib.Path.glob to allow Python < 3.10](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1775)
 - [Use of 'glob(..., root_dir)' requires Python >=3.10, cerbero enforces >= 3.7](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/519)
 - [harfbuzz: update to 10.4.0](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1757)
 - [Update fontconfig to 2.16.1, pango to 1.56.2](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1768)

#### Contributors to 1.26.1

Alexander Slobodeniuk, Alyssa Ross, Artem Martus, Arun Raghavan, Brad Hards,
Carlos Bentzen, Carlos Rafael Giani, Daniel Morin, David Smitmanis,
Detlev Casanova, Dongyun Seo, Doug Nazar, dukesook, Edward Hervey, eipachte,
Eli Mallon, François Laignel, Guillaume Desmottes, Gustav Fahlen, Hou Qi,
Jakub Adam, Jan Schmidt, Jan Tojnar, Jordan Petridis, Jordan Yelloz,
L. E. Segovia, Marc Leeman, Marek Olejnik, Mathieu Duponchelle, Matteo Bruni,
Matthew Waters, Michael Grzeschik, Nirbheek Chauhan, Ognyan Tonchev,
Olivier Blin, Olivier Crête, Philippe Normand, Piotr Brzeziński, Razvan Grigore,
Robert Mader, Sanchayan Maity, Sebastian Dröge, Seungha Yang, Shengqi Yu (喻盛琪),
Stefan Andersson, Stéphane Cerveau, Thibault Saunier, Tim-Philipp Müller,
tomaszmi, Víctor Manuel Jáquez Leal, Xavier Claessens,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.26.1

- [List of Merge Requests applied in 1.26.1](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.26.1)
- [List of Issues fixed in 1.26.1](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.26.1)

<a id="1.26.2"></a>

### 1.26.2

The second 1.26 bug-fix release (1.26.2) was released on 29 May 2025.

This release only contains bugfixes as well as a number of [security fixes][security]
and important playback fixes, and it *should* be safe to update from 1.26.0.

[security]: https://gstreamer.freedesktop.org/security/

#### Highlighted bugfixes in 1.26.2

 - Various security fixes and playback fixes
 - aggregator base class fixes to not produce buffers too early in live mode
 - AWS translate element improvements
 - D3D12 video decoder workarounds for crashes on NVIDIA cards on resolution changes
 - dav1d AV1-decoder performance improvements
 - fmp4mux: tfdt and composition time offset fixes, plus AC-3 / EAC-3 audio support
 - GStreamer editing services fixes for sources with non-1:1 aspect ratios
 - MIDI parser improvements for tempo changes
 - MP4 demuxer atom parsing improvements and security fixes
 - New skia-based video compositor element
 - Subtitle parser security fixes
 - Subtitle rendering and seeking fixes
 - Playbin3 and uridecodebin3 stability fixes
 - GstPlay stream selection improvements
 - WAV playback regression fix
 - GTK4 paintable sink colorimetry support and other improvements
 - WebRTC: allow webrtcsrc to wait for a webrtcsink producer to initiate the connection
 - WebRTC: new Janus Video Room WebRTC source element
 - vah264enc profile decision making logic fixes
 - Python bindings gained support for handling mini object writability (buffers, caps, etc.)
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [aggregator: Various state related fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8902)
 - [element: ref-sink the correct pad template when replacing an existing one](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8999)
 - [pipeline: Store the actual latency even if no static latency was configured](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9008)
 - [structure: Add gst_structure_is_writable() API to allow python bindings to be able to handle writability of MiniObjects](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9071)
 - [tracerutils: Do not warn on empty string as tracername](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8892)
 - [tracerutils: Fix leak in gst_tracer_utils_create_tracer()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9065)
 - [Ensure properties are freed before (re)setting with g_value_dup_object() or g_value_dup_boxed() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9088)
 - [Fix new warnings on Fedora 42, various meson warnings, and other small meson build/wrap fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8919)

#### gst-plugins-base

 - [alsa: Avoid infinite loop in DSD rate detection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9005)
 - [gl: Implement basetransform meta transform function](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9041)
 - [glshader: free shader on stop](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9120)
 - [glupload: Only add texture-target field to GL caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8998)
 - [gstaudioutilsprivate: Fix gcc 15 compiler error with function pointer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8910)
 - [mikey: Avoid infinite loop while parsing MIKEY payload with unhandled payload types](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8947)
 - [properties: add G_PARAM_STATIC_STRINGS where missing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8962)
 - [riff-media: fix MS and DVI ADPCM av_bps calculations](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9121)
 - [subtitleoverlay: Remove 0.10 hardware caps handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9045)
 - [subtitleoverlay: Missing support for DMABuf(?)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4353)
 - [tests: opus: Update channel support and add to meson](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9090)
 - [textoverlay: fix shading for RGBx / RGBA pixel format variants](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9111)
 - [textoverlay background is wrong while cropping](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4414)
 - [uridecodebin3: Don't hold play items lock while releasing pads](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9047)
 - [uridecodebin3: deadlock on PLAY_ITEMS_LOCK](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4443)
 - [Fix new warnings on Fedora 42, various meson warnings, and other small meson build/wrap fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8919)
 - [Fix Qt detection in various places](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9063)

#### gst-plugins-good

 - [adaptivedemux2: Fixes for collection handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9012)
 - [adaptivedemux2: Fix several races](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9108)
 - [dash: mpdclient: Don't pass terminating NUL to adapter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9068)
 - [gl: Implement basetransform meta transform function](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9041)
 - [imagefreeze: Set seqnum from segment too](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9092)
 - [interleave: Don't hold object lock while querying caps downstream](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8934)
 - [matroskamux: Write stream headers before finishing file, so that a correct file with headers is written if we finish without any data](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9066)
 - [meson: Add build_rpath for qt6 plugin on macOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9064)
 - [meson: Fix qt detection in various places](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9063)
 - [properties: add G_PARAM_STATIC_STRINGS where missing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8962)
 - [qtdemux: Check length of JPEG2000 colr box before parsing it](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8937)
 - [qtdemux: Parse chan box and improve raw audio channel layout handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9006)
 - [qtdemux: Improve track parsing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9006)
 - [qtdemux: Use byte reader to parse mvhd box](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9133)
 - [qtdemux: cmpd box is only mandatory for uncompressed video with uncC version 0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9040)
 - [rtph264pay: Reject stream-format=avc without codec_data](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8959)
 - [rtputils: Add debug category](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9093)
 - [v4l2: pool: Send drop frame signal after dqbuf success](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9036)
 - [v4l2: pool: fix assert when mapping video frame with DMA_DRM caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8922)
 - [v4l2videoenc: report error only when buffer pool parameters are invalid](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8912)
 - [wavparse: Ignore EOS when parsing the headers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8986)
 - [wavparse: Regression leading to unplaybable wav files that were working before](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4426)
 - [Ensure properties are freed before (re)setting with g_value_dup_object() or g_value_dup_boxed() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9088)
 - [Fix new warnings on Fedora 42, various meson warnings, and other small meson build/wrap fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8919)
 - [Fixes for big endian](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9025)
 - [Switch to `GST_AUDIO_NE()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9089)
 - [Valgrind fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9101)

#### gst-plugins-bad

 - [alphacombine: Fix seeking after EOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9079)
 - [cuda: Fix runtime PTX compile, fix example code build with old CUDA SDK](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8961)
 - [curl: Fix build with MSVC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8946)
 - [curl: small fixups p3](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8958)
 - [d3d12: Fix gstreamer-full subproject build with gcc](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9033)
 - [d3d12: Generate gir file](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9096)
 - [d3d12decoder: Workaround for NVIDIA crash on resolution change](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8977)
 - [d3d12memory: Allow set_fence() only against writable memory](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9094)
 - [d3d12memory: Make D3D12 map flags inspectable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9095)
 - [d3d12screencapturesrc: Fix desktop handle leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9140)
 - [dash: mpdclient: Don't pass terminating NUL to adapter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9068)
 - [dvbsuboverlay: Actually make use of subtitle running time instead of using PTS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9129)
 - [dvbsuboverlay: No subtitles after seek](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4446)
 - [h264parse: Never output stream-format=avc/avc3 caps without codec_data](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9087)
 - [lcevc: Use portable printf formatting macros](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8927)
 - [midiparse: Consider tempo changes when calculating duration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8918)
 - [nvencoder: Fix GstVideoCodecFrame leak on non-flow-ok return](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9084)
 - [play: Improve stream selection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9100)
 - [properties: add G_PARAM_STATIC_STRINGS where missing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8962)
 - [rtpsender: fix 'priority' GValue get/set](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9110)
 - [va: Fix H264 profile decision logic](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8893)
 - [vulkan/wayland: Init debug category before usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9086)
 - [Ensure properties are freed before (re)setting with g_value_dup_object() or g_value_dup_boxed() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9088)
 - [Fix new warnings on Fedora 42, various meson warnings, and other small meson build/wrap fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8919)
 - [Fixes for big endian](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9025)
 - [Fix Qt detection in various places](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9063)
 - [Switch to `GST_AUDIO_NE()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9089)
 - [Valgrind fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9101)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [awstranslate: improve control over accumulator behavior](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2221)
 - [awstranslate: output buffer lists](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2235)
 - [cea608tott: make test text less shocking by having more cues as context](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2249)
 - [dav1ddec: Directly decode into downstream allocated buffers if possible](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2190)
 - [deny: Allow webpki-root-certs license](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2233)
 - [fmp4mux: Add support for AC-3 / EAC-3](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2208)
 - [fmp4mux: Use earliest PTS for the base media decode time (tfdt)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2223)
 - [fmp4mux: Fix handling of negative DTS in composition time offset](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2232)
 - [fmp4mux: Write lmsg as compatible brand into the last fragment](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2222)
 - [mp4mux: add extra brands](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2245)
 - [mp4: avoid dumping test output into build directory](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2257)
 - [mp4: migrate to mp4-atom to check muxing](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2258)
 - [mp4: test the trak structure](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2268)
 - [gtk4: Update and adapt to texture builder API changes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2247)
 - [gtk4: Initial colorimetry support](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2022)
 - [gtk4: Update default GTK4 target version to 4.10](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2252)
 - [rtp: Update to bitstream-io 4.0](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2219)
 - [skia: Implement a video compositor using skia](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1847)
 - [webrtc: addressing a few deadlocks](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2215)
 - [webrtc: Support for producer sessions targeted at a given consumer](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2206)
 - [webrtc: add new JanusVR source element](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1473)
 - [webrtc: janus: clean up and refactoring](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2244)
 - [webrtcsink: Use seq number instead of Uuid for discovery](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2260)
 - [webrtc: Make older peers less likely to crash when webrtcsrc is used](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2259)
 - [Fix or silence various new clippy warnings](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2253)
 - [Update Cargo.lock to fix duplicated target-lexicon](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2254)

#### gst-libav

 - [Valgrind fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9101)
 - [libav: Only allocate extradata while decoding](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9099)

#### gst-rtsp-server

 - [properties: add G_PARAM_STATIC_STRINGS where missing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8962)
 - [properties: ensure properties are freed before (re)setting with g_value_dup_object() or g_value_dup_boxed() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9088)
 - [tests: Valgrind fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9055)

#### gstreamer-vaapi

 - [Ensure properties are freed before (re)setting with g_value_dup_object() or g_value_dup_boxed() and during cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9088)

#### gstreamer-sharp

 - No changes

#### gst-python

This release includes important fixes for the GStreamer Python bindings.

Since pygobject 3.13 around 10 years ago, it wasn't possible anymore to modify
GStreamer miniobjects, e.g. modify caps or set buffer timestamps, as an
implicit copy of the original would always be made. This should finally work
again now.

 - [Fix new warnings on Fedora 42, various meson warnings, and other small meson build/wrap fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8919)
 - [python: Add overrides to be able to handle writability of MiniObjects](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9071)
 - [python: Convert buffer metadata API to use @property decorators](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9138)
 - [REGRESSION: pygobject 3.13 now copies the GstStructure when getting them from a GstCaps, making it impossible to properly modify structures from caps in place](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/76)

#### gst-editing-services

 - [Fix frame position for sources with par < 1](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8894)
 - [Fix video position for sources with pixel-aspect-ratio > 1](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8891)
 - [Valgrind fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9050)
 - [properties: add G_PARAM_STATIC_STRINGS where missing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8962)
 - [Switch to `GST_AUDIO_NE() to make things work properly on Big Endian systems`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9089)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [Fix new warnings on Fedora 42, various meson warnings, and other small meson build/wrap fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8919)
 - [validate: baseclasses: Reset Test timeouts between iterations](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9091)
 - [validate: scenario: Fix race condition when ignoring EOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9098)

#### gst-examples

 - [Fix new warnings on Fedora 42, various meson warnings, and other small meson build/wrap fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8919)
 - [webrtc examples: Fix running against self-signed certs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9034)
 - [webrtc/signalling: fix compatibility with python 3.13](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9000)

#### gstreamer-docs

 - No changes

#### Development build environment

 - Various wrap updates
 - [Add `qt-method` meson options to fix Qt detection in various places](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9063)
 - [pre-commit: Workaround broken shebang on Windows](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9103)

#### Cerbero build tool and packaging changes in 1.26.2

 - [directx-headers: Fix g-ir-scanner expecting MSVC naming convention for gst-plugins-bad introspection](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1827)
 - [m4: update recipe to fix hang in configure](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1825)
 - [pango: Fix introspection missing since 1.56.2 update](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1806)

#### Contributors to 1.26.2

Adrian Perez de Castro, Alexander Slobodeniuk, Alicia Boya García,
Andoni Morales Alastruey, Biswapriyo Nath, Brad Hards, Branko Subasic,
Christoph Reiter, Daniel Morin, Doug Nazar,  Devon Sookhoo, Eva Pace,
Guillaume Desmottes, Hou Qi, Jakub Adam, Jan Schmidt, Jochen Henneberg,
Jordan Petridis, L. E. Segovia, Mathieu Duponchelle, Matthew Waters,
Nicolas Dufresne, Nirbheek Chauhan, Olivier Crête, Pablo García,
Piotr Brzeziński, Robert Mader, Sebastian Dröge, Seungha Yang,
Thibault Saunier, Tim-Philipp Müller, Vasiliy Doylov, Wim Taymans,
Xavier Claessens, Zhao, Gang,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.26.2

- [List of Merge Requests applied in 1.26.2](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.26.2)
- [List of Issues fixed in 1.26.2](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.26.2)

<a id="1.26.3"></a>

### 1.26.3

The third 1.26 bug-fix release (1.26.3) was released on 26 June 2025.

This release only contains bugfixes including some important playback fixes,
and it *should* be safe to update from 1.26.x.

#### Highlighted bugfixes in 1.26.3

 - Security fix for the H.266 video parser
 - Fix regression for WAV files with acid chunks
 - Fix high memory consumption caused by a text handling regression in uridecodebin3 and playbin3
 - Fix panic on late GOP in fragmented MP4 muxer
 - Closed caption conversion, rendering and muxing improvements
 - Decklink video sink preroll frame rendering and clock drift handling fixes
 - MPEG-TS demuxing and muxing fixes
 - MP4 muxer fixes for creating very large files with faststart support
 - New thread-sharing 1:N inter source and sink elements, and a ts-rtpdtmfsrc
 - New speech synthesis element around ElevenLabs API
 - RTP H.265 depayloader fixes and improvements, as well as TWCC and GCC congestion control fixes
 - Seeking improvements in DASH client for streams with gaps
 - WebRTC sink and source fixes and enhancements, including to LiveKit and WHIP signallers
 - The macOS osxvideosink now posts navigation messages
 - QtQML6GL video sink input event handling improvements
 - Overhaul detection of hardware-accelerated video codecs on Android
 - Video4Linux capture source fixes and support for BT.2100 PQ and 1:4:5:3 colorimetry
 - Vulkan buffer upload and memory handling regression fixes
 - gst-python: fix various regressions introduced in 1.26.2
 - cerbero: fix text relocation issues on 32-bit Android and fix broken VisualStudio VC templates
 - packages: ship pbtypes plugin and update openssl to 3.5.0 LTS
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [aggregator: Do not set event seqnum to INVALID](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9152)
 - [baseparse: test: Fix race on test start](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9261)
 - [pad: Only remove TAG events on STREAM_START if the stream-id actually changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9275)
 - [utils: Mark times array as static to avoid symbol conflict with the POSIX function](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9291)
 - [vecdeque: Use correct index type `gst_vec_deque_drop_struct()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9182)

#### gst-plugins-base

 - [GstAudioAggregator: fix structure unref in `peek_next_sample()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9260)
 - [audioconvert: Fix setting mix-matrix when input caps changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9290)
 - [encodebasebin: Duplicate encoding profile in property setter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9173)
 - [gl: simplify private `gst_gl_gst_meta_api_type_tags_contain_only()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9195)
 - [osxvideosink: Use `gst_pad_push_event()` and post navigation messages](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9169)
 - [playsink: Fix race condition in stream synchronizer pad cleanup during state changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9263)
 - [python: Fix pulling events from appsink](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9178)
 - [streamsynchronizer: Consider streams having received stream-start as waiting](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9160)
 - [urisourcebin: Text tracks are no longer set as sparse stream in urisourcebin's multiqueue](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8412)

#### gst-plugins-good

 - [aacparse: Fix counting audio channels in program_config_element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9236)
 - [adaptivedemux2: free cancellable when freeing transfer task](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9197)
 - [dashdemux2: Fix seeking in a stream with gaps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9253)
 - [decodebin wavparse cannot pull header](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4495)
 - [imagefreeze: fix not negotiate log when stop](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9272)
 - [osxvideosink: Use `gst_pad_push_event()` and post navigation messages](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9169)
 - [qml6glsink: Allow configuring if the item will consume input events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9226)
 - [qtmux: Update chunk offsets when converting stco to co64 with faststart](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9237)
 - [splitmuxsink: Only send closed message once per open fragment](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9271)
 - [rtph265depay: CRA_NUT can also start an (open) GOP](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9240)
 - [rtph265depay: fix codec_data generation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9239)
 - [rtspsrc: Don't emit error during close if server is EOF](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9280)
 - [twcc: Fix reference timestamp wrapping (again)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9244)
 - [v4l2: Fix possible internal pool leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9252)
 - [v4l2object: Add support for colorimetry bt2100-pq and 1:4:5:3](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9259)
 - [wavparse: Don't error out always when parsing acid chunks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9241)

#### gst-plugins-bad

 - [amc: Overhaul hw-accelerated video codecs detection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9257)
 - [bayer2rgb: Fix RGB stride calculation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9150)
 - [d3d12compositor: Fix critical warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9159)
 - [dashsink: Fix failing test](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9271)
 - [decklink: calculate internal using values closer to the current clock times](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9269)
 - [decklinkvideosink: show preroll frame correctly](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9238)
 - [decklink: clock synchronization after pause](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4197)
 - [h266parser: Fix overflow when parsing subpic_level_info](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9295)
 - [lcevcdec: Check for errors after receiving all enhanced and base pictures](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9177)
 - [meson: fix building -bad tests with disabled soundtouch](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9192)
 - [mpegts: handle MPEG2-TS with KLV metadata safely by preventing out of bounds](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9251)
 - [mpegtsmux: Corrections around Teletext handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9183)
 - [srtsink: Fix header buffer filtering](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9286)
 - [transcoder: Fix uritranscodebin reference handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9203)
 - [tsdemux: Allow access unit parsing failures](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9258)
 - [tsdemux: Send new-segment before GAP](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9235)
 - [vulkanupload: fix regression for uploading VulkanBuffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9228)
 - [vulkanupload: fix regression when uploading to single memory multiplaned memory images.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9243)
 - [webrtcbin: disconnect signal ICE handlers on dispose](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9249)
 - [{d3d12,d3d11}compositor: Fix negative position handling](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9161)
 - [{nv,d3d12,d3d11}decoder: Use interlace info in input caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9174)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [Add new speech synthesis element around ElevenLabs API](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2313)
 - [cea708mux: fix another WouldOverflow case](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2275)
 - [cea708mux: support configuring a limit to how much data will be pending](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2311)
 - [cea708overlay: also reset the output size on flush stop](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2270)
 - [gcc: handle out of order packets](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2255)
 - [fmp4mux: Fix panic on late GOP](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2236)
 - [livekit: expose a connection state property](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2306)
 - [mp4mux: add taic box](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2246)
 - [mp4mux: test the trak structure](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2268)
 - [pcap_writer: Make target-property and pad-path properties writable again](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2281)
 - [skia: Don't build skia plugin by default for now](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2251)
 - [threadshare: cleanups & usability improvements](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2278)
 - [threadshare: sync runtime with latest async-io](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2287)
 - [threadshare: fix kqueue reactor](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2288)
 - [threadshare: Update to getifaddrs 0.2](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2308)
 - [threadshare: add new thread-sharing inter elements](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2293)
 - [threadshare: add a ts-rtpdtmfsrc element](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2319) 
 - [transcriberbin: fix naming of subtitle pads](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2318)
 - [tttocea708: don't panic if a new service would overflow](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2283)
 - [webrtc: android: Update Gradle and migrate to FindGStreamerMobile](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2266)
 - [webrtc: add new examples for stream selection over data channel](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2276)
 - [webrtcsrc: the webrtcbin get-transceiver index is not mlineindex](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2292)
 - [webrtcsrc: send CustomUpstream events over control channel ..](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2274)
 - [webrtcsink: Don't require encoder element for pre-encoded streams](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2273)
 - [webrtcsink: Don't reject caps events if the codec_data changes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2315)
 - [whip: server: pick session-id from the endpoint if specified](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2282)
 - [cargo: add config file to force `CARGO_NET_GIT_FETCH_WITH_CLI=true`](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2295)
 - [Cargo.lock, deny: Update dependencies and log duplicated targo-lexicon](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2261)
 - [Update windows-sys dependency from ">=0.52, <=0.59" to ">=0.52, <=0.60"](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2298)
 - [deny: Add override for windows-sys 0.59](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2302)
 - [deny: Update lints](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2290)
 - [cargo_wrapper: Fix backslashes being parsed as escape codes on Windows](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2285)
 - [Fixes for Clock: non-optional return types](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2304)
 - [Rename relationmeta plugin to analytics](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2314)
 
#### gst-libav

 - No changes

#### gst-rtsp-server

 - [rtsp-server: tests: Fix a few memory leaks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9155)

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-python

This release includes some important regression fixes for the GStreamer Python
bindings for regressions introduced in 1.26.2.

 - [gst-python/tests: don't depend on webrtc and rtsp-server](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9202)
 - [python: Fix pulling events from appsink and other fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9178)

#### gst-editing-services

 - No changes

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [validate: More memory leaks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9262)
 - [validate: Valgrind fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9154)

#### gst-examples

 - No changes

#### gstreamer-docs

 - No changes

#### Development build environment

 - [gst-env: Emit a warning about `DYLD_LIBRARY_PATH` on macOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9149)

#### Cerbero build tool and packaging changes in 1.26.3

 - [WiX: fix broken VC templates](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1837)
 - [android: Don't ignore text relocation errors on 32-bit, and error out if any are found](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1848)
 - [build: source: handle existing .cargo/config.toml as in plugins-rs](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1844)
 - [ci: Detect text relocations when building android examples](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1853)
 - [gst-plugins-base: Ship pbtypes](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1851)
 - [gst-plugins-base: Fix category of pbtypes](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1854)
 - [gst-plugins-rs: Update for relationmeta -> analytics plugin rename](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1861)
 - [libsoup.recipe: XML-RPC support was removed before the 3.0 release](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1859)
 - [openssl: Update to 3.5.0 LTS](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1846)

#### Contributors to 1.26.3

Albert Sjolund, Aleix Pol, Ben Butterworth, Brad Hards,
César Alejandro Torrealba Vázquez, Changyong Ahn,
Doug Nazar, Edward Hervey, Elliot Chen, Enrique Ocaña González,
François Laignel, Glyn Davies, He Junyan, Jakub Adam, James Cowgill,
Jan Alexander Steffens (heftig), Jan Schmidt, Jochen Henneberg,
Johan Sternerup, Julian Bouzas, L. E. Segovia, Loïc Le Page,
Mathieu Duponchelle, Matthew Waters, Nicolas Dufresne, Nirbheek Chauhan,
Philippe Normand, Pratik Pachange, Qian Hu (胡骞), Sebastian Dröge,
Seungha Yang, Taruntej Kanakamalla, Théo Maillart, Thibault Saunier,
Tim-Philipp Müller, Víctor Manuel Jáquez Leal, Xavier Claessens,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.26.3

- [List of Merge Requests applied in 1.26.3](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.26.3)
- [List of Issues fixed in 1.26.3](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.26.3)

<a id="1.26.4"></a>

### 1.26.4

The fourth 1.26 bug-fix release (1.26.4) was released on 16 July 2025.

This release only contains bugfixes including some important playback fixes,
and it *should* be safe to update from 1.26.x.

#### Highlighted bugfixes in 1.26.4

 - adaptivedemux2: Fixed reverse playback
 - d3d12screencapture: Add support for monitor add/remove in device provider
 - rtmp2src: various fixes to make it play back AWS medialive streams
 - rtph265pay: add profile-id, tier-flag, and level-id to output rtp caps
 - vp9parse: Fix handling of spatial SVC decoding
 - vtenc: Fix negotiation failure with `profile=main-422-10`
 - gtk4paintablesink: Add YCbCr memory texture formats and other improvements
 - livekit: add room-timeout
 - mp4mux: add TAI timestamp muxing support
 - rtpbin2: fix various race conditions, plus other bug fixes and performance improvements
 - threadshare: add a `ts-rtpdtmfsrc` element, implement run-time input switching in `ts-intersrc`
 - webrtcsink: fix deadlock on error setting remote description and other fixes
 - cerbero: WiX installer: fix missing props files in the MSI packages
 - smaller macOS/iOS package sizes
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [tracers: Fix deadlock in latency tracer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9254)
 - [Fix various valgrind/test errors when GST_DEBUG is enabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9314)
 - [More valgrind and test fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9343)
 - [Various ASAN fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9347)

#### gst-plugins-base

 - [Revert "streamsynchronizer: Consider streams having received stream-start as waiting"](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9312)
 - [alsa: free conf cache under valgrind](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9362)
 - [gst-device-monitor: Fix caps filter splitting](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9346)
 - [Fix various valgrind/test errors when GST_DEBUG is enabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9314)
 - [More valgrind and test fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9343)
 - [Various ASAN fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9347)

#### gst-plugins-good

 - [adaptivedemux2: Fixed reverse playback](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9304)
 - [matroskademux: Send tags after seeking](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9313)
 - [qtdemux: Fix incorrect FourCC used when iterating over sbgp atoms](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9319)
 - [qtdemux: Incorrect sibling type used in sbgp iteration loop](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4511)
 - [rtph265pay: add profile-id, tier-flag, and level-id to output rtp caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9302)
 - [rtpjpeg: fix copying of quant data if it spans memory segments](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9369)
 - [soup: Disable range requests when talking to Python's http.server](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9366)
 - [v4l2videodec: need replace acquired_caps on set_format success](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9363)
 - [Fix various valgrind/test errors when GST_DEBUG is enabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9314)
 - [More valgrind and test fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9343)
 - [Various ASAN fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9347)

#### gst-plugins-bad

 - [avtp: crf: Setup socket during state change to ensure we handle failure](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9374)
 - [d3d12screencapture: Add support for monitor add/remove in device provider](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9333)
 - [mpegtsmux: fix double free caused by shared PMT descriptor](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9303)
 - [openh264: Ensure src_pic is initialized before use](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9362)
 - [rtmp2src: various fixes to make it play back AWS medialive streams](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9372)
 - [ssdobjectdetector: Use correct tensor data index for the scores](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9324)
 - [v4l2codecs: h265dec: Fix zero-copy of cropped window located at position 0,0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9315)
 - [vp9parse: Fix handling of spatial SVC decoding](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9327)
 - [vp9parse: Revert "Always default to super-frame"](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9329)
 - [vtenc: Fix negotiation failure with profile=main-422-10](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9371)
 - [vulkan: Fix drawing too many triangles in fullscreenquad](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9370)
 - [vulkanfullscreenquad: add locks for synchronisation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9357)
 - [Fix various valgrind/test errors when GST_DEBUG is enabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9314)
 - [More valgrind and test fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9343)
 - [Various ASAN fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9347)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [aws: s3hlssink: Write to S3 on OutputStream flush](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2330)
 - [cea708mux: fix clipping function](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2372)
 - [dav1ddec: Use video decoder base class latency reporting API](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2368)
 - [elevenlabssynthesizer: fix running time checks](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2348)
 - [gopbuffer: Push GOPs in order of time on EOS](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2335)
 - [gtk4: Improve color-state fallbacks for unknown values](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2349)
 - [gtk4: Add YCbCr memory texture formats](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2271)
 - [gtk4: Promote set_caps debug log to info](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2341)
 - [hlssink3: Fix a comment typo](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2329)
 - [hlssink3: Use closed fragment location in playlist generation](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2324)
 - [livekit: add room-timeout](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2307)
 - [mccparse: Convert "U" to the correct byte representation](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2357)
 - [mp4mux: add TAI timestamp element and muxing](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2280)
 - [threadshare: add a `ts-rtpdtmfsrc` element](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2319)
 - [rtp: Update to rtcp-types 0.2](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2373)
 - [rtpsend: Don't configure a zero min RTCP interval for senders](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2361)
 - [rtpbin2: Fix handling of unknown PTs and don't warn about incomplete RTP caps to allow for bundling](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2364)
 - [rtpbin2: Improve rtcp-mux support](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2362)
 - [rtpbin2: fix race condition on serialized Queries](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2332)
 - [rtpbin2: sync: fix race condition](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2337)
 - [rtprecv optimize src pad scheduling](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2346)
 - [rtprecv: fix SSRC collision event sent in wrong direction](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2351)
 - [skia: Add harfbuzz, freetype and fontconfig as dependencies in the meson build](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2300)
 - [tttocea{6,7}08: Disallow pango markup from input caps](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2367)
 - [ts-intersrc: handle dynamic inter-ctx changes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2378)
 - [threadshare: src elements: don't pause the task in downward state transitions](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2380)
 - [webrtc: sink: avoid recursive locking of the session](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2322)
 - [webrtcsink: fix deadlock on error setting remote description](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2331)
 - [webrtcsink: add mitigation modes parameter and signal](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2279)
 - [webrtc: fix Safari addIceCandidate crash](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2039)
 - [webrtc-api: Set default bundle policy to max-bundle](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2352)
 - [WHIP client: emit shutdown after DELETE request](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2358)
 - [Fix various new clippy 1.88 warnings](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2323)
 - [Update dependencies](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2356)

#### gst-libav

 - [Various ASAN fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9347)

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - [Fix various valgrind/test errors when GST_DEBUG is enabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9314)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [Update various Rust dependencies](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9399)

#### gst-examples

 - [Update various Rust dependencies](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9399)

#### gstreamer-docs

 - No changes

#### Development build environment

 - No changes

#### Cerbero build tool and packaging changes in 1.26.4

 - [WiX: fix missing props files in the MSI](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1879)
 - [cmake: Do not rely on the CERBERO_PREFIX environment variable](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1887)
 - [osx: Update pkgbuild compression algorithms resulting in much smaller packages](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1894)

#### Contributors to 1.26.4

Adrian Perez de Castro, Alicia Boya García, Arun Raghavan, Brad Hards,
David Maseda Neira, David Monge, Doug Nazar, Enock Gomes Neto, François Laignel,
Haihua Hu, Hanna Weiß, Jerome Colle, Jochen Henneberg, L. E. Segovia,
Mathieu Duponchelle, Matthew Waters, Nicolas Dufresne, Nirbheek Chauhan,
Philippe Normand, Piotr Brzeziński, Robert Ayrapetyan, Robert Mader,
Sebastian Dröge, Seungha Yang, Taruntej Kanakamalla,
Thibault Saunier, Tim-Philipp Müller, Vivia Nikolaidou,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.26.4

- [List of Merge Requests applied in 1.26.4](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.26.4)
- [List of Issues fixed in 1.26.4](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.26.4)

<a id="1.26.5"></a>

### 1.26.5

The fifth 1.26 bug-fix release (1.26.5) was released on 7 August 2025.

This release only contains bugfixes including some important playback fixes,
and it *should* be safe to update from 1.26.x.

#### Highlighted bugfixes in 1.26.5

 - audioconvert: Fix caps negotiation regression when using a mix matrix
 - <del>aws: Add support for brevity in awstranslate and add option to partition speakers in the transcription output of awstranscriber2</del>
 - <del>speechmatics speech-to-text: Expose mask-profanities property</del>
 - <del>cea708mux: Add support for discarding select services on each input</del>
 - cea608overlay, cea708overlay: Accept GPU memory buffers if downstream supports the overlay composition meta
 - d3d12screencapture source element and device provider fixes
 - decodebin3: Don't error on an incoming ONVIF metadata stream
 - uridecodebin3: Fix potential crash when adding URIs to messages, e.g. if no decoder is available
 - v4l2: Fix memory leak for dynamic resolution change
 - VA encoder fixes
 - videorate, imagefreeze: Add support for JPEG XS
 - Vulkan integration fixes
 - wasapi2 audio device monitor improvements
 - <del>webrtc: Add WHEP client signaller and add whepclientsrc element on top of webrtcsrc using that</del>
 - threadshare: Many improvements and fixes to the generic threadshare and RTP threadshare elements
 - rtpbin2 improvements and fixes
 - gst-device-monitor-1.0 command line tool improvements
 - Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [aggregator: add sub_latency_min to pad queue size](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9490)
 - [build: Disable C5287 warning on MSVC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9450)

#### gst-plugins-base

 - [audioconvert: Fix regression when using a mix matrix](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9499)
 - [audioconvert: mix-matrix causes caps negotiation failure](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4579)
 - [decodebin3: Don't error on an incoming ONVIF metadata stream](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9488)
 - [gloverlay: Recompute geometry when caps change, and load texture after stopping and starting again](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9462)
 - [uridecodebin3: Add missing locking and NULL checks when adding URIs to messages](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9501)
 - [uridecodebin3: segfault in update_message_with_uri() if no decoder available](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4559)
 - [videorate, imagefreeze: add support for JPEG XS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9421)
 - [gst-device-monitor-1.0: Add shell quoting for launch lines](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9486)
 - [gst-device-monitor-1.0: Fix criticals, and also accept utf8 in launch lines](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9498)
 - [gst-device-monitor-1.0: Use gst_print instead of g_print](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9470)

#### gst-plugins-good

 - [v4l2: fix memory leak for dynamic resolution change](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9491)
 - [videorate, imagefreeze: add support for JPEG XS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9421)

#### gst-plugins-bad

 - [av1parse: Don't error out on "currently" undefined seq-level indices](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9504)
 - [av1parse: fails to parse AV1 bitstreams generated by FFmpeg using the av1_nvenc hardware encoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4589)
 - [d3d12screencapturedevice: Avoid false device removal on monitor reconfiguration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9481)
 - [d3d12screencapturesrc: Fix OS handle leaks/random crash in WGC mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9424)
 - [meson: d3d12: Add support for MinGW DirectXMath package](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9473)
 - [va: Re-negotiate after FLUSH](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9461)
 - [vaXXXenc: calculate latency with corrected framerate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9447)
 - [vaXXXenc: fix potential race condition](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9484)
 - [vkphysicaldevice: enable sampler ycbcr conversion, synchronization2 and timeline semaphore features](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9489)
 - [vulkan: ycbcr conversion extension got promoted in 1.1.0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9482)
 - [wasapi2: Port to IMMDevice based device selection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9428)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - **Note: This list has been updated**, since it originally accidentally included some Merge Requests that only landed in the `main` branch, not in the `0.14` branch that ships with our GStreamer 1.26.5 packages.

 - [awstranscriber2, awstranslate: Handle multiple stream-start event](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2426)
 - <del>[awstranslate: expose property for turning brevity on](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2406))</del>
 - <del>[awstranscriber2: add property for setting show_speaker_labels](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2240))</del>
 - <del>[cea708mux: expose "discarded-services" property on sink pads](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2389))</del>
 - [ceaX08overlay: support ANY caps features, allowing e.g. memory:GLMemory if downstream supports the overlay composition meta](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2396)
 - [hlsmultivariantsink: Fix master playlist version](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2417)
 - [rtprecv: Drop state lock before chaining RTCP packets from the RTP chain function](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2384)
 - [Add rtpbin2 examples](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2386)
 - [rtpmp4apay2: fix payload size prefix](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2394)
 - [rtp: threadshare: fix some property ranges](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2421)
 - [mpegtslivesrc: Remove leftover debug message](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2413)
 - <del>[speechmatics: expose mask-profanities property](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2344))</del>
 - [ts-audiotestsrc fixes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2424)
 - [threadshare: fix flush for ts-queue ts-proxy & ts-intersrc](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2403)
 - [threadshare: fix regression in ts-proxysrc](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2407)
 - [threadshare: improvements to some elements](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2422)
 - <del>[threadshare: udp: avoid getifaddrs in android](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1918))</del>
 - [threadshare: Enable windows `Win32_Networking` feature](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2429)
 - [threadshare: queue & proxy: fix race condition stopping](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2430)
 - [threadshare: Also enable windows `Win32_Networking_WinSock` feature](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2432)
 - [tracers: pipeline-snapshot: reduce WebSocket connection log level](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2434)
 - [tracers: queue-levels: add support for threadshare DataQueue related elements](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2401)
 - [tracers: Update to etherparse 0.19](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2416)
 - [transcriberbin: Fix handling of upstream latency query](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2423)
 - <del>[webrtc: android example: fix media handling initialization sequence](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2216))</del>
 - [webrtcsink: Move videorate before videoconvert and videoscale to avoid processing frames that would be dropped](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2425)
 - <del>[whep: add WHEP client signaller](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1545)</del>
 - [Fix various new clippy 1.89 warnings](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2437)

#### gst-libav

 - No changes

#### gst-rtsp-server

 - No changes

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-python

 - No changes

#### gst-editing-services

 - No changes

#### gst-devtools, gst-validate + gst-integration-testsuites

 - No changes

#### gst-examples

 - No changes

#### gstreamer-docs

 - No changes

#### Development build environment

 - [gst-env: only-environment: only dump added and updated vars](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9436)
 - [gst-full: Fix detection of duplicate plugin entries](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9451)
 - [ci: Fix gst-full breakage due to a typo](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9454)
 - [build: Disable C5287 warning on MSVC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9450)

#### Cerbero build tool and packaging changes in 1.26.5

 - [a52dec: update to 0.8.0 and port to Meson](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1908)
 - [build: Fix passing multiple steps](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1913)
 - [expat: update to 2.7.1](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1909)
 - [tar: Refactor in preparation for xcframework support](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1901)

#### Contributors to 1.26.5

François Laignel, Jan Schmidt, Jaslo Ziska, L. E. Segovia, Marc-André Lureau,
Mathieu Duponchelle, Matthew Waters, Nirbheek Chauhan, Philippe Normand,
Qian Hu (胡骞), Sanchayan Maity, Sebastian Dröge, Seungha Yang, Thibault Saunier,
Tim-Philipp Müller, Víctor Manuel Jáquez Leal, Xavier Claessens,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.26.5

- [List of Merge Requests applied in 1.26.5](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.26.5)
- [List of Issues fixed in 1.26.5](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.26.5)

## Schedule for 1.28

Our next major feature release will be 1.28, and 1.27 will be the unstable
development version leading up to the stable 1.28 release. The development
of 1.27/1.28 will happen in the git `main` branch of the GStreamer mono
repository.

The schedule for 1.28 is yet to be decided, but we're aiming for a release
towards the end of 2025.

1.28 will be backwards-compatible to the stable 1.26, 1.24, 1.22, 1.20, 1.18, 1.16, 1.14, 1.12, 1.10, 1.8, 1.6, 1.4, 1.2 and 1.0 release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller with contributions from Arun Raghavan, Daniel Morin, Nirbheek Chauhan, Olivier Crête, Philippe Normand, Sebastian Dröge, Seungha Yang, Thibault Saunier, and Víctor Manuel Jáquez Leal.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
