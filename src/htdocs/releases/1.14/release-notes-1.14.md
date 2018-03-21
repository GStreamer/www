# GStreamer 1.14 Release Notes

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other
improvements.

GStreamer 1.14.0 was released on 19 March 2018.

See [https://gstreamer.freedesktop.org/releases/1.14/][latest] for the latest
version of this document.

*Last updated: Monday 19 March 2018, 12:00 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.14/
[gitlog]: https://cgit.freedesktop.org/gstreamer/www/log/src/htdocs/releases/1.14/release-notes-1.14.md

## Introduction

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other
improvements.

## Highlights

- WebRTC support: real-time audio/video streaming to and from web browsers

- Experimental support for the next-gen royalty-free [AV1][av1] video codec

- Video4Linux: encoding support, stable element names and faster device probing

- Support for the Secure Reliable Transport ([SRT][srt]) video streaming protocol

- RTP Forward Error Correction (FEC) support (ULPFEC)

- RTSP 2.0 support in `rtspsrc` and gst-rtsp-server

- ONVIF audio backchannel support in gst-rtsp-server and `rtspsrc`

- `playbin3` gapless playback and pre-buffering support

- `tee`, our stream splitter/duplication element, now does allocation query
  aggregation which is important for efficient data handling and zero-copy

- QuickTime muxer has a new prefill recording mode that allows file import
  in Adobe Premiere and FinalCut Pro while the file is still being written.

- `rtpjitterbuffer` fast-start mode and timestamp offset adjustment smoothing

- `souphttpsrc` connection sharing, which allows for connection reuse, cookie sharing, etc.

- `nvdec`: new plugin for hardware-accelerated video decoding using the NVIDIA NVDEC API

- Adaptive DASH trick play support

- `ipcpipeline`: new plugin that allows splitting a pipeline across
  multiple processes

- Major `gobject-introspection` annotation improvements for large parts of the library API

- GStreamer C# bindings have been revived and seen many updates and fixes

- The [externally][gstreamer-rs] maintained GStreamer Rust bindings had many
  usability improvements and cover most of the API now. Coinciding with the
  1.14 release, a [new release][gstreamer-rs-0-11] with the 1.14 API additions
  is happening.

[av1]: https://en.wikipedia.org/wiki/AV1
[srt]: https://www.srtalliance.org/#about_srt
[gstreamer-rs]: https://github.com/sdroege/gstreamer-rs
[gstreamer-rs-0-11]: https://coaxion.net/blog/2018/03/gstreamer-rust-bindings-0-11-plugin-writing-infrastructure-0-2-release/

## Major new features and changes

### WebRTC support

There is now basic support for WebRTC in GStreamer in form of a new
[`webrtcbin`][webrtcbin] element and a [webrtc support library][gstwebrtc].
This allows you to build applications that set up connections with and stream
to and from other WebRTC peers, whilst leveraging all of the usual GStreamer
features such as hardware-accelerated encoding and decoding, OpenGL integration,
zero-copy and embedded platform support. And it's easy to build and integrate
into your application too!

WebRTC enables real-time communication of audio, video and data with web
browsers and native apps, and it is supported or about to be support by recent
versions of all major browsers and operating systems.

GStreamer's new WebRTC implementation uses [libnice][libnice] for
Interactive Connectivity Establishment (ICE) to figure out the best way to
communicate with other peers, punch holes into firewalls, and traverse NATs.

The implementation is not complete, but all the basics are there, and the
code sticks fairly close to the [PeerConnection API][peerconnection-api].
Where functionality is missing it should be fairly obvious where it needs to
go.

For more details, background and example code, check out Nirbheek's blog post
[*GStreamer has grown a WebRTC implementation*][gstreamer-webrtc-blog], as well
as Matthew's [*GStreamer WebRTC* talk][gstreamer-webrtc-talk] from last year's
GStreamer Conference in Prague.

[webrtcbin]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-webrtcbin.html
[gstwebrtc]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-libs/html/webrtc.html
[libnice]: https://nice.freedesktop.org/wiki/
[gstreamer-webrtc-blog]: http://blog.nirbheek.in/2018/02/gstreamer-webrtc.html
[gstreamer-webrtc-talk]: https://gstconf.ubicast.tv/videos/gstreamer-webrtc/
[peerconnection-api]: https://developer.mozilla.org/en-US/docs/Web/API/RTCPeerConnection

### New Elements

- [`webrtcbin`][webrtcbin] handles the transport aspects of webrtc connections
  (see WebRTC section above for more details)

- New `srtsink` and `srtsrc` elements for the Secure Reliable Transport ([SRT][srt])
  video streaming protocol, which aims to be easy to use whilst striking a new
  balance between reliability and latency for low latency video streaming use
  cases. More details about SRT and the implementation in GStreamer in Olivier's
  blog post [*SRT in GStreamer*][srt-in-gstreamer-blog].

- `av1enc` and `av1dec` elements providing experimental support for the
  next-generation royalty free video [AV1][av1] codec, alongside Matroska
  support for it.

- [`hlssink2`][hlssink2] is a rewrite of the existing `hlssink` element, but
  unlike its predecessor `hlssink2` takes elementary streams as input and
  handles the muxing to MPEG-TS internally. It also leverages `splitmuxsink`
  internally to do the splitting. This allows more control over the chunk
  splitting and sizing process and relies less on the co-operation of an
  upstream muxer. Different to the old `hlssink` it also works with
  pre-encoded streams and does not require close interaction with an upstream
  encoder element.

- [`audiolatency`][audiolatency] is a new element for measuring audio latency
  end-to-end and is useful to measure roundtrip latency including both the
  GStreamer-internal latency as well as latency added by external components
  or circuits.

- ['fakevideosink][fakevideosink] is basically a null sink for video data and
  very similar to `fakesink`, only that it will answer allocation queries and
  will advertise support for various video-specific things such `GstVideoMeta`,
  `GstVideoCropMeta` and `GstVideoOverlayCompositionMeta` like a normal video
  sink would. This is useful for throughput testing and testing the zero-copy
  path when creating a new pipeline.

- [`ipcpipeline`][ipcpipeline]: new plugin that allows the splitting of a pipeline into
  multiple processes. Usually a GStreamer pipeline runs in a single process
  and parallelism is achieved by distributing workloads using multiple threads.
  This means that all elements in the pipeline have access to all the other
  elements' memory space however, including that of any libraries used. For
  security reasons one might therefore want to put sensitive parts of a
  pipeline such as DRM and decryption handling into a separate process to
  isolate it from the rest of the pipeline. This can now be achieved with the
  new `ipcpipeline` plugin. Check out George's blog post
  [*ipcpipeline: Splitting a GStreamer pipeline into multiple processes*][ipcpipeline-blog]
  or his [lightning talk][ipcpipeline-lightningtalk] from last year's
  GStreamer Conference in Prague for all the gory details.

[ipcpipeline-blog]: https://www.collabora.com/news-and-blog/blog/2017/11/17/ipcpipeline-splitting-a-gstreamer-pipeline-into-multiple-processes/
[ipcpipeline-lightningtalk]: https://gstconf.ubicast.tv/videos/lightning-talks/#start=1990&autoplay&timeline

- [`proxysink`][proxysink] and [`proxysrc`][proxysrc] are new elements to
  pass data from one pipeline to another within the same process, very similar
  to the existing `inter` elements, but not limited to raw audio and video
  data. These new proxy elements are very special in how they work under the
  hood, which makes them extremely powerful, but also dangerous if not used
  with care. The reason for this is that it's not just data that's passed
  from sink to src, but these elements basically establish a two-way wormhole
  that passes through queries and events in both directions, which means caps
  negotiation and allocation query driven zero-copy can work through this
  wormhole. There are scheduling considerations as well: `proxysink` forwards
  everything into the `proxysrc` pipeline directly from the `proxysink`
  streaming thread. There is a `queue` element inside `proxysrc` to decouple
  the source thread from the sink thread, but that queue is not unlimited, so
  it is entirely possible that the `proxysink` pipeline thread gets stuck in
  the `proxysrc` pipeline, e.g. when that pipeline is paused or stops consuming
  data for some other reason. This means that one should always shut down down
  the `proxysrc` pipeline before shutting down the `proxysink` pipeline, for
  example. Or at least take care when shutting down pipelines. Usually this is
  not a problem though, especially not in live pipelines. For more information
  see Nirbheek's blog post [*Decoupling GStreamer Pipelines*][blog-decoupling-pipelines],
  and also check out out the new [`ipcpipeline`][ipcpipeline] plugin for
  sending data from one process to another process (see above).

- `lcms` is a new [LCMS][lcms]-based ICC color profile correction element

- `openmptdec` is a new [OpenMPT][openmpt]-based decoder for module music
  formats, such as S3M, MOD, XM, IT. It is built on top of a new
  `GstNonstreamAudioDecoder` base class which aims to unify handling of
  files which do not operate a streaming model. The `wildmidi` plugin has also
  been revived and is also implemented on top of this new base class.

- The [curl][curl] plugin has gained a new [`curlhttpsrc`][curlhttpsrc]
  element, which is useful for testing HTTP protocol version 2.0 amongst
  other things.

- The [`msdk`][msdk] plugin has gained a MPEG-2 video decoder(msdkmpeg2dec),
  VP8 decoder(msdkvp8dec) and a VC1/WMV decoder(msdkvc1dec)

[srt-in-gstreamer-blog]: https://www.collabora.com/news-and-blog/blog/2018/02/16/srt-in-gstreamer/
[hlssink2]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-hlssink2.html
[audiolatency]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-audiolatency.html
[fakevideosink]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-fakevideosink.html
[proxysink]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-proxysink.html
[proxysrc]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-proxysrc.html
[blog-decoupling-pipelines]: http://blog.nirbheek.in/2018/02/decoupling-gstreamer-pipelines.html
[ipcpipeline]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-plugin-ipcpipeline.html
[lcms]: http://www.littlecms.com
[openmpt]: https://lib.openmpt.org
[curl]: https://curl.haxx.se/
[curlhttpsrc]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-curlhttpsrc.html
[msdk]: https://github.com/Intel-Media-SDK/MediaSDK

### Noteworthy new API

- [`GstPromise`][promise] provides future/promise-like functionality. This is
  used in the GStreamer WebRTC implementation.

[promise]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstPromise.html

- [`GstReferenceTimestampMeta`][reference-timestamp-meta] is a new meta that
  allows you to attach additional reference timestamps to a buffer. These
  timestamps don't have to relate to the pipeline clock in any way. Examples
  of this could be an NTP timestamp when the media was captured, a frame
  counter on the capture side or the (local) UNIX timestamp when the media
  was captured. The decklink elements make use of this.

[reference-timestamp-meta]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstBuffer.html#gst-buffer-add-reference-timestamp-meta

- `GstVideoRegionOfInterestMeta`: it's now possible to [attach][roi-meta-add-param]
  generic free-form element-specific parameters to a region of interest meta,
  for example to tell a downstream encoder to use certain codec parameters for
  a certain region.

[roi-meta-add-param]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-gstvideometa.html#gst-video-region-of-interest-meta-add-param

- [`gst_bus_get_pollfd`][bus-get-pollfd] can be used to obtain a file
  descriptor for the bus that can be `poll()`-ed on for new messages. This
  is useful for integration with non-GLib event loops.

[bus-get-pollfd]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstBus.html#gst-bus-get-pollfd

- `gst_get_main_executable_path()` can be used by wrapper plugins that need to
  find things in the directory where the application executable is located. In
  the same vein, `GST_PLUGIN_DEPENDENCY_FLAG_PATHS_ARE_RELATIVE_TO_EXE` can be
  used to signal that plugin dependency paths are relative to the main executable.

- pad templates can be told about the `GType` of the pad subclass of the pad
  via newly-added [`GstPadTemplate` API][pad-template] API or the
  [`gst_element_class_add_static_pad_template_with_gtype()`][element-add-template-with-gtype]
  convenience function. `gst-inspect-1.0` will use this information to print
  pad properties.

[element-add-template-with-gtype]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstElement.html#gst-element-class-add-static-pad-template-with-gtype
[pad-template]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstPadTemplate.html#gst-pad-template-new-from-static-pad-template-with-gtype

- new convenience functions to iterate over element pads without using the
  `GstIterator` API: [`gst_element_foreach_pad()`][element-foreach-pad],
  [`gst_element_foreach_src_pad()`][element-foreach-src-pad], and
  [`gst_element_foreach_sink_pad()`][element-foreach-sink-pad].

[element-foreach-pad]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstElement.html#gst-element-foreach-pad
[element-foreach-src-pad]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstElement.html#gst-element-foreach-src-pad
[element-foreach-sink-pad]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstElement.html#gst-element-foreach-sink-pad

- [`GstBaseSrc`][basesrc] and `appsrc` have gained support for buffer lists:
  `GstBaseSrc` subclasses can use [`gst_base_src_submit_buffer_list()`][submit-buffer-list],
  and applications can use [`gst_app_src_push_buffer_list()`][appsrc-push-buffer-list]
  to push a buffer list into `appsrc`.

[basesrc]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-libs/html/GstBaseSrc.html
[submit-buffer-list]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-libs/html/GstBaseSrc.html#gst-base-src-submit-buffer-list
[appsrc-push-buffer-list]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-appsrc.html#gst-app-src-push-buffer-list

- The [`GstHarness`][harness] unit test harness has a couple of new convenience
  functions to retrieve all pending data in the harness in form of a single
  chunk of memory.

[harness]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-libs/html/gstreamer-libs-GstHarness.html

- [`GstAudioStreamAlign`][audiostreamalign] is a new helper object for audio
  elements that handles discontinuity detection and sample alignment. It will
  align samples after the previous buffer's samples, but keep track of the
  divergence between buffer timestamps and sample position (jitter). If it
  exceeds a configurable threshold the alignment will be reset. This simply
  factors out code that was duplicated in a number of elements into a common
  helper API.

[audiostreamalign]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstAudio.html#gst-audio-stream-align-new

- The [`GstVideoEncoder`][videoencoder] base class implements Quality of Service
  (QoS) now. This is disabled by default and must be opted in by setting the
  `"qos"` property, which will make  the base class gather statistics about the
  real-time performance of the pipeline from downstream elements (usually sinks
  that sync the pipeline clock). Subclasses can then make use of this by checking
  whether input frames are late already using [`gst_video_encoder_get_max_encode_time()`][get-max-encode-time]
  If late, they can just drop them and skip encoding in the hope that the pipeline
  will catch up.

[videoencoder]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideoEncoder.html
[get-max-encode-time]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideoEncoder.html#gst-video-encoder-get-max-encode-time

- The [`GstVideoOverlay`][videooverlay] interface gained [a few helper functions][videooverlay-install-props]
  for installing and handling a `"render-rectangle"` property on elements that
  implement this interface, so that this functionality can also be used from
  the command line for testing and debugging purposes. The property wasn't added
  to the interface itself as that would require all implementors to provide
  it which would not be backwards-compatible.

[videooverlay]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/GstVideoOverlay.html
[videooverlay-install-props]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/GstVideoOverlay.html#gst-video-overlay-install-properties

- A new base class, [`GstNonstreamAudioDecoder`][nonstream-audio] for
  non-stream audio decoders was added to gst-plugins-bad. This base-class is
  meant to be used for audio decoders that require the whole stream to be
  loaded first before decoding can start. Examples of this are module formats
  (MOD/S3M/XM/IT/etc), C64 SID tunes, video console music files (GYM/VGM/etc),
  MIDI files and others. The new `openmptdec` element is based on this.

[nonstream-audio]: https://cgit.freedesktop.org/gstreamer/gst-plugins-bad/tree/gst-libs/gst/audio

- Full list of API new in 1.14:
  - [GStreamer core API new in 1.14](https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/ix03.html)
  - [GStreamer base library API new in 1.14](https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-libs/html/ix03.html)
  - [gst-plugins-base libraries API new in 1.14](https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/ix03.html)
  - gst-plugins-bad: no list, mostly GstWebRTC library and new non-stream audio
    decoder base class.

### New RTP features and improvements

- [`rtpulpfecenc`][rtpulpfecenc] and [`rtpulpfecdec`][rtpulpfecdec] are new
  elements that implement Generic Forward Error Correction (FEC) using Uneven
  Level Protection (ULP) as described in [RFC 5109][rfc-5109]. This can be
  used to protect against certain types of (non-bursty) packet loss, and
  important packets such as those containing codec configuration data or
  key frames can be protected with higher redundancy. Equally, packets that
  are not particularly important can be given low priority or not be protected
  at all. If packets are lost, the receiver can then hopefully restore the lost
  packet(s) from the surrounding packets which were received. This is an
  alternative to, or rather complementary to, dealing with packet loss using
  *retransmission (rtx)*. GStreamer has had retransmission support for a long
  time, but Forward Error Correction allows for different trade-offs: The
  advantage of Forward Error Correction is that it doesn't add latency, whereas
  retransmission requires at least one more roundtrip to request and hopefully
  receive lost packets; Forward Error Correction increases the required
  bandwidth however, even in situations where there is no packet loss at all,
  so one will typically want to fine-tune the overhead and mechanisms used
  based on the characteristics of the link at the time.

- New *Redundant Audio Data (RED)* encoders and decoders for RTP as per
  [RFC 2198][rfc-2198] are also provided (`rtpredenc` and `rtpreddec`), mostly
  for chrome webrtc compatibility, as chrome will wrap ULPFEC-protected streams
  in RED packets, and such streams need to be wrapped and unwrapped in order
  to use ULPFEC with chrome.

[rtpulpfecdec]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-rtpulpfecdec.html
[rtpulpfecenc]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-rtpulpfecenc.html
[rfc-5109]: https://tools.ietf.org/html/rfc5109
[rfc-2198]: https://tools.ietf.org/html/rfc2198

- a few new buffer flags for FEC support: `GST_BUFFER_FLAG_NON_DROPPABLE` can
  be used to mark important buffers, e.g. to flag RTP packets carrying keyframes
  or codec setup data for RTP Forward Error Correction purposes, or to prevent
  still video frames from being dropped by elements due to QoS. There already
  is a `GST_BUFFER_FLAG_DROPPABLE`. `GST_RTP_BUFFER_FLAG_REDUNDANT` is used to
  signal internally that a packet represents a redundant RTP packet and used
  in `rtpstorage` to hold back the packet and use it only for recovery from
  packet loss. Further work is still needed in payloaders to make use of these.

- `rtpbin` now has an option for increasing timestamp offsets gradually:
  Sudden large changes to the internal `ts_offset` may cause timestamps to
  move backwards and may also cause visible glitches in media playback. The new
  `"max-ts-offset-adjustment"` and `"max-ts-offset"` properties let the
  application control the rate to apply changes to `ts_offset`. There have
  also been some `EOS`/`BYE` handling improvements in `rtpbin`.

- `rtpjitterbuffer` has a new fast start mode: in many scenarios the jitter
  buffer will have to wait for the full configured latency before it can start
  outputting packets. The reason for that is that it often can't know what
  the sequence number of the first expected RTP packet is, so it can't know
  whether a packet earlier than the earliest packet received will still arrive
  in future. This behaviour can now be bypassed by setting the `"faststart-min-packets"`
  property to the number of consecutive packets needed to start, and the
  jitter buffer will start output packets as soon as it has N consecutive
  packets queued internally. This is particularly useful to get a first video
  frame decoded and rendered as quickly as possible.

- `rtpL8pay` and `rtpL8depay` provide RTP payloading and depayloading for
  8-bit raw audio

### New element features

- `playbin3` has gained support or gapless playback via the `"about-to-finish"`
  signal where users can set the uri for the next item to play. For non-live
  streams this will be emitted as soon as the first uri has finished
  downloading, so with sufficiently large buffers it is now possible to
  pre-buffer the next item well ahead of time (unlike `playbin` where there
  would not be a lot of time between `"about-to-finish"` emission and the end
  of the stream). If the stream format of the next stream is the same as that
  of the previous stream, the data will be concatenated via the `concat`
  element. Whether this will result in true gaplessness depends on the
  container format and codecs used, there might still be codec-related gaps
  between streams with some codecs.

- `tee` now does allocation query aggregation, which is important for
  zero-copy and efficient data handling, especially for video. Those
  who want to drop allocation queries on purpose can use the `identity`
  element's new `"drop-allocation"` property for that instead.

- `audioconvert` now has a `"mix-matrix"` property, which obsoletes
  the `audiomixmatrix` element. There's also mix matrix support in
  the audio conversion and channel mixing API.

- `x264enc`: new `"insert-vui"` property to disable VUI (Video Usability
  Information) parameter insertion into the stream, which allows creation
  of streams that are compatible with certain legacy hardware decoders that
  will refuse to decode in certain combinations of resolution and
  VUI parameters; the max. allowed number of B-frames was also increased
  from 4 to 16.

- `dvdlpcmdec`: has gained support for Blu-Ray audio LPCM.

- `appsrc` has gained support for buffer lists (see above) and also seen
  some other performance improvements.

- `flvmux` has been ported to the GstAggregator base class which means it
  can work in defined-latency mode with live input sources and continue
  streaming if one of the inputs stops producing data.

- `jpegenc` has gained a `"snapshot"` property just like `pngenc` to make it
  easier to output just a single encoded frame.

- `jpegdec` will now handle interlaced MJPEG streams properly and also handles
  frames without an End of Image marker better.

- v4l2: There are now video encoders for VP8, VP9, MPEG4, and H263. The v4l2
  video decoder handles dynamic resolution changes, and the video4linux device
  provider now does much faster device probing. The plugin also no longer uses
  the libv4l2 library by default, as it has prevented a lot of interesting use
  cases like `CREATE_BUFS`, `DMABuf`, usage of `TRY_FMT`. As the libv4l2 library
  is totally inactive and not really maintained, we decided to disable it. This
  might affect a small number of cheap/old webcams with custom vendor formats
  for which we do not provide conversion in GStreamer. It is possible to
  re-enable support for libv4l2 at run-time however, by setting the environment
  variable `GST_V4L2_USE_LIBV4L2=1`.

- `rtspsrc` now has support for RTSP protocol version 2.0 as well as ONVIF audio
  backchannels (see below for more details). It also sports a new `"accept-certificate"`
  signal for "manually" checking a TLS certificate for validity. It now also
  prints RTSP/SDP messages to the gstreamer debug log instead of stdout.

- `shout2send` now uses non-blocking I/O and has a configurable network
  operations timeout.

- `splitmuxsink` has gained a `"split-now"` action signal and new
  `"alignment-threshold"` and `"use-robust-muxing"` properties. If robust
   muxing is enabled, it will check and set the muxer's reserved space
   properties if present. This is primarily for use with mp4mux's robust
   muxing mode.

- `qtmux` has a new *prefill recording mode* which sets up a moov header with
  the correct sample positions beforehand, which then allows software like
  Adobe Premiere and FinalCut Pro to import the files while they are still
  being written to. This only works with constant framerate I-frame only
  streams, and for now only support for ProRes video and raw audio is
  implemented. Adding support for additional codecs is just a matter of
  defining appropriate maximum frame sizes though.

- `qtmux` also supports writing of svmi atoms with stereoscopic video
  information now. Trak timescales can be configured on a per-stream basis
  using the `"trak-timescale"` property on the sink pads. Various new formats
  can be muxed: MPEG layer 1 and 2, AC3 and Opus, as well as PNG and VP9.

- `souphttpsrc` now does connection sharing by default: it shares its `SoupSession`
  with other elements in the same pipeline via a `GstContext` if possible
  (session-wide settings are all the defaults). This allows for connection
  reuse, cookie sharing, etc. Applications can also force a context to use.
  In other news, HTTP headers received from the server are posted as element
  messages on the bus now for easier diagnostics, and it's also possible now
  to use other types of proxy servers such as SOCKS4 or SOCKS5 proxies, support
  for which is implemented directly in gio. Before only HTTP proxies were
  allowed.

- `qtmux`, `mp4mux` and `matroskamux` will now refuse caps changes of input
  streams at runtime. This isn't really supported with these containers
  (or would have to be implemented differently with a considerable effort)
  and doesn't produce valid and spec-compliant files that will play everywhere.
  So if you can't guarantee that the input caps won't change, use a container
  format that does support on the fly caps changes for a stream such as
  MPEG-TS or use `splitmuxsink` which can start a new file when the caps
  change. What would happen before is that e.g. `rtph264depay` or `rtph265depay`
  would simply send new SPS/PPS inband even for AVC format, which would then
  get muxed into the container as if nothing changed. Some decoders will
  handle this just fine, but that's often more luck than by design. In any
  case, it's not right, so we disallow it now.

- `matroskamux` has Table of Content (TOC) support now (chapters etc.) and
  `matroskademux` TOC support has been improved. `matroskademux` has also
   seen seeking improvements searching for the right cluster and position.

- `videocrop` now uses `GstVideoCropMeta` if downstream supports it, which
  means cropping can be handled more efficiently without any copying.

- `compositor` now has support for *crossfade blending*, which can be used
  via the new `"crossfade-ratio"` property on the sink pads.

- The [`avwait`][avwait] element has a new `"end-timecode"` property and posts
  `"avwait-status"` element messages now whenever `avwait` starts or stops
  passing through data (e.g. because target-timecode and end-timecode
  respectively have been reached).

[avwait]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-avwait.html

- `h265parse` and `h265parse` will try harder to make upstream output the same
  caps as downstream requires or prefers, thus avoiding unnecessary conversion.
  The parsers also expose chroma format and bit depth in the caps now.

- The `dtls` elements now longer rely on or require the application to run a
  GLib main loop that iterates the default main context (GStreamer plugins
  should never rely on the application running a GLib main loop).

- `openh264enc` allows to change the encoding bitrate dynamically at runtime now

- `nvdec` is a new plugin for hardware-accelerated video decoding using
  the NVIDIA NVDEC API (which replaces the old VDPAU API which is no longer
  supported by NVIDIA)

- The NVIDIA NVENC hardware-accelerated video encoders now support dynamic
  bitrate and preset reconfiguration and support the `I420` 4:2:0 video format.
  It's also possible to configure the gop size via the new `"gop-size"` property.

- The MPEG-TS muxer and demuxer (`tsmux`, `tsdemux`) now have support for JPEG2000

- `openjpegdec` and `jpeg2000parse` support 2-component images now (gray with alpha),
  and `jpeg2000parse` has gained limited support for conversion between JPEG2000
  stream-formats. (JP2, J2C, JPC) and also extracts more details such as
  colorimetry, interlace-mode, field-order, multiview-mode and chroma siting.

- The `decklink` plugin for Blackmagic capture and playback cards have seen
  numerous improvements:

  - `decklinkaudiosrc` and `decklinkvideosrc` now put hardware reference
    timestamp on buffers in form of [`GstReferenceTimestampMeta`s][reference-timestamp-meta].    
    This can be useful to know on multi-channel cards which frames from
    different channels were captured at the same time.

  - `decklinkvideosink` has gained support for Decklink hardware keying with
    two new properties (`"keyer-mode"` and `"keyer-level"`) to control the
    built-in hardware keyer of Decklink cards.

  - `decklinkaudiosink` has been re-implemented around `GstBaseSink` instead
    of the `GstAudioBaseSink` base class, since the Decklink APIs don't fit
    very well with the `GstAudioBaseSink` APIs, which used to cause various
    problems due to inaccuracies in the clock calculations. Problems were
    audio drop-outs and A/V sync going wrong after pausing/seeking.

  - support for more than 16 devices, without any artificial limit

- work continued on the `msdk` plugin for Intel's Media SDK which enables
  hardware-accelerated video encoding and decoding on Intel graphics hardware
  on Windows or Linux. Added the video memory, buffer pool, and context/session
  sharing support which helps to improve the performance and resource utilization.
  Rendernode support is in place which helps to avoid the constraint of having
  a running graphics server as DRM-Master. Encoders are exposing a number rate control
  algorithms now. More encoder tuning options like trellis-quantiztion (h264),
  slice size control (h264), B-pyramid prediction(h264), MB-level bitrate control,
  frame partitioning and adaptive I/B frame insertion were added, and more pixel formats
  and video codecs are supported now. The encoder now also handles
  force-key-unit events and can insert frame-packing SEIs for side-by-side
  and top-bottom stereoscopic 3D video.

- `dashdemux` can now do adaptive trick play of certain types of DASH streams,
  meaning it can do fast-forward/fast-rewind of normal (non-I frame only)
  streams even at high speeds without saturating network bandwidth or exceeding
  decoder capabilities. It will keep statistics and skip keyframes or fragments
  as needed. See Sebastian's blog post [*DASH trick-mode playback in GStreamer*][dash-trickmodes-blogs]
  for more details. It also supports webvtt subtitle streams now and has seen
  improvements when seeking in live streams.

[dash-trickmodes-blogs]: https://coaxion.net/blog/2017/10/dash-trick-mode-playback-in-gstreamer-fast-forwardrewind-without-saturating-your-network-and-cpu/

- `kmssink` has seen lots of fixes and improvements in this cycle, including:

  - Raspberry Pi (vc4) and Xilinx DRM driver support

  - new `"render-rectangle"` property that can be used from the command line
    as well as `"display-width"` and `"display-height"`, and `"can-scale"`
    properties

  - `GstVideoCropMeta` support

### Plugin and library moves

#### MPEG-1 audio (mp1, mp2, mp3) decoders and encoders moved to -good

Following the expiration of the last remaining mp3 patents in most jurisdictions,
and the [termination](https://www.iis.fraunhofer.de/en/ff/amm/prod/audiocodec/audiocodecs/mp3.html)
of the mp3 licensing program, as well as the [decision by certain distros](https://fedoramagazine.org/full-mp3-support-coming-soon-to-fedora/)
to officially start shipping full mp3 decoding and encoding support, these
plugins should now no longer be problematic for most distributors and have
therefore been moved from -ugly and -bad to gst-plugins-good. Distributors
can still disable these plugins if desired.

In particular these are:

- [`mpg123audiodec`][mpg123audiodec]: an mp1/mp2/mp3 audio decoder using [libmpg123](https://www.mpg123.de/api/)
- [`lamemp3enc`][lamemp3enc]: an mp3 encoder using [LAME](http://lame.sourceforge.net/)
- [`twolamemp2enc`][twolamemp2enc]: an mp2 encoder using [TwoLAME](https://www.mpg123.de/api/)

[lamemp3enc]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-lamemp3enc.html
[twolamemp2enc]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-twolamemp2enc.html
[mpg123audiodec]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-mpg123audiodec.html

#### GstAggregator moved from -bad to core

[GstAggregator][aggregator] has been moved from gst-plugins-bad to the base
library in GStreamer and is now stable API.

[GstAggregator][aggregator] is a new base class for mixers and muxers that
have to handle multiple input pads and aggregate streams into one output
stream. It improves upon the existing [GstCollectPads][collectpads] API in
that it is a proper base class which was also designed with live streaming
in mind. [GstAggregator][aggregator] subclasses will operate in a mode with
defined latency if any of the inputs are live streams. This ensures that
the pipeline won't stall if any of the inputs stop producing data, and that
the configured maximum latency is never exceeded.

[aggregator]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-libs/html/GstAggregator.html
[collectpads]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-libs/html/GstCollectPads.html

#### GstAudioAggregator, `audiomixer` and `audiointerleave` moved from -bad to -base

[GstAudioAggregator][audioaggregator] is a new base class for raw audio mixers
and muxers and is based on [GstAggregator][aggregator] (see above). It provides
defined-latency mixing of raw audio inputs and ensures that the pipeline won't
stall even if one of the input streams stops producing data.

As part of the move to stabilise the API there were some last-minute API
changes and clean-ups, but those should mostly affect internal elements.

It is used by the [`audiomixer`][audiomixer] element, which is a replacement
for 'adder', which did not handle live inputs very well and did not align input
streams according to running time. [`audiomixer`][audiomixer] should behave
much better in that respect and generally behave as one would expected in most
scenarios.

Similarly, [`audiointerleave`][audiointerleave] replaces the 'interleave'
element which did not handle live inputs or non-aligned inputs very robustly.

[GstAudioAggregator][audioaggregator] and its subclases have gained support
for input format conversion, which does not include sample rate conversion
though as that would add additional latency. Furthermore, `GAP` events are
now handled correctly.

[audioaggregator]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/GstAudioAggregator.html
[audiointerleave]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-plugins/html/gst-plugins-base-plugins-audiointerleave.html
[audiomixer]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-plugins/html/gst-plugins-base-plugins-audiomixer.html

We hope to move the video equivalents (`GstVideoAggregator` and `compositor`)
to -base in the next cycle, i.e. for 1.16.

#### GStreamer OpenGL integration library and plugin moved from -bad to -base

The [GStreamer OpenGL integration library][gst-gl] and [`opengl` plugin][opengl-plugin]
have moved from gst-plugins-bad to -base and are now part of the stable API
canon. Not all OpenGL elements have been moved; a few had to be left behind
in gst-plugins-bad in the new [`openglmixers` plugin][openglmixers-plugin],
because they depend on the `GstVideoAggregator` base class which we were not
able to move in this cycle. We hope to reunite these elements with the rest of
their family for 1.16 though.

This is quite a milestone, thanks to everyone who worked to make this happen!

[gst-gl]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gl.html
[opengl-plugin]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-plugins/html/gst-plugins-base-plugins-plugin-opengl.html
[openglmixers-plugin]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-plugin-openglmixers.html

#### Qt QML and GTK plugins moved from -bad to -good

The Qt QML-based `qmlgl` plugin has moved to -good and provides a
[`qmlglsink`][qmlglsink] video sink element as well as a [`qmlglsrc`][qmlglsrc]
element. [`qmlglsink`][qmlglsink] renders video into a `QQuickItem`, and
[`qmlglsrc`][qmlglsrc] captures a window from a QML view and feeds it as video
into a pipeline for further processing. Both elements leverage GStreamer's
OpenGL integration. In addition to the move to -good the following features were
added:

  - A proxy object is now used for thread-safe access to the QML widget which
    prevents crashes in corner case scenarios: QML can destroy the video widget
    at any time, so without this we might be left with a dangling pointer.

  - EGL is now supported with the X11 backend, which works e.g. on Freescale imx6

[qmlglsink]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-qmlglsink.html
[qmlglsrc]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-qmlglsrc.html

The [GTK+](https://www.gtk.org) plugin has also moved from -bad to -good. It
includes [`gtksink`][gtksink] and [`gtkglsink`][gtkglsink] which both render
video into a `GtkWidget`. [`gtksink`][gtksink] uses
[Cairo](https://cairographics.org) for rendering the video, which will work
everywhere in all scenarios but involves an extra memory copy, whereas
[`gtkglsink`][gtkglsink] fully leverages GStreamer's OpenGL integration, but
might not work properly in all scenarios, e.g. where the OpenGL driver does not
properly support multiple sharing contexts in different threads; on Linux
Nouveau is known to be broken in this respect, whilst NVIDIA's proprietary
drivers and most other drivers generally work fine, and the experience with
Intel's driver seems to be mixed; some proprietary embedded Linux drivers
don't work; macOS works.

[gtksink]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-gtksink.html
[gtkglsink]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-gtkglsink.html

#### GstPhysMemoryAllocator interface moved from -bad to -base

[`GstPhysMemoryAllocator`][physmemallocator] is a marker interface for
allocators with physical address backed memory.

[physmemallocator]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstPhysMemoryAllocator.html

### Plugin removals

- the `sunaudio` plugin was removed, since it couldn't ever have been built
  or used with GStreamer 1.0, but no one even noticed in all these years.

- the `schroedinger`-based Dirac encoder/decoder plugin has been removed,
  as there is no longer any upstream or anyone else maintaining it. Seeing
  that it's quite a fringe codec it seemed best to simply remove it.

### API removals

- some MPEG video parser API in the API unstable codecutils library in
  gst-plugins-bad was removed after having been deprecated for 5 years.

## Miscellaneous changes

- The [video support library][gstvideo] has gained support for a few new pixel
  formats:
  - `NV16_10LE32`: 10-bit variant of `NV16`, packed into 32bit words (plus 2 bits padding)
  - `NV12_10LE32`: 10-bit variant of `NV12`, packed into 32bit words (plus 2 bits padding)
  - `GRAY10_LE32`: 10-bit grayscale, packed in 32bit words (plus 2 bits padding)

- `decodebin`, `playbin` and `GstDiscoverer` have seen stability improvements
  in corner cases such as shutdown while still starting up or shutdown in error
  cases (hat tip to the oss-fuzz project).

- floating reference handling was inconsistent and has been cleaned up across
  the board, including annotations. This solves various long-standing memory
  leaks in language bindings, which e.g. often caused elements and pads to be
  leaked.

- major `gobject-introspection` annotation improvements for large parts of the
  library API, including nullability of return types and function parameters,
  correct types (e.g. strings vs. filenames), ownership transfer, array length
  parameters, etc. This allows to use bigger parts of the GStreamer API to be
  safely used from dynamic language bindings (e.g. Python, Javascript) and
  allows static bindings (e.g. C#, Rust, Vala) to autogenerate more API
  bindings without manual intervention.

[gstvideo]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gstreamer-video.html

### OpenGL integration

- The GStreamer OpenGL integration library has moved to gst-plugins-base and
  is now part of our stable API.

- new **Mesa3D GBM backend**. On devices with working libdrm support, it is
  possible to use Mesa3D's GBM library to set up an EGL context directly on top
  of KMS. This makes it possible to use the GStreamer OpenGL elements without a
  windowing system if a libdrm- and Mesa3D-supported GPU is present.

- Prefer wayland display over X11: As most Wayland compositors support
  XWayland, the X11 backend would get selected.

- `gldownload` can export `dmabuf`s now, and `glupload` will advertise dmabuf
   as caps feature.

## Tracing framework and debugging improvements

- **New memory ringbuffer based debug logger**, useful for long-running
  applications or to retrieve diagnostics when encountering an error. The
  GStreamer debug logging system provides in-depth debug logging about what
  is going on inside a pipeline. When enabled, debug logs are usually
  written into a file, printed to the terminal, or handed off to a log
  handler installed by the application. However, at higher debug levels the
  volume of debug output quickly becomes unmanageable, which poses a problem
  in disk-space or bandwidth restricted environments or with long-running
  pipelines where a problem might only manifest itself after multiple days.
  In those situations, developers are usually only interested in the most
  recent debug log output. The new in-memory ringbuffer logger makes this
  easy: just installed it with [`gst_debug_add_ring_buffer_logger()`][add-ring-buffer-logger]
  and retrieve logs with [`gst_debug_ring_buffer_logger_get_logs()`][logger-get-logs]
  when needed. It is possible to limit the memory usage per thread and set a
  timeout to determine how long messages are kept around. It was always possible
  to implement this in the application with a custom log handler of course, this
  just provides this functionality as part of GStreamer.

[logger-get-logs]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstInfo.html#gst-debug-ring-buffer-logger-get-logs
[add-ring-buffer-logger]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstInfo.html#gst-debug-add-ring-buffer-logger

- ['fakevideosink][fakevideosink] is a null sink for video data that advertises
  video-specific metas ane behaves like a video sink. See above for more details.

- `gst_util_dump_buffer()` prints the content of a buffer to stdout.

- `gst_pad_link_get_name()` and `gst_state_change_get_name()` print pad link
  return values and state change transition values as strings.

- The **latency tracer** has seen a few improvements: trace records now contain
  timestamps which is useful to plot things over time, and downstream
  synchronisation time is now excluded from the measured values.

- Miniobject refcount tracing and logging was not entirley thread-safe, there
  were duplicates or missing entries at times. This has now been made reliable.

- The `netsim` element, which can be used to simulate network jitter, packet
  reordering and packet loss, received new features and improvements: it can now
  also simulate network congestion using a token bucket algorithm. This can be
  enabled via the `"max-kbps"` property. Packet reordering can be disabled
  now via the `"allow-reordering"` property: Reordering of packets is not very
  common in networks, and the delay functions will always introduce reordering
  if delay > packet-spacing, so by setting `"allow-reordering"` to `FALSE` you
  guarantee that the packets are in order, while at the same time introducing
  delay/jitter to them. By using the new `"delay-distribution"` property the
  user can control how the delay applied to delayed packets is distributed: This
  is either the uniform distribution (as before) or the normal distribution;
  in addition there is also the gamma distribution which simulates the delay
  on wifi networks better.

## Tools

- `gst-inspect-1.0` now prints pad properties for elements that have pad
  subclasses with special properties, such as `compositor` or `audiomixer`.
  This only works for elements that use the newly-added [`GstPadTemplate` API][pad-template]
  API or the [`gst_element_class_add_static_pad_template_with_gtype()`][element-add-template-with-gtype]
  convenience function to tell GStreamer about the special pad subclass.

- `gst-launch-1.0` now generates a gstreamer pipeline diagram (.dot file)
  whenever SIGHUP is sent to it on Linux/*nix systems.

- `gst-discoverer-1.0` can now analyse live streams such as `rtsp://` URIs

## GStreamer RTSP server

- Initial support for [RTSP protocol version 2.0][rtsp2-lightning-talk] was
  added, which is to the best of our knowledge the first RTSP 2.0
  implementation ever!

[rtsp2-lightning-talk]: https://gstconf.ubicast.tv/videos/lightning-talks/#start=2240&autoplay&timeline

- ONVIF audio backchannel support. This is an extension [specified][onvif-spec]
  by ONVIF that allows RTSP clients (e.g. a control room operator) to send audio
  back to the RTSP server (e.g. an IP camera). Theoretically this could have
  been done also by using the `RECORD` method of the RTSP protocol, but ONVIF
  chose not to do that, so the backchannel is set up alongside the other
  streams. Format negotiation needs to be done out of band, if needed. Use the
  new ONVIF-specific subclasses [GstRTSPOnvifServer][onvif-server] and
  [GstRTSPOnvifMediaFactory][onvif-media-factory] to enable this functionality.

[onvif-spec]: https://www.onvif.org/specs/stream/ONVIF-Streaming-Spec-v210.pdf
[onvif-server]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-rtsp-server/html/gst-rtsp-server-GstRTSPOnvifServer.html
[onvif-media-factory]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-rtsp-server/html/gst-rtsp-server-GstRTSPOnvifMediaFactory.html

- The internal server streaming pipeline is now dynamically reconfigured on
  `PLAY` based on the transports needed. This means that the server no longer
  adds the pipeline plumbing for all possible transports from the start, but
  only if needed as needed. This improves performance and memory footprint.

- `rtspclientsink` has gained an `"accept-certificate"` signal for manually
  checking a TLS certificate for validity.

- Fix keep-alive/timeout issue for certain clients using TCP interleave as
  transport who don't do keep-alive via some other method such as periodic
  RTSP `OPTION` requests. We now put netaddress metas on the packets from the
  TCP interleaved stream, so can map RTCP packets to the right stream in the
  server and can handle them properly.

- Language bindings improvements: in general there were quite a few
  improvements in the gobject-introspection annotations, but we also
  extended the permissions API which was not usable from bindings before.

- Fix corner case issue where the wrong mount point was found when there were
  multiple mount points with a common prefix.

## GStreamer VAAPI

- Improve DMABuf's usage, both upstream and dowstream, and
  ``memory:DMABuf`` caps feature is also negotiated when the
  dmabuf-based buffer cannot be mapped onto user-space.

- VA initialization was fixed when it is used in headless systems.

- VA display sharing, through ``GstContext``, among the pipeline, has
  been improved, adding the possibility to the application share its
  VA display (external display) via ``gst.vaapi.app.Display`` context.

- VA display cache was removed.

- libva's log messages are now redirected into the GStreamer log handler.

- Decoders improved their upstream re-negotiation by avoiding to
  re-instantiate the internal decoder if stream caps are compatible
  with the previous one.

- When downstream doesn't support ``GstVideoMeta`` and the decoded
  frames don't have standard strides, they are copied onto system
  memory-based buffers.

- H.264 decoder has a ``low-latency`` property, for live streams which
  doesn't conform the H.264 specification but still it is required to
  push the frames to downstream as soon as possible.

- As part of the Google Summer of Code 2017 the H.264 decoder drops
  MVC and SVC frames when ``base-only`` property is enabled.

- Added support for libva-2.0 (VA-API 1.0).

- H.264 and H.265 encoders handle Region-Of-Interest metas by adding a
  ``delta-qp`` for every rectangle within the frame specified by those
  metas.

- Encoders for H.264 and H.265 set the media profile by the downstream
  caps.

- H.264 encoder inserts an AU delimiter for each encoded frame when
  ``aud`` property is enabled (it is only available for certain
  drivers and platforms).

- H.264 encoder supports for P and B hierarchical prediction modes.

- All encoders handles a ``quality-level`` property, which is a number
  from 1 to 8, where a lower number means higher quality, but slower
  processing, and vice-versa.

- VP8 and VP9 encoders support constant bit-rate mode (CBR).

- VP8, VP9 and H.265 encoders support variable bit-rate mode (VBR).

- Resurrected ``GstGLUploadTextureMeta`` handling for EGL backends.

- H.265 encoder can configure its number of reference frames via the
  ``refs`` property.

- Add H.264 encoder ``mbbrc`` property, which controls the macro-block
  bitrate as auto, on or off.

- Add H.264 encoder ``temporal-levels`` property, to select the number
  of temporal levels to be included.

- Add to H.264 and H.265 encoders the properties ``qp-ip`` and
  ``qp-ib``, to handle the QP (quality parameter) difference between
  the I and P frames, and the I and B frames, respectively.

- ``vaapisink`` was demoted to marginal rank on Wayland because COGL
  cannot display YUV surfaces.

## GStreamer Editing Services and NLE

- Handle crossfade in complex scenarios by using the new `compositorpad::crossfade-ratio`
  property

- Add API allowing to stop using proxies for clips in the timeline

- Allow management of none square pixel aspect ratios by allowing application to deal
  with them in the way they want

- Misc fixes around the timeline editing API

## GStreamer validate

- Handle running scenarios on live pipelines (in the "content sense", not the GStreamer one)

- Implement RTSP support with a basic server based on gst-rtsp-server, and add RTSP
  1.0 and 2.0 integration tests

- Implement a plugin that allows users to implement configurable tests. It currently
  can check if a particular element is added a configurable number of time in the
  pipeline. In the future that plugin should allow us to implement specific tests of
  any kind in a descriptive way

- Add a `verbosity` configuration which behaves in a similare way as the `gst-launch-1.0`
  `verbose` flags allowing the informations to be outputed on any running pipeline when
  enabling GstValidate.

- Misc optimization in the launcher, making the tests run much faster.

## GStreamer C# bindings

- Port to the [meson](http://mesonbuild.com) build system, autotools support has been
  removed

- Use a new [GlibSharp](https://github.com/GLibSharp/GtkSharp) version, set as a meson
  subproject

- Update wrapped API to GStreamer 1.14

- Removed the need for "glue" code

- Provide a [nuget](https://www.nuget.org/packages/GstSharp/)

- Misc API fixes

## Build and Dependencies

- the new WebRTC support in gst-plugins-bad depends on the GStreamer elements
  that ship as part of libnice, and libnice version 1.1.14 is required. Also
  the `dtls` and `srtp` plugins.

- gst-plugins-bad no longer depends on the libschroedinger Dirac codec library.

- The `srtp` plugin can now also be built against libsrtp2.

- some plugins and libraries have moved between modules, see the *Plugin and*
  *library moves* section above, and their respective dependencies have moved
  with them of course, e.g. the GStreamer OpenGL integration support library
  and plugin is now in gst-plugins-base, and mpg123, LAME and twoLAME based
  audio decoder and encoder plugins are now in gst-plugins-good.

- Unify static and dynamic plugin interface and remove plugin specific static
  build option: Static and dynamic plugins now have the same interface. The
  standard `--enable-static`/`--enable-shared` toggle is sufficient. This
  allows building static and shared plugins from the same object files, instead
  of having to build everything twice.

- The default plugin entry point has changed. This will only affect plugins
  that are recompiled against new GStreamer headers. Binary plugins using the
  old entry point will continue to work. However, plugins that are recompiled
  must have matching plugin names in `GST_PLUGIN_DEFINE` and filenames, as
  the plugin entry point for shared plugins is now deduced from the plugin
  filename. This means you can no longer have a plugin called `foo` living
  in a file called `libfoobar.so` or such, the plugin filename needs to match.
  This might cause problems with some external third party plugin modules
  when they get rebuilt against GStreamer 1.14.

## Note to packagers and distributors

A number of libraries, APIs and plugins moved between modules and/or libraries
in different modules between version 1.12.x and 1.14.x, see the *Plugin and*
*library moves* section above. Some APIs have seen minor ABI changes in the
course of moving them into the stable APIs section.

This means that you should try to ensure that all major GStreamer modules are
synced to the same major version (1.12 or 1.13/1.14) and can only be upgraded
in lockstep, so that your users never end up with a mix of major versions on
their system at the same time, as this may cause breakages.

Also, plugins compiled against >= 1.14 headers will not load with
GStreamer <= 1.12 owing to a new plugin entry point (but plugin binaries
built against older GStreamer versions will continue to load with newer
versions of GStreamer of course).

There is also a small structure size related ABI breakage introduced in the
gst-plugins-bad codecparsers library between version 1.13.90 and 1.13.91. This
should "only" affect gstreamer-vaapi, so anyone who ships the release
candidates is advised to upgrade those two modules at the same time.

## Platform-specific improvements

### Android

- `ahcsrc` (Android camera source) does autofocus now

### macOS and iOS

- this section will be filled in shortly {FIXME!}

### Windows

- The GStreamer [`wasapi`][wasapi-plugin] plugin was rewritten and should not
  only be usable now, but in top shape and suitable for low-latency use cases.
  The Windows Audio Session API (WASAPI) is Microsoft's most modern method for
  talking with audio devices, and now that the `wasapi` plugin is up to scratch
  it is preferred over the `directsound` plugin. The ranks of the `wasapisink`
  and `wasapisrc` elements have been updated to reflect this. Further
  improvements include:

   - support for more than 2 channels

   - a new `"low-latency"` property to enable low-latency operation
     (which should always be safe to enable)

   - support for the AudioClient3 API which is only available on Windows 10:
     in `wasapisink` this will be used automatically if available; in `wasapisrc`
     it will have to be enabled explicitly via the `"use-audioclient3"` property,
     as capturing audio with low latency and without glitches seems to require
     setting the realtime priority of the entire pipeline to "critical", which
     cannot be done from inside the element, but has to be done in the
     application.

   - set realtime thread priority to avoid glitches

   - allow opening devices in exclusive mode, which provides much lower latency
     compared to shared mode where WASAPI's engine period is 10ms. This can
     be activated via the `"exclusive"` property.

- There are now `GstDeviceProvider` implementations for the `wasapi` and
  `directsound` plugins, so it's now possible to discover both audio sources
  and audio sinks on Windows via the [`GstDeviceMonitor` API][devicemonitor]

- debug log timestamps are now higher granularity owing to `g_get_monotonic_time()`
  now being used as fallback in `gst_utils_get_timestamp()`. Before that, there
  would sometimes be 10-20 lines of debug log output sporting the same timestamp.

[devicemonitor]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstDeviceMonitor.html
[wasapi-plugin]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-plugin-wasapi.html

## Contributors

Aaron Boxer, Adrián Pardini, Adrien SCH, Akinobu Mita, Alban Bedel,
Alessandro Decina, Alex Ashley, Alicia Boya García, Alistair Buxton,
Alvaro Margulis, Anders Jonsson, Andreas Frisch, Andrejs Vasiljevs,
Andrew Bott, Antoine Jacoutot, Antonio Ospite, Antoni Silvestre,
Anton Obzhirov, Anuj Jaiswal, Arjen Veenhuizen, Arnaud Bonatti, Arun Raghavan,
Ashish Kumar, Aurélien Zanelli, Ayaka, Branislav Katreniak, Branko Subasic,
Brion Vibber, Carlos Rafael Giani, Cassandra Rommel, Chris Bass,
Chris Paulson-Ellis, Christoph Reiter, Claudio Saavedra, Clemens Lang,
Cyril Lashkevich, Daniel van Vugt, Dave Craig, Dave Johnstone, David Evans,
David Schleef, Deepak Srivastava, Dimitrios Katsaros, Dmitry Zhadinets,
Dongil Park, Dustin Spicuzza, Eduard Sinelnikov, Edward Hervey, Enrico Jorns,
Eunhae Choi, Ezequiel Garcia, fengalin, Filippo Argiolas, Florent Thiéry,
Florian Zwoch, Francisco Velazquez, François Laignel, fvanzile,
George Kiagiadakis, Georg Lippitsch, Graham Leggett, Guillaume Desmottes,
Gurkirpal Singh, Gwang Yoon Hwang, Gwenole Beauchesne, Haakon Sporsheim,
Haihua Hu, Håvard Graff, Heekyoung Seo, Heinrich Fink, Holger Kaelberer,
Hoonhee Lee, Hosang Lee, Hyunjun Ko, Ian Jamison, James Stevenson,
Jan Alexander Steffens (heftig), Jan Schmidt, Jason Lin, Jens Georg,
Jeremy Hiatt, Jérôme Laheurte, Jimmy Ohn, Jochen Henneberg, John Ludwig,
John Nikolaides, Jonathan Karlsson, Josep Torra, Juan Navarro,
Juan Pablo Ugarte, Julien Isorce, Jun Xie, Jussi Kukkonen, Justin Kim,
Lasse Laursen, Lubosz Sarnecki, Luc Deschenaux, Luis de Bethencourt,
Marcin Lewandowski, Mario Alfredo Carrillo Arevalo, Mark Nauwelaerts,
Martin Kelly, Matej Knopp, Mathieu Duponchelle, Matteo Valdina,
Matt Fischer, Matthew Waters, Matthieu Bouron, Matthieu Crapet, Matt Staples,
Michael Catanzaro, Michael Olbrich, Michael Shigorin, Michael Tretter,
Michał Dębski, Michał Górny, Michele Dionisio, Miguel París, Mikhail Fludkov,
Munez, Nael Ouedraogo, Neos3452, Nicholas Panayis, Nick Kallen, Nicola Murino,
Nicolas Dechesne, Nicolas Dufresne, Nirbheek Chauhan, Ognyan Tonchev,
Ole André Vadla Ravnås, Oleksij Rempel, Olivier Crête, Omar Akkila,
Orestis Floros, Patricia Muscalu, Patrick Radizi, Paul Kim, Per-Erik Brodin,
Peter Seiderer, Philip Craig, Philippe Normand, Philippe Renon, Philipp Zabel,
Pierre Pouzol, Piotr Drąg, Ponnam Srinivas, Pratheesh Gangadhar, Raimo Järvi,
Ramprakash Jelari, Ravi Kiran K N, Reynaldo H. Verdejo Pinochet,
Rico Tzschichholz, Robert Rosengren, Roland Peffer, Руслан Ижбулатов,
Sam Hurst, Sam Thursfield, Sangkyu Park, Sanjay NM, Satya Prakash Gupta,
Scott D Phillips, Sean DuBois, Sebastian Cote, Sebastian Dröge,
Sebastian Rasmussen, Sejun Park, Sergey Borovkov, Seungha Yang, Shakin Chou,
Shinya Saito, Simon Himmelbauer, Sky Juan, Song Bing, Sreerenj Balachandran,
Stefan Kost, Stefan Popa, Stefan Sauer, Stian Selnes, Thiago Santos,
Thibault Saunier, Thijs Vermeir, Tim Allen, Tim-Philipp Müller, Ting-Wei Lan,
Tomas Rataj, Tom Bailey, Tonu Jaansoo, U. Artie Eoff, Umang Jain,
Ursula Maplehurst, VaL Doroshchuk, Vasilis Liaskovitis,
Víctor Manuel Jáquez Leal, vijay, Vincent Penquerc'h, Vineeth T M,
Vivia Nikolaidou, Wang Xin-yu (王昕宇), Wei Feng, Wim Taymans, Wonchul Lee,
Xabier Rodriguez Calvar, Xavier Claessens, XuGuangxin, Yasushi SHOJI,
Yi A Wang, Youness Alaoui,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing.

## Bugs fixed in 1.14

More than [800 bugs][bugs-fixed-in-1.14] have been fixed during
the development of 1.14.

This list does not include issues that have been cherry-picked into the
stable 1.12 branch and fixed there as well, all fixes that ended up in the
1.12 branch are also included in 1.14.

This list also does not include issues that have been fixed without a bug
report in bugzilla, so the actual number of fixes is much higher.

[bugs-fixed-in-1.14]: https://bugzilla.gnome.org/buglist.cgi?bug_status=RESOLVED&bug_status=VERIFIED&classification=Platform&limit=0&list_id=213265&order=bug_id&product=GStreamer&query_format=advanced&resolution=FIXED&target_milestone=1.12.1&target_milestone=1.12.2&target_milestone=1.12.3&target_milestone=1.12.4&target_milestone=1.13.1&target_milestone=1.13.2&target_milestone=1.13.3&target_milestone=1.13.4&target_milestone=1.13.90&target_milestone=1.13.91&target_milestone=1.14.0

## Stable 1.14 branch

After the 1.14.0 release there will be several 1.14.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.14.x bug-fix releases will be made from the git 1.14 branch,
which is a stable branch.

### 1.14.0

1.14.0 was released on 19 March 2018.

<a name="1.14.1"></a>

### 1.14.1

The first 1.14 bug-fix release (1.14.1) is scheduled to be released around
the end of March or beginning of April.

This release only contains bugfixes and it should be safe to update from 1.14.0.

## Known Issues

- The `webrtcdsp` element (which is unrelated to the newly-landed GStreamer
  webrtc support) is currently not shipped as part of the Windows binary
  packages due to a [build system issue][bug-770264].

[bug-770264]: https://bugzilla.gnome.org/show_bug.cgi?id=770264

## Schedule for 1.16

Our next major feature release will be 1.16, and 1.15 will be the unstable
development version leading up to the stable 1.16 release. The development
of 1.15/1.16 will happen in the git master branch.

The plan for the 1.16 development cycle is yet to be confirmed, but it is
expected that feature freeze will be around August 2018 followed by several
1.15 pre-releases and the new 1.16 stable release in September.

1.16 will be backwards-compatible to the stable 1.14, 1.12, 1.10, 1.8, 1.6,
1.4, 1.2 and 1.0 release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller with*
*contributions from Sebastian Dröge, Sreerenj Balachandran, Thibault Saunier*
*and Víctor Manuel Jáquez Leal.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
