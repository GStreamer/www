# GStreamer 1.16 Release Notes

GStreamer 1.16 has not been released yet. It is scheduled for release
in April 2019.

1.15.x is the unstable development version that is being developed
in the git master branch and which will eventually result in 1.16.

1.16 will be backwards-compatible to the stable 1.14, 1.12, 1.10, 1.8, 1.6,
1.4, 1.2 and 1.0 release series.

See [https://gstreamer.freedesktop.org/releases/1.16/][latest] for the latest
version of this document.

*Last updated: Wednesday 10 April 2019, 00:50 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.16/
[gitlog]: https://cgit.freedesktop.org/gstreamer/www/log/src/htdocs/releases/1.16/release-notes-1.16.md

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

 - `line21decoder`: extract line21 closed captions from SD video streams

 - `cc708overlay`: decodes CEA 608/708 captions and overlays them on video

Additionally, the following elements have also gained Closed Caption support:

 - `qtdemux` and `qtmux` support CEA 608/708 Closed Caption tracks

 - `mpegvideoparse` extracts Closed Captions from MPEG-2 video streams

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
  `line21decoder` and `cc708overlay` (see above)

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

- `rtpmp4vpay` will be prefered over `rtpmp4gpay` for MPEG-4 video in
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

- `waylandsink` has a `"fullscreen"` property now.

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

- this section will be filled in in due course

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

- this section will be filled in in due course

## GStreamer validate

- this section will be filled in in due course

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
  will take precendence over anything specific in the configuration file.

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

- A new `-t` / `--timestamp` command line switch makes commands print timestamps

[cerbero-variants]: https://gitlab.freedesktop.org/gstreamer/cerbero#enabling-optional-features-with-variants

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

## Bugs fixed in 1.16

- this section will be filled in in due course

More than [XXX bugs][bugs-fixed-in-1.16] have been fixed during
the development of 1.16.

This list does not include issues that have been cherry-picked into the
stable 1.16 branch and fixed there as well, all fixes that ended up in the
1.16 branch are also included in 1.16.

This list also does not include issues that have been fixed without a bug
report in bugzilla, so the actual number of fixes is much higher.

[bugs-fixed-in-1.16]: https://bugzilla.gnome.org/buglist.cgi?bug_status=RESOLVED&bug_status=VERIFIED&classification=Platform&limit=0&list_id=213265&order=bug_id&product=GStreamer&query_format=advanced&resolution=FIXED&target_milestone=1.14.1&target_milestone=1.14.2&target_milestone=1.12.3&target_milestone=1.14.4&target_milestone=1.15.1&target_milestone=1.15.2&target_milestone=1.15.3&target_milestone=1.15.4&target_milestone=1.15.90&target_milestone=1.15.91&target_milestone=1.16.0

## Stable 1.16 branch

After the 1.16.0 release there will be several 1.16.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.16.x bug-fix releases will be made from the git 1.16 branch,
which is a stable branch.

### 1.16.0

1.16.0 is scheduled to be released in April 2019.

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

Our next major feature release will be 1.18, and 1.17 will be the unstable
development version leading up to the stable 1.18 release. The development
of 1.17/1.18 will happen in the git master branch.

The plan for the 1.18 development cycle is yet to be confirmed, but it is
expected that feature freeze will be around July 2019
followed by several 1.17 pre-releases and the new 1.18 stable release
in August/September.

1.18 will be backwards-compatible to the stable 1.16, 1.14, 1.12, 1.10, 1.8,
1.6, 1.4, 1.2 and 1.0 release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller with*
*contributions from Sebastian Dröge, Guillaume Desmottes and Matthew Waters.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
