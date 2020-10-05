# GStreamer 1.18 Release Notes

GStreamer 1.18.0 was originally released on 8 September 2020.

<!--
The latest bug-fix release in the 1.18 series is [1.18.1](#1.16.1) and was released on ... 2020.
-->

See [https://gstreamer.freedesktop.org/releases/1.18/][latest] for the latest version of this document.

*Last updated: Monday 7 September 2020, 23:30 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.18/
[gitlog]: https://gitlab.freedesktop.org/gstreamer/www/commits/master/src/htdocs/releases/1.18/release-notes-1.18.md

## Introduction

The GStreamer team is proud to announce a new major feature release in the stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with many new features, bug fixes and other improvements.

## Highlights

- `GstTranscoder`: new high level API for applications to transcode media files from one format to another

- High Dynamic Range (HDR) video information representation and signalling enhancements

- Instant playback rate change support

- Active Format Description (AFD) and Bar Data support
 
- RTSP server and client implementations gained ONVIF trick modes support

- Hardware-accelerated video decoding on Windows via DXVA2 / Direct3D11

- Microsoft Media Foundation plugin for video capture and hardware-accelerated video encoding on Windows

- `qmlgloverlay`: New overlay element that renders a `QtQuick` scene over the top of an input video stream

- `imagesequencesrc`: New element to easily create a video stream from a sequence of jpeg or png images

- `dashsink`: New sink to produce DASH content

- `dvbsubenc`: New DVB Subtitle encoder element

- MPEG-TS muxing now also supports TV broadcast compliant muxing with constant bitrate muxing and SCTE-35 support

- `rtmp2`: New RTMP client source and sink element from-scratch implementation

- `svthevcenc`: New [SVT-HEVC](https://github.com/OpenVisualCloud/SVT-HEVC)-based H.265 video encoder

- `vaapioverlay`: New compositor element using VA-API

- `rtpmanager` gained support for Google's Transport-Wide Congestion Control (twcc) RTP extension

- `splitmuxsink` and `splitmuxsrc` gained support for auxiliary video streams

- `webrtcbin` now contains some initial support for renegotiation involving stream addition and removal

- RTP support was enhanced with new RTP source and sink elements to easily set up RTP streaming via `rtp://` URIs

- `avtp`: New Audio Video Transport Protocol (AVTP) plugin for Time-Sensitive Applications

- Support for the Video Services Forum's Reliable Internet Stream Transport (RIST) TR-06-1 Simple Profile

- Universal Windows Platform (UWP) support

- `rpicamsrc`: New element for capturing from the Raspberry Pi camera

- RTSP Server TCP interleaved backpressure handling improvements as well as support for Scale/Speed headers

- GStreamer Editing Services gained support for nested timelines, per-clip speed rate control and the [OpenTimelineIO](https://opentimelineio.readthedocs.io) format.

- Autotools build system has been removed in favour of Meson

## Major new features and changes

### Noteworthy new features and API

#### Instant playback rate changes

Changing the playback rate as quickly as possible so far always required a flushing seek. This generally works, but has the disadvantage of flushing all data from the playback pipeline and requiring the demuxer or parser to do a full-blown seek including resetting its internal state and resetting the position of the data source. It might also require considerable decoding effort to get to the right position to resume playback from at the higher rate.

This release adds a new mechanism to achieve quasi-instant rate changes in certain playback pipelines without interrupting the flow of data in the pipeline. This is activated by sending a seek with the `GST_SEEK_FLAG_INSTANT_RATE_CHANGE` flag and `start_type` = `stop_type` = `GST_SEEK_TYPE_NONE`. This flag does not work for all pipelines, in which case it is necessary to fall back to sending a full flushing seek to change the playback rate. When using this flag, the seek event is only allowed to change the current rate and can modify the trickmode flags (e.g. keyframe only or not), but it is not possible to change the current playback position, playback direction or do a flush.

This is particularly useful for streaming use cases like HLS or DASH where the streaming download should not be interrupted when changing rate.

Instant rate changing is handled in the pipeline in a specific sequence which is detailed in the [seeking design docs](https://gstreamer.freedesktop.org/documentation/additional/design/seeking.html). Most elements don't need to worry about this, only elements that sync to the clock need some special handling which is implemented in the `GstBaseSink` base class, so should be taken care of automatically in most normal playback pipelines and sink elements.

See Jan's GStreamer Conference 2019 talk ["Changing Playback Rate Instantly"](https://gstconf.ubicast.tv/videos/changing-playback-rate-instantly/) for more information.

You can try this feature by passing the `-i` command line option to `gst-play-1.0`. It is supported at least by `qtdemux`, `tsdemux`, `hlsdemux`, and `dashdemux`.

#### Google Transport-Wide Congestion Control

`rtpmanager` now supports the parsing and generating of RTCP messages for the Google Transport-Wide Congestion Control RTP Extension, as described in: [https://tools.ietf.org/html/draft-holmer-rmcat-transport-wide-cc-extensions-01](https://tools.ietf.org/html/draft-holmer-rmcat-transport-wide-cc-extensions-01).

This "just" provides the required plumbing/infrastructure, it does not actually make effect any actual congestion control on the sender side, but rather provides information for applications to use to make such decisions.

See [Håvard's "Google Transport-Wide Congestion Control" talk](https://gstconf.ubicast.tv/videos/google-transport-wide-congestion-control/) for more information about this feature.

#### GstTranscoder: a new high-level transcoding API for applications

The new [`GstTranscoder` library](https://gstreamer.freedesktop.org/documentation/transcoder/index.html?gi-language=c), along with `transcodebin` and `uritranscodebin` elements, provides high level API for applications to transcode media files from one format to another. Watch Thibault's talk ["GstTranscoder: A High Level API to Quickly Implement Transcoding Capabilities in your Applications"](https://gstconf.ubicast.tv/videos/gsttranscoder-a-high-level-api-to-quickly-implement-transcoding-capabilities-in-your-applications/) for more information.

This also comes with a `gst-transcoder-1.0` command line utility to transcode one URI into another URI based on the specified encoding profile.

####  Active Format Description (AFD) and Bar Data support

The [GstVideo Ancillary Data](https://gstreamer.freedesktop.org/documentation/video/gstvideoanc.html?gi-language=c) API has gained support for Active Format Description (AFD) and Bar data.

This includes various two new buffer metas: `GstVideoAFDMeta` and `GstVideoBarMeta`.

GStreamer now also parses and extracts AFD/Bar data in the h264/h265 video parsers, and supports both capturing them and outputting them in the `decklink` elements. See Aaron's [lightning talk](https://gstconf.ubicast.tv/permalink/v125d173da4d6ffimx2s/#start=2690) at the GStreamer Conference for more background.

#### ONVIF trick modes support in both GStreamer RTSP server and client

- Support for the various trick modes described in section 6 of the [ONVIF streaming spec] has been implemented in both `gst-rtsp-server` and `rtspsrc`.
- Various new properties in `rtspsrc` must be set to take advantage of the ONVIF support
- Examples are available here: [test-onvif-server.c](https://gitlab.freedesktop.org/gstreamer/gst-rtsp-server/-/blob/master/examples/test-onvif-server.c) and [test-onvif-client.c](https://gitlab.freedesktop.org/gstreamer/gst-rtsp-server/-/blob/master/examples/test-onvif-client.c)
- Watch Mathieu Duponchelle's talk ["Implementing a Trickmode Player with ONVIF, RTSP and GStreamer"][onvif-talk] for more information and a live demo.

[ONVIF streaming spec]: https://www.onvif.org/specs/stream/ONVIF-Streaming-Spec.pdf
[onvif-talk]: https://gstconf.ubicast.tv/videos/implementing-a-trickmode-player-with-onvif-rtsp-and-gstreamer/

#### GStreamer Codecs library with decoder base classes

This introduces a new library in `gst-plugins-bad` which contains a set of base classes that handle bitstream parsing and state tracking for the purpose of decoding different codecs. Currently H264, H265, VP8 and VP9 are supported. These bases classes are meant primarily for internal use in GStreamer and are used in various decoder elements in connection with low level decoding APIs like DXVA, NVDEC, VAAPI and V4L2 State Less decoders. The new library is named `gstreamer-codecs-1.0` / `libgstcodecs-1.0` and is not yet guaranteed to be API stable across major versions.

#### MPEG-TS muxing improvements

The GStreamer MPEG-TS muxer has seen major improvements on various fronts in this cycle:

- It has been ported to the `GstAggregator` base class which means it can work in defined-latency mode with live input sources and continue streaming if one of the inputs stops producing data.

- `atscmux`, a new ATSC-specific `tsmux` subclass

- Constant Bit Rate (CBR) muxing support via the new `bitrate` property which allows setting the target bitrate in bps. If this is set the muxer will insert null packets as padding to achieve the desired multiplex-wide constant bitrate.

- compliance fixes for TV broadcasting use cases (esp. ATSC). See Jan's talk ["TV Broadcast compliant MPEG-TS"](https://gstconf.ubicast.tv/videos/tv-broadcast-compliant-mpeg-ts/) for details.

- Streams can now be added and removed at runtime: Until now, any streams in `tsmux` had to be present when the element started outputting its first buffer. Now they can appear at any point during the stream, or even disappear and reappear later using the same PID.

- new `pcr-interval` property allows applications to configure the desired interval instead of hardcoding it

- basic SCTE-35 support. This is enabled by setting the `scte-35-pid` property on the muxer. Sending SCTE-35 commands is then done by creating the appropriate SCTE-35 `GstMpegtsSection` and sending them on the muxer.

- MPEG-2 AAC handling improvements

### New elements

- New [`qmlgloverlay`][qmlgloverlay] element for rendering a `QtQuick` scene over the top of a video stream. `qmlgloverlay` requires that Qt support adopting an external OpenGL context and is known to work on X11 and Windows. Wayland is known not to work due to limitations within Qt. Check out the [example][qmlgloverlay-example] to see how it works.

- The `clocksync` element is a generic element that can be placed in a pipeline to synchronise passing buffers to the clock at that point. This is similar to `identity sync=true`, but because it isn't `GstBaseTransform`-based, it can process `GstBufferList`s without breaking them into separate `GstBuffer`s. It is also more discoverable than the identity option. Note that you do not need to insert this element into your pipeline to make GStreamer sync to the pipeline clock, this is usually handled automatically by the elements in the pipeline (sources and sinks mostly). This element is useful to feed non-live input such as local files into elements that expect live input such as `webrtcbin`.`

- New [`imagesequencesrc`][imagesequencesrc] element to easily create a video stream from a sequence of JPEG or PNG images (or any other encoding where the type can be detected), basically a `multifilesrc` made specifically for image sequences.

- `rpicamsrc` element for capturing raw or encoded video (H.264, MJPEG) from the Raspberry Pi camera. This works much like the popular `raspivid` command line utility but outputs data nicely timestamped and formatted in order to integrate nicely with other GStreamer elements. Also comes with a device provider so applications can discover the camera if available.
 
- [`aatv`][aatv] and [`cacatv`][cacatv] video filters that transform video ASCII art style

- `avtp`: new Audio Video Transport Protocol (AVTP) [plugin](https://gstreamer.freedesktop.org/documentation/avtp/index.html?gi-language=c#avtp-page) for Linux. See Andre Guedes' talk ["Audio/Video Bridging (AVB) support in GStreamer"](https://gstconf.ubicast.tv/videos/audiovideo-bridging-avb-support-in-gstreamer/) for more details.

- `clockselect`: a pipeline element that enables clock selection/forcing via gst-launch pipeline syntax.

- `dashsink`: Add new sink to produce DASH content. See Stéphane's [talk](https://gstconf.ubicast.tv/videos/dashsink-plugin-to-complete-the-gstreamer-offering/) or [blog post](https://www.collabora.com/news-and-blog/blog/2020/06/12/generating-mpeg-dash-streams-for-open-source-adaptive-streaming-with-gstreamer/) for details.

- `dvbsubenc`: a DVB subtitle encoder element

- `microdns`: a libmicrodns-based mdns device provider to discover RTSP cameras on the local network

- `mlaudiosink`: new audio sink element for the Magic Leap platform, accompanied by an MLSDK implementation in the `amc` plugin

- `msdkvp9enc`: VP9 encoder element for the Intel MediaSDK

- `rist`: new plugin implementing support for the Video Services Forum's Reliable Internet Stream Transport (RIST) TR-06-1 Simple Profile. See Nicolas' blog post ["GStreamer support for the RIST Specification"](https://www.collabora.com/news-and-blog/news-and-events/gstreamer-support-for-the-rist-specification.html) for more details.

- `rtmp2`: new RTMP client source and sink elements with fully asynchronous network operations, better robustness and additional features such as handling ping and stats messages, and adobe-style authentication. The new `rtmp2src` and `rtmp2sink` elements should be API-compatible with the old `rtmpsrc` / `rtmpsink` elements and should work as drop-in replacements.

- new RTP source and sink elements to easily set up RTP streaming via `rtp://` URIs: The `rtpsink` and `rtpsrc` elements add an URI interface so that streams can be decoded with decodebin using `rtp://` URIs. These can be used as follows:
    ```
    gst-launch-1.0 videotestsrc ! x264enc ! rtph264pay config-interval=3 ! rtpsink uri=rtp://239.1.1.1:1234
    
    gst-launch-1.0 videotestsrc ! x264enc ! rtph264pay config-interval=1 ! rtpsink uri=rtp://239.1.2.3:5000
    gst-launch-1.0 rtpsrc uri=rtp://239.1.2.3:5000?encoding-name=H264 ! rtph264depay ! avdec_h264 ! videoconvert ! xvimagesink
    
    gst-launch-1.0 videotestsrc ! avenc_mpeg4 ! rtpmp4vpay config-interval=1 ! rtpsink uri=rtp://239.1.2.3:5000
    gst-launch-1.0 rtpsrc uri=rtp://239.1.2.3:5000?encoding-name=MP4V-ES ! rtpmp4vdepay ! avdec_mpeg4 ! videoconvert ! xvimagesink
    ```

- `svthevcenc`: new [SVT-HEVC](https://github.com/OpenVisualCloud/SVT-HEVC)-based H.265 video encoder

- `switchbin`: new helper element which chooses between a set of processing chains (paths) based on input caps, and changes the active chain if new caps arrive. Paths are child objects, which are accessed by the GstChildProxy interface. See the [switchbin documentation](https://gstreamer.freedesktop.org/documentation/switchbin/index.html?gi-language=c#switchbin-page) for a usage example.

- `vah264dec`: new experimental `va` plugin with an element for H.264 decoding with VA-API using GStreamer's new stateless decoder infrastructure (see Linux section below).

- `v4l2codecs`: introduce an V4L2 CODECs Accelerator supporting the new CODECs uAPI in the Linux kernel (see Linux section below)

- `zxing` new plugin to detect QR codes and barcodes, based on [libzxing](https://github.com/zxing/zxing)

- also see the Rust plugins section below which contains plenty of new exciting plugins written in Rust!

[qmlgloverlay]: https://gstreamer.freedesktop.org/documentation/qmlgl/qmlgloverlay.html?gi-language=c#qmlgloverlay-page
[qmlgloverlay-example]: https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/-/tree/master/tests/examples/qt/qmloverlay
[imagesequencesrc]: https://gstreamer.freedesktop.org/documentation/multifile/imagesequencesrc.html?gi-language=c#imagesequencesrc-page
[aatv]: https://gstreamer.freedesktop.org/documentation/aasink/aatv.html?gi-language=c#aatv-page
[cacatv]: https://gstreamer.freedesktop.org/documentation/cacasink/cacatv.html?gi-language=c#cacatv-page

### New element features and additions

#### GStreamer core

- `filesink`: Add a new "full" buffer mode. Previously the `default` and `full` modes were the same. Now the `default` mode is like before: it accumulates all buffers in a buffer list until the threshold is reached and then writes them all out, potentially in multiple writes. The new `full` mode works by always copying memory to a single memory area and writing everything out with a single write once the threshold is reached.

- `multiqueue`: Add `stats` property and `current-level-{buffers, bytes, time}` pad properties to query the current levels of the corresponding internal queue.

#### Plugins Base

- `alsa`: implement a device provider
- `alsasrc`: added `use-driver-timestamp` property to force use of pipeline timestamps (and disable driver timestamps) if so desired

- `audioconvert`: fix changing the `mix-matrix` property at runtime

- `appsrc`: added support for segment forwarding or custom GstSegments via `GstSample`, enabled via the `handle-segment-change` property. This only works for segments in `TIME` format for now.

- `compositor`: various performance optimisations, checkerboard drawing fixes, and support for `VUYA` format

- `encodebin`: Fix and refactor smart encoding; ensure that a single segment is pushed into encoders; improve force-key-unit event handling.

- `opusenc`: Add low delay option (`audio-type=restricted-lowdelay`) to disable the SILK layer and achieve only 5ms delay.
- opusdec: add `stats` property to retrieve various decoder statistics.

- `uridecodebin3`: Let decodebin3 do its stream selection if no one answers
- `decodebin3`: Avoid overriding explicit user selection of streams

- `playbin`: add flag to force use of software decoders over any hardware decoders that might also be available
- `playbin3`, `playbin`: propagate sink context

- `rawvideoparse`: Fix tiling support, allow setting colorimetry

- `subparse`: output plain `utf8` text instead of `pango-markup` formatted text if downstream requires it, useful for interop with elements that only accept `utf8`-formatted subtitles such as muxers or closed caption converters.

- `tcpserversrc`, `tcpclientsrc`: add `stats` property with TCP connection stats (some are only available on Linux though)

- `timeoverlay`: add `show-times-as-dates`, `datetime-format` and `datetime-epoch` properties to display times with dates

- `videorate`: Fix changing `rate` property during playback; reverse playback fixes; update QoS events taking into account our rate

- `videoscale`: pass through and transform size sensitive metas instead of just dropping them

#### Plugins Good

- `avidemux` can handle H.265 video now. Our advice remains to immediately cease all contact and communication with anyone who hands you H.265 video in an AVI container, however.

- `avimux`: Add support for `S24LE` and `S32LE` raw audio and `v210` raw video formats; support more than 2 channels of raw audio.

- `souphttpsrc`: disable session sharing and cookie jar when the `cookies` property is set; correctly handle seeks past the end of the content

- `deinterlace`: new YADIF deinterlace method which should provide better quality than the existing methods and is LGPL licensed; alternate fields are supported as input to the deinterlacer as well now, and there were also fixes for switching the deinterlace mode on the fly.

- `flvmux`: in streamable mode allow adding new pads even if the initial header has already been written. Old clients will only process the initial stream, new clients will get a header with the new streams. The `skip-backwards-streams` property can be used to force `flvmux` to skip and drop a few buffers rather than produce timestamps that go backward and confuse librtmp-based clients. There's also better handling for timestamp rollover when streaming for a long time.

- `imagefreeze`: Add live mode, which can be enabled via the new `is-live` property. In this mode frames will only be output in `PLAYING` state according to the negotiated framerate, skipping frames if the output can't keep up (e.g. because it's blocked downstream). This makes it possible to actually use `imagefreeze` in live pipelines without having to manually ensure somehow that it starts outputting at the current running time and without still risking to fall behind without recovery.

- `matroskademux`, `qtdemux`: Provide audio lead-in for some lossy formats when doing accurate seeks, to make sure we can actually decode samples at the desired position. This is especially important for non-linear audio/video editing use-cases.

- `matroskademux`, `matroskamux`: Handle interlaced field order (tff, bff)

- `matroskamux`:
  - new `offset-to-zero` property to offset all streams to start at zero. This takes the timestamp of the earliest stream and offsets it so that it starts at 0. Some software (VLC, ffmpeg-based) does not properly handle Matroska files that start at timestamps much bigger than zero, which could happen with live streams.
  - added a `creation-time` property to explicitly set the creation time to write into the file headers. Useful when remuxing, for example, but also for live feeds where the `DateUTC` header can be set a UTC timestamp corresponding to the beginning of the file.
  - the muxer now also always waits for caps on sparse streams, and warns if caps arrive after the header has already been sent, otherwise the subtitle track might be silently absent in the final file. This might affect applications that send sparse data into `matroskamux` via an `appsrc` element, which will usually not send out the initial caps before it sends out the first buffer.

- `pulseaudio`: device provider improvements: fix discovery of newly-added devices and hide the alsa device provider if we provide alsa devices

- `qtdemux`: raw audio handling improvements, support for AC4 audio, and key-units trickmode interval support

- `qtmux`:
  - was ported to the `GstAggregator` base class which allows for better handling of live inputs, but might entail minor behavioural changes for sparse inputs if inputs are not live.
  - has also gained a `force-create-timecode-trak` property to create a timecode trak in non-mov flavors, which may not be supported by Apple but is supported by other software such as Final Cut Pro X
  - also a `force-chunks` property to force the creation of chunks even in single-stream files, which is required for Apple ProRes certification.
  - also supports 8k resolutions in prefill mode with ProRes.

- `rtpbin` gained a `request-jitterbuffer` signal which allows applications to plug in their own jitterbuffer implementation such as the threadsharing jitterbuffer from the Rust plugins, for example.

- `rtprtxsend`: add `clock-rate-map` property to allow generic RTP input caps without a clock-rate whilst still supporting the `max-size-time` property for bundled streams.

- `rtpssrcdemux`: introduce `max-streams` property to guard against attacks where the sender changes SSRC for every RTP packet.

- `rtph264pay`, `rtph264pay`: implement STAP-A and various aggregation modes controled by the new `aggegrate-mode` property: `none` to not aggregate NAL units (as before), `zero-latency` to aggregate NAL units until a VCL or suffix unit is included, or `max` to aggregate all NAL units with the same timestamp (which adds one frame of latency). The default has been kept at `none` for backwards compatibility reasons and because various RTP/RTSP implementions don't handle aggregation well. For WebRTC use cases this should be set to `zero-latency`, however.

- `rtpmp4vpay`: add support for `config-interval=-1` to resend headers with each IDR keyframe, like other video payloaders.

- `rtpvp8depay`: Add `wait-for-keyframe` property for waiting until the next keyframe after packet loss. Useful if the video stream was not encoded with error resilience enabled, in which case packet loss tends to cause very bad artefacts when decoding, and waiting for the next keyframe instead improves user experience considerably.

- `splitmuxsink` and `splitmuxsrc` can now handle auxiliary video streams in addition to the primary video stream.  The primary video stream is still used to select fragment cut points at keyframe boundaries. Auxilliary video streams may be broken up at any packet - so fragments may not start with a keyframe for those streams.

- `splitmuxsink`:
  - new `muxer-preset` and `sink-preset` properties for setting muxer/sink presets
  - a new `start-index` property to set the initial fragment id
  - and a new `muxer-pad-map` property which explicitly maps splitmuxsink pads to the muxer pads they should connect to, overriding the implicit logic that tries to match pads but yields arbitrary names.
  - Also includes the actual sink element in the `fragment-opened` and `fragment-closed` element messages now, which is especially useful for sinks without a location property or when finalisation of the fragments is done asynchronously.

- `videocrop`: add support for `Y444`, `Y41B` and `Y42B` pixel formats

- `vp8enc`, `vp9enc`: change default value of `VP8E_SET_STATIC_THRESHOLD` from 0 to 1 which matches what Google WebRTC does and results in lower CPU usage; also added a new `bit-per-pixel` property to select a better default bitrate

- `v4l2`: add support for `ABGR`, `xBGR`, `RGBA`, and `RGBx` formats and for handling interlaced video in alternate fields interlace mode (one field per buffer instead of one frame per picture with both fields interleaved)

- `v4l2`: Profile and level probing support for H264, H265, MPEG-4, MPEG-2, VP8, and VP9 video encoders and decoders

#### Plugins Ugly

- `asfdemux`: extract more metadata: disc number and disc count

- `x264enc`:
  - respect YouTube bitrate recommendation when user sets the YouTube profile preset
  - separate high-10 video formats from 8-bit formats to improve depth negotiation and only advertise suitable input raw formats for the desired output depth
  - forward downstream colorimetry and chroma-site restrictions to upstream elements
  - support more color primaries/mappings

#### Plugins Bad

- `av1enc`: add `threads`, `row-mt` and `tile-{columns,rows}` properties for this AOMedia AV1 encoder

- `ccconverter`: implement support for CDP framerate conversions

- `ccextractor`: Add `remove-caption-meta` property to remove caption metas from the outgoing video buffers

- `decklink`: add support for 2K DCI video modes, widescreen NTSC/PAL, and for parsing/outputting AFD/Bar data. Also implement a simple device provider for Decklink devices.

- `dtlsrtpenc`: add `rtp-sync` property which synchronises RTP streams to the pipeline clock before passing them to funnel for merging with RTCP.

- `fdkaac`: also decode MPEG-2 AAC; encoder now supports more multichannel/surround sound layouts

- `hlssink2`: add action signals for custom playlist/fragment handling: Instead of always going through the file system API we allow the application to modify the behaviour. For the playlist itself and fragments, the application can provide a GOutputStream. In addition the sink notifies the application whenever a fragment can be deleted.

- `interlace`: can now output data in alternate fields mode; added field switching mode for 2:2 field pattern

- `iqa`: Add a `mode` property to enable strict mode that checks that all the input streams have the exact same number of frames; also implement the child proxy interface

- `mpeg2enc`: add `disable-encode-retries` property for lower CPU usage

- `mpeg4videoparse`: allow re-sending codec config at IDR via `config-interval=-1`

- `mpegtsparse`: new `alignment` property to determine number of TS packets per output buffer, useful for feeding an MPEG-TS stream for sending via `udpsink`. This can be used in combination with the `split-on-rai` property that makes sure to start a new output buffer for any TS packet with the Random Access Indicator set. Also set delta unit buffer flag on non-random-access buffers.

- `mpegdemux`: add an `ignore-scr` property to ignore the SCR in non-compliant MPEG-PS streams with a broken SCR, which will work as long as PTS/DTS in the PES header is consistently increasing.

- `tsdemux`:
    - add an `ignore-pcr` property to ignore MPEG-TS streams with broken PCR streams on which we can't reliably recover correct timestamps.
    - new `latency` property to allow applications to lower the advertised worst-case latency of 700ms if they know their streams support this (must have timestamps in higher frequency than required by the spec)
    - support for AC4 audio

- `msdk` - Intel Media SDK plugin for hardware-accelerated video decoding and encoding on Windows and Linux:
    - mappings for more video formats: `Y210`, `Y410`, `P012_LE`, `Y212_LE`
    - encoders now support bitrate changes and input format changes in playing state
    - `msdkh264enc`, `msdkh265enc`: add support for CEA708 closed caption insertion
    - `msdkh264enc`, `msdkh265enc`: set Region of Interest (ROI) region from ROI metas
    - `msdkh264enc`, `msdkh265enc`: new `tune` property to enable low-power mode
    - `msdkh265enc`: add support 12-bit 4:2:0 encoding and 8-bit 4:2:2 encoding and `VUYA`, `Y210`, and `Y410` as input formats
    - `msdkh265enc`: add support for screen content coding extension
    - `msdkh265dec`: add support for `main-12`/`main-12-intra`, `main-422-10`/`main-422-10-intra` 10bit, `main-422-10`/`main-422-10-intra` 8bit, `main-422-12`/`main-422-12-intra`, `main-444-10`/`main-444-10-intra`, `main-444-12`/`main-444-12-intra`, and `main-444` profiles
    - `msdkvp9dec`: add support for 12-bit 4:4:4
    - `msdkvpp`: add support for `Y410` and `Y210` formats, cropping via properties, and a new `video-direction` property.

- `mxf`: Add support for CEA-708 CDP from S436 essence tracks. `mxfdemux` can now handle Apple ProRes

- `nvdec`: add H264 + H265 stateless codec implementation `nvh264sldec` and `nvh265sldec` with fewer features but improved latency. You can set the environment variable `GST_USE_NV_STATELESS_CODEC=h264` to use the stateless decoder variant as `nvh264dec` instead of the "normal" NVDEC decoder implementation.

- `nvdec`: add support for 12-bit `4:4:4`/`4:2:0` and 10-bit 4:2:0 decoding

- `nvenc`:
  - add more rate-control options, support for B-frame encoding (if device supports it), an `aud` property to toggle Access Unit Delimiter insertion, and `qp-{min,max,const}-{i,p,b}` properties.
  - the `weighted-pred` property enables weighted prediction.
  - support for more input formats, namely 8-bit and 10-bit RGB formats (`BGRA`, `RGBA`, `RGB10A2`, `BGR10A2`) and `YV12` and `VUYA`.
  - on-the-fly resolution changes are now supported as well.
  - in case there are multiple GPUs on the system, there are also per-GPU elements registered now, since different devices will have different capabilities.
  - `nvh265enc` can now support 10-bit YUV 4:4:4 encoding and 8-bit 4:4:4 / 10-bit 4:2:0 formats up to 8K resolution (with some devices). In case of HDR content HDR related SEI nals will be inserted automatically.

- `openjpeg`: enable multi-threaded decoding and add support for sub-frame encoding (for lower latency)

- `rtponviftimestamp`: add opt-out "drop-out-of-segment" property

- `spanplc`: new `stats` property

- `srt`: add support for IPv6 and for using hostnames instead of IP addresses; add `streamid` property, but also allow passing the id via the stream URI; add `wait-for-connection` property to `srtsink`

- `timecodestamper`: this element was rewritten with an updated API (properties); it has gained many new properties, seeking support and support for linear timecode (LTC) from an audio stream.

- `uvch264src` now comes with a device provider to advertise available camera sources that support this interface (mostly Logitech C920s)

- `wpe`: Add software rendering support and support for mouse scroll events

- `x265enc`: support more 8/10/12 bits 4:2:0, 4:2:2 and 4:4:4 profiles; add support for mastering display info and content light level encoding SEIs

#### gst-libav

- Add mapping for SpeedHQ video codec used by NDI

- Add mapping for aptX and aptX-HD

- `avivf_mux`: support VP9 and AV1

- `avvidenc`: shift output buffer timestamps and output segment by 1h just like x264enc does, to allow for negative DTS.

- `avviddec`: Limit default number of decoder threads on systems with more than 16 cores, as the number of threads used in avdec has a direct impact on the latency of the decoder, which is of as many frames as threads, so a large numbers of threads can make for latency levels that can be problematic in some applications.

- `avviddec`: Add `thread-type` property that allows applications to specify the preferred multithreading method (auto, frame, slice). Note that `thread-type=frame` may introduce additional latency especially in live pipelines, since it introduces a decoding delay of `number of thread` frames.

### Plugin and library moves

- There were no plugin moves or library moves in this cycle.

- The `rpicamsrc` element was moved into -good from an external repository on github.

### Plugin removals

The following elements or plugins have been removed:

- The `yadif` video deinterlacing plugin from `gst-plugins-bad`, which was one of the few GPL licensed plugins, has been removed in favour of `deinterlace method=yadif`.

- The `avdec_cdgraphics` CD Graphics video decoder element from `gst-libav` was never usable in GStreamer and we now have a `cdgdec` element written in Rust in `gst-plugins-rs` to replace it.

- The `VDPAU` plugin has been unmaintained and unsupported for a very long time and does not have the feature set we expect from hardware-accelerated video decoders. It's been superseded by the `nvcodec` plugin leveraging NVIDIA's NVDEC API.

## Miscellaneous API additions

### GStreamer core

- `gst_task_resume()`: This new API allows resuming a task if it was paused, while leaving it in stopped state if it was stopped or not started yet. This  can be useful for callback-based driver workflows, where you basically want to pause and resume the task when buffers are notified while avoiding the race with a `gst_task_stop()` coming from another thread.


- info: add printf extensions `GST_TIMEP_FORMAT` and `GST_STIMEP_FORMAT` for printing `GstClockTime`/`GstClockTimeDiff` pointers, which is much more convenient to use in debug log statements than the usual `GST_TIME_FORMAT`-followed-by-`GST_TIME_ARGS` dance. Also add an explicit `GST_STACK_TRACE_SHOW_NONE` enum value.

- `gst_element_get_current_clock_time()` and `gst_element_get_current_running_time()`: new helper functions for getting an element clock's time, and the clock time minus base time, respectively. Useful when adding additional input branches to elements such as `compositor`, `audiomixer`, `flvmux`, `interleave` or `input-selector` to determine initial pad offsets and such.

- seeking: Add `GST_SEEK_FLAG_TRICKMODE_FORWARD_PREDICTED` to just skip B-frames during trick mode, showing both keyframes + P-frame, and add support for it in `h264parse` and `h265parse`.

- elementfactory: add `GST_ELEMENT_FACTORY_TYPE_HARDWARE` to allow elements to advertise that they are hardware-based or interact with hardware. This has multiple applications: 
  - it makes it possible to easily differentiate hardware and software based element implementations such as audio or video encoders and decoders. This is useful in order to force the use of software decoders for specific use cases, or to check if a selected decoder is actually hardware-accelerated or not.
  - elements interacting with hardware and their respective drivers typically don't know the actually supported capabilities until the element is set into at least `READY` state and can open a device handle and probe the hardware.

- `gst_uri_from_string_escaped()`: identical to gst_uri_from_string() except that the userinfo and fragment components of the URI will not be unescaped while parsing. This is needed for correctly parsing usernames or passwords with `:` in them .
    
- paramspecs: new GstParamSpec flag `GST_PARAM_CONDITIONALLY_AVAILABLE` to indicate that a property might not always exist.

- `gst_bin_iterate_all_by_element_factory_name()` finds elements in a bin by factory name

- pad: `gst_pad_get_single_internal_link()` is a new convenience function to return the single internal link of a pad, which is useful e.g. to retrieve the output pad of a new `multiqueue` request pad.

- datetime: Add constructors to create datetimes with timestamps in microseconds, `gst_date_time_new_from_unix_epoch_local_time_usecs()` and `gst_date_time_new_from_unix_epoch_utc_usecs()`.

- `gst_debug_log_get_lines()` gets debug log lines formatted in the same way the default log handler would print them

- `GstSystemClock`: Add `GST_CLOCK_TYPE_TAI` as GStreamer abstraction for CLOCK_TAI, to support transmission offloading features where network packets are timestamped with the time they are deemed to be actually transmitted. Useful in combination with the new AVTP plugin.

- miscellaneous utility functions: `gst_clear_uri()`, `gst_structure_take()`.

- harness: Added `gst_harness_pull_until_eos()`

- `GstBaseSrc`:
    - `gst_base_src_new_segment()` allows subclasses to update the segment to be used at runtime from the `::create()` function. This deprecates `gst_base_src_new_seamless_segment()`
    - `gst_base_src_negotiate()` allows subclasses to trigger format renegotiation at runtime from inside the `::create()` or `::alloc()` function

- `GstBaseSink`: new `stats` property and `gst_base_sink_get_stats()` method to retrieve various statistics such as average frame rate and dropped/rendered buffers.

- `GstBaseTransform`: `gst_base_transform_reconfigure()` is now public API, useful for subclasses that need to completely re-implement the `::submit_input_buffer()` virtual method

- `GstAggregator`:
    - `gst_aggregator_update_segment()` allows subclasses to update the output segment at runtime. Subclasses should use this function rather than push a segment event onto the source pad directly.    
    - new sample selection API:
        - subclasses should now call `gst_aggregator_selected_samples()` from their `::aggregate()` implementation to signal that they have selected the next samples they will aggregate
        - `GstAggregator` will then emit the `samples-selected` signal where handlers can then look up samples per pad via `gst_aggregator_peek_next_sample()`.
        - This is useful for example to atomically update input pad properties in mixer subclasses such as `compositor`. Applications can now update properties with precise control of when these changes will take effect, and for which input buffer(s).
    - `gst_aggregator_finish_buffer_list()` allows subclasses to push out a buffer list, improving efficiency in some cases.
    - a `::negotiate()` virtual method was added, for consistency with other base classes and to allow subclasses to completely override the negotiation behaviour.
    - the new `::sink_event_pre_queue()` and `::sink_query_pre_queue()` virtual methods allow subclasses to intercept or handle serialized events and queries before they're queued up internally.

### GStreamer Plugins Base Libraries

#### Audio library

- `audioaggregator`, `audiomixer`: new `output-buffer-duration-fraction` property which allows use cases such as keeping the buffers output by compositor on one branch and audiomixer on another perfectly aligned, by requiring the compositor to output a `n/d` frame rate, and setting `output-buffer-duration-fraction` to `d/n` on the audiomixer.

- `GstAudioDecoder`: new `max-errors` property so applications can configure at what point the decoder should error out, or tell it to just keep going

- `gst_audio_make_raw_caps()` and `gst_audio_formats_raw()` are bindings-friendly versions of the `GST_AUDIO_CAPS_MAKE()` C macro.

- `gst_audio_info_from_caps()` now handles encoded audio formats as well

#### PbUtils library

- `GstEncodingProfile`:
    - Do not restrict number of similar profiles in a container
    - add GstValue serialization function
- codec utils now support more H.264/H.265 profiles/levels and have improved extension handling

#### RTP library

- `rtpbasepayloader`: Add `scale-rtptime` property for scaling RTP timestamp according to the segment rate (equivalent to RTSP speed parameter). This is useful for ONVIF trickmodes via RTSP.

- `rtpbasepayload`: add experimental property for embedding twcc sequencenumbers for Transport-Wide Congestion Control (gated behind the `GST_RTP_ENABLE_EXPERIMENTAL_TWCC_PROPERTY` environment variable) - more generic API for enabling this is [expected to land](https://gitlab.freedesktop.org/gstreamer/gst-plugins-base/-/merge_requests/748) in the next development cycle.

- `rtcpbuffer`: add `RTPFB_TYPE_TWCC` for Transport-Wide Congestion Control

- `rtpbuffer`: add `gst_rtp_buffer_get_extension_onebyte_header_from_bytes()``, so that one can parse the `GBytes` returned by gst_rtp_buffer_get_extension_bytes()

- `rtpbasedepayload`: Add `max-reorder` property to make the previously-hardcoded value when to consider a sender to have restarted configurable. In some scenarios it's particularly useful to set `max-reorder=0` to disable the behaviour that the depayloader will drop packets: when `max-reorder` is set to 0 all reordered/duplicate packets are considered coming from a restarted sender.

#### RTSP library

- add `gst_rtsp_url_get_request_uri_with_control()` to create request uri combined with control url

- `GstRTSPConnection`: add the possibility to limit the `Content-Length` for RTSP messages via `gst_rtsp_connection_set_content_length_limit()`. The same functionality is also exposed in gst-rtsp-server.

#### SDP library

- add support for parsing the `extmap` attribute from caps and storing inside caps The `extmap` attribute allows mapping RTP extension header IDs to well-known RTP extension header specifications. See [RFC8285](https://tools.ietf.org/html/rfc8285) for details.

#### Tags library

- update to latest iso-code and support more languages

- add tags for acoustid id & acoustid fingerprint, plus MusicBrainz ID handling fixes

#### Video library

- High Dynamic Range (HDR) video information representation and signalling enhancements:

    - New APIs for HDR video information representation and signalling:
        - [`GstVideoMasteringDisplayInfo`][video-mastering-display-info]: display color volume info as per SMPTE ST 2086
        - [`GstVideoContentLightLevel`][video-content-light-level]: content light level specified in CEA-861.3, Appendix A.
        - plus functions to serialise/deserialise and add them to or parse them from caps
        - `gst_video_color_{matrix,primaries,transfer}_{to,from}_iso()`: new utilility functions for conversion from/to ISO/IEC 23001-8
        - add ARIB STD-B67 transfer chracteristic function
        - add SMPTE ST 2084 support and BT 2100 colorimetry
        - define bt2020-10 transfer characteristics for clarity: bt707, bt2020-10, and bt2020-12 transfer characteristics are functionally identical but have their own unique values in the specification.

    - `h264parse`, `h265parse`: Parse mastering display info and content light level from SEIs.
    - `matroskademux`: parse HDR metadata
    - `matroskamux`: Write MasteringMetadata and Max{CLL,FALL}. Enable muxing with HDR meta data if upstream provided it
    - `avviddec`: Extract HDR information if any and map bt2020-10, PQ and HLG transfer functions

[video-mastering-display-info]: https://gstreamer.freedesktop.org/documentation/video/video-hdr.html?gi-language=c#GstVideoMasteringDisplayInfo
[video-content-light-level]: https://gstreamer.freedesktop.org/documentation/video/video-hdr.html?gi-language=c#GstVideoContentLightLevel

- added bt601 transfer function (for completeness)

- support for more pixel formats:
    - `Y412` (packed 12 bits 4:4:4:4)
    - `Y212` (packed 12 bits 4:2:2)
    - `P012` (semi-planar 4:2:0)
    - `P016_{LE,BE}` (semi-planar 16 bits 4:2:0)
    - `Y444_16{LE,BE}` (planar 16 bits 4:4:4)
    - `RGB10A2_LE` (packed 10-bit RGB with 2-bit alpha channel)
    - `NV12_32L32` (`NV12` with 32x32 tiles in linear order)
    - `NV12_4L4` (`NV12` with 4x4 tiles in linear order)

- `GstVideoDecoder`:
    - new `max-errors` property so applications can configure at what point the decoder should error out, or tell it to just keep going

    - new `qos` property to disable dropping frames because of QoS, and post QoS messages on the bus when dropping frames. This is useful for example in a scenario where the decoded video is tee-ed off to go into a live sink that syncs to the clock in one branch, and an encoding and save to file pipeline in the other branch. In that case one wouldn't want QoS events from the video sink make the decoder drop frames because that would also leave gaps in the encoding branch then.

- `GstVideoEncoder`:
    - `gst_video_encoder_finish_subframe()` is new API to push out subframes (e.g. slices), so encoders can split the encoding into subframes, which can be useful to reduce the overall end-to-end latency as we no longer need to wait for the full frame to be encoded to start decoding or sending out the data.
    - new `min-force-key-unit-interval` property allows configuring the minimum interval between force-key-unit requests and prevents a big bitrate increase if a lot of key-units are requested in a short period of time (as might happen in live streaming RTP pipelines when packet loss is detected).
    - various force-key-unit event handling fixes

- `GstVideoAggregator`, `compositor`, `glvideomixer`: expose `max-last-buffer-repeat` property on pads. This can be used to have a compositor display either the background or a stream on a lower zorder after a live input stream freezes for a certain amount of time, for example because of network issues.

- `gst_video_format_info_component()` is new API to find out which components are packed into a given plane, which is useful to prevent us from assuming a 1-1 mapping between planes and components.

- `gst_video_make_raw_caps()` and `gst_video_formats_raw()` are bindings-friendly versions of the `GST_VIDEO_CAPS_MAKE()` C macro.

- video-blend: Add support for blending on top of 16 bit per component formats, which makes sure we can support every currently supported raw video format for blending subtitles or logos on top of video.

- `GST_VIDEO_BUFFER_IS_TOP_FIELD()` and `GST_VIDEO_BUFFER_IS_BOTTOM_FIELD()` convenience macros to check whether the video buffer contains only the top field or bottom field of an interlaced picture.

- `GstVideoMeta` now includes an alignment field with the `GstVideoAlignment` so buffer producers can explicitly specify the exact geometry of the planes, allowing users to easily know the padded size and height of each plane. Default values will be used if this is not set.

  Use `gst_video_meta_set_alignment()` to set the alignment and `gst_video_meta_get_plane_size()` or `gst_video_meta_get_plane_height()` to compute the plane sizes or plane heights based on the information in the video meta.

- `gst_video_info_align_full()` works like `gst_video_info_align()` but also retrieves the plane sizes.

#### MPEG-TS library

- support for SCTE-35 sections

- extend support for ATSC tables:
    - System Time Table (STT)
    - Master Guide Table (MGT)
    - Rating Region Table (RRT)

## Miscellaneous performance, latency and memory optimisations

As always there have been many performance and memory usage improvements
across all components and modules. Some of them have already been mentioned
elsewhere so won't be repeated here.

The following list is only a small snapshot of some of the more interesting
optimisations that haven't been mentioned in other contexts yet:

- caps negotiation, structure and GValue performance optimizations

- systemclock: clock waiting performance improvements (moved from `GstPoll` to `GCond` for waiting), especially on Windows.

- `rtpsession`: add support for buffer lists on the recv path for better performance with higher packet rate streams.

- `rtpjitterbuffer`: internal timer handling has been rewritten for better performance, see Nicolas' talk ["Revisiting RTP Jitter Buffer Timers"](https://gstconf.ubicast.tv/videos/revisiting-rtp-jitter-buffer-timers/) for more details.

- H.264/H.265 parsers and RTP payloaders/depayloaders have been optimised for latency to make sure data is processed and pushed out as quickly as possible

- video-scaler: correctness and performance improvements, esp. for interlaced formats and GBRA

- `GstVideoEncoder` has gained new API to push out subframes (e.g. slices), so encoders can split the encoding into subframes, which can be useful to reduce the overall end-to-end latency as we no longer need to wait for the full frame to be encoded to start decoding or sending out the data.

  This is complemented by the new `GST_VIDEO_BUFFER_FLAG_MARKER` which is a video-specific buffer flag to mark the end of a video frame, so elements can know that they have received all data for a frame without waiting for the beginning of the next frame. This is similar to how the RTP marker flag is used in many RTP video mappings.

  The video encoder base class now also releases the internal stream lock before pushing out data, so as to not block the input side of things from processing more data in the meantime.

## Miscellaneous other changes and enhancements

- it is now possible to modify the initial rank of plugin features without modifying the source code or writing code to do so programmatically via the `GST_PLUGIN_FEATURE_RANK` environment variable. Users can adjust the rank of plugin(s) by passing a comma-separated list of `feature:rank` pairs where rank can be a numerical value or one of `NONE`, `MARGINAL`, `SECONDARY`, `PRIMARY`, and `MAX`. Example: `GST_PLUGIN_FEATURE_RANK=myh264dec:MAX,avdec_h264:NONE` sets the rank of the `myh264dec` element feature to the maximum and that of `avdec_h264` to 0 (none), thus ensuring that `myh264dec` is prefered as H264 decoder in an autoplugging context.

- `GstDeviceProvider` now does a static probe on start as fallback for providers that don't support dynamic probing to make things easier for users

## WebRTC

- `webrtcbin` now contains initial support for renegotiation involving stream addition and removal. There are a number of caveats to this initial renegotiation support and many complex scenarios are known to require some work.

- `webrtcbin` now exposes the internal ICE object for advanced configuration options.  Using the internal ICE object, it is possible to toggle UDP or TCP connection usage as well as provide local network addresses.

- Fix a number of call flows within `webrtcbin`'s `GstPromise` handling where a promise was never replied to. This has been fixed and now a promise will always receive a reply.

- `webrtcbin` now exposes a latency property for configuring the internal rtpjitterbuffer latency and buffering when receiving streams.

- `webrtcbin` now only synchronises the RTP part of a stream, allowing RTCP messages to skip synchronisation entirely.

- Fixed most of the `webrtcbin` state properties (`connection-state`, `ice-connection-state`, `signaling-state`, but not `ice-gathering-state` as that requires newer API in libnice and will be fixed in the next release series) to advance through the state values correctly. Also implemented DTLS connection states in the DTLS elements so that peer-connection-state is not always `new`.

- `webrtcbin` now accounts for the `a=ice-lite` attribute in a remote SDP offer and will configure the internal `ICE` implementation accordingly.

- `webrtcbin` will now resolve `.local` candidate addresses using the system DNS resolver. `.local` candidate addresses are now produced by web browsers to help protect the privacy of users.

- `webrtcbin` will now add candidates found in the SDP to the internal `ICE` agent. This was previously unsupported and required using the `add-ice-candidate` signal manually from the application.

- `webrtcbin` will now correctly parse a `TURN` URI that contains a username or password with a `:` in it.

- The GStreamer WebRTC library gained a `GstWebRTCDataChannel` object roughly matching the interface exposed by the WebRTC specification to allow for easier binding generation and use of data channels.

### OpenGL integration

#### GStreamer OpenGL bindings/build related changes

- The GStreamer OpenGL library (libgstgl) now ships pkg-config files for platform-specific API where libgstgl provides a public integration interface and a pkg-config file for a dependency on the detected OpenGL headers.  The new list of pkg-config files in addition to the original `gstreamer-gl-1.0` are `gstreamer-gl-x11-1.0`, `gstreamer-gl-wayland-1.0`, `gstreamer-gl-egl-1.0`, and `gstreamer-gl-prototypes-1.0` (for OpenGL headers when including `gst/gl/gstglfuncs.h`).

- GStreamer OpenGL now ships some platform-specific introspection data for platforms that have a public interface. This should allow for easier integration with bindings involving platform specific functionality. The new introspection data files are named `GstGLX11-1.0`, `GstGLWayland-1.0`, and `GstGLEGL-1.0`.

#### GStreamer OpenGL Features

- The iOS implementation no longer accesses `UIKit` objects off the main thread fixing a loud warning message when used in iOS applications.

- Support for mouse and keyboard handling using the `GstNavigation` interface was added for the wayland implementation complementing the already existing support for the X11 and Windows implementations.

- A new helper base class for source elements, `GstGLBaseSrc` is provided to ease writing source elements producing OpenGL video frames.

- Support for some more 12-bit and 16-bit video formats (`Y412_LE`, `Y412_BE`, `Y212_LE`, `Y212_BE`, `P012_LE`, `P012_BE`, `P016`, `NV16`, `NV61`) was added to glcolorconvert.

- `glupload` can now import dma-buf's into external-oes textures.

- A new display type for `EGLDevice`-based systems was added.  It is currently opt-in by using either the `GST_GL_PLATFORM=egl-device` environment variable or manual construction (`gst_gl_display_egl_device_new*()`) due to compatibility issues with some platforms.

- Support was added for WinRT/UWP using the ANGLE project for running OpenGL-based pipelines within a UWP application.

- Various elements now support changing the `GstGLDisplay` to be used at runtime in simple cases. This is primarily helpful for changing or adding an OpenGL-based video sink that must share an OpenGL context with an external source to an already running pipeline.

### GStreamer Vulkan integration

- There is now a GStreamer Vulkan library to provide integration points and helpers with applications and external GStreamer Vulkan based elements. The structure of the library is modelled similarly to the already existing GStreamer OpenGL library. Please note that the API is still unstable and may change in future releases, particularly around memory handling. The GStreamer Vulkan library contains objects for sharing the `vkInstance`, `vkDevice`, `vkQueue`, `vkImage`, `VkMemory`, etc with other elements and/or the application as well as some helper objects for using Vulkan in an application or element.

- Added support for building and running on/for the Android and Windows systems to complement the existing XCB, Wayland, MacOS, and iOS implementations.

- XCB gained support for mouse/keyboard events using the `GstNavigation` API.

- New `vulkancolorconvert` element for converting between color formats. `vulkancolorconvert` can currently convert to/from all 8-bit RGBA formats as well as 8-bit RGBA formats to/from the YUV formats `AYUV`, `NV12`, and `YUY2`.

- New `vulkanviewconvert` element for converting between stereo view layouts. `vulkanviewconvert` can currently convert between all of the single memory formats (`side-by-side`, `top-bottom`, `column-interleaved`, `row-interleaved`, `checkerboard`, `left`, `right`, `mono`).

- New `vulkanimageidentity` element for a blit from the input vulkan image/s to a new vulkan image/s.

- The `vulkansink` element can now scale the input image to the output window/surface size where that information is available.

- The `vulkanupload` element can now configure a transfer from system memory to `VulkanImage`-based memory. Previously, this required two `vulkanupload` elements.

## Tracing framework and debugging improvements

- [`gst_tracing_get_active_tracers()`](https://gstreamer.freedesktop.org/documentation/gstreamer/gsttracerutils.html?gi-language=c#gst_tracing_get_active_tracers) returns a list of active tracer objects. This can be used to interact with tracers at runtime using GObject API such as action signals. This has been implemented in the leaks tracer for snapshotting and retrieving leaked/active objects at runtime.

- The *leaks* tracer can now be interacted with programmatically at runtime via GObject action signals:
    - `get-live-object` returns a list of live (allocated) traced objects
    - `log-live-objects` logs a list of live objects into the debug log. This is the same as sending the `SIGUSR1` signal on unix systems, but works on all operating systems including Windows.
    - `activity-start-tracking`, `activity-get-checkpoint`, `activity-log-checkpoint`, `activity-stop-tracking`: add support for tracking and checkpointing objects, similar to what was previously available via `SIGUSR2` on unix systems, but works on all operating systems including Windows.

- various [GStreamer gdb debug helper](https://gstconf.ubicast.tv/videos/post-mortem-gstreamer-debugging-with-gdb-and-python/) improvements:
    - new 'gst-pipeline-tree' command
    - more gdb helper functions: `gst_element_pad()`, `gst_pipeline()` and `gst_bin_get()`
    - support for queries and buffers
    - print more info for segment events, print event seqnums, object pointers and structures
    - improve `gst-print` command to show more pad and element information

## Tools

### gst-launch-1.0

- now prints the pipeline position and duration if available when the pipeline is advancing. This is hopefully more user-friendly and gives visual feedback on the terminal that the pipeline is actually up and running. This can be disabled with the `--no-position` command line option.

- the parse-launch pipeline syntax now has support for [presets](https://gstreamer.freedesktop.org/documentation/gstreamer/gstpreset.html?gi-language=c#gstpreset-page): use`@preset=<preset-name>"` after an element to load a preset.

### gst-inspect-1.0

- new `--color` command line option to force coloured output even if not connected to a tty

### gst-tester-1.0 (new)

- `gst-tester-1.0` is a new tool for plugin developers to launch `.validatetest` files with TAP compatible output, meaning it can easily and cleanly be integrated with the meson test harness. It allows you to use `gst-validate` (from the gst-devtools module) to write integration tests in any GStreamer repository whilst keeping the tests as close as possible to the code. The tool transparently handles `gst-validate` being installed or not: if it is not installed those integration tests will simply be skipped.

### gst-play-1.0

- interactive keyboard controls now also work on Windows

### gst-transcoder-1.0 (new)

- `gst-transcoder-1.0` is a new command line tool to transcode one URI into another URI based on the specified encoding profile using the new `GstTranscoder` API (see above).

## GStreamer RTSP server

- Fix issue where the first few packets (i.e. keyframes) could sometimes be dropped if the rtsp media pipeline had a live input. This was a regression from GStreamer 1.14. There are [more fixes](https://gitlab.freedesktop.org/gstreamer/gst-rtsp-server/-/merge_requests/147) pending for that which will hopefully land in 1.18.1.

- Fix backpressure handling when sending data in TCP interleave mode where RTSP requests and responses and RTP/RTCP packets flow over the same RTSP TCP connection: The previous implementation would at some point stop sending data to other clients when a single client stopped consuming data or did not consume data fast enough. This obviously created problems for shared media, where the same stream from a single producer pipeline is sent to multiple clients. Instead we now manage a backlog in the server's stream-transport component and remove slow clients once this backlog exceeds a maximum duration (which is currently hardcoded).

- Onvif Streaming Specification trick modes support (see section at the beginning)

- Scale/Speed header support: Speed will deliver the data at the requested speed, which means increasing the data bandwidth for speeds > 1.0. Scale will attempt to do the same without affecting the overall bandwidth requirement vis-a-vis normal playback speed (e.g. it might drop data for fast-forward playback).

- `rtspclientsink`: send buffer lists in one go for better performance

## GStreamer VAAPI

- A lot of work was done adding support for [media-driver](https://github.com/intel/media-driver) (iHD), the new VAAPI driver for Intel, mostly for Gen9 onwards.

- Available color formats and frame sizes are now detected at run-time according to the context configuration.

- Gallium drivers have been re-enabled in the allowed drivers list

- Improved the mapping between VA formats and GStreamer formats by generating a mapping table at run-time since even among different drivers the mapping might be different, particularly for RGB with little endianness.

- The experimental Flexible Encoding Infrastructure (FEI) elements have been removed since they were not really actively maintained or tested.

- Enhanced the juggling of `DMABuf` buffers and `VASurface` metas

- New `vaapioverlay` element: a compositor element using VA VPP
  blend capabilities to accelerate overlaying and compositing. Example pipeline:
  
        gst-launch-1.0 -vf videotestsrc ! vaapipostproc ! tee name=testsrc ! queue \
        ! vaapioverlay sink_1::xpos=300 sink_1::alpha=0.75 name=overlay ! vaapisink \
        testsrc. ! queue ! overlay.


### vaapipostproc

- added video-orientation support, supporting frame mirroring and rotation

- added cropping support, either via properties (`crop-left`, `crop-right`, `crop-bottom` and `crop-top`) or buffer meta.

- new `skin-tone-enhancenment-level` property which is the iHD replacement of the i965 driver's `sink-tone-level`. Both are incompatible with each other, so both were kept.

- handle video colorimetry

- support HDR10 tone mapping

### vaapisink

- resurrected wayland backend for non-weston compositors by extracting the `DMABuf` from the `VASurface` and rendering it.

- merged the video overlay API for wayland. Now applications can define the "window" to render on.

- demoted the `vaapisink` element to secondary rank since libva considers rendering as a second-class feature.

### VAAPI Encoders

- new common `target-percentage` property which is the desired target percentage of bitrate for variable rate control.

- encoders now extract their caps from the driver at registration time.

- `vaapivp9enc`: added support for low power mode and support for profile 2 (profile 0 by default)

- `vaapih264enc`: new `max-qp` property that sets the maximum quantization value. Support for ICQ and QBVR bitrate control mode, adding a `quality-factor` property for these modes. Support baseline profile as constrained-baseline

- `vaapih265enc`:
  - support for main-444 and main-12 encoding profiles.
  - new `max-qp` property that sets the maximum quantization value.
  - support for ICQ and QBVR bitrate control mode, adding a `quality-factor` property for these modes.
  - handle SCC profiles.
  - `num-tile-cols` and `num-tile-row` properties to specify the number of tiles to use.
  - the `low-delay-b` property was deprecated and is now determined automatically.
  - improved profile selection through caps.

### VAAPI Decoders

- Decoder surfaces are not bound to their context any longer and can thus be created and used dynamically, removing the deadlock headache.

- Reverse playback is now fluid

- Forward Region-of-Interest (ROI) metas downstream

- `GLTextureUploadMeta` uses `DMABuf` when GEM is not available. Now Gallium drivers can use this meta for rendering with EGL.

- `vaapivp9dec`: support for 4:2:2 and 4:4:4 chroma type streams

- `vaapih265dec`: skip all pictures prior to the first I-frame. Enable passing range extension flags to the driver. Handle SCC profiles.
   
- `vaapijpegdec`: support for 4:0:0, 4:1:1, 4:2:2 and 4:4:4 chroma types pictures

- `vaapih264dec`: handle baseline streams as constrained-baseline if possible and make it more tolerant when encountering unknown NALs

## GStreamer OMX

- `omxvideoenc`: use new video encoder subframe API to push out slices as soon as they're ready

- `omxh264enc`, `omxh265enc`: negotiate subframe mode via caps. To enable it, force downstream caps to `video/x-h264,alignment=nal` or `video/x-h265,alignment=nal`.

- `omxh264enc`: Add `ref-frames` property

- Zynq ultrascale+ specific video encoder/decoder improvements:
    - `GRAY8` format support
    - support for alternate fields interlacing mode
    - video encoder: `look-ahead`, `long-term-ref`, and `long-term-freq` properties

## GStreamer Editing Services and NLE

- Added nested timelines and subproject support so that GES projects can be used
  as clips, potentially serializing nested projects in the main file or
  referencing external project files.

- Implemented an [OpenTimelineIO](https://opentimelineio.readthedocs.io) GES
  formatter. This means GES and GStreamer can now load and save projects in all
  the formats supported by otio.

- Implemented a `GESMarkerList` object which allow setting timed metadata on any
  GES object.

- Fixed audio rendering issues during clip transition by ensuring that a single
  segment is pushed into encoders.
  
- The `GESUriClipAsset` API is now MT safe.

- Added `ges_meta_container_register_static_meta()` to allow fixing a type for a
  specific metadata without actually setting a value.

- The `framepositioner` element now handles resizing the project and keeps the
  same  positioning when the aspect ratio is not changed .

- Reworked the documentation, making it more comprehensive and much more detailed.

- Added APIs to retrieve natural size and framerate of a clip (for example in
  the case of URIClip it is the framerate/size of the underlying file).
  
- `ges_container_edit()` is now deprecated and `GESTimelineElement` gained the
  `ges_timeline_element_edit()` method so the editing API is now usable
  from any element in the timeline.

- `GESProject::loading` was added so applications can be notified about when a
  new timeline starts loading.

- Implemented the `GstStream` API in `GESTimeline`.

- Added a way to add a `timeoverlay` inside the test source (potentially with
  timecodes).

- Added APIs to convert times to frame numbers and vice versa:
   - `ges_timeline_get_frame_time()`
   - `ges_timeline_get_frame_at()`
   - `ges_clip_asset_get_frame_time()`
   - `ges_clip_get_timeline_time_from_source_frame()`

     Quite a few validate tests have been implemented to check the behavior for various demuxer/codec formats

- Added `ges_layer_set_active_for_tracks()` which allows muting layers for the
  specified tracks

- Deprecated GESImageSource and GESMultiFileSource now that we have
  `imagesequencesrc` which handles the `imagesequence` "protocol"

- Stopped exposing 'deinterlacing' children properties for clip types where they
  do not make sense.

- Added support for simple time remapping effects

## GStreamer validate

- Introduced the concept of "Test files" allowing to implement "all included" test cases, meaning that inside the file the following can be defined:
   - The application arguments
   - The validate configurations
   - The validate scenario

  This replaces the previous big dictionary file in `gst-validate-launcher` to implement specific test cases.

  We set several variables inside the files (as well as inside scenarios and config files) to make them relocatable.

  The file format has been enhanced so it is easier to read and write, for example line ending with a coma or (curly) brackets can now be used as continuation marker so you do not need to add `\` at the end of lines to write a structure on several lines.

- Support the `imagesequence` "protocol" and added integration tests for it.

- Added action types to allow the scenario to run the Test Clock for better reproducibility of tests.

- Support generating tests to check that seeking is frame accurate (base on ssim).

- Added ways to record buffers checksum (in different ways) in the `validateflow` module.

- Added vp9 encoding tests.

- Enhanced seeking action types implementation to allow support for segment seeks.

- Output improvements:
  - Logs are now in markdown formats (and `bat` is used to dump them if available).
  - File format issues in scenarios/configs/tests files are nicely reported with the line numbers now.

## GStreamer Python Bindings

- Python 2.x is no longer supported

- Support mapping buffers without any memcpy:
  - Added a ContextManager to make the API more pythonic
    ```
    with buf.map(Gst.MapFlags.READ | Gst.MapFlags.WRITE) as info:
        info.data[42] = 0
    ```

- Added high-level helper API for constructing pipelines:
  - `Gst.Bin.make_and_add(factory_name, instance_name=None)`
  - `Gst.Element.link_many(element, ...)`

## GStreamer C# Bindings

- Bind `gst_buffer_new_wrapped()` manually to fix memory handling.

- Fix `gst_promise_new_with_change_func()` where `bindgen` didn't properly detect the func as a closure.

- Declare `GstVideoOverlayComposition` and `GstVideoOverlayRectangle` as opaque type and subclasses of `Gst.MiniObject`. This changes the API but without this all usage will cause memory corruption or simply not work.

- on Windows, look for gstreamer, glib and gobject DLLs using the MSVC naming convention (i.e. `gstvideo-1.0-0.dll` instead of `libgstvideo-1.0-0.dll`).

  The names of these DLLs have to be hardcoded in the bindings, and most C# users will probably be using the Microsoft toolchain anyway.

  This means that the MSVC compiler is now required to build the bindings, MingW will no longer work out of the box.

## GStreamer Rust Bindings and Rust Plugins

The GStreamer Rust bindings are released separately with a different release cadence that's tied to `gtk-rs`, but the [latest release](https://gstreamer.freedesktop.org/news/#2020-07-06T14:00:00Z) has already been [updated](https://coaxion.net/blog/2020/07/gstreamer-rust-bindings-plugins-new-releases/) for the new GStreamer 1.18 API, so there's absolutely no excuse why your next GStreamer application can't be written in Rust anymore.

`gst-plugins-rs`, the module containing GStreamer plugins written in Rust, has also seen lots of activity with many new elements and plugins.

What follows is a list of elements and plugins available in `gst-plugins-rs`, so people don't miss out on all those potentially useful elements that have no C equivalent.

### Rust audio plugins

- `audiornnoise`: New element for audio denoising which implements the [noise removal algorithm](https://people.xiph.org/~jm/demo/rnnoise/) of the Xiph RNNoise library, in Rust
- `rsaudioecho`: Port of the audioecho element from gst-plugins-good rsaudioloudnorm: Live audio loudness normalization element based on the FFmpeg `af_loudnorm` filter
- `claxondec`: FLAC lossless audio codec decoder element based on the pure-Rust claxon implementation
- `csoundfilter`: Audio filter that can use any filter defined via the Csound audio programming language
- `lewtondec`: Vorbis audio decoder element based on the pure-Rust lewton implementation

### Rust video plugins

- `cdgdec`/`cdgparse`: Decoder and parser for the CD+G video codec based on a pure-Rust CD+G implementation, used for example by karaoke CDs
- `cea608overlay`: CEA-608 Closed Captions overlay element
- `cea608tott`: CEA-608 Closed Captions to timed-text (e.g. VTT or SRT subtitles) converter
- `tttocea608`: CEA-608 Closed Captions from timed-text converter
- `mccenc`/`mccparse`: MacCaption Closed Caption format encoder and parser
- `sccenc`/`sccparse`: Scenarist Closed Caption format encoder and parser
- `dav1dec`: AV1 video decoder based on the dav1d decoder implementation by the VLC project
- `rav1enc`: AV1 video encoder based on the fast and pure-Rust rav1e encoder implementation
- `rsflvdemux`: Alternative to the flvdemux FLV demuxer element from gst-plugins-good, not feature-equivalent yet
- `rsgifenc`/`rspngenc`: GIF/PNG encoder elements based on the pure-Rust implementations by the image-rs project

### Rust text plugins

- `textwrap`: Element for line-wrapping timed text (e.g. subtitles) for better screen-fitting, including hyphenation support for some languages

### Rust network plugins

- `reqwesthttpsrc`: HTTP(S) source element based on the Rust reqwest/hyper HTTP implementations and almost feature-equivalent with the main GStreamer HTTP source souphttpsrc
- `s3src`/`s3sink`: Source/sink element for the Amazon S3 cloud storage
- `awstranscriber`: Live audio to timed text transcription element using the Amazon AWS Transcribe API

### Generic Rust plugins

- `sodiumencrypter`/`sodiumdecrypter`: Encryption/decryption element based on libsodium/NaCl
- `togglerecord`: Recording element that allows to pause/resume recordings easily and considers keyframe boundaries
- `fallbackswitch`/`fallbacksrc`: Elements for handling potentially failing (network) sources, restarting them on errors/timeout and showing a fallback stream instead
- `threadshare`: Set of elements that provide alternatives for various existing GStreamer elements but allow to share the streaming threads between each other to reduce the number of threads
- `rsfilesrc`/`rsfilesink`: File source/sink elements as replacements for the existing filesrc/filesink elements

## Build and Dependencies

- The Autotools build system has finally been removed in favour of the [Meson build system][meson]. Developers who currently use `gst-uninstalled` should move to [`gst-build`](https://gitlab.freedesktop.org/gstreamer/gst-build).

- API and plugin documentation are no longer built with `gtk_doc`. The `gtk_doc` documentation has been removed in favour of a [new unified documentation module][gst-docs] built with `hotdoc` (also see "Documentation improvements" section below). Distributors should use the [documentation release tarball](https://gstreamer.freedesktop.org/data/src/gstreamer-docs/) instead of trying to package `hotdoc` and building the documentation from scratch.

- gst-plugins-bad now includes an internal copy of [libusrsctp](https://github.com/sctplab/usrsctp), as there are problems in `usrsctp` with global shared state, lack of API stability guarantees, and the absence of any kind of release process. We also can't rely on distros shipping a version with the fixes we need. Both firefox and Chrome bundle their own copies too. It is still possible to build against an external copy of `usrsctp` if so desired.

- `nvcodec` no longer needs the NVIDIA NVDEC/NVENC SDKs available at build time, only at runtime. This allows distributions to ship this plugin by default and it will just start to work when the required run-time SDK libraries are installed by the user, without users needing to build and install the plugin from source.

- the `gst-editing-services` tarball is now named `gst-editing-services` for consistency (used to be `gstreamer-editing-services`).

- the `gst-validate` tarball has been superseded by the `gst-devtools` tarball for consistency with the git module name.

[meson]: https://mesonbuild.com
[gst-docs]: https://gitlab.freedesktop.org/gstreamer/gst-docs

### gst-build

[`gst-build`](https://gitlab.freedesktop.org/gstreamer/gst-build) is a meta-module and serves primarily as our uninstalled development environment. It makes it easy to build most of GStreamer, but unlike Cerbero it only comes with a limited number of external dependencies that can be built as subprojects if they are not found on the system.

`gst-build` is based on Meson and replaces the old autotools `gst-uninstalled` script.

- The 'uninstalled' target has been renamed to 'devenv'

- Experimental `gstreamer-full` library containing all built plugins and their deps when building with `-Ddefault_library=static`. A monolithic library is easier to distribute, and may be required in some environments. GStreamer core, GLib and GObject are always included, but external dependencies are still dynamically linked. The `gst-full-libraries` meson option allows adding other GStreamer libraries to the `gstreamer-full` build. This is an experiment for now and its behaviour or API may still change in future releases.

- Add glib-networking as a subproject when glib is a subproject and load gio modules in the devenv, `tls` option control whether to use openssl or gnutls.

- `git-worktree`: Allow multiple worktrees for subproject branches

- Guard against meson being run from inside the uninstalled devenv, as this might have unexpected consequences.

- our `ffmpeg` and `x264` meson ports have been updated to the latest stable version (you might need to update the subprojects checkout manually though, or just remove the checkouts so meson checks out the latest version again; improvements for this are pending in meson, but not merged yet).

### Cerbero

Cerbero is a meta build system used to build GStreamer plus dependencies on platforms where dependencies are not readily available, such as Windows, Android, iOS and macOS.

#### General improvements

- Recipe build steps are done in parallel wherever possible. This leads to massive improvements in overall build time.
- Several recipes were ported to Meson, which improved build times
- Moved from using both GnuTLS and OpenSSL to only OpenSSL
- Moved from yasm to nasm for all assembly compilation
- Support zsh when running the cerbero `shell` command
- Numerous version upgrades for dependencies
- Default to `xz` for tarball binary packages. `bz2` can be selected with the `--compress-method` option to `package`.
- Added boolean variant for controlling the optimization level: `-v optimization`
- Ship `.pc` pkgconfig files for all plugins in the binary packages
- CMake and nasm will only be built by Cerbero if the system versions are unusable
- The `nvcodec` variant was removed and the `nvcodec` plugin is built by default now (as it no longer requires the SDK to be installed at build time, only at runtime)

#### macOS / iOS

- Minimum iOS SDK version bumped to 11.0
- Minimum macOS SDK version bumped to 10.11
- No longer need to manually add support for newer iOS SDK versions
- Added Vulkan elements via MoltenVK
- Build times were improved by code-signing all build tools
- macOS framework ships all gstreamer libraries instead of an outdated subset
- Ship pkg-config in the macOS framework package
- fontconfig: Fix `EXC_BAD_ACCESS` crash on iOS ARM64
- Improved App Store compatibility by setting `LC_VERSION_MIN_MACOSX`, fixing relocations, and improved bitcode support

#### Windows

- MinGW-GCC toolchain was updated to 8.2. It uses the Universal CRT instead of MSVCRT which eliminates cross-CRT issues in the Visual Studio build.
- Require Windows 7 or newer for running binaries produced by Cerbero
- Require Windows x86_64 for running Cerbero to build binary packages
- Cerbero no longer uses `C:/gstreamer/1.0` as a prefix when building. That prefix is reserved for use by the MSI installers.
- Several recipes can now be buit with Visual Studio instead of MinGW. Ported to meson: opus, libsrtp, harfbuzz, cairo, openh264, libsoup, libusrsctp. Existing build system: libvpx, openssl.
- Support building using Visual Studio for 32-bit x86. Previously we only supported building for 32-bit x86 using the MinGW toolchain.
- Fixed annoying `msgmerge` popups in the middle of cerbero builds
- Added configuration options `vs_install_path` and `vs_install_version` for specifying custom search locations for older Visual Studio versions that do not support `vswhere`. You can set these in `~/.cerbero/cerbero.cbc` where `~` is the MSYS homedir, not your Windows homedir.
- New Windows-specific plugins: d3d11, mediafoundation, wasapi2
- Numerous compatibility and reliability fixes when running Cerbero on Windows, especially non-English locales
- proxy-libintl now exports the same symbols as gettext, which makes it a drop-in replacement
- New mapping variant for selecting the Visual Studio CRT to use: `-v vscrt=<value>`. Valid values are `md`, `mdd`, and `auto` (default). A separate prefix is used when building with either `md` (release) or `mdd` (debug), and the outputted package will have `+debug` in the filename. This variant is also used for selecting the correct Qt libraries (debug vs release) to use when building with `-v qt5` on Windows.
- Support cross-compile on Windows to Windows ARM64 and ARMv7
- Support cross-compile on Windows to the Universal Windows Platform (UWP). Only the subset of plugins that can be built entirely with Visual Studio will be selected in this case. To do so, use the `config/cross-uwp-universal.cbc` configuration, which will build ARM64, x86, and x86_64 binaries linked to the release CRT, with optimizations enabled, and debugging turned on. You can combine this with `-v vscrt=mdd` to produce binaries linked to the debug CRT. You can turn off optimizations with the `-v nooptimization` variant.

#### Windows MSI installer

- Require Windows 7 or newer for running GStreamer
- Fixed some issues with shipping of pkg-config in the Windows installers
- Plugin PDB debug files are now shipped in the development package, not the runtime package
- Ship installers for 32-bit binaries built with Visual Studio
- Ship debug and release "universal" (ARM64, X86, and X86_64) tarballs built for the Universal Windows Platform
- Windows MSI installers now install into separate prefixes when building with MSVC and MinGW. Previously both would be installed into `C:/gstreamer/1.0/x86` or `C:/gstreamer/1.0/x86_64`. Now, the installation prefixes are:

<table style='border-collapse: collapse;'>
 <tr style='background-color: #f2f2f2;'>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400; text-align: left;'>Target</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400; text-align: left;'>Install Path</th>
  <th style='border-width: 1px 1px 2px 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px; font-weight: 400; text-align: left;'>Build Options</th>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>MinGW 32-bit</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>C:/gstreamer/1.0/mingw_x86</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>-c config/win32.cbc</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>MinGW 64-bit</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>C:/gstreamer/1.0/mingw_x86_64</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>-c config/win64.cbc</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>MSVC 32-bit</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>C:/gstreamer/1.0/msvc_x86</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>-c config/win32.cbc -v visualstudio</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>MSVC 64-bit</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>C:/gstreamer/1.0/msvc_x86_64</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>-c config/win64.cbc -v visualstudio</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>MSVC 32-bit (debug)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>C:/gstreamer/1.0/msvc-debug_x86</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>-c config/win32.cbc -v visualstudio,vscrt=mdd</td>
 </tr>
 <tr>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>MSVC 64-bit (debug)</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>C:/gstreamer/1.0/msvc-debug_x86_64</td>
  <td style='border-width: 1px; border-color: #ccc; border-style: solid; padding: 10px 16px 10px 16px;'>-c config/win64.cbc -v visualstudio,vscrt=mdd</td>
 </tr>
</table>

Note: UWP binary packages are tarballs, not MSI installers.

#### Linux

- Support creating MSI installers using WiX when cross-compiling to Windows
- Support running cross-windows binaries with Wine when using the `shell` and `runit` cerbero commands
- Added bash-completion support inside the cerbero shell on Linux
- Require a system-wide installation of openssl on Linux
- Added variant `-v vaapi` to build gstreamer-vaapi and the new gstva plugin
- Debian packaging was disabled because it does not work. Help in fixing this is appreciated.
- Trimmed the list of packages needed for bootstrap on Linux

#### Android

- Updated to NDK r21
- Support Vulkan
- Support Qt 5.14+ binary package layout

## Platform-specific changes and improvements

### Android

- `opensles`: Remove hard-coded buffer-/latency-time values and allow `openslessink` to handle 48kHz streams.

- `photography` interface and camera source: Add additional settings relevant to Android such as: Exposure mode property, extra colour tone values (aqua, emboss, sketch, neon), extra scene modes (backlight, flowers, AR, HDR), and missing virtual methods for exposure mode, analog gain, lens focus, colour temperature, min & max exposure time. Add new effects and scene modes to Camera parameters.

### macOS and iOS

- `vtdec` can now output to Vulkan-backed memory for zerocopy support with the Vulkan elements.

### Windows

- `d3d11videosink`: new Direct3D11-based video sink with support for HDR10 rendering if supported.

- Hardware-accelerated video decoding on Windows via DXVA2 / Direct3D11 using native Windows APIs rather than per-vendor SDKs (like MSDK for Intel or NVCODEC for NVidia). Plus modern Direct3D11 integration rather than the almost 20-year old Direct3D9 from Windows XP times used in `d3dvideosink`. Formats supported for decoding are H.264, H.265, VP8, and VP9, and zero-copy operation should be supported in combination with the new `d3d11videosink`. See Seungha's blog post ["Windows DXVA2 (via Direct3D 11) Support in GStreamer 1.17"](https://medium.com/@seungha.yang/windows-dxva2-via-direct3d-11-support-in-gstreamer-1-17-1837ecc1691a) for more details.

- Microsoft Media Foundation plugin for hardware-accelerated video encoding on Windows using native Windows APIs rather than per-vendor SDKs. Formats supported for encoding are H.264, H.265 and VP9. Also includes audio encoders for AAC and MP3. See Seungha's blog post ["Bringing Microsoft Media Foundation to GStreamer"](https://medium.com/@seungha.yang/bringing-microsoft-media-foundation-to-gstreamer-27b1316351ee) for some more details about this.

- new `mfvideosrc` video capture source element using the latest Windows APIs rather than ancient APIs used by `ksvideosrc`/`winks`. `ksvideosrc` should be considered deprecated going forward.

- `d3d11`: add `d3d11convert`, a color space conversion and rescaling element using shaders, and introduce `d3d11upload` and `d3d11download` elements that work just like `glupload` and `gldownload` but for D3D11.

- *Universal Windows Platform (UWP)* support, including official GStreamer binary packages for it. Check out Nirbheek's latest blog post ["GStreamer 1.18 supports the Universal Windows Platform "](https://blog.nirbheek.in/2020/08/gstreamer-118-supports-universal.html) for more details.

- systemclock correctness and reliability fixes, and also don't start the system clock at 0 any longer (which shouldn't make any difference to anyone, as absolute clock time values are supposed to be meaningless in themselves, only the rate of increase matters).

- toolchain specific plugin registry: the registry cache is now named differently for MSVC and MinGW toolchains/packages, which should avoid problems when switching between binaries built with a different toolchain.

- new `wasapi2` plugin mainly to support UWP applications. The core logic of this plugin is almost identical to existing wasapi plugin, but the main target is Windows 10 and UWP. This plugin uses WinRT APIs, so will likely not work on Windows 8 or older. Unlike the existing wasapi plugin, this plugin supports automatic stream routing (auto fallback when device was removed) and device level mute/volume control. Exclusive streaming mode is not supported, however, and loopback features are not implemented yet. It is also only possible to build this plugin with MSVC and the Windows 10 SDK, it can't be cross-compiled with the MingW toolchain.

- new `dxgiscreencapsrc` element which uses the Desktop Duplication API to capture the desktop screen at high speed. This is only supported on Windows 8 or later. Compared to the existing elements `dxgiscreencapsrc` offers much better performance, works in High DPI environments and draws an accurate mouse cursor.

- `d3dvideosink` was downgraded to secondary rank, `d3d11videosink` is preferred now. Support OverlayComposition for GPU overlay compositing of subtitles and logos.

- debug log output fixes, esp. with a non-UTF8 locale/codepage

- speex, jack: fixed crashes on Windows caused by cross-CRT issues

- `gst-play-1.0` interactive keyboard controls now also work on Windows

### Linux

- `kmssink`: Add support for `P010` and `P016` formats

- `vah264dec`: new experimental `va` plugin with an element for H.264 decoding with VA-API. This novel approach, different from `gstreamer-vaapi`, uses the gstcodecs library for decoder state handling, which it is hoped will make for cleaner code because it uses VA-API without further layers or wrappers. Check out Víctor's blog post ["New VA-API H.264 decoder in gst-plugins-bad"](https://blogs.igalia.com/vjaquez/2020/07/10/new-va-api-h-264-decoder-in-gst-plugins-bad/) for the full lowdown and the limitations of this new plugin, and how to give it a spin.

- `v4l2codecs`: introduce a V4L2 CODECs Accelerator. This plugin will support the new CODECs uAPI in the Linux kernel, which consists of an accelerator interface similar to DXVA, NVDEC, VDPAU and VAAPI. So far H.264 and VP8 are supported. This is used on certain embedded systems such as i.mx8m, rk3288, rk3399, Allwinner H-series SoCs.


## Documentation improvements

- unified documentation containing tutorials, API docs, plugin docs, etc. all under one roof, shipped in form of a [documentation release tarball](https://gstreamer.freedesktop.org/data/src/gstreamer-docs/) containing both devhelp and html documentation.

- all documentation is now generated using [`hotdoc`](https://hotdoc.github.io/), `gtk-doc` is no longer used. Distributors should use the above-mentioned [documentation release tarball](https://gstreamer.freedesktop.org/data/src/gstreamer-docs/) instead of trying to package `hotdoc` and building the documentation from scratch.

- there is now documentation for wrapper plugins like gst-libav and frei0r, as well as tracer plugins.

- for more info, check out Thibault's ["GStreamer Documentation" lightning talk](https://gstconf.ubicast.tv/permalink/v125d173da4d6ffimx2s/#start=1349&autoplay) from the 2019 GStreamer Conference.

- new API for plugins to support the documentation system:
    - new GParamSpecFlag `GST_PARAM_DOC_SHOW_DEFAULT` to make `gst-inspect-1.0` (and the documentation) show the paramspec's default value rather than the actually set value as default
    - GstPadTemplate getter and setter for "documentation caps", `gst_pad_template_set_documentation_caps()` and `gst_pad_template_get_documentation_caps()`: This can be used in elements where the caps of pad templates are dynamically generated and/or dependent on the environment, to override the caps shown in the documentation (usually to advertise the full set of possible caps).
    - `gst_type_mark_as_plugin_api()` for marking types as plugin API, used for plugin-internal types like enums, flags, pad subclasses, boxed types, and such.

## Possibly Breaking Changes

- GstVideo: the canonical list of raw video formats (for use in caps) has been reordered, so video elements such as `videotestsrc` or `videoconvert` might negotiate to a different format now than before. The new format might be a higher-quality format or require more processing overhead, which might affect pipeline performance.

- `mpegtsdemux` used to wrongly advertise H.264 and H.265 video elementary streams as `alignment=nal`. This has now been fixed and changed to `alignment=none`, which means an `h264parse` or `h265parse` element is now required after `tsdemux` for some pipelines where there wasn't one before, e.g. in transmuxing scenarios (`tsdemux ! tsmux`). Pipelines without such a parser may now fail to link or error out at runtime. As parsers after demuxers and before muxers have been generally required for a long time now it is hoped that this will only affect a small number of applications or pipelines.

- The Android `opensles` audio source and sink used to have hard-coded buffer-/latency-time values of 20ms. This is no longer needed with newer Android versions and has now been removed. This means a higher or lower value might now be negotiated by default, which can affect pipeline performance and latency.

## Known Issues

- None in particular

## Contributors

Aaron Boxer, Adam Duskett, Adam x Nilsson, Adrian Negreanu, Akinobu Mita, 
Alban Browaeys, Alcaro, Alexander Lapajne, Alexandru Băluț, Alex Ashley, 
Alex Hoenig, Alicia Boya García, Alistair Buxton, Ali Yousuf, 
Ambareesh "Amby" Balaji, Amr Mahdi, Andoni Morales Alastruey, Andreas Frisch, 
Andre Guedes, Andrew Branson, Andrey Sazonov, Antonio Ospite, aogun, 
Arun Raghavan, Askar Safin, AsociTon, A. Wilcox, Axel Mårtensson, 
Ayush Mittal, Bastian Bouchardon, Benjamin Otte, Bilal Elmoussaoui, 
Brady J. Garvin, Branko Subasic, Camilo Celis Guzman, Carlos Rafael Giani, 
Charlie Turner, Cheng-Chang Wu, Chris Ayoup, Chris Lord, Christoph Reiter, 
cketti, Damian Hobson-Garcia, Daniel Klamt, Daniel Molkentin, Danny Smith, 
David Bender, David Gunzinger, David Ing, David Svensson Fors, David Trussel, 
Debarshi Ray, Derek Lesho, Devarsh Thakkar, dhilshad, Dimitrios Katsaros, 
Dmitriy Purgin, Dmitry Shusharin, Dominique Leuenberger, Dong Il Park, 
Doug Nazar, dudengke, Dylan McCall, Dylan Yip, Ederson de Souza, 
Edward Hervey, Eero Nurkkala, Eike Hein, ekwange, Eric Marks, 
Fabian Greffrath, Fabian Orccon, Fabio D'Urso, Fabrice Bellet, 
Fabrice Fontaine, Fanchao L, Felix Yan, Fernando Herrrera, 
Francisco Javier Velázquez-García, Freyr, Fuwei Tang, Gaurav Kalra, 
George Kiagiadakis, Georgii Staroselskii, Georg Lippitsch, Georg Ottinger, 
gla, Göran Jönsson, Gordon Hart, Gregor Boirie, Guillaume Desmottes, 
Guillermo Rodríguez, Haakon Sporsheim, Haihao Xiang, Haihua Hu, 
Havard Graff, Håvard Graff, Heinrich Kruger, He Junyan, Henry Wilkes, 
Hosang Lee, Hou Qi, Hu Qian, Hyunjun Ko, ibauer, Ignacio Casal Quinteiro, 
Ilya Smelykh, Jake Barnes, Jakub Adam, James Cowgill, James Westman, 
Jan Alexander Steffens, Jan Schmidt, Jan Tojnar, Javier Celaya, Jeffy Chen, 
Jennifer Berringer, Jens Göpfert, Jérôme Laheurte, Jim Mason, Jimmy Ohn, 
J. Kim, Joakim Johansson, Jochen Henneberg, Johan Bjäreholt, 
Johan Sternerup, John Bassett, Jonas Holmberg, Jonas Larsson, 
Jonathan Matthew, Jordan Petridis, Jose Antonio Santos Cadenas, Josep Torra, 
Jose Quaresma, Josh Matthews, Joshua M. Doe, Juan Navarro, Juergen Werner, 
Julian Bouzas, Julien Isorce, Jun-ichi OKADA, Justin Chadwell, Justin Kim, 
Keri Henare, Kevin JOLY, Kevin King, Kevin Song, Knut Andre Tidemann, 
Kristofer Björkström, krivoguzovVlad, Kyrylo Polezhaiev, Lenny Jorissen, 
Linus Svensson, Loïc Le Page, Loïc Minier, Lucas Stach, Ludvig Rappe, 
Luka Blaskovic, luke.lin, Luke Yelavich, Marcin Kolny, Marc Leeman, 
Marco Felsch, Marcos Kintschner, Marek Olejnik, Mark Nauwelaerts, 
Markus Ebner, Martin Liska, Martin Theriault, Mart Raudsepp, Matej Knopp, 
Mathieu Duponchelle, Mats Lindestam, Matthew Read, Matthew Waters, 
Matus Gajdos, Maxim Paymushkin, Maxim P. Dementiev, Michael Bunk, 
Michael Gruner, Michael Olbrich, Miguel París Díaz, Mikhail Fludkov, 
Milian Wolff, Millan Castro, Muhammet Ilendemli, Nacho García, 
Nayana Topolsky, Nian Yan, Nicola Murino, Nicolas Dufresne, 
Nicolas Pernas Maradei, Niels De Graef, Nikita Bobkov, Niklas Hambüchen, 
Nirbheek Chauhan, Ognyan Tonchev, okuoku, Oleksandr Kvl,Olivier Crête, 
Ondřej Hruška, Pablo Marcos Oltra, Patricia Muscalu, Peter Seiderer, 
Peter Workman, Philippe Normand, Philippe Renon, Philipp Zabel, 
Pieter Willem Jordaan, Piotr Drąg, Ralf Sippl, Randy Li, Rasmus Thomsen, 
Ratchanan Srirattanamet, Raul Tambre, Ray Tiley, Richard Kreckel, 
Rico Tzschichholz, R Kh, Robert Rosengren, Robert Tiemann, Roman Shpuntov, 
Roman Sivriver, Ruben Gonzalez, Rubén Gonzalez, rubenrua, Ryan Huang, 
Sam Gigliotti, Santiago Carot-Nemesio, Saunier Thibault, Scott Kanowitz, 
Sebastian Dröge, Sebastiano Barrera, Seppo Yli-Olli, Sergey Nazaryev, 
Seungha Yang, Shinya Saito, Silvio Lazzeretti, Simon Arnling Bååth, 
Siwon Kang, sohwan.park, Song Bing, Soohyun Lee, Srimanta Panda, 
Stefano Buora, Stefan Sauer, Stéphane Cerveau, Stian Selnes, Sumaid Syed, 
Swayamjeet, Thiago Santos, Thibault Saunier, Thomas Bluemel, Thomas Coldrick, 
Thor Andreassen, Tim-Philipp Müller, Ting-Wei Lan, Tobias Ronge, trilene, 
Tulio Beloqui, U. Artie Eoff, VaL Doroshchuk, Varunkumar Allagadapa, 
Vedang Patel, Veerabadhran G, Víctor Manuel Jáquez Leal, Vivek R, 
Vivia Nikolaidou, Wangfei, Wang Zhanjun, Wim Taymans, Wonchul Lee, 
Xabier Rodriguez Calvar, Xavier Claessens, Xidorn Quan, Xu Guangxin, 
Yan Wang, Yatin Maan, Yeongjin Jeong, yychao, Zebediah Figura, 
Zeeshan Ali, Zeid Bekli, Zhiyuan Sraf, Zoltán Imets,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing.

## Stable 1.18 branch

After the 1.18.0 release there will be several 1.18.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.18.x bug-fix releases will be made from the git 1.18 branch,
which will be a stable branch.

<a name="1.18.0"></a>

### 1.18.0

1.18.0 was released on 8 September 2020.

## Schedule for 1.20

Our next major feature release will be 1.20, and 1.19 will be the unstable development version leading up to the stable 1.20 release. The development of 1.19/1.20 will happen in the git master branch.

The plan for the 1.20 development cycle is yet to be confirmed, but it is now expected that feature freeze will take place some time in January 2021, with the first 1.20 stable release around February/March 2021.

1.20 will be backwards-compatible to the stable 1.18, 1.16, 1.14, 1.12, 1.10, 1.8, 1.6, 1.4, 1.2 and 1.0 release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller with contributions from Mathieu Duponchelle, Matthew Waters, Nirbheek Chauhan, Sebastian Dröge, Thibault Saunier, and Víctor Manuel Jáquez Leal.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*