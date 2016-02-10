# GStreamer 1.8 Release Notes

**NOTE: THESE RELEASE NOTES ARE VERY INCOMPLETE AND STILL WORK-IN-PROGRESS**

**GStreamer 1.8 is scheduled for release in February 2016.**

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other
improvements.

See [http://gstreamer.freedesktop.org/releases/1.8/][latest] for the latest
version of this document.

*Last updated: Thursday 4 February 2016, 21:00 UTC [(log)][gitlog]*

[latest]: http://gstreamer.freedesktop.org/releases/1.8/
[gitlog]: http://cgit.freedesktop.org/gstreamer/www/log/src/htdocs/releases/1.8/release-notes-1.8.md

## Highlights

- FILL ME

- **Hardware-accelerated zero-copy video decoding on Android**

- **new video capture source for Android using the android.hardware.Camera API**

- **Windows Media reverse playback** support (ASF/WMV/WMA)

- **new tracing system** provides support for more sophisticated debugging tools

- **improved Opus audio codec support**: MPEG-TS demuxer/muxer can now handle Opus;
  [sample-accurate](http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-gstaudiometa.html#GstAudioClippingMeta)
  encoding/decoding/transmuxing with Ogg, Matroska, ISOBMFF (Quicktime/MP4),
  and MPEG-TS as container;
  [new codec utility functions for Opus header and caps handling](http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-gstpbutilscodecutils.html)
  in pbutils library.

- **GStreamer VAAPI module now released and maintained as part of the GStreamer project**

## Major new features and changes

### Adaptive streaming: DASH, HLS and MSS improvements

FIXME

- loading of external periods/adaptationsets/etc.?

- external clocks/timing?

- adaptive demuxers (hlsdemux, dashdemux, mssdemux) now support the SNAP_AFTER
  and SNAP_BEFORE seek flags which will jump to the nearest fragment boundary
  when executing a seek, which means playback resumes more quickly after a seek.

### Noteworthy new API, features and other changes

- new GstVideoAffineTransformationMeta meta for adding a simple 4x4 affine
  transformation matrix to video buffers

- [g\_autoptr()](https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.html#g-autoptr)
  support for all types is exposed in GStreamer headers now in combination
  with a sufficiently-new GLib version (i.e. 2.44 or later). This is primarily
  for the benefit of application developers who would like to make use of
  this, the GStreamer codebase itself will not be using g_autoptr() for
  the time being due to portability issues.

- GstContexts are now automatically propagated to elements added to a bin
  or pipeline, and elements now maintain a list of contexts set on them.
  The list of contexts set on an element can now be queried using the new functions
  [gst\_element\_get\_context()](http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstElement.html#gst-element-get-context)
  and [gst\_element\_get\_contexts()](http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstElement.html#gst-element-get-contexts). GstContexts are used to share context-specific configuration objects
  between elements and can also be used by applications to set context-specific
  configuration objects on elements, e.g. for OpenGL or Hardware-accelerated
  video decoding.

- new [GST\_BUFFER\_DTS\_OR\_PTS()](http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstBuffer.html#GST-BUFFER-DTS-OR-PTS:CAPS)
  convenience macro that returns the decode timestamp if one is set and
  otherwise returns the presentation timestamp

- new GstPadEventFullFunc that returns a GstFlowReturn instead of a gboolean.
  This new API is mostly for internal use and was added to fix a race condition
  where occasionally internal flow error messages were posted on the bus when
  sticky events were propagated at just the wrong moment whilst the pipeline
  is shutting down. This happens primarily when the pipeline is shut down
  immediately after starting it up. GStreamer would not know that the reason
  the events could not be propagated is because the pipeline is shutting down
  and not some other problem, and now the flow error allows GStreamer to know
  the reason for the failure (and that there's no reason to post an error
  message). This is particularly useful for queue-like elements which may need
  to asynchronously propagate a previous flow return from downstream.

- pipeline dumps in form of "dot files" now also show pad properties that
  differ fro their default value, same it does for elements. This is
  useful for elements with pad subclasses that provide additional properties,
  e.g. videomixer or compositor.

- pad probes are now guaranteed to be called in the order they were added
  (before they were called in reverse order, but no particular order was
  documented or guaranteed)

- plugins can now have dependencies on device nodes (not just regular files)
  and also have a prefix filter. This is useful for plugins that expose
  features (elements) based on available devices, such as the video4linux
  plugin in case of video decoders on certain embedded systems.

- gst\_segment\_to\_position() has been deprecated and been replaced by the
  better-named gst\_segment\_position\_from\_running\_time(). At the same time
  gst\_segment\_position\_from\_stream\_time() was added, as well as \_full()
  variants of both to cater for negative stream time.

- GstController: the interpolation control source gained a new monotonic cubic
  interpolation mode that unlike the existing cubic mode will never overshoot
  the min/max y values set.

- GstNetAddressMeta: can now be read from buffers in language bindings as well,
  via the new gst\_buffer\_get\_net\_address\_meta() function

- ID3 tag PRIV frames are now extraced into a new GST\_TAG\_PRIVATE\_DATA tag

- gst-launch-1.0 and gst\_parse\_launch() now warn in the most common case if
  a dynamic pad link could not be resolved, instead of just silently
  waiting to see if a suitable pad appears later, which is often perceived
  by users as hanging. Now at least they are being notified and can check
  their pipeline.

- GstRTSPConnection now also parses custom RTSP message headers and retains
  them for the application instead of just ignoring them

- rtspsrc: fix authentication over tunneled connections (e.g. RTSP over HTTP)

- gst\_video\_convert\_sample() now crops if there is a crop meta on the input buffer

- the debugging system printf functions are now exposed for general use, which
  supports special printf format specifiers such as GST\_PTR\_FORMAT and
  GST\_SEGMENT\_FORMAT to print GStreamer-related objects. This is handy for
  systems that want to prepare some debug log information to be output at a
  later point in time. The GStreamer-OpenGL subsystem is making use of these
  new functions, which are [gst\_info\_vasprintf()][gst_info_vasprintf],
    [gst\_info\_strdup\_vprintf()][gst_info_strdup_vprintf] and
    [gst\_info\_strdup\_printf()][gst_info_strdup_printf].

[gst_info_vasprintf]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstInfo.html#gst-info-vasprintf
[gst_info_strdup_vprintf]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstInfo.html#gst-info-strdup-vprintf
[gst_info_strdup_printf]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstInfo.html#gst-info-strdup-printf

### Noteworthy element features and additions

**FIXME**: a lot of this should probably be moved down into 'Miscellaneous'

- *identity*: new ["drop-buffer-flags"](http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-plugins/html/gstreamer-plugins-identity.html#GstIdentity--drop-buffer-flags)
  property to drop buffers based on buffer flags. This can be used to drop all
  non-keyframe buffers, for example.

- *multiqueue*: various fixes and improvement, in particular add special handling
  for sparse streams such as substitle streams, to make sure we don't overread
  them any more. For sparse streams it can be normal that there's no buffer for
  a long period of time, so having no buffer queued is perfectly normal. Before
  we would often unnecessarily try to fill the subtitle stream queue, which
  could lead to much more data being queued in multiqueue than necessary.

- *queue2*: new ["avg-in-rate"](http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-plugins/html/gstreamer-plugins-queue2.html#GstQueue2--avg-in-rate)
  property that returns the average input rate in bytes per second; also an
  ["overrun"](http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-plugins/html/gstreamer-plugins-queue2.html#GstQueue2-overrun) 
  signal (**FIXME** might get removed again before release, double-check)

**FIXME: add alsamidisrc to docs and add link here**

- [alsamidisrc](): a new ALSA MIDI sequencer source element

- audiotestsrc now supports all audio formats and is no longer artificially
  limited with regard to the number of channels or sample rate

- gst-libav (ffmpeg codec wrapper): map and enable JPEG2000 decoder

- [multisocketsink] can on request send a custom GstNetworkMessage event
  upstream whenever data is received from a client on a socket. Similarly,
  [socketsrc] will on request pick up GstNetworkMessage events from downstream
  and send any data contained within them via the socket. This allows for
  simple bidirectional communication.

- matroska muxer and demuxer now support the ProRes video format

- improved VP8/VP9 decoding performance on multi-core systems by enabling
  multi-threaded decoding in the libvpx-based decoders on such systems

- appsrc has a new "wait-on-eos" property, so in cases where it
  is uncertain if an appsink will have a consumer for its buffers when it
  receives an EOS this can be set to FALSE to ensure that the appsink will
  not hang.

- rtph264pay and rtph265pay have a new "config-interval" mode -1 that will
  re-send the setup data (SPS/PPS/VPS) before every keyframe to ensure
  optimal coverage and the shortest possibly start-up time for a new client

- mpegtsmux can now mux H.265/HEVC video as well

### New tracing tools for developers

A new tracing subsystem API has been added to GStreamer, which provides
external tracers with the possibility to strategically hook into GStreamer
internals and collect data that can be evaluated later. These tracers are a
new type of plugin features, and GStreamer core ships with a few example
tracers (latency, stats, rusage, log) to start with. Tracers can be loaded
and configured at start-up via an environment variable (GST\_TRACER\_PLUGINS).

Background: Whilst GStreamer provides plenty of data of what's going on in a
pipeline via its debug log, that data is not necessarily structured enough to
be generally useful, and the overhead to enable logging output for all data
required might be too high in many cases. The new tracing system allows tracers
to just obtain the data needed at the right spot with as little overhead as
possible, which will be particularly useful on embedded systems.

Of course it has always been possible to do performance benchmarks and debug
memory leaks, memory consumption and invalid memory access using standard
operating system tools, but there are some things that are difficult to track
with the standard tools, and the new tracing system helps with that. Examples
are things such as latency handling, buffer flow, ownership transfer of
events and buffers from element to element, caps negotiation, etc.

For some background on the new tracing system, watch Stefan Sauer's
GStreamer Conference talk ["A new tracing subsystem for GStreamer"][tracing-0]
and for a more specific example how it can be useful have a look at
Thiago Santos's lightning talk ["Analyzing caps negotiation using GstTracer"][tracer-1]
and his ["GstTracer experiments"][tracer-2] blog post.

This is all still very much work in progress, but we hope this will provide the
foundation for a whole suite of new debugging tools for GStreamer pipelines.

[tracer-0]: https://gstconf.ubicast.tv/videos/a-new-tracing-subsystem-for-gstreamer/
[tracer-1]: https://gstconf.ubicast.tv/videos/analyzing-caps-negotiation-using-gsttracer/
[tracer-2]: http://blog.thiagoss.com/2015/07/23/gsttracer-experiments/

### GstPlayer: a new high-level API for cross-platform multimedia playback

GStreamer has had reasonably high-level API for multimedia playback
in the form of the playbin element for a long time. This allowed application
developers to just configure a URI to play, and playbin would take care of
everything else. This works well, but there is still way too much to do on
the application-side to implement a fully-featured playback application, and
too much general GStreamer pipeline API exposed, which does not exactly make
it the most accessible API to start with.

Enter GstPlayer. GstPlayer's aim is to provide an even higher-level abstraction
of a fully-featured playback API but specialised for its specific use case. It
also provides easy integration with and examples for Gtk+, Qt, Android, OS/X,
iOS and Windows. Watch Sebastian's [GstPlayer talk at the GStreamer Conference][gstplayer-talk]
for more information, or check out the [GstPlayer API reference][gstplayer-api]
and [GstPlayer examples][gstplayer-examples].

[gstplayer-api]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-libs/html/player.html
[gstplayer-talk]: https://gstconf.ubicast.tv/videos/gstplayer-a-simple-cross-platform-api-for-all-your-media-playback-needs-part-1/
[gstplayer-examples]: https://github.com/sdroege/gst-player/

### Audio library improvements

- audio conversion, quantization and channel up/downmixing functionality
  has been moved from the audioconvert element into the audio library and
  is now available as public API in form of [GstAudioConverter][audio-0],
  [GstAudioQuantize][audio-1] and [GstAudioChannelMixer][audio-2].
  Audio resampling will follow in future releases. **FIXME**: link to docs

- [gst\_audio\_channel\_get\_fallback\_mask()][audio-3]
  to retrieve a default channel mask for a given number of channels as last
  resort if the layout is unknown

- new [GstAudioClippingMeta][audio-4] meta for specifying clipping on encoded
  audio buffers

- new [GstAudioVisualizer][audio-5] base class for audio visualisation elements;
  most of the existing visualisers have been ported over to the new base class.
  This new base class lives in the pbutils library rather than the audio library,
  since we'd have had to make libgstaudio depend on libgstvideo otherwise,
  which was deemed somewhat undesirable.

[audio-0]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstAudioConverter.html
[audio-1]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstAudioQuantize.html
[audio-2]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-gstaudiochannels.html#gst-audio-channel-mix-new
[audio-3]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-gstaudiochannels.html#gst-audio-channel-get-fallback-mask
[audio-4]: http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-gstaudiometa.html#GstAudioClippingMeta
[audio-5]: **FIXME: add GstAudioVisualizer to docs and add link here**

### GStreamer OpenGL support improvements

FIXME


### GStreamer VAAPI support for hardware-accelerated video decoding and encoding on Intel (and other) platforms

#### GStreamer VAAPI is now part of upstream GStreamer

The GStreamer-VAAPI module which provides support for hardware-accelerated
video decoding, encoding and post-processing on Intel graphics hardware
on Linux has moved from its previous home at the [Intel Open Source Technology Center][iostc]
to the upstream GStreamer repositories, where it will in future be maintained
as part of the upstream GStreamer project and released in lockstep with the
other GStreamer modules. The current maintainers will continue to spearhead
the development at the new location:

[http://cgit.freedesktop.org/gstreamer/gstreamer-vaapi/][gst-vaapi-git]

[gst-vaapi-git]: http://cgit.freedesktop.org/gstreamer/gstreamer-vaapi/

GStreamer-VAAPI relies heavily on certain GStreamer infrastructure API that
is still in flux such as the OpenGL integration API or the codec parser
libraries, and one of the goals of the move was to be able to leverage
new developments early and provide tighter integration with the latest
developments of those APIs and other graphics-related APIs provided by
GStreamer, which should hopefully improve performance even further and in
some cases might also provide better stability.

Thanks to everyone involved in making this move happen!

#### GStreamer VAAPI: Bug tracking

Bugs had already been tracked on [GNOME bugzilla](bgo) but will be moved
from the gstreamer-vaapi product into a new gstreamer-vaapi component of
the GStreamer product in bugzilla. Please file new bugs against the new
component in the GStreamer product from now on.

#### GStreamer VAAPI: Pending patches

The code base has been re-indented to the GStreamer code style, which
affected some files more than others. This means that some of the patches
in bugzilla might not apply any longer, so if you have any unmerged patches
sitting in bugzilla please consider checking if they still apply cleany and
refresh them if not. Sorry for any inconvenience this may cause.

#### GStreamer VAAPI: New versioning scheme and supported GStreamer versions

The version numbering has been changed to match the GStreamer version
numbering to avoid confusion: there is a new gstreamer-vaapi 1.6.0 release
and a 1.6 branch that is roughly equivalent to the previous 0.7.0 version.
Future releases 1.7.x and 1.8.x will be made alongside GStreamer releases.

Whilst it was possible and supported by previous releases to build against
a whole range of different GStreamer versions (such as 1.2, 1.4, 1.6 or 1.7/1.8),
in future there will only be one target branch, so that git master will
track GStreamer git master, 1.8.x will target GStreamer 1.8, and
1.6.x is targetting the 1.6 series.

[iostc]: http://01.org
[bgo]:   http://bugzilla.gnome.og

#### GStreamer VAAPI: Miscellaneous changes

All GStreamer-VAAPI functionality is now provided solely by its GStreamer
elements. There is no more public library exposing GstVaapi API, this API
was only ever meant for private use by the elements. Parts of it may be
resurrected again in future if needed, but for now it has all been made
private.

GStreamer-VAAPI now unconditionally uses the codecparser library in
gst-plugins-bad instead of shipping its own internal copy. Similarly,
it no longer ships its own codec parsers but relies on the upstream
codec parser elements.

The GStreamer-VAAPI encoder elements have been renamed from vaapiencode_foo
to vaapifooenc, so encoders are now called vaapih264enc, vaapih265enc,
vaapimpeg2enc, vaapijpegenc, and vaapivp8enc.

#### GStreamer VAAPI: New features in 1.8: 10-bit H.265/HEVC decoding support

Support for decoding 10-bit H.265/HEVC has been added. For the time being
this only works in combination with vaapisink though, until support for the
P010 video format used internally is added to GStreamer and to the
vaGetImage()/vaPutimage() API in the vaapi-intel-driver.

### GStreamer Editing Services

FIXME

### GstValidate

FIXME


### cerbero build tool for SDK binary packages

FIXME

cerbero is a custom build too that builds GStreamer plus dependencies on
non-Linux operating systems such as Windows, OS/X, iOS and Android, and
produces SDK binary packages for those systems. This is needed because
GStreamer depends on a large number of external libraries, all of which in
turn have dependencies of their own. These dependent libraries are usually
not present or available on non-unix operating systems, so everything GStreamer
needs has to be pretty much built from scratch so that it can be used on on
those systems.

FIXME

## Miscellaneous

- encodebin now works with "encoder-muxers" such as wavenc

- gst-play-1.0 acquired a new keyboard shortcut: '0' seeks back to the start

- gst-play-1.0 supports two new command line switches: -v for verbose output
  and --flags to configure the playbin flags to use.

## Build and Dependencies

- the GLib dependency requirement was bumped to 2.40

- the -Bsymbolic configure check now works with clang as well

- ffmpeg is now required as libav provider, incompatible changes were
  introduced that make it no longer viable to support both FFmpeg and Libav
  as libav providers. Most major distros have switched to FFmpeg or are in
  the process of switching to it anyway, so we don't expect this to be a
  problem, and there is still an internal copy of ffmpeg that can be used
  as fallback if needed.

## Platform-specific improvements

### Android

- zero-copy video decoding on Android using the hardware-accelerated decoders
  has been implemented, and is fully integrated with the GStreamer OpenGL stack

- ahcsrc, a new camera source element, has been merged and can be used to
  capture video on android devices. It uses the android.hardware.Camera Java
  API to capture from the system's cameras.

- the OpenGL-based QML video sink can now also be used on Android

- new tinyalsasink element

### OS/X and iOS

- the system clock now uses mach\_absolute\_time() on OSX/iOS, which is
the preferred high-resolution monotonic clock to be used on Apple platforms

- FIXME: loads of applemedia/avfsrc/gl improvements

### Windows

FIXME

### Linux

FIXME

## Contributors

FIXME

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing.

## Bugs fixed in 1.8

More than [~9999 bugs FIXME)][bugs-fixed-in-1.8] have been fixed during
the development of 1.8.

This list does not include issues that have been cherry-picked into the
stable 1.6 branch and fixed there as well, all fixes that ended up in the
1.6 branch are also included in 1.8.

This list also does not include issues that have been fixed without a bug
report in bugzilla, so the actual number of fixes is much higher.

[bugs-fixed-in-1.8]: https://bugzilla.gnome.org/buglist.cgi?bug_status=RESOLVED&bug_status=VERIFIED&classification=Platform&limit=0&order=bug_id&product=GStreamer&query_format=advanced&resolution=FIXED&target_milestone=1.7.1&target_milestone=1.7.2&target_milestone=1.7.3&target_milestone=1.7.4&target_milestone=1.7.90&target_milestone=1.7.91&target_milestone=1.7.92&target_milestone=1.7.x&target_milestone=1.8.0

## Stable 1.8 branch

After the 1.8.0 release there will be several 1.8.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.8.x bug-fix releases will be made from the git 1.8 branch, which
is a stable branch.

### 1.8.0

1.8.0 was released on XX February 2016. (FIXME)

### 1.8.1

The first 1.8 bug-fix release (1.8.1) is planned for FIXME 2016.

## Schedule for 1.10

Our next major feature release will be 1.10, and 1.9 will be the unstable
development version leading up to the stable 1.10 release. The development
of 1.9/1.10 will happen in the git master branch.

The plan for the 1.10 development cycle is to get a first 1.9 development
release out by June 2016 and have our first 1.10 release candidate ready
in July 2016, so that we can release 1.10 in August 2016.

1.10 will be backwards-compatible to the stable 1.8, 1.6, 1.4, 1.2 and 1.0
release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller with
contributions from **FIXME**.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
