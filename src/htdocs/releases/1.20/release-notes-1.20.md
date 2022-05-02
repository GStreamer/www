# GStreamer 1.20 Release Notes

GStreamer 1.20.0 was originally released on 3 February 2022.

The latest bug-fix release in the 1.20 series is [1.20.2](#1.20.2) and was released on 2 May 2022.

See [https://gstreamer.freedesktop.org/releases/1.20/][latest] for the latest version of this document.

*Last updated: Monday 2 May 2022, 0:30 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.20/
[gitlog]: https://gitlab.freedesktop.org/gstreamer/www/commits/master/src/htdocs/releases/1.20/release-notes-1.20.md

## Introduction

The GStreamer team is proud to announce a new major feature release in the stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with many new features, bug fixes and other improvements.

## Highlights

- Development in GitLab was switched to a single git repository containing all the modules
- GstPlay: new high-level playback library, replaces GstPlayer
- WebM Alpha decoding support
- Encoding profiles can now be tweaked with additional application-specified element properties
- Compositor: multi-threaded video conversion and mixing
- RTP header extensions: unified support in RTP depayloader and payloader base classes
- SMPTE 2022-1 2-D Forward Error Correction support
- Smart encoding (pass through) support for VP8, VP9, H.265 in encodebin and transcodebin
- Runtime compatibility support for libsoup2 and libsoup3 (libsoup3 support experimental)
- Video decoder subframe support
- Video decoder automatic packet-loss, data corruption, and keyframe request handling for RTP / WebRTC / RTSP
- mp4 and Matroska muxers now support profile/level/resolution changes for H.264/H.265 input streams (i.e. codec data changing on the fly)
- mp4 muxing mode that initially creates a fragmented mp4 which is converted to a regular mp4 on EOS
- Audio support for the WebKit Port for Embedded (WPE) web page source element
- CUDA based video color space convert and rescale elements and upload/download elements
- NVIDIA `memory:NVMM` support for OpenGL `glupload` and `gldownload` elements
- Many WebRTC improvements
- The new VA-API plugin implementation fleshed out with more decoders and new postproc elements
- AppSink API to retrieve events in addition to buffers and buffer lists
- AppSrc gained more configuration options for the internal queue (leakiness, limits in buffers and time, getters to read current levels)
- Updated Rust bindings and many new Rust plugins
- Improved support for custom minimal GStreamer builds
- Support build against FFmpeg 5.0
- Linux Stateless CODEC support gained MPEG-2 and VP9
- Windows Direct3D11/DXVA decoder gained AV1 and MPEG-2 support
- Lots of new plugins, features, performance improvements and bug fixes

## Major new features and changes

### Noteworthy new features and API

- `gst_element_get_request_pad()` has been deprecated in favour of the newly-added `gst_element_request_pad_simple()` which does the exact same thing but has a less confusing name that hopefully makes clear that the function request a new pad rather than just retrieves an already-existing request pad.

#### Development in GitLab was switched to a single git repository containing all the modules

The GStreamer multimedia framework is a set of libraries and plugins split into a number of distinct modules which are released independently and which have so far been developed in separate git repositories in freedesktop.org GitLab.

In addition to these separate git repositories there was a gst-build module that would use the Meson build system's subproject feature to download each individual module and then build everything in one go. It would also provide an uninstalled development environment that made it easy to work on GStreamer and use or test versions other than the system-installed GStreamer version.

All of these modules have now (as of 28 September 2021) been merged into a single git repository ("Mono repository" or "monorepo") which should simplify development workflows and continuous integration, especially where changes need to be made to multiple modules at once.

This mono repository merge will primarily affect GStreamer developers and contributors and anyone who has workflows based on the GStreamer git repositories.

The Rust bindings and Rust plugins modules have not been merged into the mono repository at this time because they follow a different release cycle.

The mono repository lives in the existing [GStreamer core git repository in GitLab][git-repo] in the new `main` branch and all future development will happen on this branch.

Modules will continue to be released as separate tarballs.

For more details, please see the [GStreamer mono repository FAQ][monorepo-faq].

[git-repo]: https://gitlab.freedesktop.org/gstreamer/gstreamer/
[monorepo-faq]: https://gstreamer.freedesktop.org/documentation/frequently-asked-questions/mono-repository.html

#### GstPlay: new high-level playback library replacing GstPlayer

- [GstPlay][gst-play-lib] is a new high-level playback library that replaces the older [GstPlayer][gst-player-lib] API. It is basically the same API as `GstPlayer` but refactored to use bus messages for application notifications instead of GObject signals. There is still a signal adapter object for those who prefer signals. Since the existing `GstPlayer` API is already in use in various applications, it didn't seem like a good idea to break it entirely. Instead a new API was added, and it is expected that this new GstPlay API will be moved to gst-plugins-base in future.

- The existing `GstPlayer` API is scheduled for deprecation and will be removed at some point in the future (e.g. in GStreamer 1.24), so application developers are urged to migrate to the new `GstPlay` API at their earliest convenience.

[gst-player-lib]: https://gstreamer.freedesktop.org/documentation/player/gstplayer.html
[gst-play-lib]: https://gstreamer.freedesktop.org/documentation/play/gstplay.html

#### WebM alpha decoding

- Implement WebM alpha decoding (VP8/VP9 with alpha), which required support and additions in various places. This is supported both with software decoders and hardware-accelerated decoders.

- VP8/VP9 don't support alpha components natively in the codec, so the way this is implemented in WebM is by encoding the alpha plane with transparency data as a separate VP8/VP9 stream. Inside the WebM container (a variant of Matroska) this is coded as a single video track with the "normal" VP8/VP9 video data making up the main video data and each frame of video having an encoded alpha frame attached to it as extra data (`"BlockAdditional"`).

- `matroskademux` has been extended extract this per-frame alpha side data and attach it in form of a `GstVideoCodecAlphaMeta` to the regular video buffers. Note that this new meta is specific to this VP8/VP9 alpha support and can't be used to just add alpha support to other codecs that don't support it. Lastly, `matroskademux` also advertises the fact that the streams contain alpha in the caps.

- The new `codecalpha` plugin contains various bits of infrastructure to support autoplugging and debugging:
    - `codecalphademux` splits out the alpha stream from the metas on the regular VP8/VP9 buffers
    - `alphacombine` takes two decoded raw video streams (one alpha, one the regular video) and combines it into a video stream with alpha
    - `vp8alphadecodebin` + `vp9alphadecodebin` are wrapper bins that use the regular `vp8dec` and `vp9dec` software decoders to decode regular and alpha streams and combine them again. To decodebin these look like regular decoders.
    - The V4L2 CODEC plugin has stateless VP8/VP9 decoders that can decode both alpha and non-alpha stream with a single decoder instance

- A new `AV12` video format was added which is basically NV12 with an alpha plane, which is more convenient for many hardware-accelerated decoders.

- Watch Nicolas Dufresne's LCA 2022 talk ["Bringing WebM Alpha support to GStreamer"](https://www.youtube.com/watch?v=R0flfhLok94) for all the details and a demo.


#### RTP Header Extensions Base Class and Automatic Header Extension Handling in RTP Payloaders and Depayloaders

- RTP Header Extensions are specified in [RFC 5285][rfc-5285] and provide a way to add small pieces of data to RTP packets in between the RTP header and the RTP payload. This is often used for per-frame metadata, extended timestamps or other application-specific extra data. There are several commonly-used extensions specified in various RFCs, but senders are free to put any kind of data in there, as long as sender and receiver both know what that data is. Receivers that don't know about the header extensions will just skip the extra data without ever looking at it. These header extensions can often be combined with any kind of payload format, so may need to be supported by many RTP payloader and depayloader elements.

- Inserting and extracting RTP header extension data has so far been a bit inconvenient in GStreamer: There are functions to add and retrieve RTP header extension data from RTP packets, but nothing works automatically, even for common extensions. People would have to do the insertion/extraction either in custom elements before/after the RTP payloader/depayloader, or inside pad probes, which isn't very nice.

- This release adds various pieces of new infrastructure for generic RTP header extension handling, as well as some implementations for common extensions:

    - [`GstRTPHeaderExtension`][header-ext-obj] is a new helper base class for reading and writing RTP header extensions. Nominally this subclasses `GstElement`, but only so these extensions are stored in the registry where they can be looked up by URI or name. They don't have pads and don't get added to the pipeline graph as an element.

    - `"add-extension"` and `"clear-extension"` action signals on RTP payloaders and depayloaders for manual extension management

    - The `"request-extension"` signal will be emitted if an extension is encountered that requires explicit mapping by the application

    - new `"auto-header-extension"` property on RTP payloaders and depayloaders for automatic handling of known header extensions. This is enabled by default. The extensions must be signalled via caps / SDP.

    - RTP header extension implementations:

        - `rtphdrextclientaudiolevel`: Client-to-Mixer Audio Level Indication ([RFC 6464][rfc-6464]) (also see below)
        - `rtphdrextcolorspace`: [Color Space extension][ext-color-space], extends RTP packets with color space and high dynamic range (HDR) information
        - `rtphdrexttwcc`: Transport Wide Congestion Control support

- `gst_rtp_buffer_remove_extension_data()` is a new helper function to remove an RTP header extension from an RTP buffer

- The existing `gst_rtp_buffer_set_extension_data()` now also supports shrinking the extension data in size

[rfc-6464]: https://datatracker.ietf.org/doc/html/rfc6464
[rfc-5285]: https://datatracker.ietf.org/doc/html/rfc8285
[header-ext-obj]: https://gstreamer.freedesktop.org/documentation/rtplib/gstrtphdrext.html?gi-language=c#GstRTPHeaderExtension
[ext-color-space]: http://www.webrtc.org/experiments/rtp-hdrext/color-space

#### AppSink and AppSrc improvements

- **appsink**: new API to pull events out of `appsink` in addition to buffers and buffer lists.

  There was previously no way for users to receive incoming events from `appsink` properly serialised with the data flow, even if they are serialised events. The reason for that is that the only way to intercept events was via a pad probe on the `appsink` sink pad, but there is also internal queuing inside of `appsink`, so it's difficult to ascertain the right order of everything in all cases.

  There is now a new `"new-serialized-event"` signal which will be emitted when there's a new event pending (just like the existing `"new-sample"` signal). The `"emit-signals"` property must be set to TRUE in order to activate this (but it's also fine to just pull from the application thread without using the signals).

  `gst_app_sink_pull_object()` and `gst_app_sink_try_pull_object()` can be used to pull out either an event or a new sample carrying a buffer or buffer list, whatever is next in the queue.

  `EOS` events will be filtered and will not be returned. EOS handling can be done the usual way, same as with `_pull_sample()`.

- **appsrc**: allow configuration of internal queue limits in time and buffers and add leaky mode.

  There is internal queuing inside `appsrc` so the application thread can push data into the element which will then be picked up by the source element's streaming thread and pushed into the pipeline from that streaming thread. This queue is unlimited by default and until now it was only possible to set a maximum size limit in bytes. When that byte limit is reached, the pushing thread (application thread) would be blocked until more space becomes available.

  A limit in bytes is not particularly useful for many use cases, so now it is possible to also configure limits in time and buffers using the new `"max-time"` and `"max-buffers"` properties. Of course there are also matching new read-only`"current-level-buffers"` and `"current-level-time properties"` properties to query the current fill level of the internal queue in time and buffers.

  And as if that wasn't enough the internal queue can also be configured as leaky using the new `"leaky-type"` property. That way when the queue is full the application thread won't be blocked when it tries to push in more data, but instead either the new buffer will be dropped or the oldest data in the queue will be dropped.

#### Better string serialization of nested GstCaps and GstStructures

- New string serialisation format for structs and caps that can handle nested structs and caps properly by using brackets to delimit nested items (e.g. `some-struct, some-field=[nested-struct, nested=true]`). Unlike the default format the new variant can also support more than one level of nesting. For backwards-compatibility reasons the old format is still output by default when serialising caps and structs using the existing API. The new functions `gst_caps_serialize()` and `gst_structure_serialize()` can be used to output strings in the new format.

#### Convenience API for custom GstMetas

- New convenience API to register and create custom GstMetas: `gst_meta_register_custom()` and `gst_buffer_add_custom_meta()`. Such custom meta is backed by a `GstStructure` and does not require that users of the API expose their `GstMeta` implementation as public API for other components to make use of it. In addition, it provides a simpler interface by ignoring the impl vs. api distinction that the regular API exposes. This new API is meant to be the meta counterpart to custom events and messages, and to be more convenient than the lower-level API when the absolute best performance isn't a requirement. The reason it's less performant than a "proper" meta is that a proper meta is just a C struct in the end whereas this goes through the `GstStructure` API which has a bit more overhead, which for most scenarios is negligible however. This new API is useful for experimentation or proprietary metas, but also has some limitations: it can only be used if there's a single producer of these metas; registering the same custom meta multiple times or from multiple places is not allowed.

#### Additional Element Properties on Encoding Profiles

- `GstEncodingProfile`: The new `"element-properties"` and `gst_encoding_profile_set_element_properties()` API allows applications to set additional element properties on encoding profiles to configure muxers and encoders. So far the encoding profile template was the only place where this could be specified, but often what applications want to do is take a ready-made encoding profile shipped by GStreamer or the application and then tweak the settings on top of that, which is now possible with this API. Since applications can't always know in advance what encoder element will be used in the end, it's even possible to specify properties on a per-element basis.

  Encoding Profiles are used in the `encodebin`, `transcodebin` and `camerabin` elements and APIs to configure output formats (containers and elementary streams).

#### Audio Level Indication Meta for RFC 6464

- New [`GstAudioLevelMeta`][audiolevelmeta] containing Audio Level Indication as per [RFC 6464][rfc-6464]

- The `level` element has been updated to add `GstAudioLevelMeta` on buffers if the `"audio-level-meta"` property is set to TRUE. This can then in turn be picked up by RTP payloaders to signal the audio level to receivers through RTP header extensions (see above).

- New [Client-to-Mixer Audio Level Indication (RFC6464) RTP Header Extension][rtphdrextclientaudiolevel] which should be automatically created and used by RTP payloaders and depayloaders if their `"auto-header-extension"` property is enabled and if the extension is part of the RTP caps.

[audiolevelmeta]: https://gstreamer.freedesktop.org/documentation/audio/gstaudiometa.html?gi-language=c#GstAudioLevelMeta

[rtphdrextclientaudiolevel]: https://gstreamer.freedesktop.org/documentation/rtpmanager/rtphdrextclientaudiolevel.html?gi-language=c

#### Automatic packet loss, data corruption and keyframe request handling for video decoders

- The `GstVideoDecoder` base class has gained various new APIs to automatically handle packet loss and data corruption better by default, especially in RTP, RTSP and WebRTC streaming scenarios, and to give subclasses more control about how they want to handle missing data:

    - Video decoder subclasses can mark output frames as corrupted via the new `GST_VIDEO_CODEC_FRAME_FLAG_CORRUPTED` flag

    - A new `"discard-corrupted-frames"` property allows applications to configure decoders so that corrupted frames are directly discarded instead of being forwarded inside the pipeline. This is a replacement for the `"output-corrupt"` property of the FFmpeg decoders.

    - RTP depayloaders can now signal to decoders that data is missing when sending GAP events for lost packets. GAP events can be sent for various reason in a GStreamer pipeline. Often they are just used to let downstream elements know that there isn't a buffer available at the moment, so downstream elements can move on instead of waiting for one. They are also sent by RTP depayloaders in the case that packets are missing, however, and so far a decoder was not able to differentiate the two cases. This has been remedied now: GAP events can be decorated with `gst_event_set_gap_flags()` and `GST_GAP_FLAG_MISSING_DATA` to let decoders now what happened, and decoders can then use that in some cases to handle missing data better.

    - The `GstVideoDecoder::handle_missing_data` vfunc was added to inform subclasses about packet loss or missing data and let them handle it in their own way if they like.

    - `gst_video_decoder_set_needs_sync_point()` lets subclasses signal that they need the stream to start with a sync point. If enabled, the base class will discard all non-sync point frames in the beginning and after a flush and does not pass them to the subclass. Furthermore, if the first frame is not a sync point, the base class will try and request a sync frame from upstream by sending a force-key-unit event (see next items).

    - New `"automatic-request-sync-points"` and `"automatic-request-sync-point-flags"` properties to automatically request sync points when needed, e.g. on packet loss or if the first frame is not a keyframe. Applications may want to enable this on decoders operating in e.g. RTP/WebRTC/RTSP receiver pipelines.

    - The new `"min-force-key-unit-interval"` property can be used to ensure there's a minimal interval between keyframe requests to upstream (and/or the sender) and we're not flooding the sender with key unit requests.

    - `gst_video_decoder_request_sync_point()` allows subclasses to request a new sync point (e.g. if they choose to do their own missing data handling). This will still honour the `"min-force-key-unit-interval"` property if set.

### Improved support for custom minimal GStreamer builds

- Element registration and registration of other plugin features inside plugin init functions has been improved in order to facilitate minimal custom GStreamer builds.

- A number of new macros have been added to declare and create per-element and per-plugin feature register functions in all plugins, and then call those from the per-plugin plugin_init functions:
    - `GST_ELEMENT_REGISTER_DEFINE`, `GST_DEVICE_PROVIDER_REGISTER_DEFINE`, `GST_DYNAMIC_TYPE_REGISTER_DEFINE`, `GST_TYPE_FIND_REGISTER_DEFINE` for the actual registration call with GStreamer
    - `GST_ELEMENT_REGISTER`, `GST_DEVICE_PROVIDER_REGISTER`, `GST_DYNAMIC_TYPE_REGISTER`, `GST_PLUGIN_STATIC_REGISTER`, `GST_TYPE_FIND_REGISTER` to call the registration function defined by the `REGISTER_DEFINE` macro
    - `GST_ELEMENT_REGISTER_DECLARE`, `GST_DEVICE_PROVIDER_REGISTER_DECLARE`, `GST_DYNAMIC_TYPE_REGISTER_DECLARE`, `GST_TYPE_FIND_REGISTER_DECLARE` to declare the registration function defined by the `REGISTER_DEFINE` macro
    - and various variants for advanced use cases.

- This means that applications can call the per-element and per-plugin feature registration functions for only the elements they need instead of registering plugins as a whole with all kinds of elements that may not be required (e.g. encoder and decoder instead of just decoder). In case of static linking all unused functions and their dependencies would be removed in this case by the linker, which helps minimise binary size for custom builds.

- `gst_init()` will automatically call a `gst_init_static_plugins()` function if one exists.

- See the [GStreamer static build documentation](https://gitlab.freedesktop.org/gstreamer/gstreamer/#static-build) and Stéphane's blog post [Generate a minimal GStreamer build, tailored to your needs](https://www.collabora.com/news-and-blog/news-and-events/generate-mininal-gstreamer-build-tailored-to-your-needs.html) for more details.


### New elements

- New [**aesdec**][aesdec] and [**aesenc**][aesenc] elements for AES encryption and decryption in a custom format.

- New [**encodebin2**][encodebin2] element with dynamic/sometimes source pads in order to support the option of doing the muxing outside of `encodebin`, e.g. in combination with a `splitmuxsink`.

- New [**fakeaudiosink**][fakeaudiosink] and [**videocodectestsink**][videocodectestsink] elements for testing and debugging (see below for more details)

- **rtpisacpay**, **rtpisacdepay**: new RTP payloader and depayloader for iSAC audio codec

- **rtpst2022-1-fecdec**, **rtpst2022-1-fecenc**: new elements providing SMPTE 2022-1 2-D Forward Error Correction. More details in [Mathieu's blog post](https://mathieuduponchelle.github.io/2020-10-09-SMPTE-2022-1-2D-Forward-Error-Correction-in-GStreamer.html).

- **isac**: new plugin wrapping the [Internet Speech Audio Codec](https://en.wikipedia.org/wiki/Internet_Speech_Audio_Codec) reference encoder and decoder from the WebRTC project.

- **asio**: plugin for Steinberg ASIO (Audio Streaming Input/Output) API

- **gssrc**, **gssink**: add source and sink for Google Cloud Storage

- **onnx**: new plugin to apply ONNX neural network models to video

- **openaptx**: aptX and aptX-HD codecs using libopenaptx (v0.2.0)

- **qroverlay**, **debugqroverlay**: new elements that allow overlaying data on top of video in the form of a QR code

- **cvtracker**: new OpenCV-based tracker element

- **av1parse**, **vp9parse**: new parsers for AV1 and VP9 video
 
- **va**: work on the new VA-API plugin implementation for hardware-accelerated video decoding and encoding has continued at pace, with various new decoders and filters having joined the initial `vah264dec`:
    - **vah265dec**: VA-API H.265 decoder
    - **vavp8dec**: VA-API VP8 decoder
    - **vavp9dec**: VA-API VP9 decoder
    - **vaav1dec**: VA-API AV1 decoder
    - **vampeg2dec**: VA-API MPEG-2 decoder
    - **vadeinterlace**: : VA-API deinterlace filter
    - **vapostproc**: : VA-API postproc filter (color conversion, resizing, cropping, color balance, video rotation, skin tone enhancement, denoise, sharpen)

  See Víctor's blog post ["GstVA in GStreamer 1.20"](https://blogs.igalia.com/vjaquez/2021/12/08/gstva-in-gstreamer-1-20/) for more details and what's coming up next.

- **vaapiav1dec**: new AV1 decoder element (in gstreamer-vaapi)

- **msdkav1dec**: hardware-accelerated AV1 decoder using the Intel Media SDK / oneVPL

- **nvcodec** plugin for NVIDIA NVCODEC API for hardware-accelerated video encoding and decoding:
    - **cudaconvert**, **cudascale**: new CUDA based video color space convert and rescale elements
    - **cudaupload**, **cudadownload**: new helper elements for memory transfer between CUDA and system memory spaces
    - **nvvp8sldec**, **nvvp9sldec**: new GstCodecs-based VP8/VP9 decoders

- Various new hardware-accelerated elements for Windows:
    - **d3d11screencapturesrc**: new desktop capture element, including a `GstDeviceProvider` implementation to enumerate/select target monitors for capture.
    - **d3d11av1dec** and **d3d11mpeg2dec**: AV1 and MPEG-2 decoders
    - **d3d11deinterlace**: deinterlacing filter
    - **d3d11compositor**: video composing element
    - see Windows section below for more details

- new [Rust plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs):
    - **audiornnoise**: Removes noise from an audio stream
    - **awstranscribeparse**: Parses AWS audio transcripts into timed text buffers
    - **ccdetect**: Detects if valid closed captions are present in a closed captions stream
    - **cea608tojson**: Converts CEA-608 Closed Captions to a JSON representation
    - **cmafmux**: CMAF fragmented mp4 muxer
    - **dashmp4mux**: DASH fragmented mp4 muxer
    - **isofmp4mux**: ISO fragmented mp4 muxer
    - **ebur128level**: EBU R128 Loudness Level Measurement
    - **ffv1dec**: FFV1 video decoder
    - **gtk4paintablesink**: GTK4 video sink, which provides a `GdkPaintable` that can be rendered in various widgets
    - **hlssink3**: HTTP Live Streaming sink
    - **hrtfrender**: Head-Related Transfer Function (HRTF) renderer
    - **hsvdetector**: HSV colorspace detector
    - **hsvfilter**: HSV colorspace filter
    - **jsongstenc**: Wraps buffers containing any valid top-level JSON structures into higher level JSON objects, and outputs those as ndjson
    - **jsongstparse**: Parses ndjson as output by jsongstenc
    - **jsontovtt**: converts JSON to WebVTT subtitles
    - **regex**: Applies regular expression operations on text
    - **roundedcorners**: Adds rounded corners to video
    - **spotifyaudiosrc**: Spotify source
    - **textahead**: Display upcoming text buffers ahead (e.g. for Karaoke)
    - **transcriberbin**: passthrough bin that transcribes raw audio to closed captions using `awstranscriber` and puts the captions as metas onto the video
    - **tttojson**: Converts timed text to a JSON representation
    - **uriplaylistbin**: Playlist source bin
    - **webpdec-rs**: WebP image decoder with animation support

- New plugin **codecalpha** with elements to assist with WebM Alpha decoding
    - **codecalphademux**: Split stream with GstVideoCodecAlphaMeta into two streams
    - **alphacombine**: Combine two raw video stream (I420 or NV12) as one stream with alpha channel (A420 or AV12)
    - **vp8alphadecodebin**: A bin to handle software decoding of VP8 with alpha
    - **vp9alphadecodebin**: A bin to handle software decoding of VP9 with alpha

- New hardware accelerated elements for Linux:
    - **v4l2slmpeg2dec**: Support for Linux Stateless MPEG-2 decoders
    - **v4l2slvp9dec**: Support for Linux Stateless VP9 decoders
    - **v4l2slvp8alphadecodebin**: Support HW accelerated VP8 with alpha layer decoding
    - **v4l2slvp9alphadecodebin**: Support HW accelerated VP9 with alpha layer decoding

[aesdec]: https://gstreamer.freedesktop.org/documentation/aes/aesdec.html
[aesenc]: https://gstreamer.freedesktop.org/documentation/aes/aesenc.html
[encodebin2]: https://gstreamer.freedesktop.org/documentation/encoding/encodebin2.html
[fakeaudiosink]: https://gstreamer.freedesktop.org/documentation/debugutilsbad/fakeaudiosink.html
[videocodectestsink]: https://gstreamer.freedesktop.org/documentation/debugutilsbad/videocodectestsink.html

### New element features and additions

- **assrender**: handle more font mime types; better interaction with `matroskademux` for embedded fonts

- **audiobuffersplit**: Add support for specifying output buffer size in bytes (not just duration)

- **audiolatency**: new `"samplesperbuffer"` property so users can configure the number of samples per buffer. The default value is 240 samples which is equivalent to 5ms latency with a sample rate of 48000, which might be larger than actual buffer size of audio capture device.

- **audiomixer**, **audiointerleave**, **GstAudioAggregator**: now keep a count of samples that are dropped or processed as statistic and can be made to post QoS messages on the bus whenever samples are dropped by setting the `"qos-messages"` property on input pads.

- **audiomixer**, **compositor**: improved handling of new inputs added at runtime. New API was added to the `GstAggregator` base class to allow subclasses to opt into an aggregation mode where inactive pads are ignored when processing input buffers (`gst_aggregator_set_ignore_inactive_pads()`, `gst_aggregator_pad_is_inactive()`). An "inactive pad" in this context is a pad which, in live mode, hasn't yet received a first buffer, but has been waited on at least once. What would happen usually in this case is that the aggregator would wait for data on this pad every time, up to the maximum configured latency. This would inadvertently push mixer elements in live mode to the configured latency envelope and delay processing when new inputs are added at runtime until these inputs have actually produced data. This is usually undesirable. With this new API, new inputs can be added (requested) and configured and they won't delay the data processing. Applications can opt into this new behaviour by setting the `"ignore-inactive-pads"` property on `compositor`, `audiomixer` or other `GstAudioAggregator`-based elements.

- **cccombiner**: implement "scheduling" of captions. So far `cccombiner`'s behaviour was essentially that of a funnel: it strictly looked at input timestamps to associate together video and caption buffers. Now it will try to smoothly schedule caption buffers in order to have exactly one per output video buffer. This might involve rewriting input captions, for example when the input is CDP then sequence counters are rewritten, time codes are dropped and potentially re-injected if the input video frame had a time code meta. This can also lead to the input drifting from synchronisation, when there isn't enough padding in the input stream to catch up. In that case the element will start dropping old caption buffers once the number of buffers in its internal queue reaches a certain limit (configurable via the `"max-scheduled"` property). The new original funnel-like behaviour can be restored by setting the `"scheduling"` property to FALSE.

- **ccconverter**: new `"cdp-mode"` property to specify which sections to include in CDP packets (timecode, CC data, service info). Various software, including FFmpeg's Decklink support, fails parsing CDP packets that contain anything but CC data in the CDP packets.

- **clocksync**: new `"sync-to-first"` property for automatic timestamp offset setup: if set clocksync will set up the `"ts-offset"` value based on the first buffer and the pipeline's running time when the first buffer arrived. The newly configured `"ts-offset"` in this case would be the value that allows outputting the first buffer without waiting on the clock. This is useful for example to feed a non-live input into an already-running pipeline.

- **compositor**:
    - multi-threaded input conversion and compositing. Set the `"max-threads"` property to activate this.
    - new `"sizing-policy"` property to support display aspect ratio (DAR)-aware scaling. By default the image is scaled to fill the configured destination rectangle without padding and without keeping the aspect ratio. With `sizing-policy=keep-aspect-ratio` the input image is scaled to fit the destination rectangle specified by `GstCompositorPad:{xpos, ypos, width, height}` properties preserving the aspect ratio. As a result, the image will be centered in the destination rectangle with padding if necessary.
    - new `"zero-size-is-unscaled"` property on input pads. By default pad `width=0` or pad `height=0` mean that the stream should not be scaled in that dimension. But if the `"zero-size-is-unscaled"` property is set to `FALSE` a width or height of 0 is instead interpreted to mean that the input image on that pad should not be composited, which is useful when creating animations where an input image is made smaller and smaller until it disappears.
    - improved handling of new inputs at runtime via `"ignore-inactive-pads"`property (see above for details)
    - allow output format with alpha even if none of the inputs have alpha (also `glvideomixer` and other `GstVideoAggregator` subclasses)

- **dashsink**: add H.265 codec support and signals for allowing custom playlist/fragment output

- **decodebin3**:
    - improved decoder selection, especially for hardware decoders
    - make input activation "atomic" when adding inputs dynamically
    - better interleave handling: take into account decoder latency for interleave size

- **decklink**:
    - Updated DeckLink SDK to 11.2 to support DeckLink 8K Pro
    - **decklinkvideosrc**:
        - More accurate and stable capture timestamps: use the hardware reference clock time when the frame was finished being captured instead of a clock time much further down the road.
        - Automatically detect widescreen vs. normal NTSC/PAL

- **encodebin**:
    - add "smart encoding" support for H.265, VP8 and VP9 (i.e. only re-encode where needed and otherwise pass through encoded video as-is).
    - H.264/H.265 smart encoding improvements: respect user-specified stream-format, but if not specified default to avc3/hvc1 with in-band SPS/PPS/VPS signalling for more flexibility.
    - new **encodebin2** element with dynamic/sometimes source pads in order to support the option of doing the muxing outside of `encodebin`, e.g. in combination with `splitmuxsink`.
    - add APIs to set element properties on encoding profiles (see below)

- **errorignore**: new `"ignore-eos"` property to also ignore `FLOW_EOS` from downstream elements

- **giosrc**: add support for growing source files: applications can specify that
  the underlying file being read is growing by setting the `"is-growing"` property.
  If set, the source won't EOS when it reaches the end of the file, but will instead
  start monitoring it and will start reading data again whenever a change is detected.
  The new `"waiting-data"` and `"done-waiting-data"` signals keep the application
  informed about the current state.

- **gtksink**, **gtkglsink**:
    - scroll event support: forwarded as navigation events into the pipeline
    - `"video-aspect-ratio-override"` property to force a specific aspect ratio
    - `"rotate-method"` property and support automatic rotation based on image tags

- **identity**: new `"stats"` property allows applications to retrieve the number of bytes and buffers that have passed through so far.

- **interlace**: add support for more formats, esp 10-bit, 12-bit and 16-bit ones

- **jack**: new `"low-latency"` property for automatic latency-optimized setting and `"port-names"` property to select ports explicitly

- **jpegdec**: support output conversion to RGB using libjpeg-turbo (for certain input files)

- **line21dec**:
    - `"mode"` property to control whether and how detected closed captions should be inserted in the list of existing close caption metas on the input frame (if any): add, drop, or replace.
    - `"ntsc-only"` property to only look for captions if video has NTSC resolution

- **line21enc**: new `"remove-caption-meta"` to remove metas from output buffers after encoding the captions into the video data; support for CDP closed captions

- **matroskademux**, **matroskamux**: Add support for [ffv1](https://en.wikipedia.org/wiki/FFV1), a lossless intra-frame video coding format.

- **matroskamux**: accept in-band SPS/PPS/VPS for H.264 and H.265 (i.e. `stream-format` `avc3` and `hev1`) which allows on-the-fly profile/level/resolution changes.

- **matroskamux**: new `"cluster-timestamp-offset"` property, useful for use cases where the container timestamps should map to some absolute wall clock time, for example.

- **rtpsrc**: add `"caps"` property to allow explicit setting of the caps where needed

- **mpegts**: support SCTE-35 pass-through via new `"send-scte35-events"` property on MPEG-TS demuxer `tsdemux`. When enabled, SCTE 35 sections (e.g. ad placement opportunities) are forwarded as events downstream where they can be picked up again by `mpegtsmux`. This required a semantic change in the SCTE-35 section API: timestamps are now in running time instead of muxer pts.

- **tsdemux**: Handle PCR-less MPEG-TS streams; more robust timestamp handling in certain corner cases and for poorly muxed streams.

- **mpegtsmux**:
    - More conformance improvements to make MPEG-TS analysers happy:
        - PCR timing accuracy: Improvements to the way mpegtsmux outputs PCR observations in CBR mode, so that a PCR observation is always inserted when needed, so that we never miss the configured pcr-interval, as that triggers various MPEG-TS analyser errors.
        - Improved PCR/SI scheduling
    - Don't write PCR until PAT/PMT are output to make sure streams start cleanly with a PAT/PMT.
    - Allow overriding the automatic PMT PID selection via application-supplied `PMT_%d` fields in the `prog-map` structure/property.

- **mp4mux**:
    - new `"first-moov-then-finalise"` mode for fragmented output where the output will start with a self-contained `moov` atom for the first fragment, and then produce regular fragments. Then at the end when the file is finalised, the initial `moov` is invalidated and a new `moov` is written covering the entire file. This way the file is a "fragmented mp4" file while it is still being written out, and remains playable at all times, but at the end it is turned into a regular mp4 file (with former fragment headers remaining as unused junk data in the file).
    - support H.264 `avc3` and H.265 `hvc1` stream formats as input where the codec data is signalled in-band inside the bitstream instead of caps/file headers.
    - support profile/level/resolution changes for H.264/H.265 input streams (i.e. codec data changing on the fly). Each `codec_data` is put into its own SampleTableEntry inside the stsd, unless the input is in `avc3` stream format in which case it's written in-band and not in the headers.

- **multifilesink**: new `""min-keyframe-distance""` property to make minimum distance between keyframes in `next-file=key-frame` mode configurable instead of hard-coding it to 10 seconds.

- **mxfdemux** has seen a big refactoring to support non-frame wrappings and more accurate timestamp/seek handling for some formats

- **msdk** plugin for hardware-accelerated video encoding and decoding using the Intel Media SDK:
    - oneVPL support (Intel oneAPI Video Processing Library)
    - AV1 decoding support
    - H.264 decoder now supports `constrained-high` and `progressive-high` profiles
    - H.264 encoder:
        - more configuration options (properties): `"intra-refresh-type"`, `"min-qp"` , `"max-qp"`, `"p-pyramid"`, `"dblk-idc"`
    - H.265 encoder:
        - can output `main-still-picture` profile
        - now inserts HDR SEIs (mastering display colour volume and content light level)
        - more configuration options (properties): `"intra-refresh-type"`, `"min-qp"` , `"max-qp"`, `"p-pyramid"`, `"b-pyramid"`, `"dblk-idc"`, `"transform-skip"`
        - support for RGB 10bit format
    - External bitrate control in encoders
    - Video post proc element **msdkvpp** gained support for 12-bit pixel formats `P012_LE`, `Y212_LE` and `Y412_LE`

- **nvh264sldec**: interlaced stream support

- **openh264enc**: support `main`, `high`, `constrained-high` and `progressive-high` profiles

- **openjpeg**: support for multithreaded decoding and encoding

- **rtspsrc**: now supports IPv6 also for tunneled mode (RTSP-over-HTTP); new `"ignore-x-server-reply"` property to ignore the `x-server-ip-address` server header reply in case of HTTP tunneling, as it is often broken.

- **souphttpsrc**: Runtime compatibility support for libsoup2 and libsoup3. libsoup3 is the latest major version of libsoup, but libsoup2 and libsoup3 can't co-exist in the same process because there is no namespacing or versioning for GObject types. As a result, it would be awkward if the GStreamer souphttpsrc plugin linked to a specific version of libsoup, because it would only work with applications that use the same version of libsoup. To make this work, the soup plugin now tries to determine the libsoup version used by the application (and its other dependencies) at runtime on systems where GStreamer is linked dynamically. libsoup3 support is still considered somewhat experimental at this point. **Distro packagers** please take note of the souphttpsrc plugin dependency changes mentioned in the build and dependencies section below.

- **srtsrc**, **srtsink**: add signals for the application to accept/reject incoming connections

- **timeoverlay**: new `elapsed-running-time` time mode which shows the running time since the first running time (and each flush-stop).

- **udpsrc**: new timestamping mode to retrieve packet receive timestamps from the kernel via socket control messages (`SO_TIMESTAMPNS`) on supported platforms

- **uritranscodebin**: new `setup-source` and `element-setup` signals for applications to configure elements used

- **v4l2codecs** plugin gained support for 4x4 and 32x32 tile formats enabling some platforms or direct renders. Important memory usage improvement.

- **v4l2slh264dec** now implements the final Linux uAPI as shipped on Linux 5.11 and later.

- **valve**: add `"drop-mode"` property and provide two new modes of operation: in `drop-mode=forward-sticky-events` sticky events (stream-start, segment, tags, caps, etc.) are forwarded downstream even when dropping is enabled; `drop-mode=transform-to-gap` will in addition also convert buffers into gap events when dropping is enabled, which lets downstream elements know that time is advancing and might allow for preroll in many scenarios. By default all events and all buffers are dropped when dropping is enabled, which can cause problems with caps negotiation not progressing or branches not prerolling when dropping is enabled.

- **videocrop**: support for many more pixel formats, e.g. planar YUV formats with > 8bits and GBR* video formats; can now also accept video not backed by system memory as long as downstream supports the `GstCropMeta`

- **videotestsrc**: new `smpte-rp-219` pattern for SMPTE75 RP-219 conformant color bars

- **vp8enc**: finish support for temporal scalability: two new properties (`"temporal-scalability-layer-flags"`, `"temporal-scalability-layer-sync-flags"`) and a unit change on the `"temporal-scalability-target-bitrate`" property (now expects bps); also make temporal scalability details available to RTP payloaders as buffer metadata.

- **vp9enc**: new properties to tweak encoder performance:
    - `"aq-mode"` to configure adaptive quantization modes
    - `"frame-parallel-decoding"` to configure whether to create a bitstream that reduces decoding dependencies between frames which allows staged parallel processing of more than one video frames in the decoder. (Defaults to TRUE)
    - `"row-mt"`, `"tile-columns"` and `"tile-rows"` so multithreading can be enabled on a per-tile basis, instead of on a per tile-column basis. In combination with the new `"tile-rows"` property, this allows the encoder to make much better use of the available CPU power.

- **vp9dec**, **vp9enc**: add support for 10-bit 4:2:0 and 4:2:2 YUV, as well as 8-bit 4:4:4

- **vp8enc**, **vp9enc** now default to "good quality" for the `deadline` property rather then "best quality". Having the deadline set to best quality causes the encoder to be absurdly slow, most real-life users will prefer good-enough quality with better performance instead.

- **wpesrc**:
    - implement audio support: a new sometimes source pad will be created for each audio stream created by the web engine.
    - move `wpesrc` to `wpevideosrc` and add a wrapper bin `wpesrc` to also support audio
    - also handles web:// URIs now (same as `cefsrc`)
    - post messages with the estimated load progress on the bus

- **x265enc**: add negative DTS support, which means timestamps are now offset by 1h same as with `x264enc`

#### RTP Payloaders and Depayloaders

- **rtpisacpay**, **rtpisacdepay**: new RTP payloader and depayloader for iSAC audio codec

- **rtph264depay**:
    - new `"request-keyframe"` property to make the depayloader automatically request a new keyframe from the sender on packet loss, consistent with the new property on `rtpvp8depay`.
    - new `"wait-for-keyframe"` property to make depayloader wait for a new keyframe at the beginning and after packet loss (only effective if the depayloader outputs AUs), consistent with the existing property on `rtpvp8depay`.

- **rtpopuspay**, **rtpopusdepay**: support libwebrtc-compatible multichannel audio in addition to the previously supported multichannel audio modes

- **rtpopuspay**: add DTX (Discontinuous Transmission) support

- **rtpvp8depay**: new `"request-keyframe"` property to make the depayloader automatically request a new keyframe from the sender on packet loss.

- **rtpvp8pay**: temporal scaling support

- **rtpvp9depay**: Improved SVC handling (aggregate all layers)

#### RTP Infrastructure

- **rtpst2022-1-fecdec**, **rtpst2022-1-fecenc**: new elements providing SMPTE 2022-1 2-D Forward Error Correction. More details in [Mathieu's blog post](https://mathieuduponchelle.github.io/2020-10-09-SMPTE-2022-1-2D-Forward-Error-Correction-in-GStreamer.html).

- **rtpreddec**: BUNDLE support

- **rtpredenc**, **rtpulpfecenc**: add support for Transport-wide Congestion Control (TWCC)

- **rtpsession**: new `"twcc-feedback-interval"` property to allow RTCP TWCC reports to be scheduled on a timer instead of per marker-bit.

### Plugin and library moves

- There were no plugin moves or library moves in this cycle.

### Plugin removals

The following elements or plugins have been removed:

- The `ofa` audio fingerprinting plugin has been removed. The MusicIP database has been [defunct for years](https://musicbrainz.org/doc/Fingerprinting#PUID) so this plugin is likely neither useful nor used by anyone.

- The `mms` plugin containing `mmssrc` has been removed. It seems unlikely anyone still needs this or that there are even any streams left out there. The [MMS](https://en.wikipedia.org/wiki/Microsoft_Media_Server) protocol was deprecated in 2003 (in favour of RTSP) and support for it was [dropped](https://sdp.ppona.com/news2008.html) with Microsoft Media Services 2008, and Windows Media Player apparently also does not support it any more.

## Miscellaneous API additions

### Core

- `gst_buffer_new_memdup()` is a convenience function for the widely-used `gst_buffer_new_wrapped(g_memdup(data,size),size)` pattern.

- `gst_caps_features_new_single()` creates a new single `GstCapsFeatures`, avoiding the need to use the vararg function with `NULL` terminator for simple cases.

- `gst_element_type_set_skip_documentation()` can be used by plugins to signal that certain elements should not be included in the GStreamer plugin documentation. This is useful for plugins where elements are registered dynamically based on hardware capabilities and/or where the available plugins and properties vary from system to system. This is used in the `d3d11` plugin for example to ensure that only the list of default elements is advertised in the documentation.

- `gst_type_find_suggest_empty_simple()` is a new convenience function for typefinders for cases where there's only a media type and no other fields.

- New API to create elements and set properties at construction time, which is not only convenient, but also allows GStreamer elements to have construct-only properties: `gst_element_factory_make_full()`, `gst_element_factory_make_valist()`, `gst_element_factory_make_with_properties()`, `gst_element_factory_create_full()`, `gst_element_factory_create_valist()`, `gst_element_factory_create_with_properties()`.

- **[GstSharedTaskPool][shared-taskpool]**: new "shared" task pool subclass with slightly different default behaviour than the existing `GstTaskPool` which would create unlimited number of threads for new tasks. The shared task pool creates up to N threads (default: 1) and then distributes pending tasks to those threads round-robin style, and blocks if no thread is available. It is possible to join tasks. This can be used by plugins to implement simple multi-threaded processing and is used for the new multi-threaded video conversion and compositing done in GstVideoAggregator, videoconverter and compositor.

[shared-taskpool]: https://gstreamer.freedesktop.org/documentation/gstreamer/gsttaskpool.html?gi-language=c#GstSharedTaskPool

### Plugins Base Utils library

- **GstDiscoverer**:
    - `gst_discoverer_container_info_get_tags()` was added to retrieve global/container tags (vs. per-stream tags). Per-Stream tags can be retrieved via the existing `gst_discoverer_stream_info_get_tags()`. `gst_discoverer_info_get_tags()`, which for many files returns a confusing mix of stream and container tags, has been deprecated in favour of the container/stream-specific functions.
    - `gst_discoverer_stream_info_get_stream_number()` returns a unique integer identifier for a given stream within the given `GstDiscoverer` context. (If this matches the stream number inside the container bitstream that's by coincidence and not by design.)

- `gst_pb_utils_get_caps_description_flags()` can be used to query whether certain caps represent a container, audio, video, image, subtitles, tags, or something else. This only works for formats known to GStreamer.

- `gst_pb_utils_get_file_extension_from_caps()` returns a possible file extension for given caps.

- `gst_codec_utils_h264_get_profile_flags_level()`: Parses profile, flags, and level from H.264 AvcC `codec_data`. The format of H.264 AVCC extradata/sequence_header is documented in the ITU-T H.264 specification section 7.3.2.1.1 as well as in ISO/IEC 14496-15 section 5.3.3.1.2.

- `gst_codec_utils_caps_get_mime_codec()` to convert caps to a RFC 6381 compatible MIME codec string codec. Useful for providing the `codecs` field inside the `Content-Type` HTTP header for container formats, such as mp4 or Matroska.

## GStreamer OpenGL integration library and plugins

- **glcolorconvert**: added support for converting the video formats `A420`, `AV12`, `BGR`, `BGRA`, `RGBP` and `BGRP`.

- Added support to `GstGLBuffer` for persistent buffer mappings where a Pixel Buffer Object (PBO) can be mapped by both the CPU and the GPU.  This removes a `memcpy()` when uploading textures or vertices particularly when software decoders (e.g. libav) are direct rendering into our memory.  Improves transfer performance significantly.  Requires OpenGL 4.4, `GL_ARB_buffer_storage` or `GL_EXT_buffer_storage`

- Added various helper functions for handling 4x4 matrices of affine transformations as used by `GstVideoAffineTransformationMeta`.

- Add support to `GstGLContext` for allowing the application to control the config (`EGLConfig`, `GLXConfig`, etc) used when creating the OpenGL context.  This allows the ability to choose between RGB16 or RGB10A2 or RGBA8 back/front buffer configurations that were previously hardcoded.  `GstGLContext` also supports retrieving the configuration it was created with or from an externally provide OpenGL context handle.  This infrastructure is also used to create a compatible config from an application/externally provided OpenGL context in order to improve compatibility with other OpenGL frameworks and GUI toolkits.  A new environment variable `GST_GL_CONFIG` was also added to be able to request a specific configuration from the command line.  Note: different platforms will have different functionality available.

- Add support for choosing between EGL and WGL at runtime when running on Windows. Previously this was a build-time switch.  Allows use in e.g. Gtk applications on Windows that target EGL/ANGLE without recompiling GStreamer.  `gst_gl_display_new_with_type()` can be used by applications to choose a specific display type to use.

- Build fixes to explicitly check for Broadcom-specific libraries on older versions of the Raspberry Pi platform.  The Broadcom OpenGL ES and EGL libraries have different filenames.  Using the vc4 Mesa driver on the Raspberry Pi is not affected.

- Added support to `glupload` and `gldownload` for transferring RGBA buffers  using the `memory:NVMM` available on the Nvidia Tegra family of embedded devices.

- Added support for choosing libOpenGL and libGLX as used in a GLVND environment on unix-based platforms.  This allows using desktop OpenGL and EGL without pulling in any GLX symbols as would be required with libGL.

### Video library

- New raw video formats:
    - AV12 (NV12 with alpha plane)
    - RGBP and BGRP (planar RGB formats)
    - ARGB64 variants with specified endianness instead of host endianness:
        - ARGB64_LE, ARGB64_BE
        - RGBA64_BE, RGBA64_LE
        - BGRA64_BE, BGRA64_LE
        - ABGR64_BE, ABGR64_LE

- `gst_video_orientation_from_tag()` is new convenience API to parse the image orientation from a `GstTagList`.

- `GstVideoDecoder` subframe support (see below)

- `GstVideoCodecState` now also carries some HDR metadata

- Ancillary video data: implement transform functions for AFD/Bar metas, so they will be forwarded in more cases

### MPEG-TS library

This library only handles section parsing and such, see above for changes to the actual `mpegtsmux` and `mpegtsdemux` elements.

- many additions and improvements to SCTE-35 section parsing
- new API for fetching extended descriptors: `gst_mpegts_find_descriptor_with_extension()`
- add support for SIT sections (Selection Information Tables)
- expose event-from-section constructor `gst_event_new_mpegts_section()`
- parse Audio Preselection Descriptor needed for Dolby AC-4

### GstWebRTC library + webrtcbin

- Change the way in which sink pads and transceivers are matched together to support easier usage.  If a pad is created without a specific index (i.e. using `sink_%u` as the pad template), then an available compatible transceiver will be searched for.  If a specific index is requested (i.e. `sink_1`) then if a transceiver for that m-line already exists, that transceiver must match the new sink pad request.  If there is no transceiver available in either scenario, a new transceiver is created.  If a mixture of both `sink_1` and `sink_%u` requests result in an impossible situation, an error will be produced at pad request time or from create offer/answer.

- `webrtcbin` now uses regular ICE nomination instead of libnice's default of aggressive ICE nomination. Regular ICE nomination is the default recommended by various relevant standards and improves connectivity in specific network scenarios.

- Add support for limiting the port range used for RTP with the addition of the `min-rtp-port` and `max-rtp-port` properties on the ICE object.

- Expose the SCTP transport as a property on `webrtcbin` to more closely match the WebRTC specification.

- Added support for taking into account the data channel transport state when determining the value of the `"connection-state"`  property.  Previous versions of the WebRTC spec did not include the data channel state when computing this value.

- Add configuration for choosing the size of the underlying sockets used for transporting media data

- Always advertise support for the transport-cc RTCP feedback protocol as `rtpbin` supports it.  For full support, the configured caps (input or through codec-preferences) need to include the relevant RTP header extension.

- Numerous fixes to caps and media handling to fail-fast when an incompatible situation is detected.

- Improved support for attaching the required media after a remote offer has been set.

- Add support for dynamically changing the amount of FEC used for a particular stream.

- `webrtcbin` now stops further SDP processing at the first error it encounters.

- Completed support for either local or the remote closing a data channel.

- Various fixes when performing BUNDLEing of the media streams in relation to RTX and FEC usage.

- Add support for writing out QoS DSCP marking on outgoing packets to improve reliability in some network scenarios.

- Improvements to the statistics returned by the `get-stats` signal including the addition of the raw statistics from the internal `RTPSource`, the TWCC stats when available.

- The webrtc library does not expose any objects anymore with public fields.  Instead properties have been added to replace that functionality.  If you are accessing such fields in your application, switch to the corresponding properties.

### GstCodecs and Video Parsers

- Support for render delays to improve throughput across all CODECs (used with NVDEC and V4L2).
- lots of improvements to parsers and the codec parsing decoder base classes (H.264, H.265, VP8, VP9, AV1, MPEG-2) used for various hardware-accelerated decoder APIs. 

### Bindings support

- `gst_allocation_params_new()` allocates a `GstAllocationParams` struct on the heap. This should only be used by bindings (and freed via `gst_allocation_params_free()` afterwards). In C code you would allocate this on the stack and only init it in place.

- `gst_debug_log_literal()` can be used to log a string to the debug log without going through any printf format expansion and associated overhead. This is mostly useful for bindings such as the Rust bindings which may have done their own formatting already .

- Provide non-inlined versions of refcounting APIs for various GStreamer mini objects, so that they can be consumed by bindings (e.g. gstreamer-sharp): `gst_buffer_ref`, `gst_buffer_unref`, `gst_clear_buffer`, `gst_buffer_copy`, `gst_buffer_replace`, `gst_buffer_list_ref`, `gst_buffer_list_unref`, `gst_clear_buffer_list`, `gst_buffer_list_copy`, `gst_buffer_list_replace`, `gst_buffer_list_take`, `gst_caps_ref`, `gst_caps_unref`, `gst_clear_caps`, `gst_caps_replace`, `gst_caps_take`, `gst_context_ref`, `gst_context_unref`, `gst_context_copy`, `gst_context_replace`, `gst_event_replace`, `gst_event_steal`, `gst_event_take`, `gst_event_ref`, `gst_event_unref`, `gst_clear_event`, `gst_event_copy`, `gst_memory_ref`, `gst_memory_unref`, `gst_message_ref`, `gst_message_unref`, `gst_clear_message`, `gst_message_copy`, `gst_message_replace`, `gst_message_take`, `gst_promise_ref`, `gst_promise_unref`, `gst_query_ref`, `gst_query_unref`, `gst_clear_query`, `gst_query_copy`, `gst_query_replace`, `gst_query_take`, `gst_sample_ref`, `gst_sample_unref`, `gst_sample_copy`, `gst_tag_list_ref`, `gst_tag_list_unref`, `gst_clear_tag_list`, `gst_tag_list_replace`, `gst_tag_list_take`, `gst_uri_copy`, `gst_uri_ref`, `gst_uri_unref`, `gst_clear_uri`.

- expose a `GType` for `GstMiniObject`

- `gst_device_provider_probe()` now returns non-floating device object

## API Deprecations

- `gst_element_get_request_pad()` has been deprecated in favour of the newly-added `gst_element_request_pad_simple()` which does the exact same thing but has a less confusing name that hopefully makes clear that the function request a new pad rather than just retrieves an already-existing request pad.

- `gst_discoverer_info_get_tags()`, which for many files returns a confusing mix of stream and container tags, has been deprecated in favour of the container-specific and stream-specific functions, `gst_discoverer_container_info_get_tags()` and `gst_discoverer_stream_info_get_tags()`.

- `gst_video_sink_center_rect()` was deprecated in favour of the more generic newly-added `gst_video_center_rect()`.

- The `GST_MEMORY_FLAG_NO_SHARE` flag has been deprecated, as it tends to cause problems and prevents sub-buffering. If pooling or lifetime tracking is required, memories should be allocated through a custom `GstAllocator` instead of relying on the lifetime of the buffers the memories were originally attached to, which is fragile anyway.

- The `GstPlayer` high-level playback library is being replaced with the new `GstPlay` library (see above). `GstPlayer` should be considered deprecated at this point and will be marked as such in the next development cycle. Applications should be ported to `GstPlay`.

- Gstreamer Editing Services: `ges_video_transition_set_border()`, `ges_video_transition_get_border()` `ges_video_transition_set_inverted()` `ges_video_transition_is_inverted()` have been deprecated, use `ges_timeline_element_set_children_properties()` instead.

## Miscellaneous performance, latency and memory optimisations

### More video conversion fast paths

- v210 ↔ I420, YV12, Y42B, UYVY and YUY2
- A420 → RGB

### Less jitter when waiting on the system clock

- Better system clock wait accuracy, less jitter: where available, `clock_nanosleep` is used for higher accuracy for waits below 500 usecs, and waits below 2ms will first use the regular waiting system and then `clock_nanosleep` for the remainder. The various wait implementation have a latency ranging from 50 to 500+ microseconds. While this is not a major issue when dealing with a low number of waits per second (for ex: video), it does introduce a non-negligible jitter for synchronisation of higher packet rate systems.

### Video decoder subframe support

- The `GstVideoDecoder` base class gained API to process input at the sub-frame level. That way video decoders can start decoding slices before they have received the full input frame in its entirety (to the extent this is supported by the codec, of course). This helps with CPU utilisation and reduces latency.

- This functionality is now being used in the OpenJPEG JPEG 2000 decoder, the FFmpeg H.264 decoder (in case of NAL-aligned input) and the OpenMAX H.264/H.265 decoders (in case of NAL-aligned input).

## Miscellaneous other changes and enhancements

- `GstDeviceMonitor` no longer fails to start just because one of the device providers failed to start. That could happen for example on systems where the pulseaudio device provider is installed, but pulseaudio isn't actually running but ALSA is used for audio instead. In the same vein the device monitor now keeps track of which providers have been started (via the new `gst_device_provider_is_started()`) and only stops actually running device providers when stopping the device monitor.

- On embedded systems it can be useful to create a registry that can be shared and read by multiple processes running as different users. It is now possible to set the new `GST_REGISTRY_MODE` environment variable to specify the file mode for the registry file, which by default is set to be only user readable/writable.

- `GstNetClientClock` will signal lost sync in case the remote time resets (e.g. because device power cycles), by emitting the "synced" signal with synced=FALSE parameter, so applications can take action.

- `gst_value_deserialize_with_pspec()` allows deserialisation with a hint for what the target GType should be. This allows for example passing arrays of flags through the command line or `gst_util_set_object_arg()`, eg: `foo="<bar,bar+baz>"`.

- It's now possible to create an empty `GstVideoOverlayComposition` without any rectangles by passing a `NULL` rectangle to `gst_video_overlay_composition_new()`. This is useful for bindings and simplifies application code in some places.

## Tracing framework, debugging and testing improvements

- New [`factories`][factories-tracer] tracer to list loaded elements (and other plugin features). This can be useful to collect a list of elements needed for an application, which in turn can be used to create a tailored minimal GStreamer build that contains just the elements needed and nothing else.
- New `plugin-feature-loaded` tracing hook for use by tracers like the new `factories` tracer

[factories-tracer]: https://gstreamer.freedesktop.org/documentation/coretracers/factories.html?gi-language=c#factories-page

- GstHarness: Add `gst_harness_set_live()` so that harnesses can be set to non-live and return is-live=false in latency queries if needed. Default behaviour is to always return is-live=true in latency queries.

- **navseek**: new `"hold-eos"` property. When enabled, the element will hold back an EOS event until the next keystroke (via navigation events). This can be used to keep a video sink showing the last frame of a video pipeline until a key is pressed instead of tearing it down immediately on EOS.

- New [**fakeaudiosink**][fakeaudiosink] element: mimics an audio sink and can be used for testing and CI pipelines on systems where no audio system is installed or running. It differs from fakesink in that it only support audio caps and syncs to the clock by default like a normal audio sink. It also implements the `GstStreamVolume` interface like most audio sinks do.

- New [**videocodectestsink**][videocodectestsink] element for video codec conformance testing: Calculates MD5 checksums for video frames and skips any padding whilst doing so. Can optionally also write back the video data with padding removed into a file for easy byte-by-byte comparison with reference data.

## Tools

### gst-inspect-1.0

- Can sort the list of plugins by passing `--sort=name` as command line option

### gst-launch-1.0

- will now error out on top-level properties that don't exist and which were silently ignored before
- On Windows the high-resolution clock is enabled now, which provides better clock and timer performance on Windows (see Windows section below for more details).

### gst-play-1.0

- New `--start-position` command line argument to start playback from the specified position
- Audio can be muted/unmuted in interactive mode by pressing the `m` key.
- On Windows the high-resolution clock is enabled now (see Windows section below for more details)

### gst-device-monitor-1.0

- New `--include-hidden` command line argument to also show "hidden" device providers

### ges-launch-1.0

- New interactive mode that allows seeking and such. Can be disabled by passing the `--no-interactive` argument on the command line.
- Option to forward tags
- Allow using an existing clip to determine the rendering format (both topology and profile) via new `--profile-from` command line argument.

## GStreamer RTSP server

- `GstRTSPMediaFactory` gained API to disable RTCP (`gst_rtsp_media_factory_set_enable_rtcp()`, `"enable-rtcp"` property). Previously RTCP was always allowed for all RTSP medias. With this change it is possible to disable RTCP completely, irrespective of whether the client wants to do RTCP or not.

- Make a mount point of `/` work correctly. While not allowed by the RTSP 2 spec, the RTSP 1 spec is silent on this and it is used in the wild. It is now possible to use `/` as a mount path in gst-rtsp-server, e.g. `rtsp://example.com/` would work with this now. Note that query/fragment parts of the URI are not necessarily correctly handled, and behaviour will differ between various client/server implementations; so use it if you must but don't bug us if it doesn't work with third party clients as you'd hoped.

- multithreading fixes (races, refcounting issues, deadlocks)

- ONVIF audio backchannel fixes

- ONVIF trick mode optimisations

- **rtspclientsink**: new `"update-sdp"` signal that allows updating the SDP before sending it to the server via `ANNOUNCE`. This can be used to add additional metadata to the SDP, for example. The order and number of medias must not be changed, however.

## GStreamer VAAPI

- new AV1 decoder element (`vaapiav1dec`)

- H.264 decoder: handle stereoscopic 3D video with frame packing arrangement SEI messages

- H.265 encoder: added Screen Content Coding extensions support

- H.265 decoder: gained `MAIN_444_12` profile support (decoded to `Y412_LE`), and 4:2:2 12-bits support (decoded to `Y212_LE`)

- vaapipostproc: gained BT2020 color standard support

- vaapidecode: now generates caps templates dynamically at runtime in order to advertise actually supported caps instead of all theoretically supported caps.

- `GST_VAAPI_DRM_DEVICE` environment variable to force a specified DRM device when a DRM display is used. It is ignored when other types of displays are used. By default `/dev/dri/renderD128` is used for DRM display.

## GStreamer OMX

- subframe support in H.264/H.265 decoders

## GStreamer Editing Services and NLE

 - framepositioner: new `"operator"` property to access blending modes in the compositor
 - timeline: Implement snapping to markers
 - smart-mixer: Add support for d3d11compositor and glvideomixer
 - titleclip: add `"draw-shadow"` child property
 - ges:// URI support to define a timeline from a description.
 - command-line-formatter
    - Add track management to timeline description
    - Add keyframe support
 - ges-launch-1.0:
    - Add an interactive mode where we can seek etc...
    - Add option to forward tags
    - Allow using an existing clip to determine the rendering format (both topology and profile) via new `--profile-from` command line argument.
 - Fix static build

## GStreamer validate

- report: Add a way to force backtraces on reports even if not a critical issue (`GST_VALIDATE_ISSUE_FLAGS_FORCE_BACKTRACE`)
- Add a flag to `gst_validate_replace_variables_in_string()` allow defining how to resolve variables in structs
- Add `gst_validate_bin_monitor_get_scenario()` to get the bin monitor scenario, which is useful for applications that use Validate directly.
- Add an `expected-values` parameter to `wait, message-type=XX` allowing more precise filtering of the message we are waiting for.
- Add config file support: each test can now use a config file for the given media file used to test.
- Add support to check properties of object properties
- scenario: Add an `"action-done"` signal to signal when an action is done
- scenario: Add a `"run-command"` action type
- scenario: Allow forcing running action on idle from scenario file
- scenario: Allow iterating over arrays in `foreach`
- scenario: Rename 'interlaced' action to 'non-blocking'
- scenario: Add a `non-blocking` flag to the `wait` signal

## GStreamer Python Bindings

- Fixes for Python 3.10
- Various build fixes
- at least one known breaking change caused by g-i annotation changes (see below)

## GStreamer C# Bindings

- Fix `GstDebugGraphDetails` enum
- Updated to latest GtkSharp
- Updated to include GStreamer 1.20 API

## GStreamer Rust Bindings and Rust Plugins

- The GStreamer Rust bindings are released separately with a different release cadence that's tied to `gtk-rs`, but the latest release has already been updated for the upcoming new GStreamer 1.20 API (`v1_20` feature).

- `gst-plugins-rs`, the module containing GStreamer plugins written in Rust, has also seen lots of activity with many new elements and plugins. See the New Elements section above for a list of new Rust elements.

## Build and Dependencies

- Meson 0.59 or newer is now required to build GStreamer.

- The GLib requirement has been bumped to GLib 2.56 or newer (from March 2018).

- The `wpe` plugin now requires wpe >= 2.28 and wpebackend-fdo >= 1.8

- The `souphttpsrc` plugin is no longer linked against libsoup but instead tries to pick up either libsoup2 or libsoup3 dynamically at runtime. **Distro packagers** please ensure to add a dependency on one of the libsoup runtimes to the gst-plugins-good package so that there is actually a libsoup for the plugin to find!

### Explicit opt-in required for build of certain plugins with (A)GPL dependencies

Some plugins have GPL- or AGPL-licensed dependencies and those plugins will no longer be built by default unless you have explicitly opted in to allow (A)GPL-licensed dependencies by passing `-Dgpl=enabled` to Meson, even if the required dependencies are available.

See [Building plugins with (A)GPL-licensed dependencies][build-gpl-opt-in] for more details and a non-exhaustive list of plugins affected.

[build-gpl-opt-in]: https://gitlab.freedesktop.org/gstreamer/gstreamer/#building-plugins-with-agpl-licensed-dependencies

### gst-build: replaced by mono repository

See mono repository section above and the [GStreamer mono repository FAQ][monorepo-faq].

[monorepo-faq]: https://gstreamer.freedesktop.org/documentation/frequently-asked-questions/mono-repository.html

### Cerbero

Cerbero is a meta build system used to build GStreamer plus dependencies on platforms where dependencies are not readily available, such as Windows, Android, iOS and macOS.

#### General Cerbero improvements

- Plugin removed: `libvisual`
- New plugins: `rtpmanagerbad` and `rist`

#### macOS / iOS specific Cerbero improvements

- XCode 12 support
- macOS OS release support is now future-proof, similar to iOS
- macOS Apple Silicon (ARM64) cross-compile support has been added,
  including Universal binaries. There is a [known bug][apple-silicon-bug] regarding this
  on ARM64.
- Running Cerbero itself on macOS Apple Silicon (ARM64) is currently experimental and is known to have bugs

[apple-silicon-bug]: https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/361

#### Windows specific Cerbero improvements

- Visual Studio 2022 support has been added
- `bootstrap` is faster since it requires building fewer build-tools recipes on Windows
- `package` is faster due to better scheduling of recipe stages and elimination of unnecessary autotools regeneration
- The following plugins are no longer built on Windows:
  - a52dec (another decoder is still available in libav)
  - dvdread
  - resindvd

#### Windows MSI installer

- no major changes

#### Linux specific Cerbero improvements

- Fedora, Debian OS release support is now more future-proof
- Amazon Linux 2 support has been added

#### Android specific Cerbero improvements

- no major changes

## Platform-specific changes and improvements

### Android

- No major changes [](FIXME)

### macOS and iOS

- **applemedia**: add ProRes support to **vtenc** and **vtdec**

- The `GStreamer.framework` location is now relocatable and is not required to be `/Library/Frameworks/`

- Cerbero now supports cross-compiling to macOS running on Apple Silicon (ARM64), and Universal binaries are now available that can be used on both X86_64 and ARM64 macOS.

### Windows

- On Windows the high-resolution clock is enabled now in the `gst-launch-1.0` and `gst-play-1.0` command line tools, which provides better clock and timer performance on Windows, at the cost of higher power consumption. By default, without the high-resolution clock enabled, the timer precision on Windows is system-dependent and may be as bad as 15ms which is not good enough for many multimedia applications. Developers may want to do the same in their Windows applications if they think it's a good idea for their application use case, and depending on the Windows version they target. This is not done automatically by GStreamer because on older Windows versions (pre-Windows 10) this [affects a global Windows setting](https://docs.microsoft.com/en-us/windows/win32/api/timeapi/nf-timeapi-timebeginperiod#remarks) and also there's a power consumption vs. performance trade-off that may differ from application to application.

- **dxgiscreencapsrc** now supports resolution changes

- The **wasapi2** audio plugin was rewritten and now has a higher rank than the old wasapi plugin since it has a number of additional features such as automatic stream routing, and no known-but-hard-to-fix issues. The plugin is always built if the Windows 10 SDK is available now.

- The **wasapi device providers** now detect and notify dynamic device additions/removals 

- **d3d11screencapturesrc**: new desktop capture element, including `GstDeviceProvider` implementation to enumerate/select target monitors for capture.

- Direct3D11/DXVA decoder now supports AV1 and MPEG-2 codecs (**d3d11av1dec**, **d3d11mpeg2dec**)

- VP9 decoding got more reliable and stable thanks to a newly written codec parser

- Support for decoding interlaced H.264/AVC streams

- Hardware-accelerated video deinterlacing (**d3d11deinterlace**) and video mixing (**d3d11compositor**)

- Video mixing with the Direct3D11 API (**d3d11compositor**)

- MediaFoundation API based hardware encoders gained the ability to receive Direct3D11 textures as an input

- Seungha's blog post ["GStreamer ❤ Windows: A primer on the cool stuff you’ll find in the 1.20 release"][gst-win-blog-seungha] describes many of the Windows-related improvements in more detail

[gst-win-blog-seungha]: https://medium.com/@seungha.yang/gstreamer-%EF%B8%8Fwindows-a-primer-on-the-cool-stuff-youll-find-in-the-1-20-release-fa68366bca7c?p=fa68366bca7c

### Linux

- **bluez**: LDAC Bluetooth audio codec support in **a2dpsink** and **avdtpsink**, as well as an LDAC RTP payloader (**rtpldacpay**) and an LDAC audio encoder (**ldacenc**)

- **kmssink**: gained support for NV24, NV61, RGB16/BGR16 formats; auto-detect NVIDIA Tegra driver

## Documentation improvements

- hardware-accelerated GPU plugins will now no longer always list all the element variants for all available GPUs, since those are system-dependent and it's confusing for users to see those in the documentation just because the GStreamer developer who generated the docs had multiple GPUs to play with at the time. Instead just show the default elements.

## Possibly Breaking and Other Noteworthy Behavioural Changes

- `gst_parse_launch()`, `gst_parse_bin_from_description()` and friends will now error out when setting properties that don't exist on top-level bins. They were silently ignored before.

- The `GstWebRTC` library does not expose any objects anymore with public fields. Instead properties have been added to replace that functionality. If you are accessing such fields in your application, switch to the corresponding properties.

- `playbin` and `uridecodebin` now emit the `source-setup` signal *before* the element is added to the bin and linked so that the source element is already configured before any scheduling query comes in, which is useful for elements such as `appsrc` or `giostreamsrc`.

- The source element inside `urisourcebin` (used inside `uridecodebin3` which is used inside `playbin3`) is no longer called `"source"`. This shouldn't affect anyone hopefully, because there's a `"setup-source"` signal to configure the source element and no one should rely on names of internal elements anyway.

- The `vp8enc` element now expects bps (bits per second) for the `"temporal-scalability-target-bitrate`" property, which is consistent with the `"target-bitrate"` property. Since additional configuration is required with modern libvpx to make temporal scaling work anyway, chances are that very few people will have been using this property

- `vp8enc` and `vp9enc` now default to "good quality" for the `"deadline"` property rather then "best quality". Having the deadline set to best quality causes the encoder to be absurdly slow, most real-life users will want the good quality tradeoff instead.

- The experimental `GstTranscoder` library API in gst-plugins-bad was changed from a GObject signal-based notification mechanism to a `GstBus`/message-based mechanism akin to `GstPlayer`/`GstPlay`.

- MPEG-TS SCTE-35 API: semantic change for SCTE-35 splice commands: timestamps passed by the application should be in running time now, since users of the API can't really be expected to predict the local PTS of the muxer.

- The `GstContext` used by **`souphttpsrc`** to share the session between multiple element instances has changed. Previously it provided direct access to the internal `SoupSession` object, now it only provides access to an opaque, internal type. This change is necessary because `SoupSession` is not thread-safe at all and can't be shared safely between arbitrary external code and `souphttpsrc`.

- Python bindings: GObject-introspection related Annotation fixes have led to a [case][gitlab-g-p-47] of a `GstVideo.VideoInfo`-related function signature changing in the Python bindings (possibly one or two other cases too). This is for a function that should never have been exposed in the first place though, so the bindings are being updated to throw an exception in that case, and the correct replacement API has been added in form of an override.

[gitlab-g-p-47]: https://gitlab.freedesktop.org/gstreamer/gst-python/-/issues/47

## Known Issues

- nothing in particular at this point (but also see possibly breaking changes section above)

## Contributors

Aaron Boxer, Adam Leppky, Adam Williamson, Alba Mendez,
Alejandro González, Aleksandr Slobodeniuk, Alexander Vandenbulcke,
Alex Ashley, Alicia Boya García, Andika Triwidada, Andoni Morales Alastruey,
Andrew Wesie, Andrey Moiseev, Antonio Ospite, Antonio Rojas,
Arthur Crippa Búrigo, Arun Raghavan, Ashley Brighthope, Axel Kellermann,
Baek, Bastien Nocera, Bastien Reboulet, Benjamin Gaignard, Bing Song,
Binh Truong, Biswapriyo Nath, Brad Hards, Brad Smith, Brady J. Garvin,
Branko Subasic, Camilo Celis Guzman, Chris Bass, ChrisDuncanAnyvision,
Chris White, Corentin Damman, Daniel Almeida, Daniel Knobe, Daniel Stone,
david, David Fernandez, David Keijser, David Phung, Devarsh Thakkar,
Dinesh Manajipet, Dmitry Samoylov, Dmitry Shusharin, Dominique Martinet,
Doug Nazar, Ederson de Souza, Edward Hervey, Emmanuel Gil Peyrot,
Enrique Ocaña González, Ezequiel Garcia, Fabian Orccon, Fabrice Fontaine,
Fernando Jimenez Moreno, Florian Karydes,
Francisco Javier Velázquez-García, François Laignel, Frederich Munch,
Fredrik Pålsson, George Kiagiadakis, Georg Lippitsch, Göran Jönsson,
Guido Günther, Guillaume Desmottes, Guiqin Zou, Haakon Sporsheim,
Haelwenn (lanodan) Monnier, Haihao Xiang, Haihua Hu, Havard Graff, He Junyan,
Helmut Januschka, Henry Wilkes, Hosang Lee, Hou Qi, Ignacio Casal Quinteiro,
Igor Kovalenko, Ilya Kreymer, Imanol Fernandez, Jacek Tomaszewski,
Jade Macho, Jakub Adam, Jakub Janků, Jan Alexander Steffens (heftig),
Jan Schmidt, Jason Carrete, Jason Pereira, Jay Douglass, Jeongki Kim,
Jérôme Laheurte, Jimmi Holst Christensen, Johan Sternerup, John Hassell,
John Lindgren, John-Mark Bell, Jonathan Matthew, Jordan Petridis,
Jose Quaresma, Julian Bouzas, Julien, Kai Uwe Broulik,
Kasper Steensig Jensen, Kellermann Axel, Kevin Song, Khem Raj,
Knut Inge Hvidsten, Knut Saastad, Kristofer Björkström, Lars Lundqvist,
Lawrence Troup, Lim Siew Hoon, Lucas Stach, Ludvig Rappe,
Luis Paulo Fernandes de Barros, Luke Yelavich, Mads Buvik Sandvei,
Marc Leeman, Marco Felsch, Marek Vasut, Marian Cichy, Marijn Suijten,
Marius Vlad, Markus Ebner, Mart Raudsepp, Matej Knopp, Mathieu Duponchelle,
Matthew Waters, Matthieu De Beule, Mengkejiergeli Ba, Michael de Gans,
Michael Olbrich, Michael Tretter, Michal Dzik, Miguel Paris, Mikhail Fludkov,
mkba, Nazar Mokrynskyi, Nicholas Jackson, Nicola Murino, Nicolas Dufresne,
Niklas Hambüchen, Nikolay Sivov, Nirbheek Chauhan, Olivier Blin,
Olivier Crete, Olivier Crête, Paul Goulpié, Per Förlin, Peter Boba, P H,
Philippe Normand, Philipp Zabel, Pieter Willem Jordaan, Piotrek Brzeziński,
Rafał Dzięgiel, Rafostar, raghavendra, Raghavendra, Raju Babannavar,
Raleigh Littles III, Randy Li, Randy Li (ayaka), Ratchanan Srirattanamet,
Raul Tambre, reed.lawrence, Ricky Tang, Robert Rosengren, Robert Swain,
Robin Burchell, Roman Sivriver, R S Nikhil Krishna, Ruben Gonzalez,
Ruslan Khamidullin, Sanchayan Maity, Scott Moreau, Sebastian Dröge,
Sergei Kovalev, Seungha Yang, Sid Sethupathi, sohwan.park, Sonny Piers,
Staz M, Stefan Brüns, Stéphane Cerveau, Stephan Hesse, Stian Selnes,
Stirling Westrup, Théo MAILLART, Thibault Saunier, Tim, Timo Wischer,
Tim-Philipp Müller, Tim Schneider, Tobias Ronge, Tom Schoonjans,
Tulio Beloqui, tyler-aicradle, U. Artie Eoff, Ung, Val Doroshchuk,
VaL Doroshchuk, Víctor Manuel Jáquez Leal, Vivek R, Vivia Nikolaidou,
Vivienne Watermeier, Vladimir Menshakov, Will Miller, Wim Taymans,
Xabier Rodriguez Calvar, Xavier Claessens, Xℹ Ruoyao, Yacine Bandou,
Yinhang Liu, youngh.lee, youngsoo.lee, yychao, Zebediah Figura,
Zhang yuankun, Zhang Yuankun, Zhao, Zhao Zhili, , Aleksandar Topic,
Antonio Ospite, Bastien Nocera, Benjamin Gaignard, Brad Hards,
Carlos Falgueras García, Célestin Marot, Corentin Damman, Corentin Noël,
Daniel Almeida, Daniel Knobe, Danny Smith, Dave Piché, Dmitry Osipenko,
Fabrice Fontaine, fjmax, Florian Zwoch, Guillaume Desmottes, Haihua Hu,
Heinrich Kruger, He Junyan, Jakub Adam, James Cowgill,
Jan Alexander Steffens (heftig), Jean Felder, Jeongki Kim, Jiri Uncovsky,
Joe Todd, Jordan Petridis, Krystian Wojtas, Marc-André Lureau, Marcin Kolny,
Marc Leeman, Mark Nauwelaerts, Martin Reboredo, Mathieu Duponchelle,
Matthew Waters, Mengkejiergeli Ba, Michael Gruner, Nicolas Dufresne,
Nirbheek Chauhan, Olivier Crête, Philippe Normand, Rafał Dzięgiel,
Ralf Sippl, Robert Mader, Sanchayan Maity, Sangchul Lee, Sebastian Dröge,
Seungha Yang, Stéphane Cerveau, Teh Yule Kim, Thibault Saunier,
Thomas Klausner, Timo Wischer, Tim-Philipp Müller, Tobias Reineke,
Tomasz Andrzejak, Trung Do, Tyler Compton, Ung, Víctor Manuel Jáquez Leal,
Vivia Nikolaidou, Wim Taymans, wngecn, Wonchul Lee, wuchang li,
Xavier Claessens, Xi Ruoyao, Yoshiharu Hirose, Zhao,

... and many others who have contributed bug reports, translations,
sent suggestions or helped testing.

## Stable 1.20 branch

After the 1.20.0 release there will be several 1.20.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.20.x bug-fix releases will be made from the [git 1.20 branch][1.20-branch],
which will be a stable branch.

[1.20-branch]: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/commits/1.20/

<a name="1.20.0"></a>

### 1.20.0

1.20.0 was released on 3 February 2022.

<a name="1.20.1"></a>

### 1.20.1

The first 1.20 bug-fix release (1.20.1) was released on 14 March 2022.

This release only contains bugfixes and it *should* be safe to update
from 1.20.0.

#### Highlighted bugfixes in 1.20.1

 - deinterlace: various bug fixes for yadif and greedy methods
 - gtk video sink: Fix rotation not being applied when paused
 - gst-play-1.0: Fix trick-mode handling in keyboard shortcut
 - jpegdec: fix RGB conversion handling
 - matroskademux: improved ProRes video handling
 - matroskamux: Handle multiview-mode/flags/pixel-aspect-ratio caps fields correctly when checking caps equality on input caps changes
 - videoaggregator fixes (negative rate handling, current position rounding)
 - soup http plugin: Lookup libsoup dylib files on Apple platforms & fix Cerbero static build on Android and iOS
 - Support build against libfreeaptx in openaptx plugin
 - Fix linking issues on Illumos distros
 - GstPlay: Fix new error + warning parsing API (was unusuable before)
 - mpegtsmux: VBR muxing fixes
 - nvdecoder: Various fixes for 4:4:4 and high-bitdepth decoding
 - Support build against libfreeaptx in openaptx plugin
 - webrtc: Various fixes to the webrtc-sendrecv python example 
 - macOS: support a relocatable `GStreamer.framework` on macOS (see below for details)
 - macOS: fix applemedia plugin failing to load on ARM64 macOS
 - windows: ship wavpack library
 - gst-python: Fix build with Python 3.11
 - various bug fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - plugin loader: show the reason when spawning of `gst-plugin-scanner` fails
 - registry, plugin loading: fix dynamic relocation if `GST_PLUGIN_SUBDIR` (libdir) is not a single subdirectory; improve `GST_PLUGIN_SUBDIR` handling
 - context: fix transfer annotation on `gst_context_writable_structure()` for bindings
 - baseparse: Don't truncate the duration to milliseconds in `gst_base_parse_convert_default()`
 - bufferpool: Deactivate pool and get rid of references to other objects from dispose instead of finalize

#### gst-plugins-base

 - typefindfunctions: Fix WebVTT format detection for very short files
 - gldisplay: Reorder `GST_GL_WINDOW` check for egl-device
 - rtpbasepayload: Copy all buffer metadata instead of just GstMetas for the input meta buffer
 - codec-utils: Avoid out-of-bounds error
 - navigation: Fix Since markers for mouse scroll events
 - videoaggregator: Fix for unhandled negative rate
 - videoaggregator: Use floor() to calculate current position
 - video-color: Fix for missing clipping in PQ EOTF function
 - gst-play-1.0: Fix trick-mode handling in keyboard shortcut
 - audiovisualizer: shader: Fix out of bound write

#### gst-plugins-good

 - deinterlace: various bug fixes for yadif method
 - deinterlace: Refactor greedyh and fix planar formats
 - deinterlace: Prevent race between method configuration and latency query
 - gtk video sink: Fix rotation not being applied when paused
 - jpegdec: fix RGB conversion handling
 - matroskademux: improved ProRes video handling
 - matroskamux: Handle multiview-mode/flags/pixel-aspect-ratio caps fields correctly when checking caps equality on input caps changes
 - rtprtx: don't access type-system per buffer (performance optimisation); code cleanups
 - rtpulpfecenc: fix unmatched `g_slice_free()`
 - rtpvp8depay: fix crash when making `GstRTPPacketLost` custom event
 - qtmux: Don't post an error message if pushing a sample failed with FLUSHING (e.g. on pipeline shutdown)
 - soup: Lookup libsoup dylib files on Apple platforms & fix Cerbero static build on Android and iOS
 - souphttpsrc: element not present on iOS after 1.20.0 update
 - v4l2tuner: return NULL if no norm set
 - v4l2bufferpool: Fix race condition between qbuf and pool streamoff
 - meson: Don't build lame plugin with -Dlame=disabled

#### gst-plugins-bad

 - GstPlay: Fix new error + warning parsing API (was unusuable before)
 - av1parse: let the parser continue on verbose OBUs
 - d3d11converter: Fix RGB to GRAY conversion, broken debug messages, and add missing GRAY conversion
 - gs: look for google_cloud_cpp_storage.pc
 - ipcpipeline: fix crash and error on windows with `SOCKET` or `_pipe()`
 - ivfparse: Don't set zero resolution on caps
 - mpegtsdemux: Handle PES headers bigger than a mpeg-ts packet; fix locking in error code path; handle more program updates
 - mpegtsmux: Start last_ts with `GST_CLOCK_TIME_NONE` to fix VBR muxing behaviour
 - mpegtsmux: Thread safety fixes: lock mux->tsmux, the programs hash table, and pad streams
 - mpegtsmux: Skip empty buffers
 - osxaudiodeviceprovider: Add initial support for duplex devices on OSX
 - rtpldacpay: Fix missing payload information
 - sdpdemux: add media attributes to caps, fixes ptp clock handling
 - mfaudioenc: Handle empty IMFMediaBuffer
 - nvdecoder: Various fixes for 4:4:4 and high-bitdepth decoding
 - nvenc: Fix deadlock because of too strict buffer pool size
 - va: fix library build issues, caps leaks in the vpp transform function, and add vaav1dec to documentation
 - v4l2codecs: vp9: Minor fixes
 - v4l2codecs: h264: Correct scaling matrix ABI check
 - dtlstransport: Notify ICE transport property changes
 - webrtc: Various fixes to the webrtc-sendrecv python example 
 - webrtc-ice: Fix memory leaks in `gst_webrtc_ice_add_candidate()`
 - Support build against libfreeaptx in openaptx plugin
 - Fix linking issues on Illumos distros

#### gst-plugins-ugly

 - x264enc: fix plugin long-name and description

#### gst-libav

 - No changes

#### gst-rtsp-server

 - Fix race in rtsp-client when tunneling over HTTP

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - Fix build with Python 3.11

#### gst-editing-services

 - Update validate test scenarios for videoaggregator rounding behaviour change

#### gst-integration-testsuites

 - Update validate test scenarios for videoaggregator rounding behaviour change

#### Development build environment

 - gst-env: various clean-ups and documentation improvements

#### Cerbero build tool and packaging changes in 1.20.1

 - Fix nasm version check
 - Disable certificate checking on RHEL/CentOS 7
 - packages: Ship wavpack.dll for Windows
 - osx/universal: make the library name relocatable
 - macOS: In order to support a relocatable `GStreamer.framework` on macOS,
   an application may now need to add an rpath entry to the location of the
   `GStreamer.framework` (which could be bundled with the application itself).
   Some build systems will do this for you by default.
 - Disable MoltenVK on macOS arm64 to fix applemedia plugin loading
 - Fix applemedia plugin failing to load on ARM64 macOS

#### Contributors to 1.20.1

Bastien Nocera, Branko Subasic, David Svensson Fors, Dmitry Osipenko, 
Edward Hervey, Guillaume Desmottes, Havard Graff, Heiko Becker, He Junyan, 
Igor V. Kovalenko, Jan Alexander Steffens (heftig), Jan Schmidt, jinsl00000, 
Joseph Donofry, Jose Quaresma, Marek Vasut, Matthew Waters, 
Mengkejiergeli Ba, Nicolas Dufresne, Nirbheek Chauhan, Philippe Normand, 
Qi Hou, Rouven Czerwinski, Ruben Gonzalez, Sanchayan Maity, Sangchul Lee, 
Sebastian Dröge, Sebastian Fricke, Sebastian Groß, Sebastian Mueller, 
Sebastian Wick, Seungha Yang, Stéphane Cerveau, Thibault Saunier, 
Tim Mooney, Tim-Philipp Müller, Víctor Manuel Jáquez Leal, 
Vivia Nikolaidou, Zebediah Figura, 

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.20.1

- [List of Merge Requests applied in 1.20.1](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.20.1)
- [List of Issues fixed in 1.20.1](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.20.1)

<a name="1.20.2"></a>

### 1.20.2

The second 1.20 bug-fix release (1.20.2) was released on 2 May 2022.

This release only contains bugfixes and it *should* be safe to update from 1.20.x.

#### Highlighted bugfixes in 1.20.2

 - avviddec: Remove vc1/wmv3 override and fix crashes on WMV files with FFMPEG 5.0+
 - macOS: fix plugin discovery for GStreamer installed via brew and fix loading of Rust plugins
 - rtpbasepayload: various header extension handling fixes
 - rtpopusdepay: fix regression in stereo input handling if sprop-stereo is not advertised
 - rtspclientsink: fix possible shutdown deadlock
 - mpegts: gracefully handle "empty" program maps and fix AC-4 detection
 - mxfdemux: Handle empty VANC packets and fix EOS handling
 - playbin3: various playbin3, uridecodebin3, and playsink fixes
 - ptpclock: fix initial sync-up with certain devices
 - gltransformation: let graphene alloc its structures memory aligned
 - webrtcbin fixes and webrtc sendrecv example improvements
 - video4linux2: various fixes including some fixes for Raspberry Pi users
 - videorate segment handling fixes and other fixes
 - nvh264dec, nvh265dec: Fix broken key-unit trick modes and reverse playback
 - wpe: Reintroduce persistent WebContext
 - cerbero: Make it easier to consume 1.20.1 macOS GStreamer .pkgs
 - build fixes and gobject annotation fixes
 - bug fixes, security fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [devicemonitor: clean up signal handlers and hidden providers list](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2221)
 - [Leaks tracer: fix pthread_atfork return value check leading to bogus warning in log](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2210)
 - [Rust plugins: Not picked up by the plugin loader on macOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1149)
 - [Failed to use plugins of latest GStreamer version 1.20.x installed by brew on macOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1159)
 - [ptpclock: Allow at least 100ms delay between `Sync`/`Follow_Up` and `Delay_Req`/`Delay_Resp` messages. Fixes problems acquiring initial sync with certain devices](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2168)
 - [meson: Add -Wl,-rpath,${libdir} on macOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2237)
 - [registry: skip Rust dep builddirs when searching for plugins recursively](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2338)

#### gst-plugins-base

 - [appsrc: Clarify buffer ref semantics in signals documentation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2118)
 - [appsrc: fix annotations for bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2189)
 - [typefind: Skip extension parsing for data:// URIs, fixing regression with mp4 files serialised to data uris](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1983)
 - [playbin3: various fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2236)
 - [playbin3: fix missing lock when unknown stream type in pad-removed cb](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2209)
 - [decodebin3: fix collection leaks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2216)
 - [decodebin3: Don't duplicate stream selections](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2208)
 - [discoverer: chain up to parent finalize methods in all our types to fix memory leaks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1996)
 - [glmixerbin: slightly better pad/element creation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2053)
 - [gltransformation: let graphene alloc its structures memory aligned](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2128)
 - [ogg: fix possible buffer overrun](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2138)
 - [rtpbasepayload: Don't write header extensions if there's no corresponding...](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2205)
 - [rtpbasepayload: always store input buffer meta before negotiation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2321)
 - [rtpbasepayload: fix transfer annotation for push and push_list](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2137)
 - [subparse: don't try to index string with -1](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2148)
 - [riff-media: fix memory leak after usage for `g_strjoin()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2136)
 - [playbin/playbin3: Allow setting a NULL URI](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2105)
 - [playsink: Complete reconfiguration on pad release.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1940)
 - [parsebin: Expose streams of unknown type](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2323)
 - [pbutils: Fix wmv screen description detection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2076)
 - [subparse: don't deref a potentially NULL variable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2325)
 - [rawvideoparse: set format from caps in gst_raw_video_parse_set_config_from_caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2054)
 - [videodecoder: release stream lock after handling gap events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2326)
 - [videorate: fix assertion when pushing last and only buffer without duration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2320)
 - [videorate: Revert "don't reset on segment update" to fix segment handling regressions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2255)
 - [gst-play-1.0, gst-launch-1.0: Enable win32 high-resolution timer also for MinGW build](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2167)

#### gst-plugins-good

 - [deinterlace: silence unused-but-set werror from imported code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2062)
 - [qtdemux: fix leak of channel_mapping](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2184)
 - [rtpopusdepay: missing sprop-stereo should not assume mono](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2139)
 - [rtpjitterbuffer: Fix invalid memory access in rtp_jitter_buffer_pop()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1994)
 - [rtpptdemux: fix leak of caps when ignoring a pt](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2033)
 - [rtpredenc: quieten warning about ignoring header extensions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2281)
 - [soup: Fix pre-processor macros in souploader for libsoup-3.0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2082)
 - [twcc: Note that twcc-stats packet loss counts reordering as loss + add some logging](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1979)
 - [video4linux2: Manual backports for RPi users](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1991)
 - [wavparse: handle URI query in any parse state, fixing audio track selection issue in GES](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2011)
 - [wavparse: Unset DISCONT buffer flag for divided into multiple buffers in push mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2322)

#### gst-plugins-bad

 - [av1parse: Fix several issues about the colorimetry.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2297)
 - [av1parse: fix up various possible logic errors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2240)
 - [dashsink: fix missing mutex unlock in error code path when failing to get content](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2246)
 - [d3d11videosink: Fix for unhandled mouse double click events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2286)
 - [interlace: Also handle a missing "interlace-mode" field as progressive](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2337)
 - [msdk: fix build with MSVC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2113)
 - [mxfdemux: Fix issues at EOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2162)
 - [mxfdemux: Handle empty VANC packets](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2124)
 - [nvh264dec, nvh265dec: Fix broken key-unit trick and reverse playback](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1923)
 - [nvvp9sldec: Increase DPB size to cover render delay](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2324)
 - [rvsg: fix cairo include](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2280)
 - [tsdemux: Fix AC-4 detection in MPEG-TS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2176)
 - [tsdemux: Handle "empty" PMT gracefully](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2327)
 - [va: pool: don't advertise the `GST_BUFFER_POOL_OPTION_VIDEO_ALIGNMENT` option any more](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2301)
 - [v4l2codecs: Fix memory leak](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2002)
 - [v4l2videodec: set frame duration according to framerate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1989)
 - [webrtcbin: Update documentation of 'get-stats' action signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2034)
 - [webrtcbin: Check data channel transport for notifying 'ice-gathering-state'](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1981)
 - [webrtcbin: Avoid access of freed memory](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2258)
 - [wpe: Reintroduce persistent WebContext](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1982)
 - [Build: use CMake to find some openssl and exr deps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2035)
 - [Fix multiple "unused-but-set variable" compiler warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2068)

#### gst-plugins-ugly

 - [x264enc: Don't try to fixate ANY allowed caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2207)

#### gst-libav

 - [video decoders: fix frame leak on negotiation error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2217)
 - [Fix build on systems without C++ compiler](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2119)
 - [avviddec: Remove vc1/wmv3 override (fixing crash with FFmpeg 5](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2074)
 - [Segfaults on ASF/WMV files with FFMPEG 5.0+](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1054)

#### gst-rtsp-server

 - [rtspclientsink: fix possible shutdown deadlock in `collect_streams()`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2278)
 - [Minor spelling fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2172)

#### gstreamer-vaapi

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-omx

 - No changes

#### gst-python

 - [Fix build on systems without C++ compiler](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2214)

#### gst-editing-services

 - [License clarification: GES is released under the LGPL2+ license](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2015)

#### gst-examples:

 - [Fix build on macOS with gtk+-quartz-3.0](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2116)
 - [player android: add missing dummy.cpp](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2065)
 - [player android: update for android changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2059)
 - [webrtc_sendrecv.py: Link pads instead of elements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2013)
 - [webrtc_sendrecv.py: Implement all negotiation modes + bugfixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1995)

#### Development build environment + gst-full build

 - [meson: provide `gobject-cast-checks`, `glib-checks` and `glib-asserts` options at top level as well](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2243)

#### Cerbero build tool and packaging changes in 1.20.2

 - [macOS: Make it easier to consume 1.20.1 GStreamer .pkgs](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/371)
 - [Android: fix text relocation regression on Android (x86/ x86_64 platforms)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/1012)

#### Bindings

 - [appsrc: fix annotations for bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2189)
 - [bindings: The out args for `gst_rtp_buffer_get_extension_data*()` are optional](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1980)
 - [rtpbasepayload: fix transfer annotation for push and push_list](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2137)

#### Contributors to 1.20.2

Bastian Krause, Benjamin Gaignard, Camilo Celis Guzman, Chun-wei Fan,
Corentin Damman, Daniel Stone, Dongil Park, Edward Hervey, Fabrice Fontaine,
Guillaume Desmottes, Havard Graff, He Junyan, Hoonhee Lee, Hou Qi,
Jan Schmidt, Marc Leeman, Mathieu Duponchelle, Matthew Waters,
Nicolas Dufresne, Nirbheek Chauhan, Philippe Normand, Pierre Bourré,
Sangchul Lee, Sebastian Dröge, Seungha Yang, Stéphane Cerveau,
Thibault Saunier, Tim-Philipp Müller, Tong Wu, Tristan Matthews,
Tulio Beloqui, Wonchul Lee, Zhao Zhili,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.20.2

 - [List of Merge Requests applied in 1.20.2](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.20.2)
 - [List of Issues fixed in 1.20.2](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.20.2)

## Schedule for 1.22

Our next major feature release will be 1.22, and 1.21 will be the unstable development version leading up to the stable 1.22 release. The development of 1.21/1.22 will happen in the git main branch.

The [plan for the 1.22 development cycle][1.22-schedule] is yet to be confirmed. Assuming no major project-wide reorganisations in the 1.22 cycle we might try and aim for a release around August 2022.

1.22 will be backwards-compatible to the stable 1.20, 1.18, 1.16, 1.14, 1.12, 1.10, 1.8, 1.6, 1.4, 1.2 and 1.0 release series.

[1.22-schedule]: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/974

- - -

*These release notes have been prepared by Tim-Philipp Müller with contributions from Matthew Waters, Nicolas Dufresne, Nirbheek Chauhan, Sebastian Dröge and Seungha Yang.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
