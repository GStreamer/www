# GStreamer 1.16 Release Notes

GStreamer 1.16.0 was originally released on 19 April 2019.

The latest bug-fix release in the 1.16 series is [1.16.3](#1.16.3) and was
released on 21 October 2020.

1.16.3 will likely be the last release in the 1.16 release series which has
now been superseded by the [1.18 release series][1.18].

See [https://gstreamer.freedesktop.org/releases/1.16/][latest] for the latest
version of this document.

*Last updated: Tuesday 20 October 2020, 00:30 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.16/
[gitlog]: https://cgit.freedesktop.org/gstreamer/www/log/src/htdocs/releases/1.16/release-notes-1.16.md
[1.18]: https://gstreamer.freedesktop.org/releases/1.18/

## Introduction

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with many new features, bug fixes and
other improvements.

## Highlights

- GStreamer WebRTC stack gained support for [data channels][webrtc-p2p-api]
  for peer-to-peer communication based on SCTP, BUNDLE support, as well as
  support for multiple TURN servers.

- AV1 video codec support for Matroska and QuickTime/MP4 containers and more
  configuration options and supported input formats for the AOMedia AV1 encoder

- Support for Closed Captions and other Ancillary Data in video

- Support for planar (non-interleaved) raw audio

- `GstVideoAggregator`, `compositor` and OpenGL mixer elements are now in -base

- New alternate fields interlace mode where each buffer carries a single field

- WebM and Matroska ContentEncryption support in the Matroska demuxer

- new WebKit WPE-based web browser source element

- Video4Linux: HEVC encoding and decoding, JPEG encoding, and improved dmabuf import/export

- Hardware-accelerated Nvidia video decoder gained support for VP8/VP9 decoding,
  whilst the encoder gained support for H.265/HEVC encoding.

- Many improvements to the Intel Media SDK based hardware-accelerated video
  decoder and encoder plugin (`msdk`): dmabuf import/export for zero-copy
  integration with other components; VP9 decoding; 10-bit HEVC encoding; video
  post-processing (vpp) support including deinterlacing; and the video decoder
  now handles dynamic resolution changes.

- The ASS/SSA subtitle overlay renderer can now handle multiple subtitles
  that overlap in time and will show them on screen simultaneously

- The [Meson][meson] build is now feature-complete <sup>(\*)</sup> and it
  is now the recommended build system on all platforms. The Autotools build is
  scheduled to be removed in the next cycle.

- The GStreamer [Rust bindings][gst-rs] and [Rust plugins module][gst-plugins-rs]
  are now officially part of upstream GStreamer.

- The GStreamer Editing Services gained a `gesdemux` element that allows
  directly playing back serialized edit list with `playbin` or `(uri)decodebin`

- Many performance improvements

[meson]: https://mesonbuild.com
[gst-rs]: https://gitlab.freedesktop.org/gstreamer/gstreamer-rs
[gst-plugins-rs]: https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/
[webrtc-p2p-api]: https://www.w3.org/TR/webrtc/#peer-to-peer-data-api

## Major new features and changes

### Noteworthy new API

- `GstAggregator` has a new `"min-upstream-latency"` property that forces a
  minimum aggregate latency for the input branches of an aggregator. This is
  useful for dynamic pipelines where branches with a higher latency might be
  added later after the pipeline is already up and running and where a change
  in the latency would be disruptive. This only applies to the case where at
  least one of the input branches is live though, it won't force the aggregator
  into live mode in the absence of any live inputs.

- `GstBaseSink` gained a `"processing-deadline"` property and setter/getter API
  to configure a processing deadline for live pipelines. The processing deadline
  is the acceptable amount of time to process the media in a live pipeline
  before it reaches the sink. This is on top of the systemic latency that is
  normally reported by the latency query. This defaults to 20ms and should make
  pipelines such as `v4l2src ! xvimagesink` not claim that all frames are late
  in the QoS events. Ideally, this should replace the `"max-lateness"`
  property for most applications.

- RTCP Extended Reports (XR) parsing according to RFC 3611: Loss/Duplicate RLE,
  Packet Receipt Times, Receiver Reference Time, Delay since the last Receiver
  (DLRR), Statistics Summary, and VoIP Metrics reports. This only provides the
  ability to parse such packets, generation of XR packets is not supported yet
  and XR packets are not automatically parsed by `rtpbin` / `rtpsession` but
  must be actively handled by the application.

- a [new mode for interlaced video][interlace-mode-alternate] was added where
  each buffer carries a single field of interlaced video, with [buffer flags][field-flags]
  indicating whether the field is the top field or bottom field. Top and bottom
  fields are expected to alternate in this mode. Caps for this interlace mode
  must also carry a `format:Interlaced` caps feature to ensure backwards
  compatibility.

- The video library has gained support for three new [raw pixel formats][video-formats]:

   - `Y410`: packed 4:4:4 YUV, 10 bits per channel
   - `Y210`: packed 4:2:2 YUV, 10 bits per channel
   - `NV12_10LE40`: fully-packed 10-bit variant of `NV12_10LE32`, i.e. without
     the padding bits

[field-flags]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideo.html#GST-VIDEO-BUFFER-FLAG-TOP-FIELD:CAPS
[interlace-mode-alternate]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideo.html#GST-VIDEO-INTERLACE-MODE-ALTERNATE:CAPS
[video-formats]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideo.html#GstVideoFormat

- `GstRTPSourceMeta` is a new meta that can be used to transport information
  about the origin of depayloaded or decoded RTP buffers, e.g. when mixing
  audio from multiple sources into a single stream. A new `"source-info"`
  property on the RTP depayloader base class determines whether depayloaders
  should put this meta on outgoing buffers. Similarly, the same property on
  RTP payloaders determines whether they should use the information from this
  meta to construct the CSRCs list on outgoing RTP buffers.

- `gst_sdp_message_from_text()` is a convenience constructor to parse SDPs
  from a string which is particularly useful for language bindings.

#### Support for Planar (Non-Interleaved) Raw Audio

Raw audio samples are usually passed around in interleaved form in GStreamer,
which means that if there are multiple audio channels the samples for each
channel are interleaved in memory, e.g. `|LEFT|RIGHT|LEFT|RIGHT|LEFT|RIGHT|`
for stereo audio. A non-interleaved or planar arrangement in memory would
look like `|LEFT|LEFT|LEFT|RIGHT|RIGHT|RIGHT|` instead, possibly with
`|LEFT|LEFT|LEFT|` and `|RIGHT|RIGHT|RIGHT|` residing in separate memory
chunks or separated by some padding.

GStreamer has always had signalling for non-interleaved audio since version
1.0, but it was never actually properly implemented in any elements.
`audioconvert` would advertise support for it, but wasn't actually able to
handle it correctly.

With this release we now have full support for non-interleaved audio as well,
which means more efficient integration with external APIs that handle audio
this way, but also more efficient processing of certain operations like
interleaving multiple 1-channel streams into a multi-channel stream which can
be done without memory copies now.

New API to support this has been added to the [GStreamer Audio support library][GstAudio]:
There is now a new [`GstAudioMeta`][GstAudioMeta] which describes how data is
laid out inside the buffer, and buffers with non-interleaved audio must always
carry this meta. To access the non-interleaved audio samples you must map such
buffers with [`gst_audio_buffer_map()`][gst_audio_buffer_map] which works much
like `gst_buffer_map()` or `gst_video_frame_map()` in that it will populate a
little [`GstAudioBuffer`][GstAudioBuffer] helper structure passed to it with the
number of samples, the number of planes and pointers to the start of each plane
in memory. This function can also be used to map interleaved audio buffers in
which case there will be only one plane of interleaved samples.

Of course support for this has also been implemented in the various audio
helper and conversion APIs, base classes, and in elements such as `audioconvert`,
`audioresample`, `audiotestsrc`, `audiorate`.

[GstAudio]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstAudio.html
[GstAudioMeta]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstAudio-meta.html#GstAudioMeta
[GstAudioBuffer]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstAudio.html#GstAudioBuffer
[gst_audio_buffer_map]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstAudio.html#gst-audio-buffer-map

#### Support for Closed Captions and Other Ancillary Data in Video

The video support library has gained support for detecting and extracting
[Ancillary Data][anc-data] from videos as per the SMPTE S291M specification,
including:

 - a [VBI (Vertical Blanking Interval) parser][vbi-parser] that can detect and
   extract Ancillary Data from Vertical Blanking Interval lines of component
   signals. This is currently supported for videos in v210 and UYVY format.

 - a [new `GstMeta` for closed captions: `GstVideoCaptionMeta`][video-caption-meta].
   This supports the two types of closed captions, CEA-608 and CEA-708, along
   with the four different ways they can be transported (other systems are a
   superset of those).

 - a [VBI (Vertical Blanking Interval) encoder][vbi-encoder] for writing ancillary
   data to the Vertical Blanking Interval lines of component signals.

[anc-data]: https://en.wikipedia.org/wiki/Ancillary_data
[vbi-parser]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideo-Ancillary.html#GstVideoVBIParser
[vbi-encoder]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideo-Ancillary.html#GstVideoVBIEncoder
[video-caption-meta]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideo-Ancillary.html#GstVideoCaptionMeta

The new `closedcaption` plugin in `gst-plugins-bad` then makes use of all this
new infrastructure and provides the following elements:

 - `cccombiner`: a closed caption combiner that takes a closed captions stream
   and another stream and adds the closed captions as `GstVideoCaptionMeta` to
   the buffers of the other stream.

 - `ccextractor`: a closed caption extractor which will take `GstVideoCaptionMeta`
   from input buffers and output them as a separate closed captions stream.

 - `ccconverter`: a closed caption converter that can convert between different
   formats

 - `line21encoder`, `line21decoder`: inject/extract line21 closed captions to/from SD video streams

 - `cc708overlay`: decodes CEA 608/708 captions and overlays them on video

Additionally, the following elements have also gained Closed Caption support:

 - `qtdemux` and `qtmux` support CEA 608/708 Closed Caption tracks

 - `mpegvideoparse`, `h264parse` extracts Closed Captions from MPEG-2/H.264 video streams

 - `avviddec`, `avvidenc`, `x264enc` got support for extracting/injecting
   Closed Captions

 - `decklinkvideosink` can output closed captions and `decklinkvideosrc` can
    extract closed captions

 - `playbin` and `playbin3` learned how to autoplug CEA 608/708 CC overlay elements

 - the externally maintained `ajavideosrc` element for AJA capture cards has
   support for extracting closed captions

The `rsclosedcaption` plugin in the Rust plugins collection includes a
MacCaption (MCC) file parser and encoder.

### New Elements

- `overlaycomposition`: New element that allows applications to draw
  `GstVideoOverlayComposition`s on a stream. The element will emit the `"draw"`
  signal for each video buffer, and the application then generates an overlay
  for that frame (or not). This is much more performant than e.g. `cairooverlay`
  for many use cases, e.g. because pixel format conversions can be avoided or
  the blitting of the overlay can be delegated to downstream elements (such
  as `gloverlaycompositor`). It's particularly useful for cases where only a
  small section of the video frame should be drawn on.

- `gloverlaycompositor`: New OpenGL-based compositor element that flattens
  any overlays from `GstVideoOverlayCompositionMeta`s into the video stream.
  This element is also always part of `glimagesink`.

- `glalpha`: New element that adds an alpha channel to a video stream. The
  values of the alpha channel can either be set to a constant or can be
  dynamically calculated via chroma keying. It is similar to the existing
  `alpha` element but based on OpenGL. Calculations are done in floating point
  so results may not be identical to the output of the existing `alpha` element.

- `rtpfunnel` funnels together RTP streams into a single session. Use cases
  include multiplexing and bundle. `webrtcbin` uses it to implement `BUNDLE`
  support.

- `testsrcbin` is a source element that provides an audio and/or video stream
  and also announces them using the recently-introduced `GstStream` API. This
  is useful for testing elements such as `playbin3` or `uridecodebin3` etc.

- New closed caption elements: `cccombiner`, `ccextractor`, `ccconverter`,
  `line21encoder`, `line21decoder` and `cc708overlay` (see above)

- `wpesrc`: new source element acting as a Web Browser based on WebKit WPE

- Two new OpenCV-based elements: `cameracalibrate` and `cameraundistort` that
  can communicate to figure out distortion correction parameters for a camera
  and correct for the distortion.

- New `sctp` plugin based on `usrsctp` with `sctpenc` and `sctpdec` elements.
  These elements are used inside `webrtcbin` for implementing data channels.

### New element features and additions

- `playbin3`, `playbin` and `playsink` have gained a new `"text-offset"`
  property to adjust the positioning of the selected subtitle stream vis-a-vis
  the audio and video streams. This uses `subtitleoverlay`'s new
  `"subtitle-ts-offset"` property. `GstPlayer` has gained matching API for this,
  namely `gst_player_get_text_video_offset()`.

- `playbin3` buffering improvements: in network playback scenarios there may be
  multiple inputs to decodebin3, and buffering will be done before decodebin3
  using `queue2` or `downloadbuffer` elements inside `urisourcebin`. Since this
  is before any parsers or demuxers there may not be any bitrate information
  available for the various streams, so it was difficult to configure the
  buffering there smartly within global constraints. This was improved now: The
  `queue2` elements inside `urisourcebin` will now use the new bitrate query to
  figure out a bitrate estimate for the stream if no bitrate was provided by
  upstream, and `urisourcebin` will use the bitrates of the individual queues
  to distribute the globally-set `"buffer-size"` budget in bytes to the various
  queues. `urisourcebin` also gained `"low-watermark"` and `"high-watermark"`
  properties which will be proxied to the internal queues, as well as a
  read-only `"statistics"` property which allows querying of the
  minimum/maximum/average byte and time levels of the queues inside the
  `urisourcebin` in question.

- `splitmuxsink` has gained a couple of new features:

  - new `"async-finalize"` mode: This mode is useful for muxers or outputs
    that can take a long time to finalize a file. Instead of blocking the
    whole upstream pipeline while the muxer is doing its stuff, we can unlink
    it and spawn a new muxer + sink combination to continue running normally.
    This requires us to receive the muxer and sink (if needed) as factories
    via the new `"muxer-factory"` and `"sink-factory"` properties, optionally
    accompanied by their respective properties structures (set via the new
    `"muxer-properties"` and `"sink-properties"` properties). There are also
    new `"muxer-added"` and `"sink-added"` signals in case custom code has to
    be called for them to configure them.

  - `"split-at-running-time"` action signal: When called by the user, this
    action signal ends the current file (and starts a new one) as soon as the
    given running time is reached. If called multiple times, running times are
    queued up and processed in the order they were given.

  - `"split-after"` action signal to finish outputting the current GOP to the
    current file and then start a new file as soon as the GOP is finished and
    a new GOP is opened (unlike the existing `"split-now"` which immediately
    finishes the current file and writes the current GOP into the next
    newly-started file).

  - `"reset-muxer"` property: when unset, the muxer is reset using flush events
    instead of setting its state to `NULL` and back. This means the muxer can
    keep state across resets, e.g. `mpegtsmux` will keep the continuity counter
    continuous across segments as required by `hlssink2`.

- `qtdemux` gained PIFF track encryption box support in addition to the
  already-existing PIFF sample encryption support, and also allows applications
  to select which encryption system to use via a `"drm-preferred-decryption-system-id"`
  context in case there are multiple options.

- `qtmux`: the `"start-gap-threshold"` property determines now whether an edit
  list will be created to account for small gaps or offsets at the beginning
  of a stream in case the start timestamps of tracks don't line up perfectly.
  Previously the threshold was hard-coded to 1% of the (video) frame duration,
  now it is 0 by default (so edit list will be created even for small
  differences), but fully configurable.

- `rtpjitterbuffer` has improved end-of-stream handling

- `rtpmp4vpay` will be preferred over `rtpmp4gpay` for MPEG-4 video in
  autoplugging scenarios now

- `rtspsrc` now allows applications to send RTSP `SET_PARAMETER` and
  `GET_PARAMETER` requests using action signals.

- `rtspsrc` has a small (100ms) configurable teardown delay by default to
  try and make sure an RTSP `TEARDOWN` request gets sent out when the source
  element shuts down. This will block the downward PAUSED to READY state change
  for a short time, but can be disabled where it's a problem. Some servers only
  allow a limited number of concurrent clients, so if no proper `TEARDOWN` is
  sent new clients may have problems connecting to the server for a while.

- `souphttpsrc` behaves better with low bitrate streams now. Before it would
  increase the read block size too quickly which could lead to it not reading
  any data from the socket for a very long time with low bitrate streams that
  are output live downstream. This could lead to servers kicking off the client.

- `filesink`: do internal buffering to avoid performance regression with small
  writes since we bypass libc buffering by using `writev()` instead of
  `fwrite()`

- `identity`: add `"eos-after"` property and fix `"error-after"` property when
  the element is reused

- `input-selector`: lets context queries pass through, so that e.g. upstream
  OpenGL elements can use contexts and displays advertised by downstream elements

- `queue2`: avoid ping-pong between 0% and 100% buffering messages if upstream is
  pushing buffers larger than one of its limits, plus performance optimisations

- `opusdec`: new `"phase-inversion"` property to control phase inversion. When
   enabled, this will slightly increase stereo quality, but produces a stream
   that when downmixed to mono will suffer audio distortions.

- The `x265enc` HEVC encoder also exposes a `"key-int-max"` property to
  configure the maximum allowed GOP size now.

- `decklinkvideosink` has seen stability improvements for long-running
  pipelines (potential crash due to overflow of leaked clock refcount) and
  clock-slaving improvements when performing flushing seeks (causing stalls
  in the output timeline), pausing and/or buffering.

- `srtpdec`, `srtpenc`: add support for MKIs which allow multiple keys
  to be used with a single SRTP stream

- `srtpdec`, `srtpenc`: add support for AES-GCM and also add support for it in
  `gst-rtsp-server` and `rtspsrc`.

- The `srt` Secure Reliable Transport plugin has integrated server and client
  elements `srt{client,server}{src,sink}` into one (`srtsrc` and `srtsink`),
  since SRT connection mode can be changed by uri parameters.

- `h264parse` and `h265parse` will handle SEI recovery point messages and
  mark recovery points as keyframes as well (in addition to IDR frames)

- `webrtcbin`: `"add-turn-server"` action signal to pass multiple ICE relays
  (TURN servers).

- The `removesilence` element has received various new features and properties,
  such as a `"threshold"` property, detecting silence only after minimum
  silence time/buffers, a `"silent"` property to control bus message
  notifications as well as a `"squash"` property.

- AOMedia AV1 decoder gained support for 10/12bit decoding whilst the
  AV1 encoder supports more image formats and subsamplings now and acquired
  support for rate control and profile related configuration.

- The Fraunhofer `fdkaac` plugin can now be built against the 2.0.0 version API
  and has improved multichannel support

- `kmssink` now supports unpadded 24-bit RGB and can configure mode setting
  from video info, which enables display of multi-planar formats such as I420
  or NV12 with modesetting. It has also gained a number of new properties:
  The `"restore-crtc"` property does what it says on the tin and is enabled by
  default. `"plane-properties"` and `"connector-properties"` can be used to
  pass custom properties to the DRM.

- `waylandsink` has a `"fullscreen"` property now and supports the XDG-Shell
  protocol.

- `decklinkvideosink`, `decklinkvideosrc` support selecting between half/full
  duplex

- The `vulkan` plugin gained support for macOS and iOS via [`MoltenVK`][moltenvk]
  in addition to the existing support for X11 and Wayland

- `imagefreeze` has a new `num-buffers` property to limit the number of
  buffers that are produced and to send an EOS event afterwards

- `webrtcbin` has a new, introspectable `get-transceiver` signal in addition
  to the old `get-transceivers` signal that couldn't be used from bindings

- Support for per-element latency information was added to the latency tracer

[moltenvk]: https://github.com/KhronosGroup/MoltenVK

### Plugin and library moves

- The `stereo` element was moved from -bad into the existing `audiofx` plugin
  in -good. If you get duplicate type registration warnings when upgrading,
  check that you don't have a stale `stereo`plugin lying about somewhere.

#### GstVideoAggregator, `compositor`, and OpenGL mixer elements moved from -bad to -base

[`GstVideoAggregator`][videoaggregator] is a new base class for raw video mixers
and muxers and is based on [`GstAggregator`][aggregator]. It provides
defined-latency mixing of raw video inputs and ensures that the pipeline won't
stall even if one of the input streams stops producing data.

As part of the move to stabilise the API there were some last-minute API
changes and clean-ups, but those should mostly affect internal elements. Most
notably, the `"ignore-eos"` pad property was renamed to `"repeat-after-eos"`
and the conversion code was moved to a `GstVideoAggregatorConvertPad` subclass
to avoid code duplication, make things less awkward for subclasses like the
OpenGL-based video mixer, and make the API more consistent with the audio
aggregator API.

It is used by the [`compositor`][compositor] element, which is a replacement
for 'videomixer' which did not handle live inputs very well. [`compositor`][compositor]
should behave much better in that respect and generally behave as one would
expected in most scenarios.

The compositor element has gained support for per-pad blending mode operators
(`SOURCE`, `OVER`, `ADD`) which determines what operator to use for blending
this pad over the previous ones. This can be used to implement crossfading and
the available operators can be extended in the future as needed.

A number of OpenGL-based video mixer elements (`glvideomixer`, `glmixerbin`,
`glvideomixerelement`, `glstereomix`, `glmosaic`) which are built on top of
`GstVideoAggregator` have also been moved from -bad to -base now. These
elements have been merged into the existing OpenGL plugin, so if you get
duplicate type registration warnings when upgrading, check that you don't have
a stale `openglmixers` plugin lying about somewhere.

[videoaggregator]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/GstVideoAggregator.html
[aggregator]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-libs/html/GstAggregator.html
[compositor]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-plugins/html/gst-plugins-base-plugins-compositor.html

### Plugin removals

The following plugins have been removed from `gst-plugins-bad`:

- The experimental `daala` plugin has been removed, since it's not so useful
  now that all effort is focused on AV1 instead, and it had to be enabled
  explicitly with `--enable-experimental` anyway.

- The `spc` plugin has been removed. It has been replaced by the `gme` plugin.

- The `acmmp3dec` and `acmenc` plugins for Windows have been removed. ACM is
  an ancient legacy API and there was no point in keeping the plugins around for a
  licensed MP3 decoder now that the MP3 patents have expired and we have a decoder
  in -good. We also didn't ship these in our cerbero-built Windows packages,
  so it's unlikely that they'll be missed.

## Miscellaneous API additions

- `GstBitwriter`: new generic bit writer API to complement the existing bit reader

- `gst_buffer_new_wrapped_bytes()` creates a wrap buffer from a `GBytes`

- `gst_caps_set_features_simple()` sets a caps feature on all the structures
   of a `GstCaps`

- New `GST_QUERY_BITRATE` query: This allows determining from downstream what
  the expected bitrate of a stream may be which is useful in `queue2` for
  setting time based limits when upstream does not provide timing information.
  `tsdemux`, `qtdemux` and `matroskademux` have basic support for this query on
  their sink pads.

- elements: there is a new "Hardware" class specifier. Elements interacting
  with hardware devices should specify this classifier in their element factory
  class metadata. This is useful to advertise as one might need to put such
  elements into `READY` state to test if the hardware is present in the system
  for example.

- protection: Add a new definition for unspecified system protection,
  `GST_PROTECTION_UNSPECIFIED_SYSTEM_ID`

- take functions for various mini objects that didn't have them yet:
  `gst_query_take()`, `gst_message_take()`,  `gst_tag_list_take()`,
  `gst_buffer_list_take()`. Unlike the various `_replace()` functions `_take()`
  does not increase the reference count but takes ownership of the mini object
  passed.

- clear functions for various mini object types and `GstObject` which unrefs
  the object or mini object (if non-`NULL`) and sets the variable pointed to to
  `NULL`: `gst_clear_structure()`, `gst_clear_tag_list()`, `gst_clear_query()`,
  `gst_clear_message()`, `gst_clear_event()`, `gst_clear_caps()`,
  `gst_clear_buffer_list()`, `gst_clear_buffer()`, `gst_clear_mini_object()`,
  `gst_clear_object()`

- miniobject: new API `gst_mini_object_add_parent()` and `gst_mini_object_remove_parent()`
  to set parent pointers on mini objects to ensure correct writability: Every
  container of miniobjects now needs to store itself as parent in the child
  object, and remove itself again later. A mini object is then only writable if
  there is at most one parent, that parent is writable itself, and the reference
  count of the mini object is 1. `GstBuffer` (for memories), `GstBufferList` (for buffers),
  `GstSample` (for caps, buffer, bufferlist), and `GstVideoOverlayComposition`
  were updated accordingly. Without this it was possible to have e.g. a buffer
  list with a refcount of 2 used in two places at once that both modify the
  same buffer with refcount 1 at the same time wrongly thinking it is writable
  even though it's really not.

- poll: add API to watch for `POLLPRI` and stop treating `POLLPRI` as a read.
  This is useful to wait for video4linux events which are signalled via `POLLPRI`.

- sample: new API to update the contents of a `GstSample` and make it writable:
  `gst_sample_set_buffer()`, `gst_sample_set_caps()`, `gst_sample_set_segment()`,
  `gst_sample_set_info()`, plus `gst_sample_is_writable()` and `gst_sample_make_writable()`.
  This makes it possible to reuse a sample object and avoid unnecessary memory
  allocations, for example in appsink.

- `ClockIDs` now keep a weak reference to underlying clock to avoid crashes in
  `basesink` in corner cases where a clock goes away while the `ClockID` is still
  in use, plus some new API (`gst_clock_id_get_clock()`, `gst_clock_id_uses_clock()`)
  to check the clock a ClockID is linked to.

- The `GstCheck` unit test library gained a `fail_unless_equals_clocktime()`
  convenience macro as well as some new `GstHarness` API for for proposing
  meta APIs from the allocation query: `gst_harness_add_propose_allocation_meta()`.
  `ASSERT_CRITICAL()` checks in unit tests are now skipped if GStreamer was
  compiled with `GST_DISABLE_GLIB_CHECKS`.

- `gst_audio_buffer_truncate()` convenience function to truncate a raw audio buffer

- `GstDiscoverer` has support for caching the results of discovery in the
  default cache directory. This can be enabled with the `use-cache` property
  and is disabled by default.

- `GstMeta` that are attached to `GstBuffer`s are now always stored in the
  order in which they were added.

- Additional support for signalling ONVIF specific features were added: the
  `SEEK` event can store a `trickmode-interval` now and support for the
  `Rate-Control` and `Frames` RTSP headers was added to the RTSP library.

## Miscellaneous performance and memory optimisations

As always there have been many performance and memory usage improvements
across all components and modules. Some of them (such as `dmabuf` import/export)
have already been mentioned elsewhere so won't be repeated here.

The following list is only a small snapshot of some of the more interesting
optimisations that haven't been mentioned in other contexts yet:

- The `GstVideoEncoder` and `GstVideoDecoder` base classes now release the
  `STREAM_LOCK` when pushing out buffers, which means (multi-threaded) encoders
  and decoders can now receive and continue to process input buffers whilst
  waiting for downstream elements in the pipeline to process the buffer that
  was pushed out. This increases throughput and reduces processing latency,
  also and especially for hardware-accelerated encoder/decoder elements.

- `GstQueueArray` has seen a few API additions (`gst_queue_array_peek_nth()`,
  `gst_queue_array_set_clear_func()`, `gst_queue_array_clear()`) so that it
  can be used in other places like `GstAdapter` instead of a `GList`, which
  reduces allocations and improves performance.

- `appsink` now reuses the sample object in `pull_sample()` if possible

- `rtpsession` only starts the RTCP thread when it's actually needed now

- `udpsrc` uses a buffer pool now and the `GstUdpSrc` object structure was
  optimised for better cache performance

### GstPlayer

- API was added to fine-tune the synchronisation offset between subtitles and video

## Miscellaneous changes

- As a result of moving to newer FFmpeg APIs, encoder and decoder elements
  exposed by the [GStreamer FFmpeg wrapper plugin (`gst-libav`)][gst-libav]
  may have seen possibly incompatible changes to property names and/or types,
  and not all properties exposed might be functional. We are still reviewing
  the new properties and aim to minimise breaking changes at least for the most
  commonly-used properties, so please report any issues you run into!

### OpenGL integration

- The OpenGL mixer elements have been moved from -bad to `gst-plugins-base`
  (see above)

- The Mesa GBM backend now supports headless mode

- `gloverlaycompositor`: New OpenGL-based compositor element that flattens
  any overlays from `GstVideoOverlayCompositionMeta`s into the video stream.

- `glalpha`: New element that adds an alpha channel to a video stream. The
  values of the alpha channel can either be set to a constant or can be
  dynamically calculated via chroma keying. It is similar to the existing
  `alpha` element but based on OpenGL. Calculations are done in floating point
  so results may not be identical to the output of the existing `alpha` element.

- `glupload`: Implement direct dmabuf uploader, the idea being that some GPUs
   (like the Vivante series) can actually perform the YUV->RGB conversion
   internally, so no custom conversion shaders are needed. To make use of this
   feature, we need an additional uploader that can import DMABUF FDs and also
   directly pass the pixel format, relying on the GPU to do the conversion.

- The OpenGL library no longer restores the OpenGL viewport.  This is a
  performance optimization to not require performing multiple expensive
  `glGet*()` function calls per frame.  This affects any application or plugin
  use of the following functions and objects:
  - `glcolorconvert` library object (not the element)
  - `glviewconvert` library object (not the element)
  - `gst_gl_framebuffer_draw_to_texture()`
  - custom `GstGLWindow` implementations

## Tracing framework and debugging improvements

- There is now a **gdb pretty printer for various GStreamer types**:
  For `GstObject` pointers the type and name is added, e.g.
  `0x5555557e4110 [GstDecodeBin|decodebin0]`. For `GstMiniObject` pointers the
  object type is added, e.g. `0x7fffe001fc50 [GstBuffer]`. For `GstClockTime`
  and `GstClockTimeDiff` the time is also printed in human readable form,
  e.g. `150116219955 [+0:02:30.116219955]`.

- **gdb extension with two custom gdb commands `gst-dot` and `gst-print`:**

  - `gst-dot` creates dot files that a very close to what
    `GST_DEBUG_BIN_TO_DOT_FILE()` produces, but object properties and
    buffer contents such as codec-data in caps are not available.

  - `gst-print` produces high-level information about a GStreamer object. This
    is currently limited to pads for GstElements and events for the pads. The
    output may look like this:
    <br/><img src="gdb-gst-print.png" alt="gst-print example" style="width:80%;"/>

- `gst_structure_to_string()` now serialises the actual value of pointers when
  serialising `GstStructure`s instead of claiming they're `NULL`. This makes
  debug logging in various places less confusing, because it's clear now that
  structure fields actually hold valid objects. Such object pointer values will
  never be deserialised however.

## Tools

- `gst-inspect-1.0` has coloured output now and will automatically use a pager
  if the output does not fit on a page. This only works in a UNIX environment
  and if the output is not piped, and on Windows 10 build 16257 or newer.
  If you don't like the colours you can disable them by setting the
  `GST_INSPECT_NO_COLORS=1` environment variable or passing the `--no-color`
  command line option.

## GStreamer RTSP server

- Improved backlog handling when using TCP interleaved for data transport.
  Before there was a fixed maximum size for backlog messages, which was prone
  to deadlocks and made it difficult to control memory usage with the watch
  backlog. The RTSP server now limits queued TCP data messages to one per
  stream, moving queuing of the data into the pipeline and leaving the RTSP
  connection responsive to RTSP messages in both directions, preventing all
  those problems.

- Initial ULP Forward Error Correction support in `rtspclientsink` and
  for `RECORD` mode in the server.

- API to explicitly enable retransmission requests (RTX)

- Lots of multicast-related fixes

- rtsp-auth: Add support for parsing .htdigest files

## GStreamer VAAPI

- Support Wayland's display for context sharing, so the application
  can pass its own `wl_display` in order to be used for the VAAPI
  display creation.

- A lot of work to support new Intel hardware using
  [media-driver](https://github.com/intel/media-driver) as VA backend.

- For non-x86 devices, VAAPI display can instantiate, through DRM,
  with no PCI bus. This enables the usage of
  [libva-v4l2-request](https://github.com/bootlin/libva-v4l2-request)
  driver.

- Added support for XDG-shell protocol as wl_shell replacement which
  is currently deprecated. This change add as dependency
  `wayland-protocol`.

- `GstVaapiFilter`, `GstVaapiWindow`, and `GstVaapiDecoder` classes
  now inherit from GstObject, gaining all the GStreamer's
  instrumentation support.

- The metadata now specifies the plugin as `Hardware` class.

- H264 decoder is more stable with problematic streams.

- In H265 decoder added support for profiles `main-422-10`
  (`P010_10LE`), `main-444` (`AYUV`) and `main-444-10` (`Y410`)

- JPEG decoder handles dynamic resolution changes.

- More specification adherence in H264 and H265 encoders.

## GStreamer OMX

- Add support of NV16 format to video encoders input.

- Video decoders now handle the `ALLOCATION` query to tell upstream about the
  number of buffers they require. Video encoders will also use this query to
  adjust their number of allocated buffers preventing starvation when
  using dynamic buffer mode.

- The `OMX_PERFORMANCE` debug category has been renamed to `OMX_API_TRACE`
  and can now be used to track a widder variety of interactions between OMX
  and GStreamer.

- Video encoders will now detect frame rate only changes and will inform
  OMX about it rather than doing a full format reset.

- Various Zynq UltraScale+ specific improvements:
  - Video encoders are now able to import dmabuf from upstream.
  - Support for HEVC range extension profiles and more AVC profiles.
  - We can now request video encoders to generate an IDR using the force
    key unit event.

## GStreamer Editing Services and NLE

- Added a `gesdemux` element, it is an auto pluggable element that allows
  decoding edit list like files supported by GES

- Added `gessrc` which wraps a `GESTimeline` as a standard source
  element (implementing the `ges` protocol handler)

- Added basic support for `videorate::rate` property potentially allowing
  changing playback speed

- Layer priority is now fully automatic and they should be moved with the new
  `ges_timeline_move_layer` method, `ges_layer_set_priority` is now deprecated.

- Added a `ges_timeline_element_get_layer_priority` so we can simply get all
  information about `GESTimelineElement` position in the timeline

- `GESVideoSource` now auto orientates the images if it is defined in a meta
  (overridable).

- Added some PyGObject overrides to make the API more pythonic

- The threading model has been made more explicit with safe guard to make sure
  not thread safe APIs are not used from the wrong threads. It is also now
  possible to properly handle in what thread the API should be used.

- Optimized `GESClip` and `GESTrackElement` creation

- Added a way to compile out the old, unused and deprecated `GESPitiviFormatter`

- Re implemented the timeline editing API making it faster and making the code much more
  maintainable

- Simplified usage of `nlecomposition` outside GES by removing quirks in it API
  usage and removing the need to treat it specially from an application
  perspective.

- `ges-launch-1.0`:

  - Added support to add titles to the timeline
  - Enhance the `help` auto generating it from the code

- Deprecate `ges_timeline_load_from_uri` as loading the timeline should be done
  through a project now

- **Many** leaks have been plugged and the unit testsuite is now "leak free"

## GStreamer validate

- Added an action type to verify the checksum of the sink `last-sample`

- Added an `include` keyword to validate scenarios

- Added the notion of `variable` in scenarios, with the `set-vars` keyword

- Started adding support for "performance" like tests by allowing to define the
  number of dropped buffers or the minimum buffer frequency on a specific pad

- Added a `validateflow` plugin which allows defining the data flow to be seen
  on a particular pad and verifying that following runs match the expectations

- Added support for `appsrc` based test definition so we can instrument
  the data pushed into the pipeline from scenarios

- Added a `mockdecryptor` allowing adding tests with on encrypted files, the element
  will potentially be instrumented with a validate scenario

- `gst-validate-launcher`:

  - Cleaned up output

  - Changed the default for "muting" tests as user doesn't expect hundreds of
    windows to show up when running the testsuite

  - Fixed the outputted xunit files to be compatible with GitLab

  - Added support to run tests on media files in push mode (using `pushfile://`)

  - Added support for running inside `gst-build`

  - Added support for running ssim tests on rendered files

  - Added a way to simply define tests on pipelines through a simple `.json`
    file

  - Added a `python` app to easily run python testsuite reusing all the launcher
    features

  - Added `flatpak` knowledge so we can print backtrace even when running from
    within flatpak

  - Added a way to automatically generated "known issues" suppressions lines

  - Added a way to rerun tests to check if they are flaky and added a way to
    tolerate tests known to be flaky

  - Add a way to output html log files

## GStreamer Python Bindings

- add binding for `gst_pad_set_caps()`

- `pygobject` dependency requirement was bumped to >= 3.8

- new `audiotestsrc`, `audioplot`, and `mixer` plugin examples, and a dynamic pipeline example

## GStreamer C# Bindings

- bindings for the `GstWebRTC` library

## GStreamer Rust Bindings

The GStreamer Rust bindings are now officially part of the GStreamer
project and are also maintained in the GStreamer GitLab.

The releases will generally not be synchronized with the releases of
other GStreamer parts due to dependencies on other projects.

Also unlike the other GStreamer libraries, the bindings will not
commit to full API stability but instead will follow the approach that
is generally taken by Rust projects, e.g.:

  1) 0.12.X will be completely API compatible with all other 0.12.Y
     versions.
  2) 0.12.X+1 will contain bugfixes and compatible new feature
     additions.
  3) 0.13.0 will *not* be backwards compatible with 0.12.X but projects
     will be able to stay at 0.12.X without any problems as long as
     they don't need newer features.

The current stable release is 0.12.2 and the next release series will
be 0.13, probably around March 2019.

At this point the bindings cover most of GStreamer core (except for
most notably `GstAllocator` and `GstMemory`), and most parts of the
app, audio, base, check, editing-services, gl, net. pbutils, player,
rtsp, rtsp-server, sdp, video and webrtc libraries.

Also included is support for creating subclasses of the following types
and writing GStreamer plugins:

- `gst::Element`
- `gst::Bin` and `gst::Pipeline`
- `gst::URIHandler` and `gst::ChildProxy`
- `gst::Pad`, `gst::GhostPad`
- `gst_base::Aggregator` and `gst_base::AggregatorPad`
- `gst_base::BaseSrc` and `gst_base::BaseSink`
- `gst_base::BaseTransform`

### Changes to 0.12.X since 0.12.0

#### Fixed

- PTP clock constructor actually creates a PTP instead of NTP clock

#### Added

- Bindings for GStreamer Editing Services
- Bindings for GStreamer Check testing library
- Bindings for the encoding profile API (encodebin)

- `VideoFrame`, `VideoInfo`, `AudioInfo`, `StructureRef` implements Send and Sync now
- `VideoFrame` has a function to get the raw FFI pointer
- From impls from the `Error`/`Success` enums to the combined enums like
  `FlowReturn`
- Bin-to-dot file functions were added to the Bin trait
- `gst_base::Adapter` implements `SendUnique` now
- More complete bindings for the `gst_video::VideoOverlay` interface, especially
  `gst_video::is_video_overlay_prepare_window_handle_message()`

#### Changed

- All references were updated from GitHub to freedesktop.org GitLab
- Fix various links in the README.md
- Link to the correct location for the documentation
- Remove GitLab badge as that only works with gitlab.com currently

### Changes in git master for 0.13

#### Fixed

- `gst::tag::Album` is the album tag now instead of artist sortname

#### Added

- Subclassing infrastructure was moved directly into the bindings,
  making the `gst-plugin` crate deprecated. This involves many API
  changes but generally cleans up code and makes it more flexible.
  Take a look at the `gst-plugins-rs` crate for various examples.

- Bindings for `CapsFeatures` and `Meta`
- Bindings for `ParentBufferMeta, `VideoMeta` and `VideoOverlayCompositionMeta`
- Bindings for `VideoOverlayComposition` and `VideoOverlayRectangle`
- Bindings for `VideoTimeCode`

- `UniqueFlowCombiner` and `UniqueAdapter` wrappers that make use of
  the Rust compile-time mutability checks and expose more API in a safe
  way, and as a side-effect implement `Sync` and `Send` now

- More complete bindings for `Allocation` `Query`
- `pbutils` functions for codec descriptions
- `TagList::iter()` for iterating over all tags while getting a single
   value per tag. The old `::iter_tag_list()` function was renamed to
   `::iter_generic()` and still provides access to each value for a tag
- `Bus::iter()` and `Bus::iter_timed()` iterators around the
  corresponding `::pop\*()` functions

- serde serialization of `Value` can also handle `Buffer` now

- Extensive comments to all examples with explanations
- Transmuxing example showing how to use `typefind`, `multiqueue` and
  dynamic pads
- basic-tutorial-12 was ported and added

#### Changed

- Rust 1.31 is the minimum supported Rust version now
- Update to latest gir code generator and glib bindings

- Functions returning e.g. `gst::FlowReturn` or other "combined" enums
  were changed to return split enums like `Result<gst::FlowSuccess,
  gst::FlowError>` to allow usage of the standard Rust error handling.

- `MiniObject` subclasses are now newtype wrappers around the
   underlying `GstRc<FooRef>` wrapper. This does not change the
   API in any breaking way for the current usages, but allows
   `MiniObject`s to also be implemented in other crates and
   makes sure `rustdoc` places the documentation in the right places.

- `BinExt` extension trait was renamed to `GstBinExt` to prevent
  conflicts with `gtk::Bin` if both are imported

- `Buffer::from_slice()` can't possible return `None`

- Various `clippy` warnings

## GStreamer Rust Plugins

Like the GStreamer Rust bindings, the Rust plugins are now officially part
of the GStreamer project and are also maintained in the GStreamer GitLab.

In the 0.3.x versions this contained infrastructure for writing GStreamer
plugins in Rust, and a set of plugins.

In git master that infrastructure was moved to the GLib and GStreamer
bindings directly, together with many other improvements that were made
possible by this, so the [`gst-plugins-rs`][gst-plugins-rs] repository only
contains GStreamer elements now.

Elements included are:

- Tutorials plugin: `identity`, `rgb2gray` and `sinesrc` with extensive comments

- `rsaudioecho`, a port of the `audiofx` element

- `rsfilesrc`, `rsfilesink`

- `rsflvdemux`, a FLV demuxer. Not feature-equivalent with `flvdemux` yet

- `threadshare` plugin: `ts-appsrc`, `ts-proxysrc/sink`, `ts-queue`,
  `ts-udpsrc` and `ts-tcpclientsrc` elements that use a fixed number of
  threads and share them between instances. For more background about these
  elements see [Sebastian's talk "When adding more threads adds more problems -
  Thread-sharing between elements in GStreamer"][thread-sharing-talk] at the
  GStreamer Conference 2017.

- `rshttpsrc`, a HTTP source around the `hyper`/`reqwest` Rust libraries.
  Not feature-equivalent with `souphttpsrc` yet.

- `togglerecord`, an element that allows to start/stop recording at any
  time and keeps all audio/video streams in sync.

- `mccparse` and `mccenc`, parsers and encoders for the MCC closed caption
  file format.

[thread-sharing-talk]: https://gstconf.ubicast.tv/videos/when-adding-more-threads-adds-more-problems-thread-sharing-between-elements-in-gstreamer/

### Changes to 0.3.X since 0.3.0

- All references were updated from GitHub to freedesktop.org GitLab
- Fix various links in the README.md
- Link to the correct location for the documentation

### Changes in git master for 0.4

- `togglerecord`: Switch to `parking_lot` crate for mutexes/condition
  variables for lower overhead
- Merge `threadshare` plugin here
- New `closedcaption` plugin with `mccparse` and `mccenc` elements
- New `identity` element for the `tutorials` plugin

- Register plugins statically in tests instead of relying on the plugin
  loader to find the shared library in a specific place

- Update to the latest API changes in the GLib and GStreamer bindings
- Update to the latest versions of all crates

## Build and Dependencies

- The **[Meson build system][meson] build is now feature-complete** <sup>(\*)</sup>
  and it is now the recommended build system on all platforms and also used by
  Cerbero to build GStreamer on all platforms. The Autotools build is scheduled
  to be removed in the next cycle. Developers who currently use `gst-uninstalled`
  should move to [`gst-build`](https://gitlab.freedesktop.org/gstreamer/gst-build).
  The build option naming has been cleaned up and made consistent and there are
  now feature options to enable/disable plugins and various other features on
  a case-by-case basis. <sup>(\*) with the exception of plugin docs which will
  be handled differently in future</sup>

- Symbol export in libraries is now controlled via explicit exports using
  symbol visibility or export defines where supported, to ensure consistency
  across all platforms. This also allows libraries to have exports that vary
  based on detected platform features and configure options as is the case with
  the GStreamer OpenGL integration library for example. A few symbols that had
  been exported by accident in earlier versions may no longer be exported. These
  symbols will not have had declarations in any public header files then though
  and would not have been usable.

- The [GStreamer FFmpeg wrapper plugin (`gst-libav`)][gst-libav] now
  depends on FFmpeg 4.x and uses the new FFmpeg 4.x API and stopped
  relying on ancient API that was removed with the FFmpeg 4.x release. This
  means that it is no longer possible to build this module against an older
  system-provided FFmpeg 3.x version. Use the internal FFmpeg 4.x copy instead
  if you build using autotools, or use gst-libav 1.14.x instead which targets
  the FFmpeg 3.x API and *should* work fine in combination with a newer GStreamer.
  It's difficult for us to support both old and new FFmpeg APIs at the same time,
  apologies for any inconvenience caused.

[gst-libav]: https://gitlab.freedesktop.org/gstreamer/gst-libav/

- Hardware-accelerated Nvidia video encoder/decoder plugins `nvdec` and `nvenc`
  can be built against CUDA Toolkit versions 9 and 10.0 now. The dynlink
  interface has been dropped since it's deprecated in 10.0.

- The (optional) OpenCV requirement has been bumped to >= 3.0.0 and the
  plugin can also be built against OpenCV 4.x now.

- New `sctp` plugin based on [`usrsctp`][usrsctp] (for WebRTC data channels)

[usrsctp]: https://github.com/sctplab/usrsctp

### Cerbero

Cerbero is a meta build system used to build GStreamer plus dependencies on
platforms where dependencies are not readily available, such as Windows,
Android, iOS and macOS.

Cerbero has seen a number of improvements:

- Cerbero has been ported to Python 3 and requires Python 3.5 or newer now

- Source tarballs are now protected by checksums in the recipes to guard
  against download errors and malicious takeover of projects or websites.
  In addition, downloads are only allowed via secure transports now and plain
  HTTP, FTP and git:// transports are not allowed anymore.

- There is now a new `fetch-bootstrap` command which downloads sources required
  for bootstrapping, with an optional `--build-tools-only` argument to match
  the `bootstrap --build-tools-only` command.

- The `bootstrap`, `build`, `package` and `bundle-source` commands gained a new
  `--offline` switch that ensures that only sources from the cache are used and
  never downloaded via the network. This is useful in combination with the `fetch`
  and `fetch-bootstrap` commands that acquire sources ahead of time before any
  build steps are executed. This allows more control over the sources used and
  when sources are updated, and is particularly useful for build environments
  that don't have network access.

- `bootstrap --assume-yes` will automatically say 'yes' to any interactive
  prompts during the bootstrap stage, such as those from `apt-get` or `yum`.

- `bootstrap --system-only` will only bootstrap the system without build tools.

- Manifest support: The build manifest can be used in continuous integration (CI)
  systems to fixate the Git revision of certain projects so that all builds of a
  pipeline are on the same reference. This is used in GStreamer's gitlab CI for
  example. It can also be used in order to re-produce a specific build. To set
  a manifest, you can set `manifest = 'my_manifest.xml'` in your configuration
  file, or use the `--manifest` command line option. The command line option
  will take precedence over anything specific in the configuration file.

- The new `build-deps` command can be used to build only the dependencies of
  a recipe, without the recipe itself.

- new `--list-variants` command to list available variants

- variants can now be set on the command line via the `-v` option as a
  comma-separated list. This overrides any variants set in any configuration
  files.

- new `qt5`, `intelmsdk` and `nvidia` variants for enabling Qt5 and
  hardware codec support. See the [Enabling Optional Features with Variants][cerbero-variants]
  section in the Cerbero documentation for more details how to enable and use
  these variants.

- When building on Windows, Cerbero can now build GStreamer recipes and core
  dependencies such as glib with Visual Studio. This is controlled by the
  `visualstudio` variant. Visual Studio 2015, 2017, and 2019 are supported.
  Currently, only 64-bit x86 is supported due to a [known bug][x86-vs-def]
  which will be fixed for the next release.

- A new `-t` / `--timestamp` command line switch makes commands print timestamps

[cerbero-variants]: https://gitlab.freedesktop.org/gstreamer/cerbero#enabling-optional-features-with-variants
[x86-vs-def]: https://gitlab.freedesktop.org/gstreamer/cerbero/issues/124

## Platform-specific changes and improvements

### Android

- toolchain: update compiler to clang and NDKr18. NDK r18 removed the armv5
  target and only has Android platforms that target at least armv7 so the
  armv5 target is not useful anymore.

- The way that GIO modules are named has changed due to upstream GLib natively
  adding support for loading static GIO modules. This means that any GStreamer
  application using gnutls for SSL/TLS on the Android or iOS platforms (or any
  other setup using static libraries) will fail to link looking for the
  `g_io_module_gnutls_load_static()` function. The new function name is now
  `g_io_gnutls_load(gpointer data)`. data can be NULL for a static library.
  Look at [this commit][gio-gnutls-static-link-example] for the necessary
  change in the examples.

- various build issues on Android have been fixed.

### macOS and iOS

- various build issues on iOS have been fixed.

- the minimum required iOS version is now 9.0. The difference in adoption
  between 8.0 and 9.0 is 0.1% and the bump to 9.0 fixes some build issues.

- The way that GIO modules are named has changed due to upstream GLib natively
  adding support for loading static GIO modules. This means that any GStreamer
  application using gnutls for SSL/TLS on the Android or iOS platforms (or any
  other setup using static libraries) will fail to link looking for the
  `g_io_module_gnutls_load_static()` function. The new function name is now
  `g_io_gnutls_load(gpointer data)`. data can be NULL for a static library.
  Look at [this commit][gio-gnutls-static-link-example] for the necessary
  change in the examples.

[gio-gnutls-static-link-example]: insert gst-examples/tutorial commit (FIXME)

### Windows

- The `webrtcdsp` element is shipped again as part of the Windows
  binary packages, the build system issue [has been resolved][bug-webrtcdsp].

- 'Inconsistent DLL linkage' warnings when building with MSVC have been fixed

- Hardware-accelerated Nvidia video encoder/decoder plugins `nvdec` and `nvenc`
  build on Windows now, also with MSVC and using Meson.

- The `ksvideosrc` camera capture plugin supports 16-bit grayscale video now

- The `wasapisrc` audio capture element implements loopback recording from
  another output device or sink

- `wasapisink` recover from low buffer levels in shared mode and some
  exclusive mode fixes

- `dshowsrc` now implements the GstDeviceMonitor interface

[bug-webrtcdsp]: https://gitlab.freedesktop.org/gstreamer/cerbero/merge_requests/30

## Contributors

Aaron Boxer, Aleix Conchillo Flaqué, Alessandro Decina, Alexandru Băluț,
Alex Ashley, Alexey Chernov, Alicia Boya García, Amit Pandya,
Andoni Morales Alastruey, Andreas Frisch, Andre McCurdy, Andy Green,
Anthony Violo, Antoine Jacoutot, Antonio Ospite, Arun Raghavan, Aurelien Jarno,
Aurélien Zanelli, ayaka, Bananahemic, Bastian Köcher, Branko Subasic,
Brendan Shanks, Carlos Rafael Giani,  Charlie Turner, Christoph Reiter,
Corentin Noël, Daeseok Youn, Damian Vicino, Dan Kegel, Daniel Drake,
Daniel Klamt,  Danilo Spinella, Dardo D Kleiner, David Ing, David Svensson Fors,
Devarsh Thakkar, Dimitrios Katsaros, Edward Hervey, Emilio Pozuelo Monfort,
Enrique Ocaña González, Erlend Eriksen, Ezequiel Garcia, Fabien Dessenne,
Fabrizio Gennari, Florent Thiéry, Francisco Velazquez, Freyr666, Garima Gaur,
Gary Bisson, George Kiagiadakis, Georg Lippitsch, Georg Ottinger, Geunsik Lim,
Göran Jönsson, Guillaume Desmottes, H1Gdev, Haihao Xiang, Haihua Hu,
Harshad Khedkar, Havard Graff, He Junyan, Hoonhee Lee, Hosang Lee, Hyunjun Ko,
Ilya Smelykh, Ingo Randolf, Iñigo Huguet, Jakub Adam, James Stevenson,
Jan Alexander Steffens, Jan Schmidt, Jerome Laheurte, Jimmy Ohn,
Joakim Johansson, Jochen Henneberg, Johan Bjäreholt, John-Mark Bell,
John Bassett, John Nikolaides, Jonathan Karlsson, Jonny Lamb, Jordan Petridis,
Josep Torra, Joshua M. Doe, Jos van Egmond, Juan Navarro, Julian Bouzas,
Jun Xie, Junyan He, Justin Kim, Kai Kang, Kim Tae Soo, Kirill Marinushkin,
Kyrylo Polezhaiev, Lars Petter Endresen, Linus Svensson,
Louis-Francis Ratté-Boulianne, Lucas Stach, Luis de Bethencourt, Luz Paz,
Lyon Wang, Maciej Wolny, Marc-André Lureau, Marc Leeman, Marco Trevisan (Treviño),
Marcos Kintschner, Marian Mihailescu, Marinus Schraal, Mark Nauwelaerts, 
Marouen Ghodhbane, Martin Kelly, Matej Knopp, Mathieu Duponchelle,
Matteo Valdina, Matthew Waters, Matthias Fend, memeka, Michael Drake, 
Michael Gruner, Michael Olbrich, Michael Tretter, Miguel Paris, Mike Wey, 
Mikhail Fludkov, Naveen Cherukuri, Nicola Murino, Nicolas Dufresne,
Niels De Graef, Nirbheek Chauhan, Norbert Wesp, Ognyan Tonchev, Olivier Crête, 
Omar Akkila, Pat DeSantis, Patricia Muscalu, Patrick Radizi, Patrik Nilsson,
Paul Kocialkowski, Per Forlin, Peter Körner, Peter Seiderer, Petr Kulhavy,
Philippe Normand, Philippe Renon, Philipp Zabel, Pierre Labastie, Piotr Drąg,
Roland Jon, Roman Sivriver, Roman Shpuntov, Rosen Penev, Russel Winder,
Sam Gigliotti, Santiago Carot-Nemesio, Sean-Der, Sebastian Dröge, Seungha Yang,
Shi Yan, Sjoerd Simons, Snir Sheriber, Song Bing, Soon, Thean Siew, 
Sreerenj Balachandran, Stefan Ringel, Stephane Cerveau, Stian Selnes, 
Suhas Nayak, Takeshi Sato, Thiago Santos, Thibault Saunier, Thomas Bluemel, 
Tianhao Liu, Tim-Philipp Müller, Tobias Ronge, Tomasz Andrzejak,
Tomislav Tustonić, U. Artie Eoff, Ulf Olsson, Varunkumar Allagadapa,
Víctor Guzmán, Víctor Manuel Jáquez Leal, Vincenzo Bono, Vineeth T M,
Vivia Nikolaidou, Wang Fei, wangzq, Whoopie, Wim Taymans, Wind Yuan,
Wonchul Lee, Xabier Rodriguez Calvar, Xavier Claessens, Haihao Xiang,
Yacine Bandou, Yeongjin Jeong, Yuji Kuwabara, Zeeshan Ali,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing.

## Stable 1.16 branch

After the 1.16.0 release there will be several 1.16.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.16.x bug-fix releases will be made from the git 1.16 branch,
which is a stable branch.

### 1.16.0

1.16.0 was released on 19 April 2019.

<a name="1.16.1"></a>

### 1.16.1

The first 1.16 bug-fix release (1.16.1) was released on 23 September 2019.

This release only contains bugfixes and it *should* be safe to update
from 1.16.0.

#### Highlighted bugfixes in 1.16.1

 - GStreamer-vaapi: fix green frames and decoding artefacts in some cases
 - OpenGL: fix wayland event source burning CPU in certain circumstances
 - Memory leak fixes and memory footprint improvements
 - Performance improvements
 - Stability and security fixes
 - Fix enum for `GST_MESSAGE_DEVICE_CHANGED` which is technically an
   API break, but this is only used internally in GStreamer and duplicated
   another message enum
 - hls: Make crypto dependency optional when hls-crypto is auto
 - player: fix switching back and forth between forward and reverse playback
 - decklinkaudiosink: Drop late buffers
 - openh264enc: Fix compilation with openh264 v2.0
 - wasapisrc: fix segtotal value being always 2
 - android: Fix gnutls issue causing a FORTIFY crash on Android Q
 - windows: Fix two crashes due to cross-CRT free when using MSVC

#### gstreamer core

 - device: `gst_device_create_element()` is `transfer floating`, not `transfer full`
 - filesink, fdsink: respect `IOV_MAX` for the writev iovec array (Solaris)
 - miniobject: free qdata array when the last qdata is removed (reduces memory footprint)
 - bin: Fix minor race when adding to a bin
 - aggregator: Actually handle `NEED_DATA` return from `update_src_caps()`
 - aggregator: Ensure that the source pad is created as a `GstAggregatorPad` if no type is given in the pad template
 - latency: fix custom event leaks
 - registry: Use plugin directory from the build system for relocateable Windows builds
 - message: fix up enum value for `GST_MESSAGE_DEVICE_CHANGED`
 - info: Fix deadlock in `gst_ring_buffer_logger_log()`
 - downloadbuffer: Check for flush after seek
 - identity: Non-live upstream have no max latency
 - identity: Fix the ts-offset property getter
 - aggregator: Make parsing of explicit sink pad names more robust
 - bufferpool: Fix the buffer size reset code
 - fakesink, fakesrc, identity: sync `gst_buffer_get_flags_string()` with new flags
 - multiqueue: never unref queries we do not own
 - concat: Reset last\_stop on `FLUSH_STOP` too
 - aggregator: fix flow-return boolean return type mismatch
 - gstpad: Handle probes that reset the data field
 - gst: Add support for `g_autoptr(GstPromise)`
 - gst-inspect: fix unused-const-variable error in windows
 - base: Include `gstbitwriter.h` in the single-include header
 - Add various Since: 1.16 markers
 - `GST_MESSAGE_DEVICE_CHANGED` duplicates `GST_MESSAGE_REDIRECT`
 - Targetting wrong meson version
 - meson: Make `get_flex_version.py` script executable
 - meson: Link to objects instead of static helper library
 - meson: set correct install path for gdb helper
 - meson: fix warning about configure_file() install kwarg

#### gst-plugins-base

 - video-info: parse field-order for all interleaved formats
 - tests: fix up valgrind suppressions for glibc getaddrinfo leaks
 - meson: Reenable NEON support (in audio resampler)
 - audio-resampler: Update NEON to handle remainders not multiples of 4
 - eglimage: Fix memory leak
 - audiodecoder: Set output caps with negotiated caps to avoid critical info printed
 - video-frame: Take TFF flag from the video info if it was set in there
 - glcolorconvert: Fix external-oes shader
 - video-anc: Fix ADF detection when trying to extract data from vanc
 - gl/wayland: fix wayland event source burning CPU
 - configure: add used attribute in order to make NEON detection working with -flto.
 - audioaggregator: Return a valid rate range from caps query if downstream supports a whole range
 - rtspconnection: data-offset increase not set
 - rtpsconnection: Fix number of n_vectors
 - video-color: Add compile-time assert for ColorimetryInfo enum
 - audiodecoder: Fix leak on failed audio gaps
 - glupload: Keep track of cached EGLImage texture format
 - playsink: Set ts-offset to text sink.
 - meson.build: use join_paths() on prefix
 - compositor: copy frames as-is when possible
 - compositor: Skip background when a pad obscures it completely
 - rtspconnection: Start CSeq at 1 (some servers don't cope well with seqnum 0)
 - viv-fb: fix build break for `GST_GL_API`
 - gl/tests: fix shader creation tests part 2
 - gl/tests: fix shader creation tests
 - wayland: set the event queue also for the xdg_wm_base object
 - video: Added GI annotation for gstvideoaffinetransformationmeta apply_matrix
 - compositor: Remove unneeded left shift for ARGB/AYUV SOURCE operator
 - Colorimetry fixes
 - alsasrc: Don't use driver timestamp if it's zero
 - gloverlaycompositor: fix crash if buffer doesn't have video meta
 - meson: Don't try to find gio-unix on Windows
 - glshader: fix default external-oes shaders
 - subparse: fix pushing WebVTT cue with no newline at the end
 - meson: Missing "android" choice in gl_winsys
 - video test: Keep BE test inline with LE test
 - id3tag: Correctly validate the year from v1 tags before passing to GstDateTime
 - gl/wayland: Don't prefix wl_shell struct field
 - eglimage: Add compatibility define for `DRM_FORMAT_NV24`
 - Add various Since: 1.16 markers
 - video-anc: Handle SD formats correctly
 - Docs: add `GL_CFLAGS` to `GTK_DOC_CFLAGS`
 - GL: using vaapi and showing on glimagesink on wayland loads one core for 100% on 1.16
 - GL: external-oes shader places precision qualifier before #extension (was: androidmedia amcviddec fail after 1.15.90 1.16.0 update)

#### gst-plugins-good

 - alpha: Fix `one_over_kc` calculation on arm/aarch64
 - souphttpsrc: Fix incompatible type build warning
 - rtpjitterbuffer: limit max-dropout-time to maxint32
 - rtpjitterbuffer: Clear clock master before unreffing
 - qtdemux: Use empty-array safe way to cleanup GPtrArray
 - v4l2: Fix type compatibility issue with glibc 2.30
 - valgrind: suppress Cond error coming from gnutls and Ignore leaks caused by shout/sethostent
 - rtpfunnel: forward correct segment when switching pad
 - gtkglsink: fix crash when widget is resized after element destruction
 - jpegdec: Don't dereference NULL input state if we have no caps in TIME segments
 - rtp: opuspay: fix memory leak in `gst_rtp_opus_pay_setcaps`
 - v4l2videodec: return right type for drain.
 - rtpssrcdemux: Avoid taking streamlock out-of-band
 - Support v4l2src buffer orphaning
 - splitmuxsink: Only set running time on finalizing sink element when in async-finalize mode
 - rtpsession: Always keep at least one NACK on early RTCP
 - rtspsrc: do not try to send EOS with invalid seqnum
 - rtpsession: Call on-new-ssrc earlier
 - rtprawdepay: Don't get rid of the buffer pool on FLUSH_STOP
 - rtpbin: Free storage when freeing session
 - scaletempo: Advertise interleaved layout in caps templates
 - Support v4l2src buffer orphaning

#### gst-plugins-bad

 - hls: Make crypto dependency optional when hls-crypto is auto
 - player: fix switching back and forth between forward and reverse playback
 - decklinkaudiosink: Drop late buffers
 - srt: Add stats property, include sender-side statistics and fix a crash
 - dshowsrcwrapper: fix regression on device selection
 - tsdemux: Limit the maximum PES payload size
 - wayland: Define libdrm_dep in meson.build to fix meson configure error when kms is disabled
 - sctp: Fix crash on free() when using the MSVC binaries
 - webrtc: Fix signals documentation
 - h264parse: don't critical on VUI parameters > 2^31
 - rtmp: Fix crash inside free() with MSVC on Windows
 - iqa: fix leak of map_meta.data
 - d3dvideosink: Fix crash on WinProc handler
 - amc: Fix crash when a sync_meta survives its sink
 - pitch: Fix race between putSamples() and setting soundtouch parameters
 - webrtc: fix type of max-retransmits, make it work
 - mxfdemux: Also allow picture essence element type 0x05 for VC-3
 - wasapi: fix symbol redefinition build error
 - decklinkvideosrc: Retrieve mode of the ancillary data from the frame
 - decklinkaudiosrc/decklinkvideosrc: Do nothing in BaseSrc::negotiate() and...
 - adaptivedemux: do not retry downloads during shutdown.
 - webrtcbin: fix GInetAddress leak
 - dtls: fix dtls connection object leak
 - siren: fix a global buffer overflow spotted by asan
 - kmssink: Fix implicit declaration build error
 - Fix -Werror=return-type error in configure.
 - aiff: Fix infinite loop in header parsing.
 - nvdec: Fix possible frame drop on EOS
 - srtserversrc: yields malformed rtp payloads
 - srtsink: Fix crash in case no URI
 - dtlsagent: Fix leaked dtlscertificate
 - meson: bluez: Early terminate configure on Windows
 - decklink: Correctly ensure >=16 byte alignment for the buffers we allocate
 - webrtcbin: fix DTLS when receivebin is set to DROP
 - zbar: Include running-time, stream-time and duration in the messages
 - uvch264src: Make sure we set our segment
 - avwait: Allow start and end timecode to be set back to NULL
 - avwait: Don't print warnings for every buffer passed
 - hls/meson: fix dependency logic
 - Waylandsink gnome shell workaround
 - avwait: Allow setting start timecode after end timecode; protect propeties with mutex
 - wayland/wlbuffer: just return if used_by_compositor is true when attach
 - proxy: Set SOURCE flag on the source and SINK flag on the sink
 - ivfparse: Check the data size against `IVF_FRAME_HEADER_SIZE`
 - webrtc: Add various Since markers to new types after 1.14.0
 - msdk: fix the typo in debug category
 - dtlsagent: Do not overwrite openssl locking callbacks
 - meson: Fix typo in gsm header file name
 - srt: handle races in state change
 - webrtc: Add `g_autoptr()` support for public types
 - openh264enc: Fix compilation with openh264 v2.0
 - meson: Allow CUDA_PATH fallback on linux
 - meson: fix build with opencv=enabled and opencv4. Fixes #964
 - meson: Add support for the colormanagement plugin
 - autotools: gstsctp: set LDFLAGS
 - nvenc/nvdec: Add NVIDIA SDK headers to noinst_HEADERS
 - h264parse: Fix typo when setting multiview mode and flags
 - Add various Since: 1.16 markers
 - opencv: allow compilation against 4.1.x
 - Backport of some minor srt commits without MR into 1.16
 - meson: fix build with opencv=enabled and opencv4
 - wasapisrc: fix segtotal value being always 2 due to an unused variable
 - meson:  colormanagement missing
 - androidmedia amcviddec fail after 1.15.90 1.16.0 update

#### gst-plugins-ugly

 - meson: Always require the gmodule dependency

#### gst-libav

 - docs: don't include the type hierarchy, fixing build with gtk-doc 1.30
 - avvidenc: Correctly signal interlaced input to ffmpeg when the input caps are interlaced
 - autotools: add bcrypt to win32 libs
 - gstav: Use libavcodec util function for version check
 - API documentation fails to build with gtk-doc 1.30

#### gst-rtsp-server

 - rtsp-client: RTP Info must exist in PLAY response
 - onvif-media: fix "void function returning a value" compiler warning
 - Add various Since: 1.16 markers

#### gstreamer-vaapi

 - fix egl context leak and display creation race
 - pluginutil: Remove Mesa from drivers white list
 - Classify vaapidecodebin as a hardware decoder
 - Fix two leak
 - vaapivideomemory: demote error message to info
 - encoder: vp8,vp9: reset frame_counter when input frame's format changes
 - encoder: mpeg2: No packed header for SPS and PPS
 - decoder: vp9: clear parser pointer after release
 - encoder: Fixes deadlock in change state function
 - encoder: h265: reset `num_ref_idx_l1_active_minus1` when low delay B.
 - encoder: not call `ensure_num_slices` inside `g_assert()`
 - encoder: continue if roi meta is NULL
 - decoder: vp9: Set chroma_ ype by VP9 bit_depth
 - vaapipostproc: don't do any color conversion when `GL_TEXTURE_UPLOAD`
 - libs: surface: fix double free when dmabuf export fails
 - h264 colors and artifacts upon upgrade to GStreamer Core Library version 1.15.90

#### gst-editing-services

 - element: Properly handle the fact that pasting can return NULL
 - Add various missing Since markers
 - launch: Fix caps restriction short names
 - python: Avoid warning about using deprecated methods
 - video-transition: When using non crossfade effect use 'over' operations
 - meson: Generate a pkgconfig file for the GES plugin

#### gst-devtools

 - launcher: testsuites: skip systemclock stress tests
 - validate: fix build on macOS

#### gst-build

 - Update win flex bison binaries
 - Update the flexmeson windows binary version
 - Don't allow people to run meson inside the uninstalled env

#### Cerbero build tool and packaging changes in 1.16.1

 - cerbero: Add enums for Fedora 30, Fedora 31 and Debian bullseye
 - gnutls.recipe: Fix crash when running on Android Q
 - recipes: Upgrade openssl to 1.1.1c
 - Fix some typos
 - add support for vs build tools 2019, fixes #183
 - android: Adjust gstreamer-1.0.mk for NDK r20
 - Fix license enums
 - bootstrap: Fix dnf usage on CentOS
 - Make `_add_system_libs` reentrant
 - meson.recipe: Fix setting of bitcode compiler options
 - cerbero: support Ubuntu disco dingo
 - cerbero: Set utf-8 to execution character set also on MSVC
 - git: simplify the reset of the source branch.
 - `FORTIFY: %n not allowed` on Android Q
 - Fails to build if there's no license file for the given license
   (GPL/LGPL without Plus, Proprietary, ...)

#### Contributors to 1.16.1

Aaron Boxer,  Adam Duskett, Alicia Boya García, Andoni Morales Alastruey,
Antonio Ospite, Arun Raghavan, Askar Safin, A. Wilcox, Charlie Turner,
Christoph Reiter, Damian Hobson-Garcia, Daniel Klamt, Danny Smith,
David Gunzinger, David Ing, David Svensson Fors, Doug Nazar, Edward Hervey,
Eike Hein, Fabrice Bellet, Fernando Herrrera, Georg Lippitsch, Göran Jönsson,
Guillaume Desmottes, Haihao Xiang, Haihua Hu, Håvard Graff, Hou Qi,
Ignacio Casal Quinteiro, Ilya Smelykh, Jan Schmidt, Javier Celaya, Jim Mason,
Jonas Larsson, Jordan Petridis, Jose Antonio Santos Cadenas, Juan Navarro,
Knut Andre Tidemann, Kristofer Björkström, Lucas Stach, Marco Felsch,
Marcos Kintschner, Mark Nauwelaerts, Martin Liska, Martin Theriault,
Mathieu Duponchelle, Matthew Waters, Michael Olbrich, Mike Gorse, Nicola Murino,
Nicolas Dufresne, Niels De Graef, Niklas Hambüchen, Nirbheek Chauhan,
Olivier Crête, Philippe Normand, Ross Burton, Sebastian Dröge, Seungha Yang,
Song Bing, Thiago Santos, Thibault Saunier, Thomas Coldrick, Tim-Philipp Müller,
Víctor Manuel Jáquez Leal, Vivia Nikolaidou, Xavier Claessens, Yeongjin Jeong,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.16.1

- [List of Merge Requests applied in 1.16](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.16.1)
- [List of Issues fixed in 1.16.1](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.16.1)

<a name="1.16.2"></a>

### 1.16.2

The second 1.16 bug-fix release (1.16.2) was released on 03 December 2019.

This release only contains bugfixes and it *should* be safe to update
from 1.16.1.

#### Highlighted bugfixes in 1.16.2

 - Interlaced video scaling fixes
 - CineForm video support in AVI
 - audiorate: avoid glitches due to rounding errors after changing rate
 - Command line tool output printing improvements on Windows
 - various performance improvements, memory leak fixes and security fixes
 - VP9 decoding fixes
 - avfvideosrc: Explicitly request video permission on macOS 10.14+
 - wasapi: bug fixes and stability improvements
 - webrtc-audio-processing: fix segmentation fault on 32-bit windows
 - tsdemux: improved handling of certain discontinuities
 - vaapi h265 decoder: wait for I-frame before trying to decode

#### gstreamer

 - gst-launch: Fix ugly stdout on Windows
 - tee: Make sure to actually deactivate pads that are released
 - bin: Drop `need-context` messages without source instead of crashing
 - gst: Don't pass miniobjects to `GST_DEBUG_OBJECT()` and similar macros
 - tracers: Don't leak temporary GstStructure

#### gst-plugins-base

 - xvimagepool: Update size, stride, and offset with allocated XvImage
 - video-converter: Fix RGB-XYZ-RGB conversion
 - audiorate: Update next_offset on rate change
 - audioringbuffer: Reset reorder flag before check
 - audio-buffer: Don't fail to map buffers with zero samples
 - videorate: Fix `max-duplication-time` handling
 - gl/gbm: ensure we call the resize callback before attempting to draw
 - video-converter: Various fixes for interlaced scaling
 - gstrtspconnection: messages_bytes not decreased
 - check: Don't use real audio devices for tests
 - riff: add CineForm mapping
 - glfilters: Don't use static variables for storing per-element state
 - glupload: Add VideoMetas and GLSyncMeta to the raw uploaded buffers
 - streamsynchronizer: avoid pad release race during logging.
 - gst-play: Use gst_print* to avoid broken stdout string on Windows

#### gst-plugins-good

 - vp9dec: Fix broken 4:4:4 8bits decoding
 - rtpsession: add locking for clear-pt-map
 - rtpL16depay: don't crash if data is not modulo channels*width
 - wavparse: Fix push mode ignoring audio with a size smaller than segment buffer
 - wavparse: Fix push mode ignoring last audio payload chunk
 - aacparse: fix wrong offset of the channel number in adts header
 - jpegdec: Fix incorrect logic in EOI tag detection
 - videocrop: Also update the coordinate when in-place
 - jpegdec: don't overwrite the last valid line
 - vpx: Error out if enabled and no features found
 - v4l2videodec: ensure pool exists before orphaning it
 - v4l2videoenc: fix type conversion errors
 - v4l2bufferpool: Queue number of allocated buffers to capture
 - v4l2object: fix mpegversion number typo
 - v4l2object: Work around bad TRY_FMT colorimetry implementations

#### gst-plugins-bad

 - avfvideosrc: Explicitly request video permission on macOS 10.14+
 - wasapi: Various fixes and a workaround for a specific driver bug
 - wasapi: Move to CoInitializeEx for COM initialization
 - wasapi: Fix runtime/build warnings
 - waylandsink: Commit the parent after creating subsurface
 - msdkdec: fix surface leak in msdkdec_handle_frame
 - tsmux: Fix copying of buffer region
 - tsdemux: Handle continuity mismatch in more cases
 - tsdemux: Always issue a DTS even when it's equal to PTS
 - openexr: Fix build with OpenEXR 2.4 (and also OpenEXR 2.2 on Ubuntu 18.04)
 - ccextractor: Always forward all sticky events to the caption pad
 - pnmdec: Return early on ::finish() if we have no actual data to parse
 - ass: avoid infinite unref loop with bad data
 - fluidsynth: add sf3 to soundfont search path
 - webrtcdsp/webrtcechoprobe segmentation fault on windows (1.16.0 x86)

#### gst-libav

 - avvidenc: Fix error propagation
 - avdemux: Fix segmentation fault if long_name is NULL
 - avviddec: Fix huge leak caused by circular reference
 - avviddec: Enforce allocate new AVFrame per input frame
 - avdec_mpeg2video (and probably more): Huge memory leak in git master

#### gst-rtsp-server

 - rtsp-media: Use lock in gst_rtsp_media_is_receive_only
 - rtsp-client: RTP Info when completed_sender
 - rtsp-client: fix location uri-format by getting uri directly from context instead

#### gstreamer-vaapi

 - meson build: halt configuration if no renderer API
 - libs: decoder: h265: skip all pictures prior the first I-frame
 - libs: window: x11: Avoid usage of deprecated API

#### gst-editing-services

 - Initialize debug categories before usage

#### gst-build

 - gst-env: Use locally built GStreamer utility programs

#### Cerbero build tool and packaging changes in 1.16.2

##### General

 - openssl: Update to 1.1.1d
 - Updated ffmpeg, expat, flac, freetype, croco, ogg, xml2, mpg123, openjpeg, opus, pixman, speex, tiff recipes
 - Fix setting of git credentials in local source repos

##### Windows

 - webrtc-audio-processing: fix segmentation fault on 32-bit windows
   with webrtcdsp/webrtcechoprobe elemens
 - vpx plugin has no features when built with Visual Studio 2019
 - libvpx: Add support for Visual Studio 2019
 - mingw-runtime.recipe: Correctly package pkg-config in the MSI
 - GIO doesn't load any modules on Windows with MSVC, which breaks TLS support since glib-networking's giognutls module isn't loaded
 - Make the instructions for running Cerbero the same on all platforms

##### macOS + iOS

 - Add support for macOS 10.15 Catalina
 - Updates for Xcode 11
 - macos/ios: expose objc++ compilers in env variables
 - srt.recipe: Fix crash in constructor on iOS
 - osx-framework.recipe: Dynamically generate the list of libraries and ship pkg-config
 - macos: add -mmacosx-version-min for framework
 - gstreamer-1.0-osx-framework.recipe contains an outdated hard-coded list of libraries
 - We need to ship pkg-config with macOS

##### Linux

 - Fix `filesprovider.find_shlib_regex` when a `lib_suffix` is used in the
   cerbero config file

#### Contributors to 1.16.2

Adam Nilsson, Amr Mahdi, Angus Ao, Charlie Turner, Edward Hervey,
Fabian Greffrath, Fuwei Tang, Havard Graff, Hu Qian, James Cowgill,
Jan Alexander Steffens (heftig), Jeffy Chen, Jeremy Lempereur,
Joakim Johansson,  Jochen Henneberg, Julien Isorce, Kevin Joly,
Kristofer Bjorkstrom, Kyrylo Polezhaiev, Matthew Waters, Michael Olbrich,
Muhammet Ilendemli, Nicolas Dufresne, Nirbheek Chauhan, Pablo Marcos Oltra,
Roman Shpuntov, Ruben Gonzalez, Scott Kanowitz, Sebastian Dröge, Seungha Yang,
Thibault Saunier,  Tim-Philipp Müller, Víctor Manuel Jáquez Leal,
Vivia Nikolaidou,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.16.2

- [List of Merge Requests applied in 1.16](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.16.2)
- [List of Issues fixed in 1.16.2](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.16.2)

<a name="1.16.3"></a>

### 1.16.3

The third (and likely last) 1.16 bug-fix release (1.16.3) was released
on 21 October 2020.

This release only contains bugfixes and it *should* be safe to update
from 1.16.2.

#### Highlighted bugfixes in 1.16.3

- important security fixes
- bug fixes, memory leak fixes and various stability and reliability improvements

#### gstreamer

 - delay creation of threadpools
 - bin: Fix `deep-element-removed` log message
 - buffer: fix meta sequence number fallback on rpi
 - bufferlist: foreach: always remove as parent if buffer is changed
 - bus: Make setting/replacing/clearing the sync handler thread-safe
 - elementfactory: Fix missing features in case a feature moves to another filename
 - element: When removing a ghost pad also unset its target
 - meta: intern registered impl string
 - registry: Use a toolchain-specific registry file on Windows
 - systemclock: Invalid internal time calculation causes non-increasing clock time on Windows
 - value: don't write to `const char *`
 - value: Fix segfault comparing empty GValueArrays
 - Revert floating enforcing
 - aggregator: fix iteration direction in skip_buffers
 - sparsefile: fix possible crash when seeking
 - baseparse: cache fix
 - baseparse: fix memory leak when subclass skips whole input buffer
 - baseparse: Set the private duration before posting a duration-changed message
 - basetransform: allow not passthrough if generate_output is implemented
 - identity: Fix a minor leak using meta_str
 - queue: protect against lost wakeups for iterm_del condition
 - queue2: Avoid races when posting buffering messages
 - queue2: Fix missing/dropped buffering messages at startup
 - identity: Unblock condition variable on FLUSH_START
 - check: Use `g_thread_yield()` instead of `g_usleep(1)`
 - tests: use cpu_family for arch checks
 - gst-launch: Follow up to missing `s/g_print/gst_print/g`
 - gst-inspect: Add define guard for `g_log_writer_supports_color()`
 - gst-launch: go back down to `GST_STATE_NULL` in one step.
 - device-monitor: list hidden providers before listing devices

#### gst-plugins-base

 - audioaggregator: Check all downstream allowed caps structures if they support the upstream rate
 - audioaggregator: Fix negotiation with downstream if there is no peer yet
 - audioencoder: fix segment event leak
 - discoverer: Fix caps handling in `pad-added` signal handler
 - discoverer: Start discovering next URI from right thread
 - fft: Update our kiss fft version, fixes thread-safety and concurrency issues and misc other things
 - gl: numerous memory fixes (use-after-free, leaks, missing NULL-ify)
 - gl/display/egl: ensure debug category is initialized
 - gstglwindow_x11: fix resize
 - pbutils: Add latest H.264 level values
 - rtpbuffer: fix header extension length validation
 - video: Fix NV12_64Z32 number of component
 - video-format: RGB16/15 are not 16 bit per component but only 5.333 and 5
 - video: fix top/bottom field flags
 - videodecoder: don't copy interlace-mode from reference state
 - appsrc/appsink: Make setting/replacing callbacks thread-safe
 - compositor: Fix checkerboard filling for BGRx/RGBx and UYVY/YUY2/YVYU
 - decodebin3: only force streams-selected seqnum after a select-streams
 - glupload: Fix fallback from direct dmabuf to dmabuf upload method
 - glvideomixer: perform `_get_highest_precision()` on the GL thread
 - libvisual: use `gst_element_class_set_metadata()` when passing dynamic strings
 - oggstream: Workaround for broken PAR in VP8 BOS
 - subparse: accept WebVTT timestamps without an hour component
 - playbin: Handle error message with redirection indication
 - textrender: Fix AYUV output.
 - typefind: Consider MPEG-PS PSM to be a PES type
 - uridecodebin3: default to non-0 buffer-size and buffer-duration, otherwise it could potentially cause big memory allocations over time
 - videoaggregator: Don't configure NULL chroma-site/colorimetry
 - videorate/videoscale/audioresample: Ensure that the caps returned from...
 - build: Replace bashisms in configure for Wayland and GLES3

#### gst-plugins-good

 - deinterlace: on-the-fly renegotiation
 - flacenc: Pass audio info from set_format() to query_total_samples() explicitly
 - flacparse: fix broken reordering of flac metadata
 - jack: Use jack_free(3) to release ports
 - jpegdec: check buffer size before dereferencing
 - pulse: fix discovery of newly added devices
 - qtdemux fuzzing fixes
 - qtdemux: Add 'mp3 ' fourcc that VLC seems to produce now
 - qtdemux: Specify REDIRECT information in error message
 - rtpbin: fix shutdown crash in rtpbin
 - rtpsession: rename RTCP thread
 - rtpvp8pay, rtpvp9pay: fix caps leak in set_caps()
 - rtpjpegdepay: outputs framed jpeg
 - rtpjitterbuffer: Properly free internal packets queue in finalize()
 - rtspsrc: Don't return TRUE for unhandled query
 - rtspsrc: Avoid stack overflow recursing waiting for response
 - rtspsrc: Use the correct type for storing the max-rtcp-rtp-time-diff property
 - rtspsrc: Error out when failling to receive message response
 - rtspsrc: Fix for segmentation fault when handling set/get_parameter requests
 - speex: Fix crash on Windows caused by cross-CRT issue
 - speexdec: Crash when stopping the pipeline
 - splitmuxsrc: Properly stop the loop if no part reader is present
 - use gst_element_class_set_metadata when passing dynamic strings
 - v4l2videodec: Increase internal bitstream pool size
 - v4l2: fix crash when handling unsupported video format
 - videocrop: allow properties to be animated by GstController
 - videomixer: Don't leak peer caps
 - vp8enc/vp8enc: set 1 for the default value of VP8E_SET_STATIC_THRESHOLD
 - wavenc: Fix writing of the channel mask with >2 channels

#### gst-plugins-bad

 - amcvideodec: fix sync meta copying not taking a reference
 - audiobuffersplit: Perform discont tracking on running time
 - audiobuffersplit: Specify in the template caps that only interleaved audio is supported
 - audiobuffersplit: Unset DISCONT flag if not discontinuous
 - autoconvert: Fix lock-less exchange or free condition
 - autoconvert: fix compiler warnings with g_atomic on recent GLib versions
 - avfvideosrc: element requests camera permissions even with capture-screen property is true
 - codecparsers: h264parser: guard against ref_pic_markings overflow
 - dtlsconnection: Avoid segmentation fault when no srtp capabilities are negotiated
 - dtls/connection: fix EOF handling with openssl 1.1.1e
 - fdkaacdec: add support for mpegversion=2
 - hls: Check nettle version to ensure AES128 support
 - ipcpipeline: Rework compiler checks
 - interlace: Increment phase_index before checking if we're at the end of the phase
 - lv2: Make it build with -fno-common
 - h264parser: Do not allocate too large size of memory for registered user data SEI
 - ladspa: fix unbounded integer properties
 - modplug: avoid division by zero
 - msdkdec: Fix GstMsdkContext leak
 - msdkenc: fix leaks on windows
 - musepackdec: Don't fail all queries if no sample rate is known yet
 - openslessink: Allow openslessink to handle 48kHz streams.
 - opencv: allow compilation against 4.2.x
 - proxysink: event_function needs to handle the event when it is disconnecetd from proxysrc
 - vulkan: Drop use of VK_RESULT_BEGIN_RANGE
 - wasapi: added missing lock release in case of error in gst_wasapi_xxx_reset
 - wasapi: Fix possible deadlock while downwards state change
 - waylandsink: Clear window when pipeline is stopped
 - webrtc: Support non-trickle ICE candidates in the SDP
 - webrtc: Unmap all non-binary buffers received via the datachannel
 - meson: build with neon 0.31

#### gst-plugins-ugly

 - x264enc: corrected em_data value in CEA-708 CC SEI message

#### gst-libav

 - avaudenc/avvidenc: Reopen encoding session if it's required
 - avauddec/audenc/videnc: Don't return GST_FLOW_EOS when draining
 - avauddec/avviddec: Avoid dropping non-OK flow return
 - avviddec: Limit default number of decoder threads
 - avauddec: fix buffer leak when send packet failed
 - Ensure drain even if codec has not delay capabilities

#### gst-rtsp-server

 - rtsp-stream: explicitly set caps on udpsrc elements
 - rtsp-stream: use mcast_udpsink[0] last-sample if available for rtpinfo
 - rtspclientsink: Set async-handling=false for the internal bins
 - rtsp-auth: Fix NULL pointer dereference when handling an invalid basic Authorization header
 - rtsp-latency-bin: replace `G_TYPE_INSTANCE_GET_PRIVATE` as it's been deprecated
 - rtsp-auth: fix default token leak

#### gstreamer-vaapi

 - display: drm: use g_strcmp0 to be null safe
 - vaapipluginutil: Use `GST_VAAPI_DISPLAY_TYPE_DRM` for Mesa3D GBM
 - vaapivideobufferpool: force video meta if sizes are different
 - Fix negotiate lock
 - decoder: h265: parser state after update dependent slice
 - h265enc: Set `VA_PICTURE_HEVC_INVALID` flag for invalid picture
 - vaapivideobufferpool: Log messages in proper category.
 - vaapih264enc: fix log message
 - display: fix a resource leak in X11 pixmap format.
 - decoder: h264, h265: `fix g_return_val_if_fail()` missuse
 - utils: guard the VAEntrypointFEI symbol
 - h265dec: remove limitation of get iq matrix
 - videopool: fix undocumented behavior and counting
 - Remove last negotiated video info if caps are the same
 - encoder: increase bitrate prop max value
 - misc backports into 1.16

#### gstreamer-sharp

 - Bind `gst_buffer_new_wrapped()` manually
 - Declare `GstVideoOverlayComposition`/`Rectangle` as opaque type and subclasses of `Gst.MiniObject`
 - Fix `gst_promise_new_with_change_func`

#### gst-python

 - Add exampleTransform.py from the master branch, modified to work on 1.16
 - Fix build with Python 3.8 by also checking for python-3.X-embed.pc

#### gst-editing-services

 - ges-launch fixes: enhance error message when no clip duration is set, avoid setting invalid clip duration

#### gst-integration-testsuites

 - Yesterday.flac.media_info: Update for changed flacparse behavior
 - flow-expectations: Rename colon to short dash

#### gst-build

 - subprojects: ffmpeg: bump to 4.1.5
 - git-update: Use --force when checking out manifest
 - gst-env: Use meson-uninstalled pkgconfig files if available
 - Fixate wrap versions in 1.16
 - Update android cross file
 - Use gstreamer mirror as primary source for win-nasm and win-flex-bison
 - fetch wrap patches from github
 - env: preprend gst-build/prefix/etc/xdg to `XDG_CONFIG_DIRS`
 - Backport various gst uninstalled bug fixes into 1.16
 - gst-env: Automatically set the prompt for zsh too
 - gst-env: Don't put helper binaries in PATH
 - fish: ignore SIGINT and set prompt correctly

#### Cerbero build tool and packaging changes in 1.16.3

 - meson: Ensure large file support for MinGW build
 - ci: Temporarily change remote and branch for ci template
 - cerbero: Run download tool outside of the build env
 - cache: Re-implememt cache on top of our external storage
 - cerbero: Ship plugin .pc files for all modules
 - cerbero: Define a custom user agent while downloading
 - Fix for fetching tags using git
 - Fix gettext download error and improve download failure exception usability
 - cerbero: Disable debian packaging for now
 - Fix misc windows bugs, and explicitly enable GL sub-options
 - Prepend `$CERBERO_PREFIX/lib` path in `LD_LIBRARY_PATH`
 - meson.recipe: Ignore programs in the WindowsApps directory
 - meson.recipe: Write out DLL/EXE checksums with MSVC
 - gst-plugins-bad: We can build ipcpipeline on Windows
 - Fix Python 3.8 compat on Windows
 - Fix malformed gendef output on x86
 - utils: fix python 3.8 compatibility on linux
 - Use the new artifact server for 1.16 too
 - GnuTLS: patch to handle certificate chain expiration
 - fontconfig: `Fix EXC_BAD_ACCESS` crash on iOS ARM64
 - glib: fix `G_GNUC_INTERNAL` on macOS/iOS
 - gnutls: Update to 3.5.19
 - nettle: add `-std=c99` to CFLAGS
 - openh264: fix recipe for text relocation issues on Android >= 5.0 x86 builds
 - openssl: Don't build/package for native linux
 - x264: Use relative paths in pkgconfig file
 - Backport various commits into 1.16 for the 1.16.3 release
 - FreeType: update to 2.10.4 to fix security vulnerability

#### Contributors to 1.16.3

Alexander Lapajne, Alicia Boya García, Andrew Wesie, Camilo Celis Guzman,
Carlos Rafael Giani, Chris Lord, Chris Mayo, Christoph Reiter,
Daniel Molkentin, David Bender, Debarshi Ray, dhilshad, Dimitrios Katsaros,
Dmitry Shusharin, Edward Hervey, François Laignel, Guillaume Desmottes,
Guillermo Rodríguez, Haihao Xiang, Havard Graff, He Junyan,
Jan Alexander Steffens (heftig), Jan Schmidt, Jennifer Berringer,
Jérôme Laheurte, Jonas Holmberg, Jonathan Matthew, Jordan Petridis,
Jose Quaresma, Julien Isorce, Justin Chadwell, Levente Révész, Matej Knopp,
Mathieu Duponchelle, Matthew Read, Matthew Waters, Matus Gajdos,
Michael Olbrich, Miguel Paris, Nicola Murino, Nicolas Dufresne,
Nicolas Pernas Maradei, Nirbheek Chauhan, okuoku, Olivier Crête,
Ondřej Hruška, Philippe Normand, Roman Shpuntov, Sebastian Dröge,
Seungha Yang, Silvio Lazzeretti, Stéphane Cerveau, Stian Selnes,
Thibault Saunier, Tim-Philipp Müller, U. Artie Eoff,
Víctor Manuel Jáquez Leal, Wangfei, Wang Zhanjun, Will Miller,
worldofpeace, Xu Guangxin, Yeongjin Jeong, Zebediah Figura,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.16.3

- [List of Merge Requests applied in 1.16.3](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.16.3)
- [List of Issues fixed in 1.16.3](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.16.3)

## Known Issues

- possibly breaking/incompatible changes to properties of wrapped FFmpeg
  decoders and encoders (see above).

- The way that GIO modules are named has changed due to upstream GLib natively
  adding support for loading static GIO modules. This means that any GStreamer
  application using gnutls for SSL/TLS on the Android or iOS platforms (or any
  other setup using static libraries) will fail to link looking for the
  `g_io_module_gnutls_load_static()` function. The new function name is now
  `g_io_gnutls_load(gpointer data)`. See Android/iOS sections above for further
  details.

## Schedule for 1.18

GStreamer 1.18.0 was released on 8 September 2020: [GStreamer 1.18 release notes][1.18]

- - -

*These release notes have been prepared by Tim-Philipp Müller with*
*contributions from Sebastian Dröge, Guillaume Desmottes, Matthew Waters, *
*Thibault Saunier, and  Víctor Manuel Jáquez Leal.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
