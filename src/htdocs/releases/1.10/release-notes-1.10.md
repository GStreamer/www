# GStreamer 1.10 Release Notes

**NOTE: THESE RELEASE NOTES ARE VERY INCOMPLETE AND STILL WORK-IN-PROGRESS**

**GStreamer 1.10 is scheduled for release in TBD 2016.**

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other
improvements.

See [https://gstreamer.freedesktop.org/releases/1.10/][latest] for the latest
version of this document.

*Last updated: Saturday 22 Oct 2016, 16:00 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.10/
[gitlog]: https://cgit.freedesktop.org/gstreamer/www/log/src/htdocs/releases/1.10/release-notes-1.10.md

## Introduction

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other
improvements.

## Highlights

- FILL ME

## Major new features and changes

### Noteworthy new API, features and other changes

#### Core API additions

##### Receive property change notifications via bus messages

New API was added to receive element property change notifications via
bus messages. So far applications had to connect a callback to an element's
`notify::propert-name` signal via the GObject API, which was inconvenient for
at least two reasons: one had to implement a signal callback function, and that
callback function would usually be called from one of the streaming threads, so
one had to marshal (send) any information gathered or pending requests to the
main application thread which was tedious and error-prone.

Enter [`gst_element_add_property_notify_watch()`][notify-watch] and
[`gst_element_add_property_deep_notify_watch()`][deep-notify-watch] which will
watch for changes of a property on the specified element, either only for the
specified element or recursively for a whole bin or pipeline. Whenever such a
property change happens, a `GST_MESSAGE_PROPERTY_NOTIFY` message will be posted
on the pipeline bus with details of the element, the property and the new
property value, all of which can be retrieved later from the message in the
application via [`gst_message_parse_property_notify()`][parse-notify]. Unlike
the GstBus watch functions, this API does not rely on a running GLib main loop.

This can be used to be notified asynchronously of caps changes in the pipeline,
or volume changes on an audio sink element, for example.

[notify-watch]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstElement.html#gst-element-add-property-notify-watch
[deep-notify-watch]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstElement.html#gst-element-add-property-deep-notify-watch
[parse-notify]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstMessage.html#gst-message-parse-property-notify

##### GstBin "deep" element-added and element-removed signals

GstBin has gained `"deep-element-added"` and `"deep-element-removed"` signals
which makes it easier for applications and higher-level plugins to track when
elements are added or removed from a complex pipeline with multiple sub-bins.

playbin makes use of this to implement the new `"element-setup"` signal which
can be used to configure elements as they are added to playbin, just like the
existing `"source-setup"` signal which can be used to configure the source
element created.

##### Error messages can contain additional structured details

- FILL ME: e.g. HTTP status codes

##### Redirect messages have official API now

Sometimes elements need to redirect the current stream URL and tell the
application to proceed with a different URL, possibly using a different
protocol (thus changing the pipeline configuration). Until now this was
implemented informally using `ELEMENT` messages on the bus.

Now this has been formalised in form of a new `GST_MESSAGE_REDIRECT` message.
A new redirect message can be created using [`gst_message_new_redirect()`][new-redirect].
If needed, multiple redirect locations can be specified by calling
[`gst_message_add_redirect_entry()`][add-redirect] to add further redirect
entires, all with metadata so that the application can decide which is
most suitable (e.g. depending on the bitrate tags).

[new-redirect]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstMessage.html#gst-message-new-redirect
[add-redirect]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstMessage.html#gst-message-add-redirect-entry

##### New pad linking convenience functions that automatically create ghost pads

New pad linking convenience functions were added:
[`gst_pad_link_maybe_ghosting()`][pad-maybe-ghost] and
[`gst_pad_link_maybe_ghosting_full()`][pad-maybe-ghost-full] which were
previously internal to GStreamer have now been exposed for general use.

The existing pad link functions will refuse to link pads or elements at
different levels in the pipeline hierarchy, requiring the developer to
create ghost pads where necessary. These new utility functions will
automatically create ghostpads if needed when linking pads at different
levels of the hierarchy (e.g. from an element inside a bin to one that's at
the same level in the hierarchy as the bin, or in another bin).

[pad-maybe-ghost]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstPad.html#gst-pad-link-maybe-ghosting
[pad-maybe-ghost-full]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstPad.html#gst-pad-link-maybe-ghosting-full

##### Miscellaneous

Pad probes: IDLE and BLOCK probes now work slightly differently in pull mode
so that push and pull mode have opposite scenarios for idle and blocking probes.
In push mode it will block with some data type and IDLE won't have any data.
In pull mode it will block _before_ getting a buffer and will be IDLE once some
data has been obtained. ([commit][commit-pad-probes], [bug][bug-pad-probes])

[commit-pad-probes]: https://cgit.freedesktop.org/gstreamer/gstreamer/commit/gst/gstpad.c?id=368ee8a336d0c868d81fdace54b24431a8b48cbf
[bug-pad-probes]: https://bugzilla.gnome.org/show_bug.cgi?id=761211

[`gst_parse_launch_full()`][parse-launch-full] can now be made to return a
`GstBin` instead of a top-level pipeline by passing the new
`GST_PARSE_FLAG_PLACE_IN_BIN` flag.

[parse-launch-full]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstParse.html#gst-parse-launch-full

The default GStreamer debug log handler can now be removed already before
calling `gst_init()`, so that it will never get installed and won't be active
during initialisation.

#### GstStream API for stream announcement and stream selection

New stream listing and stream selection API: new API has been added to
provide high-level abstractions for streams ([`GstStream`][stream-api])
and collections of streams ([`GstStreamCollections`][stream-collection-api]).

##### Stream listing

A [`GstStream`][stream-api] contains all the information pertinent to a stream,
such as stream id, caps, tags, flags and stream type(s); it can represent a
single elementary streams (e.g. audio, video, subtitles, etc.) or a container
stream. It will depend on the context which it will be. In a decodebin3/playbin3
context it will typically be elementary streams that can be selected and
unselected.

A [`GstStreamCollection`][stream-collection-api] represents a group of streams
and is used to announce or publish all available streams. A GstStreamCollection
is immutable - once created it won't change. If the available streams change,
e.g. because a new stream appeared or some streams disappeared, a new stream
collection will be published. The new stream collection may contain streams
from the previous collection, if those streams persist, or completely new
streams. Stream collections do not yet list all theoretically available streams,
e.g. other available DVD angles or alternative resolutions/bitrate of the same
stream in case of adaptive streaming.

New events and messages have been added to notify or update other elements and
the application about which streams are currently available and/or selected.
This way we can easily and seamlessly let the application know whenever the
available streams change, as happens frequently with digital television streams
for example. The new system is also more flexible. For example, it is now also
possible for the application to select multiple streams of the same type
(e.g. in a transcoding/transmuxing scenario).

A [`STREAM_COLLECTION` message][stream-collection-msg] is posted on the bus
to inform the parent bin (e.g. playbin3, decodebin3) and/or the application
about what streams are available, so you no longer have to hunt for this
information (number of streams of each type, caps, tags etc.) in different
places. Bins and/or the application can intercept this message synchronously
to select and deselect streams before any data is produced (for the case where
elements such as the demuxers support the new stream  API, not necessarily in
the parsebin compatibility fallback case). Similarly, there is also a
[`STREAM_COLLECTION` event][stream-collection-event] to inform downstream
elements of the available streams. This event can be used by elements to
aggregate streams from multiple inputs into one single collection.

The `STREAM_START` event was extended so that it can also contain a GstStream
object with all information about the current stream, see
[`gst_event_set_stream()`][event-set-stream] and
[`gst_event_parse_stream()`][event-parse-stream].
[`gst_pad_get_stream()`][pad-get-stream] is a new utility function that can be
used to look up the GstStream from the `STREAM_START` sticky event on a pad.

[stream-api]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstStream.html
[stream-collection-api]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstStreamCollection.html
[stream-collection-msg]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstMessage.html#gst-message-new-stream-collection
[stream-collection-event]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstEvent.html#gst-event-new-stream-collection
[event-set-stream]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstEvent.html#gst-event-set-stream
[event-parse-stream]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstEvent.html#gst-event-parse-stream
[pad-get-stream]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstPad.html#gst-pad-get-stream

##### Stream selection

Once the available streams have been published, streams can be selected via
their stream ID using the new `SELECT_STREAMS` event, which can be created
with [`gst_event_new_select_streams()`][event-select-streams]. The new API
supports selecting multiple streams per stream type. In future we may also
implement explicit deselection of streams that will never be used so that
elements can skip those and never expose them or output data for them in the
first place.

The application is then notified of the currently selected streams via the
new `STREAMS_SELECTED` message on the pipeline bus, containing both the current
stream collection as well as the selected streams. This might be posted in
response to the application sending a `SELECT_STREAMS` event or when decodebin3
or playbin3 decide on the streams selected initially without application input.

[event-select-streams]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstEvent.html#gst-event-new-select-streams

##### Further reading

See further below for some notes on the new elements supporting this new
stream API, namely `decodebin3`, `playbin3` and `parsebin`.

More information about the new API and the new elements can also be found here:

- GStreamer [stream selection design docs][streams-design]
- Edward Hervey's talk ["The new streams API: Design and usage"][streams-talk] ([slides][streams-slides])
- Edward Hervey's talk ["Decodebin3: Dealing with modern playback use cases"][db3-talk] ([slides][db3-slides])

[streams-design]: https://cgit.freedesktop.org/gstreamer/gstreamer/tree/docs/design/part-stream-selection.txt
[streams-talk]: https://gstconf.ubicast.tv/videos/the-new-gststream-api-design-and-usage/
[streams-slides]: https://gstreamer.freedesktop.org/data/events/gstreamer-conference/2016/Edward%20Hervey%20-%20The%20New%20Streams%20API%20Design%20and%20Usage.pdf
[db3-talk]: https://gstconf.ubicast.tv/videos/decodebin3-or-dealing-with-modern-playback-use-cases/
[db3-slides]: https://gstreamer.freedesktop.org/data/events/gstreamer-conference/2015/Edward%20Hervey%20-%20decodebin3.pdf

#### Audio conversion and resampling API

The audio conversion library received a completely new and rewritten audio
resampler complementing the audio conversion routines moved into the audio
library in the [previous release][release-notes-1.8]. Integrating the resampler
with the other audio conversion library allows us to implement generic
conversion much more efficiently, as format conversion and resampling can now
be done in the same processing loop instead of having to do it in separate
steps (our element implementations do not make use of this yet though).

The new audio resampler library is a combination of some of the best features
of other samplers such as ffmpeg, speex, SRC. It natively supports S16, S32,
F32 and F64 formats and uses optimized x86 and neon assembly for most of its
processing. It has support for dynamically changing samplerates by incrementally
updating the filter tables using linear or cubic interpolation. According to
some benchmarks it's one of the fastest and most accurate resamplers around.

The audio resampler plugin has been ported to the new audioconverter library
to make use of this new resampler.

[release-notes-1.8]: https://gstreamer.freedesktop.org/releases/1.8/

#### Support for SMPTE timecodes

#### GStreamer OpenMAX IL plugin

- FILL ME

### New Elements

#### decodebin3, urisrcbin, parsebin and playbin3

#### LV2 source element and switch from slv2 to lilv2

#### WebRTC DSP Plugin for echo-cancellation, gain control and noise suppression

A set of new elements ([webrtcdsp][webrtcdsp], [webrtcechoprobe][webrtcechoprobe])
based on the WebRTC DSP software stack can now be used to improve your audio
voice communication pipelines. It currently supports echo cancellation,
gain control, noise suppression and more. For more details you may read
[Nicolas' blog post][webrtc-blog-post].

[webrtcdsp]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-webrtcdsp.html
[webrtcechoprobe]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-plugins/html/gst-plugins-bad-plugins-webrtcechoprobe.html
[webrtc-blog-post]: https://ndufresne.ca/2016/06/gstreamer-echo-canceller/

#### FDK AAC encoder and decoder

- FILL ME

### Noteworthy element features and additions

#### Major RTP and RTSP improvements

RTX, jitterbuffer, RTSP server fixes, rtspsrc seeking stability
App and protocol specific RTCP
RFC7273 support
H265 payloader sync with RFC

#### Improvements to splitmuxsrc

#### opencv plugins ported to OpenCV 3.1

#### OpenGL/GLES improvements

#### Vulkan

#### QML video sink ported to more platforms

#### KMS video sink

#### Wayland video sink

#### DVB improvements

#### DASH, HLS and adaptivedemux

trick modes, alternative renditions, ...

#### a2dpsink finally works

#### GStreamer VAAPI

#### V4L2 changes

- More pixels formats are now supported
- Decoder is now using `G_SELECTION` instead of deprecated `G_CROP`
- Decoder now uses `STOP` command to handle EOS
- Transform element can now scale the pixel aspect ratio
- Colorimetry support has been improved even more
- We now support `OUTPUT_OVERLAY` type of video node in v4l2sink

### Plugin moves

- FILL ME

### New leaks tracer

- FILL ME

### GES and NLE changes

- FILL ME

## Miscellaneous

- Additional machine-readable details in error messages, e.g. HTTP status
  codes
- New redirect message
- `gst_element_call_async()` API
- GstBin suppressed flags API
- GstAdapter PTS/DTS/offset at discont and discont tracking
- New video orientation interface
- appsrc duration in time and try pull API
- gst-libav uses ffmpeg 3.1
- x264enc has support for chroma-site and colorimetry settings
- JPEG2000 parser and caps cleanup
- Reverse playback support for videorate, deinterlace
- GstPoll / GstBus race conditions
- Various improvements for reverse playback and `KEY_UNITS` trick mode
- New cleaned up rawaudioparse, rawvideoparse elements
- Decklink 10 bit and timecode support, various fixes
- Multiview and other new API for GstPlayer

## Build and Dependencies

### Experimental meson-based build system

- FILL ME

## Platform-specific improvements

### Android

#### New universal binaries for all supported ABIs

We now provide a "universal" tarball to allow building apps against all the
architectures currently supported (x86, x86-64, armeabi, armeabi-v7a,
armeabi-v8a). This is needed for building with recent versions of the Android
NDK which defaults to building against all supported ABIs. Use [the Android
player example][android-player-example-build] as a reference of the required
changes.

[android-player-example-build]: https://cgit.freedesktop.org/gstreamer/gst-examples/commit/playback/player/android?id=a5cdde9119f038a1eb365aca20faa9741a38e788

#### Miscellaneous

- FILL ME

### OS/X and iOS

- We now support querying available devices on OS/X via the GstDeviceProvider
  API.

- FILL ME

### Windows

- FILL ME

## Contributors

- FILL ME

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing.

## Bugs fixed in 1.10

More than [~600 bugs][bugs-fixed-in-1.10] have been fixed during
the development of 1.10.

This list does not include issues that have been cherry-picked into the
stable 1.8 branch and fixed there as well, all fixes that ended up in the
1.8 branch are also included in 1.10.

This list also does not include issues that have been fixed without a bug
report in bugzilla, so the actual number of fixes is much higher.

[bugs-fixed-in-1.10]: https://bugzilla.gnome.org/buglist.cgi?bug_status=RESOLVED&bug_status=VERIFIED&classification=Platform&limit=0&list_id=107311&order=bug_id&product=GStreamer&query_format=advanced&resolution=FIXED&target_milestone=1.6.1&target_milestone=1.6.2&target_milestone=1.9.1&target_milestone=1.9.2&target_milestone=1.9.3&target_milestone=1.9.4&target_milestone=1.9.5&target_milestone=1.9.90&target_milestone=1.9.91&target_milestone=1.9.92&target_milestone=1.9.93&target_milestone=1.10.0

## Stable 1.10 branch

After the 1.10.0 release there will be several 1.10.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.10.x bug-fix releases will be made from the git 1.10 branch,
which is a stable branch.

### 1.10.0

1.10.0 was released on TBD 2016.

## Known Issues

- FILL ME

## Schedule for 1.12

Our next major feature release will be 1.12, and 1.11 will be the unstable
development version leading up to the stable 1.12 release. The development
of 1.11/1.12 will happen in the git master branch.

The plan for the 1.12 development cycle is yet to be confirmed, but it is
expected that feature freeze will be around early/mid-January,
followed by several 1.11 pre-releases and the new 1.12 stable release
in March.

1.12 will be backwards-compatible to the stable 1.10, 1.8, 1.6, 1.4, 1.2 and
1.0 release series.

- - -

*These release notes have been prepared by Sebastian Dröge, Arun Raghavan,
Tim-Philipp Müller, ....*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
