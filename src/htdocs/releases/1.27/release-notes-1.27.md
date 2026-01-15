# GStreamer 1.27.x Release Notes

GStreamer 1.27.x was an API/ABI-unstable development series leading up to the stable 1.28 series.

This has now been superseded by the [stable GStreamer 1.28.0 release series](../1.28/), which was released in January 2026.

<a id="1.27.90"></a>

### 1.27.90 (1.28.0 release candidate 1)

The 1.27.90 pre-release is the first release candidate for the upcoming 1.28.0 stable feature release, and was released on 05 January 2026.

Any newly-added API in the 1.27.x series may still change or be removed again before 1.28 and should be considered unstable until 1.28 is released.

#### Highlighted changes in 1.27.90

 - Add a burn-based YOLOX inference element and a YOLOX tensor decoder in Rust
 - Add an audio source separation element based on demuc in Rust
 - Add new GIF decoder element in Rust with looping support
 - Add a Rust-based icecastsink element with AAC support
 - analytics: Improvement to inference elements; move modelinfo to analytics lib; add script to help with modelinfo generation and upgrade
 - decklinkvideosink: Fix frame duration to be based on the decklink clock
 - flv: Fix track ID 0 semantics and extended FLV for non multitrack type packets
 - GstPlay: Add support for gapless looping
 - input-selector: implements a two-phase sinkpad switch now to avoid races when switching input pads
 - intersrc: new event-types property to forward upstream events to sink
 - isomp4mux: Support caps change and add support for raw audio as per ISO/IEC 23003-5
 - jpegparse: fix handling of JPEGs with HDR gain maps
 - jsontovtt: add property to enable per-cue line attributes
 - textaccumulate: implement no-timeout mode for forwarding full sentences
 - matroskademux: make maximum allowed block size large enough to support 4k uncompressed video
 - qtdemux: fix various MP4 demuxing issues and regressions
 - GstValue: The recently-introduced GstSet API was renamed to GstUniqueList
 - cerbero: add support for Python wheel packaging, fix Windows build with Python 3.14, support system recipes, ship Gtk4 and more plugins
 - Countless bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [input-selector: implement a two-phase sinkpad switch](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10204)
 - [value: Rename GstSet to GstUniqueList](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10384)
 - [GstValueSet: gst_value_set_stuff() functions became static methods now](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4813)
 - [utils: Fix race in gst_element_link_pads_filtered() (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10383)
 - [queue: Log the status of the queue at debug level](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10403)
 - [info: Increase test interval when running under valgrind](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10456)
 - [Assorted fixes for the Cerbero symbolication support under macOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10466)
 - [Fix several memory leaks (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10476)

#### gst-plugins-base

 - [basetextoverlay: Don't negotiate if caps haven't changed (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10352)
 - [gl: Add support for Y444_12](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10451)
 - [gl: adjust log level from error to warning when copying memory](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10382)
 - [glimagesink: don't assume GstVideoMeta always exists in the buffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10462)
 - [gloverlaycompositor: Type change of member in public struct](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4818)
 - [glupload: Fix GST_DEBUG GObject warning](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10436)
 - [opusenc: Simplify Vorbis channel layout mapping code and fix 7.1 layout & use surround multistream encoder (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10374)
 - [playbin3: ensure GST_EVENT_SELECT_STREAMS event is sent to collection source (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10341)
 - [tagdemux: propagate seek event seqnum to upstream (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10356)
 - [uridecodebin3: Fix docs for the select-stream signal (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10480)
 - [videoaggregator/videomixer2: handle non-TIME segment events gracefully](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10459)
 - [video: Include gstvideodmabufpool.h from video.h](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10411)
 - [Fix debug logging crashes (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10475)
 - [Fix several memory leaks (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10476)
 - [Properly unref pad template caps (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10477)

#### gst-plugins-good

 - [flac: Fix 6.1 / 7.1 channel layouts (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10375)
 - [flacdec: Don't forbid S32 sample size (0x07) unnecessarily (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10369)
 - [flacenc: Support S32 samples (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10377)
 - [flv: Fix track ID 0 semantics and extended FLV for non multitrack type packets](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10071)
 - [gl: Add support for Y444_12](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10451)
 - [level: fix crash if no caps have been sent (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10236)
 - [matroskamux: Fix some more thread-safety issues (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10349)
 - [matroskademux: Bump maximum block size from 15MB to 32MB (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10417)
 - [mxfdemux / aiffparse / matroskaparse: Remove segment closing on non-flushing seeks (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10399)
 - [qtdemux: Regression in pull mode where EOS is never reached](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4833)
 - [qtdemux: Some mp4 videos don't start to play and stutter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4600)
 - [qtdemux: Fix splitting up / padding of captions (regression)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10458)
 - [qtdemux: use PTS instead of DTS for sample scheduling (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10383)
 - [qtdemux: Add mapping for tsc2 fourcc](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10471)
 - [splitmuxsrc - fix for seeking / flushing deadlock (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10344)
 - [videoaggregator/videomixer2: handle non-TIME segment events gracefully](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10459)
 - [wavenc: Fix downstream negotiation (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10412)
 - [Fix several memory leaks (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10476)
 - [Properly unref pad template caps (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10477)

#### gst-plugins-bad

 - [analyticsrelationmeta: Skip Mtd that can't be transformed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10443)
 - [ModelInfo: use model info in onnxinference + tool](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10244)
 - [decklinkvideosink: Fix frame duration to be based on the decklink clock](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10401)
 - [gstplay: Add gapless looping](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10418)
 - [jpgparse: support multi picture format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10301)
 - [jpegparse: reports the wrong dimensions for JPEGs containing half-size HDR gain maps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4774)
 - [tensordecoder: rename ssdobjectdetector to ssdtensordec](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10340)
 - [tensordecoder: ssdtensordec backward compat with oldname](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10380)
 - [value: Rename GstSet to GstUniqueList](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10384)
 - [video: decoders: Fix possible crash when flushing H265/H266 decoder (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10421)
 - [vkformat: Add VK_FORMAT_G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16 format (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10333)
 - [webrtc/nice: fix crashes on gathering stats for relay candidates](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10336)
 - [webrtcbin: Check transport before setting state when closing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10432)
 - [webrtcnice: Plug leaks caused by outstanding resolve tasks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8519)
 - [win32ipcbasesink: Serialize metas from uploaded buffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10362)
 - [win32ipcsink: Preserve original buffer flags in raw-video fallback path](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10343)

Build improvements, introspection fixes, leak fixes, clean-ups and other smaller improvements:

 - [aesenc / aesdec: use correct format specifier for buffer size in debug log (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10239)
 - [dtlsdec: mark generated cert agent with GST_OBJECT_FLAG_MAY_BE_LEAKED (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10366)
 - [fdkaacdec: Invalidate channel_types/indices when setting a known config (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10370)
 - [geometrictransform: Fix integer overflow in map allocation (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10448)
 - [hlsdemux: Mark discontinuity on seek](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10402)
 - [hlssink: Guard NULL structure and use gst_structure_has_name() (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10393)
 - [kaleidoscope: Fix potential division by zero in geometric transform (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10438)
 - [meson: fix building -bad tests with disabled vmaf](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10353)
 - [modelinfo: Add some missing annotations](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10410)
 - [mxfdemux / aiffparse / matroskaparse: Remove segment closing on non-flushing seeks (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10399)
 - [mxfdemux: Simplify timestamp tracking (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10396)
 - [mxfdemux: send event SegmentDone for segment seeks (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10331)
 - [onnx: remove invalid properties](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10427)
 - [onnxinference: Fix integer overflow in buffer allocation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10449)
 - [qroverlay: use proper klass](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10493)
 - [tensordecoder: fix typo in header](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10342)
 - [video: Include gstvideodmabufpool.h from video.h](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10411)
 - [vp8decoder: Fix incorrect variable in warning message](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10494)
 - [Fix several memory leaks (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10476)
 - [Properly unref pad template caps (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10477)

#### gst-plugins-ugly

 - No changes

#### GStreamer Rust plugins

 - [Add a burn-based YOLOX inference element and a YOLOX tensor decoder](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2347)
 - [Add audio source separation element based on demucs](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2554)
 - [Add new icecastsink element with AAC support](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1588)
 - [audiornnoise: Fix audio level value reporting (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2741)
 - [gif: add new decoder element](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2763)
g- [gtk4paintablesink: Propose a udmabuf pool / allocator if upstream asks for sysmem (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2738)
 - [gtk4: Use safe udmabuf allocator / pool bindings (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2768)
 - [intersrc: event-types property to forward upstream events](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2750)
 - [isobmff/mp4mux: Add support for raw audio as per ISO/IEC 23003-5](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2762)
 - [jsontovtt: add property to enable per-cue line attributes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2736)
 - [mp4mux: Support caps change](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2743)
 - [rtp: basepay2: Consider size of header extensions in maximum payload size (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2783)
 - [textaccumulate: implement no-timeout mode for forwarding full sentences](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2730)
 - [threadshare: allow disabling the IPv4 or IPv6 socket in ts-udpsink (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2753)
 - [tracers: add function and signal for writing logs to PadPushTimings (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2746)
 - [webrtc: mark static caps with GST_MINI_OBJECT_FLAG_MAY_BE_LEAKED (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2757)
 - [webrtc: Deprecate webrtchttp plugin](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2707)

Build improvements, clean-ups and other smaller improvements:

 - [burn: Update to dirs 6](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2777)
 - [demucs: Update to async-tungstenite 0.32](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2778)
 - [demucs: Update to pyo3 0.27](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2781)
 - [dav1d: Stop iteration after finding first working pool (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2744)
 - [dav1d: Various fixes to allocation query handling (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2739)
 - [gtk4: Fix typo in odd-size subsample workaround (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2752)
 - [isobmff/fmp4mux: Fix incorrect log level](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2764)
 - [isobmff: Refactor and consolidate code for brands](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2776)
 - [quinn: Fix broken tests](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2745)
 - [quinn: Reduce mini object copying and allocations, and remove unused imports](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2794)
 - [quinn: Explicitly use ring as rustls crypto provider, fix up TLS certificate configuration, and minor cleanups](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2795)
 - [rtp: Fix amr tests test_amr_{nb,wb}_bit_packed (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2792)
 - [rtp: Update to rtcp-types 0.3 (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2759)
 - [threadshare: Update to flume 0.12 (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2742)
 - [tracers: Update to signal-hook 0.4 (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2780)
 - [Fix new clippy 1.92 warnings (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2754)
 - [Port from rustls-pemfile to rustls-pki-types (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2787)
 - [Update dependencies (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2770)
 - [Update dependencies II (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2790)
 - [Update MSRV to 1.92](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2773)
 - [version-helper: Update to toml_edit 0.24 (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2765)

#### gst-libav

 - [avviddec: Set video alignment to internal pool (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10437)
 - [Fix several memory leaks (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10476)

#### gst-rtsp-server

 - No changes

#### gstreamer-sharp

 - No changes

#### gst-python

 - [webrtcnice: Plug leaks caused by outstanding resolve tasks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8519)
 - [Make python linter happy with test_analytics](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10244)

#### gst-editing-services

 - No changes

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [devtool: New script to generate ModelInfo from ONNX](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10244)
 - [dots-viewer: add build directory to devenv PATH](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10354)
 - [gst-validate-launcher: Fix typo in --help](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10409)
 - [webrtcnice: Plug leaks caused by outstanding resolve tasks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8519)
 - [mxfdemux: Simplify timestamp tracking (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10396)
 - [Update Rust dependencies (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10385)

### gst-examples

 - [Update Rust dependencies (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10385)
 - [gst-examples: Allow using real sources for webrtc-sendrecv](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10416)

#### gstreamer-docs

 - [Document Python wheel support in Cerbero](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10414)
 - [value: Rename GstSet to GstUniqueList](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10384)
 - [Fix typo](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10430)

#### Development build environment

 - [Update wraps, incl. glib: directxmath, expat, fdk-aac, flac, freetype2, gdk-pixbuf, gtest, harfbuzz, json-glib, lame, libjpeg-turbbb, libopenjp2, libpng, libsrtp2, libxml2, nghttp2, ogg, pango, pcre2, soundtoch, sqlite3, wayland-protocols, zlib](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10422)

#### Cerbero build tool and packaging changes in 1.27.90

 - [Add a Windows ARM64 MSI](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/483)
 - [Be able to install cerbero](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1484)
 - [Ship Gtk4 and gtk4paintablesink](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2022)
 - [Replace use_system_libs with SystemRecipes](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1971)
 - [More python 3.14 fixes on Windows, get rid of os.path.join hack (backported)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2029)
 - [Update to Rust 1.92 and cargo-c 0.10.19](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2008)
 - [cache: Fix post-merge pipeline by moving to Path.as_posix()](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2035)
 - [cerbero: Assorted fixes for issues found during frei0r PDB testing](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2023)
 - [cerbero: Implement symbol listing and packaging](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1917)
 - [cerbero: Remove UWP support, leaving cross-win-arm64 support in its place](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2021)
 - [cerbero: Use ninja for all cmake recipes by default (backported)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2014)
 - [Cleanup env vars that can affect the build, fix lcevcdec.recipe, don't set PKG_CONFIG_PATH in the wheels env](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2040)
 - [ci: Mark a racy xcode toolchain bug for retrying (backported)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2011)
 - [cmake, harfbuzz, graphene: Misc fixes split out from !1750](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2019)
 - [frei0r-plugins: Fix files_plugins considering more than just modules](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2012)
 - [gst-plugins-bad: Temporarily disable lcevcdec on 32-bit Windows](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2009)
 - [gst-plugins-rs: ship rust audioparsers and speechmatics plugins](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1922)
 - [gst-plugins-rs: ship new burn and demucs plugins; add analytics category + package](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2028)
 - [gtk: fix InvalidRecipeError call](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2042)
 - [lcevcdec: Update to 4.0.4](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2010)
 - [macOS packages do not ship debug symbol files *.dsym](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/350)
 - [packages: Add support for Python wheel packaging](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2004)
 - [pkg-config: Ship it in the devel package (backported)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2025)
 - [recipe: Update License enums to SPDX expressions (backported)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2018)
 - [recipes: Fix GPL categorization of some plugins (backported)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2000)
 - [recipes: add GstAnalytics and GstApp python binding](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1999)
 - [setup: Fix the logging import](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2037)
 - [wheel: Also add gstreamer_gtk rpath to libgmodule](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2041)
 - [wheel: Don't try to add '.' as a dll directory](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2043)
 - [wheel: Fix entrypoint invocation](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2038)
 - [wheel: Fix entrypoint naming on non-Windows](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2039)
 - [wheel: Make frei0r plugins be an opt-in feature](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2027)
 - [Put frei0r plugins behind an option on the gstreamer wheel](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/544)
 - [Windows build broken with Python 3.14.x](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/542)
 - [Windows ARM64 packaging support](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2030)
 - [Error loading the environment setup whether GStreamer environment variables are already present](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/524)
 - [Python plugin doesn't load via the wheels distribution, only on macOS](https://gitlab.freedesktop.org/gstreamer/cerbero/-/issues/545)
 - [python: Fix loading of gstpython plugin on macOS](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2036)

#### Contributors to 1.27.90

Aaron Boxer, Adrien Plazas, Alicia Boya García, Brad Reitmeyer,
Carlos Falgueras García, Christian Gräfe, Daniel Morin, Doug Nazar, Elliot Chen,
François Laignel, Gang Zhao, Hyunjun Ko, Jakub Adam, Jan Schmidt, Jeongmin Kwak,
Jerome Colle, Johan Sternerup, Jorge Zapata, L. E. Segovia, Mathieu Duponchelle,
Nicolas Dufresne, Nirbheek Chauhan, Olivier Crête, Paxton Hare, Philippe Normand,
Piotr Brzeziński, Ratchanan Srirattanamet, Robert Mader, Ruben Gonzalez,
Sanchayan Maity, Sebastian Dröge, Seungha Yang, Taruntej Kanakamalla,
Stéphane Cerveau, Thibault Saunier, Tim-Philipp Müller, Tjitte de Wert,
Tobias Schlager, Víctor Manuel Jáquez Leal, Yun Liu,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.27.90

- [List of Merge Requests applied in 1.27.90](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.27.90)
- [List of Issues fixed in 1.27.90](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.27.90)

<a id="1.27.50"></a>

### 1.27.50

The third API/ABI-unstable 1.27.x development snapshot release (1.27.50) was released on 09 December 2025 and marks the beginning of our feature freeze in preparation of the upcoming 1.28 stable release.

Any newly-added API in the 1.27.x series may still change or be removed again before 1.28 and should be considered unstable until 1.28 is released.

The 1.27.x release series is for testing and development purposes, and distros should probably not package it.

#### Highlighted changes in 1.27.50

 - Vulkan Video AV1 decoder
 - webrtcsink: add renegotiation support, and support for va hardware encoders
 - New ST-2038 ancillary data combiner and extractor elements
 - applemedia: VP9 and AV1 hardware-accelerated video decoding support, and 10-bit HEVC encoding
 - fallbacksrc gained support for encoded streams
 - flv: enhanced rtmp H.265 video support, and support for multitrack audio
 - glupload: Implement udmabuf uploader to share buffers between software decoders/sources and GPUs, display engines (wayland), and other dma devices
 - video: Add crop, scale, rotate, flip, shear and more GstMeta transformation
 - New task pool GstContext to share a thread pool amongst elements for better resource management and performance, especially for video conversion and compositing
 - analytics: New tensordecodebin element to auto-plug compatible tensor decoders based on their caps and many other additions and improvements
 - New Deepgram speech-to-text transcription plugin
 - Speech synthesizers: expose new "compress" overflow mode that can speed up audio while preserving pitch
 - Support new Speechmatics speaker identification API
 - ElevenLabs voice cloning element
 - New Qt6 QML qml6 render source element
 - appsink, appsrc: new bindings-friendly "simple" callbacks API
 - New element to calculate perceptual video quality assessment scores using Netflix's VMAF framework
 - Add new metadata GstStream type and use in decodebin3 for KLV, ID3 PES and ST-2038 ancillary data
 - New MPEG-H audio decoding plugin plus MP4 demuxing support
 - The inter plugin wormhole sink and source elements gained new properties to fine tune the inner elements
 - hlscmafsink can generate I-frame only playlist now
 - New LCEVC H.266 encoder element
 - webrtc: add WHEP server signaller
 - Added "robust MPEG audio", raw audio (L8, L16, L24), and ancillary metadata RTP payloaders in Rust
 - The Windows IPC plugin gained support for passing generic data in addition to raw audio/video, and various properties
 - New D3D12 interlace and overlay compositor elements
 - GStreamer AMD HIP integration functionality is now available in a helper library
 - Blackmagic Decklink elements gained support for capturing and outputting all types of VANC via GstAncillaryMeta
 - Replaygain R128 gain tags support
 - aws: URI handler for S3 URIs; dropped registration of rusotos3src and rusotos3sink
 - quinn: Support sharing of QUIC/WebTransport connection/session
 - validate: New plugin with a check-last-frame-qrcode action
 - clocksync: new "rate" property and "resync" action signal
 - debug logging: Add convenience macros around GstLogContext for logging things only once
 - Countless bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [Add gst_check_version() utility function for checking the current version at runtime](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9915)
 - [Add gst_call_async() and gst_object_call_async() variants](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/869)
 - [Add GstCpuId API to detect CPU features](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10004)
 - [aggregator: Prevent start time selection before reaching PLAYING](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9689)
 - [compositor, videoaggregator, videoconvertscale: add support for task pool context which allows applications to provide a task pool shared between all elements in pipelines for better resource management and performance](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10047)
 - [controller: Add threadsafe gst_timed_value_control_source_list_control_points()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9830)
 - [context: Add a `gst.task.pool` GstContext type that can be shared between all elements in pipelines](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10047)
 - [GstClock: Add gst_clock_is_system_monotonic_clock()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8257)
 - [device-monitor: Start providers in a separate thread + new GST_MESSAGE_DEVICE_MONITOR_STARTED](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9698)
 - [info: Add convenience macros around GstLogContext for logging once](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9939)
 - [info: Print thread ID instead of GThread handle on Windows/Linux/FreeBSD and pthread_t* elsewhere](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9913)
 - [object: Add gst_object_get_toplevel() to get the toplevel object](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10075)
 - [pad: add more accessors for `GstPadProbeInfo` fields / accessor for `GstMapInfo` `data` field](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9661)
 - [pad: make gst_pad_forward not O(n²) (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9902)
 - [plugin: convert plugin loading mutex to recursive mutex](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9759)
 - [memory: Various API cleanups, deprecations and additions for consistency (and bindings)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10020)
 - [streams: Add GST_STREAM_TYPE_METADATA for metadata streams (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10249)
 - [streamcollection: Fix race condition between disconnecting notify proxy and notifications (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10196)
 - [tags: add `GST_TAG_TRACK_GAIN_R128` and `GST_TAG_ALBUM_GAIN_R128`: replay gain tags](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6369)
 - [value: Support 0b/0B prefix for bitmasks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9732)
 - [value: add GstSet, a new unordered, unique container value type (used in tensor caps)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10262)

Build improvements, introspection fixes, leak fixes, clean-ups and other smaller improvements:

 - [basetransform, basesrc: Fix handling of buffer pool configuration failures (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10298)
 - [controller: Fix get_all() return type annotation (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9828)
 - [factory: Move debug logging to clarify code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10049)
 - [filesink: fix the build with recent mingw-w64 (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10268)
 - [info: Added parentheses to ensure proper evaluation of conditions in logging level checks (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9917)
 - [info: Fix test pattern to check for an expected debug log line (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10012)
 - [info: Forbid GST_LEVEL_MEMDUMP for GstLogContext logging](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9936)
 - [info: Force comparison to same types (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10165)
 - [info: GST_CTX_MEMDUMP can invoke undefined behaviour](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4722)
 - [meta: throttle down warning about unregistered meta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9652)
 - [metafactory: Use same parameter name in header and source file to make g-i happy](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9664)
 - [netclientclock: Fix memory leak in error paths (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9740)
 - [parse: Move g_strfreev() a bit later to avoid use-after-free (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9871)
 - [pipeline: Improve resource cleanup logic for clock objects (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10179)
 - [structure: Don't crash if GArray has NULL value (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10036)
 - [utils: Annotate temp array in gst_calculate_linear_regression() as such](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10108)
 - [utils: Fix leak in gst_util_filename_compare (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9916)
 - [value: Add missing for symbol for builds without asserts/checks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10069)
 - [value: Fix GstAllocationParams string conversion (used in debug logging) on 32-bit architectures (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10222)
 - [vasnprintf: free dynamic tmp buffer on error to prevent memory leak (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9893)
 - [Add G_GNUC_WARN_UNUSED_RESULT to constructors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9796)
 - [Build fixes for projects that use -Wpedantic and -Wcast-qual](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10076)
 - [Clean up warnings when checks & asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9724)
 - [Clean up warnings when checks & asserts disabled in GstBase](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9760)
 - [Mark callback inout parameters as such](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9847)
 - [Mark functions WARN_UNUSED_RESULT where return is full transfer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9766)
 - [GstAdapter: Add doc clarification regarding timestamps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9690)
 - [Some more introspection fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9709)
 - [meson: Add missing devenv values](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9800)
 - [libcheck: use SIGABRT instead of SIGKILL on timeout](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/2585)

Tools:

 - [gst-launch-1.0: Do not assume error messages have a src element (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9737)
 - [gst-launch-1.0: Print details of error message (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9894)
 - [gst-inspect-1.0: Pretty print tensor caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9109)

Core elements:

 - [clocksync: Add rate property and resync action signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7463)
 - [multiqueue: Fix object reference handling in signal callbacks (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9738)
 - [queue: Use GST_PTR_FORMAT everywhere for debug logging](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10068)

#### gst-plugins-base

 - [appsink, appsrc: Add new bindings-friendly "simple" callbacks API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10037)
 - [audio-resample: enable SIMD optimisations when building with MSVC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10004)
 - [audio: add U20_32 and S20_32 audio format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9650)
 - [audiomixmatrix: Add sparse matrix LUT optimization](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10002)
 - [codec-utils: Add support for FLAC and AC4 in mime codec strings (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10319)
 - [decodebin3: Add a separate pad template for metadata streams and consider KLV, ID3 PES streams and ST-2038 streams as raw formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10249)
 - [glupload: Implement udmabuf uploader to share buffers between software decoders/sources and GPUs, display engines (wayland), and dma devices](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8540)
 - [giosrc: Fix race changing is-growing property](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9854)
 - [gl: Support DMABuf passthrough with meta:GstVideoOverlayComposition (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10000)
 - [glupload: Set caps format to RGBA also on legacy dmabuf direct upload](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9702)
 - [opengl: Fix importation of padded textures](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10120)
 - [pbutils: Add ID3 metadata to codec descriptions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7645)
 - [riff: Add channel reorder maps for 3 and 7 channel audio (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9736)
 - [rtpbaseaudiopay: Consider RESYNC flag as discontinuity too (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9836)
 - [rtpbuffer: Don't mix different buffer / memory mappings when setting extension data](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10020)
 - [sdp: fix usage of gst_buffer_append (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9716)
 - [video: Add crop, scale, rotate, flip, shear and more meta transformation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9497)
 - [videoaggregatorpad: set thread count from pool max thread count in newly created video convert config](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10073)
 - [videoconverter: converter created with pool and no config should use pool max thread count](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4743)
 - [videoconverter: assume pool max thread count if no config provided](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10063)
 - [videorate: fix assert fail due to invalid buffer duration (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9820)
 - [VideoOverlayCompositionMeta: Fix multiple composition meta usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7627)

Build improvements, introspection fixes, leak fixes, clean-ups and other smaller improvements:

 - [allocators: udmabuf: Only build if UDMABUF_CREATE and linux/dma-buf.h exist](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10320)
 - [alsasrc: use new gst_clock_is_system_monotonic_clock()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8257)
 - [alsadeviceprovider: Fix device name leak (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10224)
 - [audio: Re-order the all formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10074)
 - [audio: meta: Fix annotation for matrix on gst_buffer_add_audio_downmix_meta()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10152)
 - [audioaggregator: Remove unnecessary event unref](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10101)
 - [audio-resampler-neon: Add missing stdint include](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10209)
 - [audiovisualizer: Use break instead of goto for escape logic (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10124)
 - [compositor: Fix critical warning due to late debug category initialization](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9995)
 - [decodebin3: Clear previous collection on input (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10109)
 - [decodebin3: Protect NULL dereference (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10246)
 - [discoverer: Mark gst_discoverer_stream_info_list_free() as `transfer full` (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9819)
 - [encoding-target: Fix memory leak in gst_encoding_target_save (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10007)
 - [fdmemory: Add is_span implementation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10299)
 - [fdmemory: Fix size calculation when sharing (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10308)
 - [egl: Don't crash for supported formats without modifiers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10300)
 - [egl: fix memory leak in _print_all_dma_formats (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9960)
 - [drmdumb, gldownload: Add KEEP_MAPPED flag to the allocated buffers (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10153)
 - [glbasesrc: Add unlock handling for non-negotiated cases (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10125)
 - [glcolorconvert: Fix memory leak in _create_shader (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10009)
 - [gldisplay: Remove return caused by unnecessary conditional statement](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10103)
 - [glfiltershader: Add missing unlock (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10123)
 - [glimagesink: Fix handling of odd height buffers (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10330)
 - [glstereosplit: Add missing unlock for exceptional case (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10127)
 - [gltestsrc: Fix memory leaks on shader creation failure (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9959)
 - [glupload: dmabuf: Add missing texture target check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10227)
 - [glutils: Remove logically dead code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10100)
 - [id3: fix csets memory leak in string_utf8_dup (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10006)
 - [opusdec: Unref intersected caps when empty to avoid leaks (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10029)
 - [parsebin: Free missing plugin details and return failure when plugin is not found (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9958)
 - [pbutils: Fix bit shifting when generate hevc mime codec string (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10097)
 - [pbutils: Don't throw critical for unknown mime codec (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9920)
 - [playbin2: Remove logically dead code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10098)
 - [qt: Fix building examples on macOS (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9764)
 - [rtpbasedepayload: Add missing unlocks (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10128)
 - [rtsp: fix memory leaks in gst_rtsp_connection_connect_with_response_usec (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9961)
 - [samiparse: Remove structurally dead code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10105)
 - [tag: use locale-independent number parsing in vorbistag](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6369)
 - [tcp: Edit README, remove "protocol=none"](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9694)
 - [tcp: drop unused parameter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9778)
 - [test/profile: Use random profile names for load/save tests.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5536)
 - [typefindfunctions: Remove logically dead code](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10099)
 - [uridecodebin3: Add null check of play items in purge (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10106)
 - [urisourcebin: Add missing unlock (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10129)
 - [urisourcebin: Fix initial values of min_byte_level and min_time_level variables (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10102)
 - [videoaggregator: Don't post have-context for internally created task pool](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10325)
 - [videoencoder: fix warning of uninitialized buffer (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10210)
 - [videodecoder, videoaggregator: Fix handling of buffer pool configuration failures (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10298)
 - [Add G_GNUC_WARN_UNUSED_RESULT to constructors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9796)
 - [Annotate unused functions/variables when checks/asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9931)
 - [Can't compile on FreeBSD because no linux/udmabuf.h exists (regression in main branch)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4793)
 - [GstAudioBuffer, GstVideoFrame: Clear various fields on unmap](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10020)
 - [Clean up warnings when checks & asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9760)
 - [Documentation fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10180)
 - [Fix build error with glib < 2.68 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9707)
 - [Mark functions WARN_UNUSED_RESULT where return is full transfer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9766)
 - [Use new gst_call_async() and gst_object_call_async() functions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/869)

Tools:

 - [gst-device-monitor-1.0: Print the type of each structure field](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9814)
 - [gst-play-1.0: fix printing of missing plugin details and try to install missing plugins if the distro supports it (partially backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10173)
 - [gst-play-1.0: Add missing unlock for invalid track type (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10126)

#### gst-plugins-good

 - [aacparse: support streams which does not have frequent LOAS config (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9927)
 - [cairooverlay: Fix multiple composition meta usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7627)
 - [deinterlace, goom: use GstCpuId instead of liborc to decide what SIMD optimisations to enable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10004)
 - [flv: add support for multitrack audio in muxer and demuxer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9682)
 - [flv: enhanced rtmp h265 support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9873)
 - [hlsdemux2: error out instead of aborting on negative stream time (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10091)
 - [hlsdemux2: Keep streams with different names (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10218)
 - [id3metaparse: new element that parses timed ID3 metadata packets such as from MPEG-TS id3 metadata PES](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7645)
 - [mp4mux: Add support for E-AC3](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9951)
 - [mpg123audiodec: Always break the decoding loop and relay downstream flow errors upstream (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9673)
 - [multifile: verify format identifiers in filename template strings (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10056)
 - [osxaudio: Switch from device-id to unique-id everywhere, add a property for the transport type](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9710)
 - [osxaudio: Drop in io_proc on pause instead of removing it to fix potential deadlock](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10107)
 - [osxaudio: Various fixes, incl a potential crash when probing (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9846)
 - [osxaudio: Core Audio deadlock](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4155)
 - [qml6: implement new element qml6glrendersrc](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9308)
 - [qtdemux: add support for MPEG-H Audio](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9449)
 - [qtmux: Fix robust recording estimates (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10286)
 - [replaygain: Use R128 gain tags when available](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6369)
 - [rtpvp9pay: Fix parsing of show-existing-frame (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10005)
 - [rtph263pay: Fix Out-of-bounds access (OVERRUN) (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9935)
 - [rtph264depay: Implement support for MTAP16 / MTAP24](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9785)
 - [qtdemux: fix open/seek perf for GoPro files with SOS track (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9784)
 - [splitmuxsink: accept pads named 'sink_%u' on the muxer (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9891)
 - [v4l2: Add support for WVC1 and WMV3 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9630)
 - [v4l2transform: reconfigure v4l2object only if respective caps changed (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8941)
 - [v4l2allocator: Add KEEP_MAPPED flag to the allocated buffers (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10153)
 - [videobox, videocrop, videoflip: implement new video matrix meta transformation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9497)

Build improvements, introspection fixes, leak fixes, clean-ups and other smaller improvements:

 - [adaptivedemux2: Fix a crash on rapid state changes, and startup busy waiting (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10217)
 - [adaptivedemux2: Initialize start bitrate for dashdemux2 and hlsdemux2 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10284)
 - [audio: Re-order the all formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10074)
 - [audiodeinterlave, audiointerleave: add support for new U20_32 and S20_32 audio formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9650)
 - [audioparsers: Various memory and buffer handling fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10035)
 - [flvmux: optimize strlen calls and add FLV spec compliance](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10028)
 - [isoff: fix fall through warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9703)
 - [matroskamux, flvmux: Properly check if pads are EOS in find_best_pad (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9803)
 - [matroskamux: Fix thread-safety issues when requesting new pads (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10332)
 - [multifile: use new gst_call_async() and gst_object_call_async() variants](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/869)
 - [osxaudio: Remove unnecessary if, add comment about GstDevice lifetime (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10223)
 - [qt: Fix building examples on macOS (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9764)
 - [qtdemux: handle unsupported channel layout tags gracefully (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9750)
 - [qtdemux: set channel-mask to 0 for unknown layout tags (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9753)
 - [qtdemux: avoid rounding sample timestamps early](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9713)
 - [qtdemux: Use gst_util_uint64_scale to scale guint64 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10287)
 - [rtp: Fix usage of uninitialized variable (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9930)
 - [rtpvp9depay: fix wrong event referencing, use same packet lost logic from neighboring vp8depay (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9872)
 - [v4l2: Fix VYUY mapping](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10070)
 - [v4l2: Fix NULL pointer dereference in probe error path (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9870)
 - [v4l2videoenc: Fix codec frame leak on error (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10114)
 - [v4l2videoenc: fix memory leak about output state and caps (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10030)
 - [v4l2videodec: clear source change flag after dequeuing source change event](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10263)
 - [v4l2: Add GstV4l2Error handling in gst_v4l2_get_capabilities (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9629)
 - [v4l2: Extend the iterator range to VIDEO_NUM_DEVICES 256](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9660)
 - [v4l2: Fix memory leak for DRM caps negotiation (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9779)
 - [wavparse: prevent setting empty strings as title tag (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10266)
 - [Fix issues with G_DISABLE_CHECKS & G_DISABLE_ASSERT (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9662)
 - [Cleanup warnings when checks & asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9780)
 - [Mark functions WARN_UNUSED_RESULT where return is full transfer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9766)

#### gst-plugins-bad

 - [Add Vulkan Video AV1 decoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8316)
 - [Add MPEG-H audio decoder plugin based on the Fraunhofer MPEG-H decoder implementation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9361)
 - [Add tensordecodebin](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9109)
 - [applemedia: add P010_LE support to support 10-bit HEVC encoding via vtenc_hw](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9789)
 - [ajasink, decklinkvideosrc: Fix some GstAncillaryMeta handling bugs (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10167)
 - [alphacombine: Only reset once both pads are done flushing (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8759)
 - [analytics: Add tensor decoder element for yolo detection and segmentation models](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8652)
 - [analytics: Adding GstAnalyticsTensorMtd](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7959)
 - [analytics: batchmeta: Merge event/buffer/bufferlist into a single field](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9563)
 - [analytics: Implement Intersection-over-Union (IoU)-based tracker element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9274)
 - [analytics: segmentation and object detection mtd: Implement new matrix meta transformation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9497)
 - [analyticsoverlay: Add segmentation overlay](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7149)
 - [analyticsoverlay, vulkancompositor, d3d, dwriteoverlay: Fix multiple composition meta usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7627)
 - [asio: Implement device monitoring using USB events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9663)
 - [audio: add support for new U20_32 and S20_32 audio formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9650)
 - [audiomixmatrix: Add sparse matrix LUT optimization](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10002)
 - [av1parse: Fix duplicated frames issue in frame splitting (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9901)
 - [cea608mux, mpegtsmux: Properly check if pads are EOS in find_best_pad (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9803)
 - [cc708overlay: Remove element, superseded by cea708overlay from gst-plugins-rs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4207)
 - [closedcaption: Remove cc708overlay and move closedcaption plugin to section without external dependencies](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10285)
 - [classifiertensordecoder: Add pre-softmax mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8995)
 - [cudaconvert: Fix crop meta support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9734)
 - [d3d12: Add interlace element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9680)
 - [d3d12: Add overlay compositor element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9683)
 - [d3d12: Upload/download optimization via staging memory implementation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9648)
 - [d3d12convert: Fix crop meta support (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9735)
 - [d3d12deinterlace: Fix passthrough handling (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9691)
 - [d3d12overlayblender: Rectangle upload optimization](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9693)
 - [decklinkvideosrc/sink: Add support for outputting all VANC via GstAncillaryMeta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10111)
 - [deinterlace: Improve pool configuration (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10315)
 - [dtlsconnection: Increase DTLS MTU to 1200 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10054)
 - [GstPlay: Fixed wrong initial position update interval configuration (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10110)
 - [h264parse, h265parse, h266parse: Use VUI framerate when upstream framerate is 0/1](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10039)
 - [h266decoder: support vvc1 and vvi1 modes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8662)
 - [h265parse: Add support for AUD insertion](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9955)
 - [hip: Move core methods to gst-libs library](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9340)
 - [hip: Generate gir files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9804)
 - [id3tag: Fix resource leak (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10050)
 - [lcevcencoder: Add lcevch266enc element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9705)
 - [mfcapturedshow: fix for top-down RGB images](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9950)
 - [mxfvanc: Add support for non-closed-caption VANC](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10087)
 - [nvcodec: Ensure interlace is used only when required and supported](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9730)
 - [nvcodec: Add num-slices property to nvh264enc and nvh265enc](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10242)
 - [objectdetectionoverlay: In the presence of tracking Mtd, draw different colors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9538)
 - [onnx: Port to use the ONNX Runtime C API and remove any C++ usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9911)
 - [tsdemux: support demuxing id3 metadata pes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7645)
 - [tsdemux: Directly forward Opus AUs without `opus_control_header` (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9719)
 - [tsmux: Write a full Opus channel configuration if no matching Vorbis one is found (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9729)
 - [tsmux: Reset PUSI flag after writing stream packet (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9857)
 - [unixfdsink: add num-clients property and notify on it when the number of clients changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7224)
 - [unixfd: Fix case of buffer with big payload (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9701)
 - [unixfd, vs: Add KEEP_MAPPED flag to the allocated buffers to keep dmabufs mapped (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10153)
 - [vmaf: add new element to calculate VMAF scores](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9757)
 - [v4l2object: Add support for colorimetry 1:4:16:3 - SMPTE170M / ITU-R BT1358 525 or 625 / ITU-R BT1700 NTSC (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10151)
 - [vtdec: Add vp9 support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10175)
 - [vtdec: Add support for AV1 hardware decoding](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9448)
 - [vtdec: Fix race condition in decoder draining. Fluster runs were unstable (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10229)
 - [vulkan video: generate dynamically encoders/decoders pad templates at registry](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9748)
 - [wasapi2: Auto-select IAudioClient3 and pick shared-mode period](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9666)
 - [wasapi2: Preserve channel mask from device/mix format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9649)
 - [waylandsink: Add udmabuf support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10307)
 - [waylandsink: Add a fullscreen-output property](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9653)
 - [waylandsink: Implement GstVideoCropMeta support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9991)
 - [waylandsink: handle flush stop event](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9642)
 - [webrtc: ice: Add support for getting the selected candidate pair](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8484)
 - [webrtcbin: Add a close signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9379)
 - [webrtcbin: Ensure ice-gathering-state reaches complete](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10206)
 - [webrtcbin: Optional support for async tasks and a potential critical warning fix](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9823)
 - [win32ipc: Rewrite plugin, add generic src/sink, and add various properties](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10296)
 - [x265enc: Calculate latency based on encoder parameters (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9849)

Build improvements, introspection fixes, leak fixes, clean-ups and other smaller improvements:

 - [aja, d3d11ipc, d3d12ipc, cudaipc, win32ipc, unixfd: use new gst_clock_is_system_monotonic_clock()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8257)
 - [analyticsmeta: Initialize span to avoid undefined behavior (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9963)
 - [analytics: Fix build on MSVC by using libm dependency (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10283)
 - [asiodeviceprovider: Fix deadlock on stop](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10245)
 - [audio: Re-order the all formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10074)
 - [avfassetsrc: Prevent access to released CMSampleBuffer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10197)
 - [avwait: Unify conditions between the different modes (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10001)
 - [codecparsers: fix h264 handling of scaling lists](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9505)
 - [cuda: Fix runtime kernel compile with CUDA 13.0 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9745)
 - [curlhttpsrc: Various fixes (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5537)
 - [decklinkvideosink: Add some debug output for writing ancillary data](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10182)
 - [decklinkvideosink: Fix frame completion callbacks for firmware 14.3+ (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10295)
 - [dtsdec: use GstCpuId instead of liborc to decide which SIMD optimisations to enable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10004)
 - [d3d11converter & d3d12converter: Initialize video_direction (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10016)
 - [d3d12basefilter: Make device access thread-safe](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9984)
 - [d3d12converter: Apply background color even without mipmapping](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10096)
 - [d3d12swapchainsink: Fix flickering after resize](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9897)
 - [dwrite: Fix D3D12 critical warning (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9681)
 - [examples: Vulkan video decoder SDL3 interop test](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9677)
 - [h264parser: fix uint32 to int32 truncation (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9967)
 - [h265parse: Add debug logging for unknown H.265 values](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9889)
 - [hip: Fix loading of HIP libraries on Linux](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9749)
 - [isoff: fix fall through warnings](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9703)
 - [meson: Add missing devenv values](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9800)
 - [meson: Remove "allow_fallback: true" from non essential deps (aja, svtjpegxs)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9767)
 - [midiparse: Fix a couple of potential out-of-bounds reads (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10276)
 - [mpegtsdemux: add debug logs for various stream handling cases](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9928)
 - [mpegtsdemux: make sure to expose audio GstStream for DTS (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10249)
 - [mpegtsdemux: Use some named constants instead of hard-coded values](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9921)
 - [mpegtsmux ID3 tag handling fixes and cleanup (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9925)
 - [mpegtsmux: Avoid infinite recursion writing PCR packets (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6380)
 - [mpegtsmux: Fix potential deadlock changing pmt-interval (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10261)
 - [mssdemux: Clarify pad name cleanup in _create_pad()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9982)
 - [mxfmpeg: Add custom Sony picture essence coding UL (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10219)
 - [mxfmux: Create empty edit units for VANC packets without content or gap events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10256)
 - [mxfmux: Fix memset usage (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10254)
 - [mxfdemux: Fix typo on mxf_ffv1_create_caps (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10095)
 - [nvenc: Fix tests resolution and typo for modern GPUs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9952)
 - [onnxinference: Read Image.NominalPixelRange and other improvements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10143)
 - [osxaudio: Various fixes, incl a potential crash when probing (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9846)
 - [ristsink: Fix double free regression (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9858)
 - [scte-section: fix missing cleanup on splice component parse failure (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9981)
 - [scte-section: fix resource leak in splice component parsing (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9964)
 - [tflitevsiinference: Replace renamed API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9731)
 - [unixfd: Fix pointer casting on 32bit arch](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10212)
 - [uvcgadget: always ensure to switch to fakesink (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7574)
 - [v4l2codecs: Free sub-request on allocation failure (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9944)
 - [va: a couple of non-functional changes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9747)
 - [va: build and other minor fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10077)
 - [va: encoding minor fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10084)
 - [va: move methods from encoder to display-priv](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10083)
 - [vaav1enc: add upscaledwidth value for SCC encoding](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9783)
 - [vacompositor: Correct scale-method properties (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9718)
 - [vabasedec: Don't assert when negotiating based on a gap event before the first buffer (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10297)
 - [vaencoder: remove rt_format parameter from _open()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10086)
 - [vaencoder: refactor in order to split open() in two stages](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10115)
 - [vaencoder and display-priv fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10192)
 - [videoparser: Various memory and buffer handling fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10035)
 - [vkdecoder: fix typo on MAINTENANCE2](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9616)
 - [vkh264enc: remove unused member variable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10080)
 - [vkh265dec: Fix a typo (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10166)
 - [vkphysical-device-private: add functions that are used repetitively](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9837)
 - [vkvp9dec: fix dpb_size calculation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9904)
 - [vkvp9dec: fix resolution change NULL pointer dereference](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9786)
 - [vkvideo-private: Replace GstBuffer with GstMemory array for video sessions (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10169)
 - [vulkan: Add missing G_DECLS symbols to gstvkqueue and gstvkcommandqueue (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10078)
 - [vulkan: fix AV1 encode test with TILE_GROUP OBU](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9631)
 - [vulkan: fix bufferRowLength size for vulkan upload/download copy](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8862)
 - [vulkan, analyticsmeta: Various memory handling improvements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10020)
 - [vulkan: initialize YUVUpdateData before memcpy](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10199)
 - [vulkan: zero-initialize ViewUpdate before use](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10200)
 - [vulkan: decoders handle events](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10324)
 - [vulkanupload: fix return error in raw to buffer method](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9957)
 - [wasapi2: Create background thread with normal priority](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9895)
 - [wayland: Fix using uninitialized value of data.wbuf (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10051)
 - [waylandsink: increase wait time for configure event](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9838)
 - [webrtc: nice: Fix a use-after-free and a mem leak (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9808)
 - [webrtc: Keep a ref of the ICEStream in the TransportStream (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10312)
 - [wpe2: Check for presence of wpe-platform.h](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10003)
 - [Add G_GNUC_WARN_UNUSED_RESULT to constructors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9796)
 - [Annotate unused functions/variables when checks/asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9931)
 - [Cleanup warnings when checks & asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9788)
 - [Documentation fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10180)
 - [Fix all compiler warnings on Fedora (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9695)
 - [Fix issues with G_DISABLE_CHECKS & G_DISABLE_ASSERT (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9662)
 - [Fix a few small leaks (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9756)
 - [Mark functions WARN_UNUSED_RESULT where return is full transfer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9766)
 - [Use new gst_call_async() and gst_object_call_async() variants](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/869)

#### gst-plugins-ugly

 - [a52dec: use new GstCpuId API instead of liborc to determine what SIMD optimisations to enable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10004)
 - [rmdemux: Remove unnecessary condition (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10130)
 - [Cleanup warnings when checks & asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9795)

#### GStreamer Rust plugins

 - [Add ST-2038 ancillary metadata combiner and extractor element (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2704)
 - [New deepgram speech-to-text transcription plugin](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2527)
 - [analytics splitter/combiner: Remove the separate fields to events and buffer (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2473)
 - [audiornnoise: copy input metadatas to ouput buffer (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2686)
 - [aws: Drop registration of rusotos3src and rusotos3sink](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2601)
 - [aws: Support the use of S3 compatible URI](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2615)
 - [awstranscriber2/awstranslate: enrich awstranslate/raw message](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2164)
 - [awstranscriber2, awstranslate: Post error message on connection error](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2587)
 - [awstranscriber2: refactor to match speechmatics transcriber design](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2642)
 - [aws, webrtc, cargo: Remove all constraints on AWS SDK and tune optimizations (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2409)
 - [cctost2038anc: Support alignment (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2701)
 - [cea608overlay: Support non-system memory correctly (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2555)
 - [cea708: Non-relative positioning implementation](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2549)
 - [dav1d: Various fixes to allocation query handling (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2739)
 - [elevenlabs: implement new voice cloner element](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2597)
 - [fallbacksrc: Add support for encoded outputs](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2591)
 - [fallbacksrc: Fix custom source reuse case (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2592)
 - [fallbacksrc: Fix sources only being restarted once (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2547)
 - [fallbacksrc: Post no-more-pads signal for streams-unaware parent (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2551)
 - [fmp4, mp4: Merge into a single isobmff plugin](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2628)
 - [gifenc: Avoid unnecessary flush/reset on caps change for fields we do not use](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2584)
 - [gif: Update to gif 0.14 (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2689)
 - [gitignore: add .helix (helix editor configuration dir)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2568)
 - [gtk4: Add property to control reconfigure on window-resize behavior (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2692)
 - [gtk4: Fix compile warning (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2710)
 - [gtk4: Implement cropped imports without viewport (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2635)
 - [hlscmafsink: Add support for I-frame only playlist](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2366)
 - [hlscmafsink and fmp4mux's hls_live example: minor improvements](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2562)
 - [inter: add properties to fine tune the inner elements](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2561)
 - [inter: Give the appsrc/appsink a name that has the parent element as prefix (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2545)
 - [inter/examples: Add an example to show GL context sharing](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2682)
 - [isobmff: Fix EAC3 datarate calculation (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2668)
 - [isobmff: Fix EAC3 substream writing in EC3SpecificBox (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2669)
 - [isobmff: Implement GstChildProxy for MP4Mux and FMP4Mux (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2693)
 - [isobmff: Sync codec support between fragmented and non-fragmented MP4 muxer](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2664)
 - [isobmff: Unify and extend brands selection between fmp4mux and mp4mux](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2680)
 - [isobmff: Update to dash-mpd 0.19 (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2677)
 - [json, closedcaption: Return FlowError from scan_duration (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2667)
 - [mcc: Add support for non-caption VANC (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2732)
 - [ndisrcdemux: fix audio corruption with non-interleaved stride padding (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2721)
 - [onvifmetadatapay: copy metadata from source buffer (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2460)
 - [polly: fix overflow budget calculation](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2728)
 - [quinn: Support sharing of QUIC/WebTransport connection/session](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2643)
 - [quinn: Update web-transport-quinn and fix flaky QUIC test (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2713)
 - [reqwest: add `rust-tls-native-roots` feature to the `reqwest` dep (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2586)
 - [rsvalidate: Add plugin with check-last-frame-qrcode action](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2647)
 - [rtp: Add linear audio (L8, L16, L24) RTP payloaders / depayloaders (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1488)
 - [rtp: add mparobust / RFC 5219 depayloader](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2651)
 - [rtp: Add SMPTE ST291-1 ancillary metadata RTP payloader and depayloader (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2691)
 - [rtp: baseaudiopay: Fix marker bit handling (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2622)
 - [rtp: basepay: reuse last PTS, when possible to work around problems with NVIDIA Jetson AV1 encoder (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2470)
 - [rtpbin2, threadshare: update code sites marked as candidates for newer APIs](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2655)
 - [rtp: linear_audio: fix expect string in unit test](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2645)
 - [rtpamrpay2: Actually forward the frame quality indicator (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2580)
 - [rtpamrpay2: Set frame quality indicator flag (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2577)
 - [rtpsend/recv: fix property type for stats (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2553)
 - [rtsp: fix AppSrc `max-time`](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2556)
 - [sccparse: Best-effort decode streams with more byte tuples in the SCC field](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2720)
 - [speech synthesis: various bug fixes and small improvements in synthesizers and textaccumulate](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2564)
 - [speech synthesizers: expose new overflow mode, compress](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2516)
 - [speech elements: misc improvements](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2659)
 - [speechmaticstranscriber: in-depth refactoring](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2617)
 - [speechmatics: expose properties to control speaker identification](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2700)
 - [spotify: bump librespot 0.8.0 (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2688)
 - [st2038ancdemux: Support alignment (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2698)
 - [st2038ancmux: Support frame alignment (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2697)
 - [st2038: Forward frame rate in caps where available (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2681)
 - [st2038combiner: Some fixes (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2724)
 - [st2038extractor: Add always-add-st2038-pad property (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2731)
 - [st2038extractor: Some fixes (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2725)
 - [synthesizers: remove signalsmith_stretch from default members ..](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2567)
 - [textaccumulate: fix drain_on_speaker_change typo](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2596)
 - [textaccumulate: fix extended-duration-gap getter](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2573)
 - [textaccumulate: forward metas from input buffers](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2598)
 - [threadshare: audiotestsrc: support more Audio formats (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2605)
 - [threadshare: backpressure: abort pending items on flush start (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2603)
 - [threadshare: fixes & improvements (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2621)
 - [threadshare: fix Pad mod diagram (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2649)
 - [threadshare: latency related improvements and fixes (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2585)
 - [threadshare: runtime task: execute action in downward transition (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2602)
 - [threadshare: standalone example update](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2608)
 - [threadshare: udpsink: fix panic recalculating latency from certain executors (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2609)
 - [threadshare: Update to getifaddrs 0.6 (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2630)
 - [transcriberbin: fix latency query on custom channel source pads](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2729)
 - [tracers: Fix inability to create new log files (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2640)
 - [tracers: Fix inverted append logic when writing log files (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2625)
 - [transcriberbin: add example to demonstrate transcriber switching](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2684)
 - [uriplaylistbin: Ignore all tests for now (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2557)
 - [uriplaylistbin: Propagate error message source (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2582)
 - [webrtc: document grant requirement for livekitwebrtcsink auth token (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2657)
 - [webrtc: add WHEP server signaller](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1538)
 - [webrtc: Support server side offers for WHEP client](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2662)
 - [webrtc: livekit: Drop connection lock after take() (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2614)
 - [webrtcsink: Correct lock ordering to prevent Lock (A), Lock (B) + Lock(B), Lock(A) deadlock between on_remote_description_set() and handle_ice() (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2665)
 - [webrtcsink: implement renegotiation](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2683)
 - [webrtcsink: support va encoders (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2656)
 - [webrtcsink: Don't let recalculate_latency block tokio worker thread (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2708)
 - [webrtcsrc: Clean up EOS and session handling](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2491)
 - [webrtc: Drop use of async_recursion crate (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2633)
 - [whepserversink: implement example for external HTTP server](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2733)
 - [whipserversrc: implement example for external HTTP server](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2709)
 - [README: add missing closedcaption elements](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2590)
 - [Document the tags and branches in this repository (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2627)
 - [Fix some new clippy 1.90 warnings (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2575)
 - [Fix a couple of new 1.91 clippy warnings (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2661)
 - [cargo_wrapper: Fix mismatched quotes causing SyntaxError](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2565)
 - [cargo_wrapper: Improve test execution and build infrastructure](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2583)
 - [Update dependencies (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2571)
 - [Update dependencies (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2619)
 - [Update dependencies (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2663)
 - [Update dependencies (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2712)
 - [Update MSRV to 1.86](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2652)
 - [meson: Add auto_plugin_features option (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2594)
 - [meson: Add a clippy target](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2611)
 - [meson: Don't require all gstreamer libraries (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2636)
 - [meson: Fix .pc files installation and simplify build output handling (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2552)
 - [meson: Refactor to use auto_plugin_features consistently for all plugins (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2599)
 - [meson: fix build when GTK is not present (backported)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2711)

#### gst-libav

 - [Fix all compiler warnings on Fedora (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9695)
 - [Cleanup warnings when checks & asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9795)
 - [avviddec: Various fixes to allocation query handling (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10306)

#### gst-rtsp-server

 - [rtsp-client: Add a pre-closed signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10081)
 - [examples: Use new gst_object_call_async() API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/869)
 - [Add G_GNUC_WARN_UNUSED_RESULT to funcs with transfer full returns](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9772)
 - [Fix issues with G_DISABLE_CHECKS & G_DISABLE_ASSERT (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9662)
 - [Mark functions WARN_UNUSED_RESULT where return is full transfer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9766)
 - [Mark variables that are unused when checks or asserts are disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9793)

#### gstreamer-sharp

 - No changes

#### gst-python

 - [Move GES OTIO formatter to a separate Python plugin in gst-python](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9759)
 - [ges: otio: Use valid Python comment syntax](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9979)
 - [Add Gst.MapInfo.get_data() override](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9665)
 - [meson: Remove "allow_fallback: true" from non essential deps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9767)
 - [meson: python: add GES Python plugin path to meson devenv](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9853)
 - [Fix GDir leak in gst_python_load_directory (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9864)
 - [Fix NotInitialized mechanism for introspected methods](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9918)
 - [Fix cross-compiling (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6252)
 - [Add some typing annotation to overrides (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10238)
 - [More typing fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10243)
 - [Even more typing fixes (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10252)
 - [Override GstPadProbeInfo to get writable objects (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9909)
 - [Override signature cannot contain Gst prefix - again](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10329)
 - [Misc improvements (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10305)

#### gst-editing-services

 - [controller: Add MT-safe gst_timed_value_control_source_list_control_points()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9830)
 - [Add `ges_error_quark()` function for GError domain](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9700)
 - [Move OTIO formatter to a separate Python plugin  and converts GStreamer plugin loading mutex to recursive mutex](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9759)
 - [ges: load_python_formatters() crashes during g-ir-scanner](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4676)
 - [Add error reporting to base bin timeline setup (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9841)
 - [Fix asset refcount leak in command-line formatter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10154)
 - [Separate clip layer move detection from track element freezing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9855)
 - [timeline: Respect SELECT_ELEMENT_TRACK signal discard decision (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9809)
 - [Add G_GNUC_WARN_UNUSED_RESULT to constructors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9797)
 - [Add G_GNUC_WARN_UNUSED_RESULT to funcs with transfer full returns](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9773)
 - [Fix a few small leaks (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9756)
 - [Mark functions WARN_UNUSED_RESULT where return is full transfer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9766)
 - [tests: convert g_assert() to g_assert_*() and mark unused items](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9794)
 - [nlesource: use new gst_object_call_async()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/869)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [debug-viewer: Make 0x prefix optional thread ID regexes (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10041)
 - [devtools: Add G_GNUC_WARN_UNUSED_RESULT to constructors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9798)
 - [dots-viewer: debounce SVG rendering during initial load](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10279)
 - [dots-viewer: Misc enhancements and fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9782)
 - [dots-viewer: Update static-files dependency (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9976)
 - [validate: ssim: Check all images before reporting errors](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10044)
 - [validate: update links for gitlab issues moved from gst-plugins-{good,bad,base} to monorepo](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9755)
 - [validate: Core improvements for feature management and reverse playback](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9867)
 - [validate: Fix crash during scenario cleanup](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9834)
 - [validate: add missing GST_VALIDATE_API annotation (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9863)
 - [validate: remove unimplemented gst_validate_report_add_message API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10172)
 - [validate: use meson compile instead of ninja directly (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9842)
 - [vulkan: fix bufferRowLength size for vulkan upload/download copy](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8862)
 - [Add G_GNUC_WARN_UNUSED_RESULT to funcs with transfer full returns](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9774)
 - [Cleanup warnings when checks & asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9795)
 - [Fix issues with G_DISABLE_CHECKS & G_DISABLE_ASSERT (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9662)
 - [Update Rust dependencies (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9974)
 - [Look for glib.supp file in XDG_DATA_DIRS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9590)
 - [meson: Add missing devenv values](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9800)

### gst-examples

 - [Cleanup warnings when checks & asserts disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9795)
 - [Fix signal lookup in GTK player example (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9885)
 - [Update Rust dependencies (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9974)

#### gstreamer-docs

 - [Python tutorial for dynamic pipelines](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8833)
 - [Python time tutorial](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9791)
 - [Update GstMeta design docs to match the current state](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6136)
 - [Update machine learning and analytics documentation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9109)
 - [Tutorials: Fix incorrect flow returns on sample pull](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9818)
 - [docs: add windows section to dev environment](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9815)

#### Development build environment

 - [libnice.wrap: add upstream patch from libnice (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9875)
 - [libnice.wrap: upgrade to 0.1.23](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1986)
 - [libsoup.wrap: Apply upstream fix for GModule deadlock (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9692)
 - [libsoup.wrap: Fix build on older distros such as Ubuntu 18.04](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10232)
 - [libsoup.wrap: remove fallback gio-unix on windows build (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10136)
 - [pygobject: Update to 3.50.2 with the MSVC build fix](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9992)
 - [webrtc-audio-processing: Fix build with abseil-cpp 202508 (backported)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9949)
 - [x264.wrap: Add missing [provide] section (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9674)

#### Cerbero build tool and packaging changes in 1.27.50

 - [Fix extraction on Windows when building on a different drive than `C:\`, bump pixman and pygobject (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1973)
 - [Add recipe for the LCEVCdec library and build the plugin with it.](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1579)
 - [Add support for Visual Studio 2026 (Insiders) (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1969)
 - [bootstrap-windows: fix setuptools install and allow to run non-interactively](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1963)
 - [EndeavourOS support (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1955)
 - [cerbero: Add rust support for Linux X86 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1966)
 - [cerbero: Open log files as utf-8 and with error resilience (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1972)
 - [cookbook: List all the dependencies when listed in reverse (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1979)
 - [ci: update macos image to 26-tahoe (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1952)
 - [dragonfire: Update to 0.1.3 to allow imports from ksecdd.sys and ntoskrnl.exe](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1947)
 - [gst-plugins-base: Disable libdrm support temporarily](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2003)
 - [gst-plugins-bad: actually build svtjpegxs plugin on 64-bit Windows (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1981)
 - [gst-plugins-rs: update for MP4 plugins now being merged into a single `isobmff` plugin](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1957)
 - [gst-plugins-rs: Remove bak files from melding on CI to shrink artifact tarballs](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1942)
 - [gstreamer-vaapi: delete recipe](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1965)
 - [harfbuzz: disable documentation (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1968)
 - [hacks: Fix breakage on Python 3.14 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1993)
 - [meson: Update to 1.9.0 to enable Xcode 26 compatibility (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1946)
 - [recipes: Fix stray devel files making it into runtime (backported)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/2001)
 - [rust: Update to 1.90](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1948)
 - [rust: Update to 1.91 and rustup to 1.28.2](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1970)
 - [cache: Fix post-merge cache pipelines (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1992)
 - [cargo-c: Update to 0.10.16](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1949)
 - [README: make it clearer how to disable variants](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1960)
 - [Modernize MSI license.rtf formatting (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1994)

#### Contributors to 1.27.50

Abd Razak,Muhammad Azizul Hazim,
Amy Ko,
Andoni Morales Alastruey,
anonymix007,
Artem Martus,
Brad Hards,
Brad Reitmeyer,
Branko Subasic,
Camilo Celis Guzman,
Carlos Bentzen,
Carlos Rafael Giani,
Chengfa Wang,
Christo Joseph,
Christoph Reiter,
Daniel Almeida,
Daniel Morin,
David Maseda Neira,
Diego Nieto,
Dominique Leroux,
DongJoo Kim,
Doug Nazar,
Edward Hervey,
Ekwang Lee,
François Laignel,
Gang Zhao,
Haejung Hwang,
Havard Graff,
He Junyan,
Hou Qi,
Hyunjun Ko,
Inbok Kim,
Jaehoon Lee,
Jakub Adam,
Jan Alexander Steffens (heftig),
Jan Schmidt,
Jeehyun Lee,
Jeffery Wilson,
jeongmin kwak,
Jerome Colle,
Jihoon Lee,
Jochen Henneberg,
Jordan Yelloz,
Julian Bouzas,
Kevin Scott,
Kevin Wolf,
L. E. Segovia,
Linus Svensson,
Loïc Le Page,
Manuel Torres,
Marek Olejnik,
Mark Nauwelaerts,
Markus Hofstaetter,
Mathieu Duponchelle,
Matthew Semeniuk,
Matthew Waters,
Max Goltzsche,
Mazdak Farzone,
Michael Grzeschik,
Michael Olbrich,
Michiel Westerbeek,
Nicholas Jin,
Nicolas Dufresne,
Nirbheek Chauhan,
Norbert Hańderek,
Olivier Crête,
Oz Donner,
Pablo García,
Patricia Muscalu,
Patrick Fischer,
Paul Fee,
Paweł Kotiuk,
Peter Stensson,
pfee,
Philippe Normand,
Piotr Brzeziński,
Pratik Pachange,
Qian Hu (胡骞),
Rafael Caricio,
Rares Branici,
Razvan Grigore,
Rinat Zeh,
Robert Mader,
Ross Burton,
Ruben Gonzalez,
Ruben Sanchez,
Sanchayan Maity,
Santiago Carot-Nemesio,
Santosh Mahto,
Sebastian Dröge,
Seungha Yang,
Shengqi Yu (喻盛琪),
Stéphane Cerveau,
stevn,
Sven Püschel,
Sylvain Garrigues,
Taruntej Kanakamalla,
Teus Groenewoud,
Thibault Saunier,
Tim-Philipp Müller,
Tulio Beloqui,
Val Packett,
Víctor Manuel Jáquez Leal,
Vincent Beng Keat Cheah,
Vivia Nikolaidou,
Vivienne Watermeier,
Wilhelm Bartel,
William Wedler,
Xavier Claessens,
Yun Liu,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.27.50

- [List of Merge Requests applied in 1.27.50](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.27.50)
- [List of Issues fixed in 1.27.50](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.27.50)

<a id="1.27.2"></a>

### 1.27.2

The second API/ABI-unstable 1.27.x development snapshot release (1.27.2) was released on 07 September 2025.

Any newly-added API in the 1.27.x series may still change or be removed again before 1.28 and should be considered unstable until 1.28 is released.

The 1.27.x release series is for testing and development purposes, and distros should probably not package it.

#### Highlighted changes in 1.27.2

 - Add more 10bit RGB formats in GStreamer Video, OpenGL and Wayland, as well as in deinterlace and gdkpixbufoverlay
 - analytics: new analytics combiner and splitter elements plus batch meta to batch buffers from one or more streams
 - analyticsoverlay: Add expire-overlay property
 - onnx: Add Verisilicon provider support
 - awstranscriber2: add property for setting show_speaker_labels
 - awstranslate: expose property for turning brevity on
 - speechmatics: expose mask-profanities property
 - textaccumulate: new element for speech synthesis or translation preprocessing
 - tttocea608: expose speaker-prefix property
 - cea708mux: expose "discarded-services" property on sink pads
 - cuda crop meta support
 - hlssink3, hlscmafsink: Support the use of a single media file
 - s302mparse: Add new S302M audio parser
 - webrtc: add WHEP client signaller; sdp and stats-related improvements
 - threadshare: many improvements to the various elements, plus examples and a new benchmark program; relicense to MPL-2.0
 - gtk4paintablesink: Add YCbCr memory texture formats and improve color-state fallbacks
 - OpenGL: Add support for the NV24 pixel format; support changing caps and `get_gl_context()` in glbasesrc
 - rtspsrc: Send RTSP keepalives also in TCP/interleaved modes
 - nvencoder: interlaced video handling improvements
 - vaav1enc: Enable intrablock copy and palette mode
 - videopool: support parsing dma_drm caps
 - Vulkan VP9 video decode support and many other video encode and decode improvements
 - waylandsink: Parse and set the HDR10 metadata and other color management improvements
 - LCEVC: Add autoplugging decoding support for LCEVC H265 and H266 video streams and LCEVC H.265 encoder
 - GstMiniObject: Add missing `take()` and `steal()` functions and convert `is_writable()` and `make_writable()` macros to inline functions
 - alsa: Improve PCM sink enumeration
 - d3d12: various d3d12swapchainsink enhancements and bug fixes; fisheye image dewarping support
 - wasapi2: add support for dynamic device switching, exclusive mode and format negotiation; device provider and latency enhancements
 - windows: Disable all audio device providers except wasapi2
 - dots-viewer: Improve dot file generation and interactivity
 - gst-editing-services: Make framepositioner zorder controllable and expose it
 - Various introspection fixes and bindings updates
 - Cerbero: Update to Android API level 24; add config for number of cargo jobs; ship unixfd plugin
 - Cerbero: Implement library melding for smaller binary sizes of Rust plugins
 - Countless bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

**Possibly breaking behavioural changes**

 - Previously it was guaranteed that there is only ever up to one `GstTensorMeta` per buffer.
   This is no longer true and code working with `GstTensorMeta` must be able to handle multiple
   `GstTensorMeta` now (after this [Merge Request](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9564)).

#### gstreamer

 - [Remove outdated documentation files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9476)
 - [aggregator: implement start-time-selection=now](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9394)
 - [baseparse: Try harder to fixate caps based on upstream in default negotiation (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9593)
 - [baseparse: don't clear most sticky events after a FLUSH_STOP event (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9506)
 - [buffer: Add gst_buffer_take and gst_buffer_steal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9595)
 - [buffer: Add test for _memset() & _memcmp() with various offsets](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9628)
 - [buffer: Find initial memory block without unnecessary mapping](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9354)
 - [buffer: Fix gst_buffer_memcmp() / gst_buffer_memset() using wrong memory index](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9565)
 - [caps: fix nested caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9378)
 - [caps: Mark out parameter of gst_structure_get_caps() as `transfer none`](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9646)
 - [debug: Category init should happen in class_init when possible](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9496)
 - [element: Deprecate `gst_element_state_*()` API and provide replacement](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9655)
 - [meta: Add GstMetaFactory to dynamically register GstMetaInfo](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9598)
 - [miniobjects: Add missing _take() and _steal() functions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9595)
 - [miniobjects: Convert `is_writable()` / `make_writable()` macros to inline functions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9588)
 - [value: Consider NULL caps in array a fixed value](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9522)
 - [Make sure to zero-initialize the GValue before G_VALUE_COLLECT_INIT (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9525)
 - [introspection: Disable miniobject inline functions for gobject-introspection for non-subprojects too (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9518)
 - [Various introspection fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9524)
 - [ptp: Fix a new Rust 1.89 compiler warning on Windows (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9527)
 - [ptp: Fix new compiler warning with Rust 1.89 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9512)
 - [Build: Disable C5287 warning on MSVC (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9431)
 - [gst-launch-1.0: clean up unused local variable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9551)

#### gst-plugins-base

 - [Add more 10bit RGB formats in GStreamer Video, OpenGL and Wayland](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9460)
 - [alsa, oss: Check for element types when reconfiguring](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9558)
 - [alsa: Improve PCM sink enumeration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9534)
 - [audioconvert: Fix regression when using a mix matrix (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9487)
 - [debug: Category init should happen in class_init when possible](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9496)
 - [decodebin3: Don't error on an incoming ONVIF metadata stream (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9433)
 - [decodebin3: Update stream tags (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9557)
 - [device-monitor: Use gst_print instead of g_print (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9467)
 - [gl: Add support for the NV24 pixel format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9596)
 - [gl: detect the correct context_api on MacOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9619)
 - [gl/basesrc: support changing caps and add get_gl_context()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9455)
 - [glcolorconvert:: Revert "should copy metadatas from the incoming buffer"](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6212)
 - [gloverlay: Two small fixes (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9434)
 - [glupload: fix the issue of printing critical log for some cases](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9478)
 - [gstreamer: Misc memory cleanups (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9352)
 - [rtpbasedepayload: Avoid potential use-after free (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9579)
 - [rtspconnection: Add get_url and get_ip return value annotation (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9651)
 - [uridecodebin3: Add missing locking and NULL checks when adding URIs to messages (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9500)
 - [video: dma-drm: Add P016_LE format map (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9513)
 - [video: pool: Fix pool size configuration for DMA DRM](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9600)
 - [videometa: Fix valgrind warning when deserializing video meta (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9647)
 - [videopool: support parsing dma_drm caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9345)
 - [videorate: don't hold the reference to the buffer in drop-only mode (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9532)
 - [videorate: Fix several videorate issues in ges when using time control (setting the `rate` property)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9013)
 - [Remove outdated documentation files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9476)
 - [gst-device-monitor-1.0: Fix device monitor criticals, and also accept utf8 in launch lines (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9494)
 - [gst-device-monitor-1.0: Add shell quoting for launch lines (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9466)
 - [gst-device-monitor-1.0: Add quoting for powershell and cmd (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9625)

#### gst-plugins-good

 - [deinterlace, gdkpixbufoverlay: Add more 10bit RGB formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9460)
 - [adaptivedemux2: fix crash due to log (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9573)
 - [alsa, oss: Check for element types when reconfiguring](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9558)
 - [hlsdemux2: Fix parsing of byterange and init map directives (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9533)
 - [rtspsrc: Send RTSP keepalives in TCP/interleaved modes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9577)
 - [soup: Disable range requests when talking to Python's http.server (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9341)
 - [v4l2: Fix memory leak for dynamic resolution change (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9479)
 - [v4l2videodec: Add protection when acquiring drm caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8533)
 - [v4l2videodec: Need to replace acquired_caps on set_format success (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8674)
 - [windows: Disable all audio device providers except wasapi2 (directsoundsink deviceprovider)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9438)
 - [Debug category init should happen in class_init when possible](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9496)
 - [Remove outdated documentation files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9476)

#### gst-plugins-bad

 - [Add autoplugging decoding support for LCEVC H265 and H266 video streams](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9427)
 - [Add more 10bit RGB formats in GStreamer Video, OpenGL and Wayland](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9460)
 - [analytics: Add GstAnalyticsBatchMeta for batches of buffers from one or more streams](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9282)
 - [analytics: Add unit test for copying GstAnalyticsRelationMeta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9475)
 - [analytics: Include new batch meta in the single-include header](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9391)
 - [analytics: always add GstTensorMeta (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9564)
 - [analyticsmeta: Remove incorrect check](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9413)
 - [analyticsoverlay: Add expire-overlay property](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9409)
 - [av1parse: Set CLL and MDI caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9445)
 - [av1parse: Set mastering-display-info into the final caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9474)
 - [av1parser: Don't error out on "currently" undefined seq-level indices (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9502)
 - [avtp: Use the DTS as the AVTP base time ... and other small improvements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9412)
 - [avtp: crf: Setup socket during state change to ensure we handle failure (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9364)
 - [cccombiner: Crash fixes (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9415)
 - [cuda: Add support for crop meta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9523)
 - [curlsmtpsink: adapt to date formatting issue (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9639)
 - [d3d12: Add support for dewarping fisheye images](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9441)
 - [d3d12screencapturedevice: Avoid false device removal on monitor reconfiguration (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9472)
 - [d3d12swapchainsink: Add last-rendered-sample action signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9423)
 - [d3d12swapchainsink: Fix force-aspect-ratio change in playing state](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9392)
 - [d3d12swapchainsink: Update uv-remap signal to support background color](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9393)
 - [decklinkvideosrc: fix decklinkvideosrc becomes unrecoverable if it fails to start streaming (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9578)
 - [debug: Category init should happen in class_init when possible](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9496)
 - [dtls: Use ECDSA private key for default certificate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9323)
 - [gstreamer: Misc memory cleanups (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9352)
 - [h265parse: Parse and attach LCEVC metadata to buffers if present](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9335)
 - [h266parse: Parse SEI registered user data and attach LCEVC metadata to buffers if present](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9365)
 - [hlsdemux2: Fix parsing of byterange and init map directives (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9533)
 - [inter: Move intertest example to tests/examples/inter](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9627)
 - [lcevcdec improvements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9463)
 - [lcevcdec: Set LCEVCdec min version to 4.0.1 and fix build](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9414)
 - [lcevcdecodebin: Update the base decoder when setting base-decoder property](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9599)
 - [lcevcencoder: Add lcevch265enc element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9632)
 - [lcevcencoder: Add ldconfig and install steps to the readme](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7805)
 - [meson: d3d12: Add support for MinGW DirectXMath package (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9464)
 - [mpegtsmux: Caps event fails with stream type change error](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9430)
 - [nvcodec: Add emit-frame-stats signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9429)
 - [nvdsdewarp: Output resize support and performance optimizations](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8558)
 - [nvencoder: Always allow interlaced stream](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9328)
 - [objectdetectionoverlay: Print tracking id](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9440)
 - [onnx: Add Verisilicon provider](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9408)
 - [rtmp2src: various fixes to make it play back AWS medialive streams (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9360)
 - [ssdtensordecoder: Use tensor ids from the registry](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9439)
 - [tensor decoders: Use utility function and other cleanups](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9419)
 - [tensor: Clarify meaning of the dimensions array in the docs](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9325)
 - [tensordecoder: rename facedetector element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9344)
 - [tensormeta: Fix the api to check the tensor type](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9411)
 - [tests: add vulkan av1 encode support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8841)
 - [tests: fix queues for vulkan h26x encoders](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9571)
 - [tests: vkh26xenc: use vkvideoencodebase](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9077)
 - [tflite: Add support for VSI delegate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9410)
 - [transcoder: Various fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9407)
 - [unixfd: fix and improve the example pipelines in the documentation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9422)
 - [va: Re-negotiate after FLUSH (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9457)
 - [vaXXXenc: calculate latency with corrected framerate (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9437)
 - [vaXXXenc: fix potential race condition (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9480)
 - [vaav1enc: Enable intrablock copy and palette mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8560)
 - [vkdownload: implement decide_allocation DownloadMethod](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8931)
 - [vkimagebufferpool: don't use independent profile flag for some usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9570)
 - [vkimagebufferpool: fix regression from !9492](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9545)
 - [vkimagebufferpool: support video profile independent images](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9550)
 - [vkphysicaldevice: enable sampler ycbcr conversion, synchronization2 and timeline semaphore features (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9483)
 - [vkphysicaldevice: silence validation for features](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9544)
 - [vkupload: fix the refactored frame copy](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9373)
 - [vkvideoutils-private: make it private](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9493)
 - [vkvideoutils: fix typo in vp9 profile map](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9638)
 - [vtenc: Fix negotiation failure with profile=main-422-10 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9348)
 - [Vulkan Video: VP9 decode support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9204)
 - [vulkan: Refactor common library in the video parts](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9492)
 - [vulkan: enable video maintenance2 for inline session parameters](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9585)
 - [vulkan: fix validation layer complains](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9591)
 - [vulkan: fixes previous mistakes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9552)
 - [vulkan: video encode and decoder cleanups](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9531)
 - [vulkanh24xdec: couple of fixes (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9560)
 - [vulkanh264enc: calculate latency with corrected framerate](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9465)
 - [vulkanh26xdec: fix discont state handling (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9610)
 - [vulkan: enable vulkan tests in validate on the CI](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9416)
 - [wasapi2: Add support for dynamic device switch](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9326)
 - [wasapi2: Add support for exclusive mode and format negotiation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9586)
 - [wasapi2: Device provider enhancements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9468)
 - [wasapi2: Fix default render device probing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9517)
 - [wasapi2: Handle device init error on acquire()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9624)
 - [wasapi2: Pass correct data flow value to GetDefaultAudioEndpoint()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9521)
 - [wasapi2sink: Do not push too large preroll buffer to endpoint](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9553)
 - [wayland: display: Scale whitepoint the same as the primaries](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9444)
 - [wayland: window: Name the color management queue](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9446)
 - [waylandsink: Parse and set the HDR10 metadata](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9353)
 - [waylandsink: add some error handler for event dispatch (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9511)
 - [webrtc: Misc sdp and stats-related improvements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9485)
 - [windows: Disable all audio device providers except wasapi2](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9438)
 - [x265enc: Fix duplicate SEI at startup IDR frame problem](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9604)
 - [zbar: tests: Handle symbol-bytes as not null-terminated (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9510)
 - [Remove outdated documentation files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9476)

#### gst-plugins-ugly

 - [Remove outdated documentation files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9476)

#### GStreamer Rust plugins

 - [Add rtpbin2 examples (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2360)
 - [analytics: Add new analyticscombiner / analyticssplitter elements](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2317)
 - [analyticscombiner: Use NULL caps instead of EMPTY caps in the array for streams with no caps (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2444)
 - [aws: Ensure task stopping on paused-to-ready state change (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2440)
 - [awspolly: some improvements ported over from 11labs synthesizer](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2510)
 - [awstranscriber2: add property for setting show_speaker_labels](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2240)
 - [awstranscriber2,awstranslate: Handle multiple stream-start event (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2404)
 - [awstranslate: expose property for turning brevity on](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2406)
 - [cea708mux: expose "discarded-services" property on sink pads](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2389)
 - [cea708mux: fix clipping function (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2372)
 - [ceaX08overlay: support ANY caps features (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2390)
 - [dav1ddec: Use video decoder base class latency reporting API (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2368)
 - [elevenlabssynthesizer: improve gap handling in non-clip overflow modes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2493)
 - [fallbacksrc: Don't panic during retries if the element was shut down in parallel (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2451)
 - [fallbacksrc: Don't restart source if the element is just being shut down (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2455)
 - [fallbacksrc: Fix some custom source deadlocks (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2474)
 - [Fix various new clippy 1.89 warnings (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2436)
 - [gtk4: Add 10/12/16bit SW decoder formats (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2408)
 - [gtk4: Try importing dmabufs withouth DMA_DRM caps (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2490)
 - [hlsmultivariantsink: Fix master playlist version (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2415)
 - [hlssink3/hlscmafsink: Support the use of a single media file](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2439)
 - [mccparse: Convert "U" to the correct byte representation (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2357)
 - [mpegtslivesrc: Remove leftover debug message (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2412)
 - [net/webrtc: Drop the use of a separate tls-utils crate (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2533)
 - [net/webrtc: Fix tokio-rustls dependency and leftover tls-utils (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2534)
 - [net/webrtc: Fix tokio-rustls using aws_lc_rs by default](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2531)
 - [mp4: Skip tests using x264enc if it does not exist (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2499)
 - [net/webrtc/whep: add WHEP client signaller](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1545)
 - [reqwest: switch to rustls (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2500)
 - [rtpbin2: Fix handling of unknown PTs and don't warn about incomplete RTP caps to allow for bundling (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2364)
 - [rtpbin2: Improve rtcp-mux support (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2362)
 - [rtpgccbwe: avoid clamp() panic when min_bitrate > max_bitrate (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2456)
 - [rtpmp4apay2: fix payload size prefix (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2391)
 - [rtpmp4gdepay2: allow only constantduration with neither constantsize nor sizelength set (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2441)
 - [rtprecv: Drop state lock before chaining RTCP packets from the RTP chain function (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2381)
 - [rtprecv: fix race condition on first buffer (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2466)
 - [rtprecv optimize src pad scheduling](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2346)
 - [rtpsend: Don't configure a zero min RTCP interval for senders (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2361)
 - [rtp: threadshare: fix some property ranges (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2382)
 - [rtp: Update to rtcp-types 0.2 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2373)
 - [s302mparse: Add new S302M audio parser](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2435)
 - [speechmatics: expose mask-profanities property](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2344)
 - [speechmatics: Specify rustls as an explicit dependency (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2502)
 - [spotify: update to librespot 0.7 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2521)
 - [text: implement new textaccumulate element](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2350)
 - [textaccumulate: misc fixes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2528)
 - [threadshare: add a blocking adapter element (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2427)
 - [threadshare: Also enable windows `Win32_Networking_WinSock` feature (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2431)
 - [threadshare: always use `block_on_or_add_subtask` (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2494)
 - [threadshare: audiotestsrc: fix setting samples-per-buffer... (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2461)
 - [threadshare: blocking_adapter: fix Since marker in docs (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2479)
 - [threadshare: Enable windows `Win32_Networking` feature (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2420)
 - [threadshare: examples: add a new benchmark program](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2496)
 - [threadshare: fix flush for ts-queue ts-proxy & ts-intersrc (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2400)
 - [threadshare: fix regression in ts-proxysrc (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2405)
 - [threadshare: fix resources not available when preparing asynchronously (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2517)
 - [threadshare: fix ts-inter test one_to_one_up_first (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2497)
 - [threadshare: have Task log its obj (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2476)
 - [threadshare: improvements to some elements (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2387)
 - [threadshare: intersink: return from blocking tasks when stopping (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2465)
 - [threadshare: inter: update doc example (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2477)
 - [threadshare: queue & proxy: fix race condition stopping (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2428)
 - [threadshare: runtime/pad: lower log level pushing Buffer to flushing pad (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2512)
 - [threadshare: re-licensing to MPL-2.0](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2481)
 - [threadshare: separate blocking & throttling schedulers (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2526)
 - [threadshare: src elements: don't pause the task in downward state transitions](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2380)
 - [threadshare: standalone examples: improvements & a deadlock fix](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2518)
 - [threadshare: standalone examples: log stats on EOS](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2524)
 - [threadshare: ts-audiotestsrc fixes (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2392)
 - [threadshare: ts-intersrc: handle dynamic inter-ctx changes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2378)
 - [threadshare: Bump up getiffaddrs to 0.1.5 and revert "threadshare: udp: avoid getifaddrs in android" (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1918)
 - [threadshare: update examples (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2484)
 - [threadshare: Update to getifaddrs 0.5 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2503)
 - [threadshare: Fix macOS build post getifaddrs 0.5 update (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2515)
 - [tracers: pipeline-snapshot: reduce WebSocket connection log level (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2433)
 - [tracers: queue-levels: add support for threadshare DataQueue related elements (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2399)
 - [tracers: Update to etherparse 0.19 (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2414)
 - [transcriberbin: Fix handling of upstream latency query (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2398)
 - [transcriberbin: Fix some deadlocks (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2463)
 - [tttocea608: expose speaker-prefix property](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2345)
 - [tttocea{6,7}08: Disallow pango markup from input caps (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2367)
 - [video/gtk4: Add YCbCr memory texture formats](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2271)
 - [video/gtk4: Improve color-state fallbacks for unknown values](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2349)
 - [webrtc: android example: fix media handling initialization sequence](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2216)
 - [webrtc: Migrate to warp 0.4 and switch to tokio-rustls (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2487)
 - [webrtc-api: Set default bundle policy to max-bundle](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2352)
 - [webrtc/signalling: Fix setting of host address (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2540)
 - [webrtcsink: Move videorate before videoconvert and videoscale (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2402)
 - [webrtcsrc: Clean up EOS and session handling](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2491)
 - [WHIP client: emit shutdown after DELETE request](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2358)
 - [Update Cargo.lock](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2365)
 - [Update Cargo.lock](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2539)
 - [Update dependencies (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2448)
 - [Update dependencies (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2508)
 - [Update dependencies](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2356)
 - [Update to async-tungstenite 0.30](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2379)
 - [README: Don't suggest running `cargo cinstall` after `cargo cbuild` (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2442)
 - [cargo_wrapper: Fix depfile generation and stale dependency handling](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2471)
 - [cargo_wrapper: Fix mismatched quotes causing SyntaxError](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2529)
 - [deny: Update](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2520)
 - [meson: Isolate built plugins from cargo target directory (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2519)

#### gst-libav

 - [Remove outdated documentation files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9476)

#### gst-rtsp-server

 - [rtspclientsink: error out on RTCP timeout](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9124)
 - [Remove outdated documentation files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9476)
 - [Tests: Switch to fixtures to ensure pool shutdown (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9351)

#### gstreamer-sharp

 - [Remove outdated documentation files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9476)
 - [Update C# bindings for new 1.28 API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9620)

#### gst-python

 - [Handle buffer PTS/DTS/duration/offset/offset-end as unsigned long long (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9567)
 - [Meson: add convenience target `gst-python-extensions` to build the Python extension modules](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5987)
 - [Various introspection fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9524)

#### gst-editing-services

 - [docs: fix enum value extraction for enums with gaps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9495)
 - [framepositioner: Make zorder controllable and expose it](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5987)
 - [Fix several videorate issue when using time control (setting the `rate` property)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9013)
 - [Fix various memory leaks (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9350)
 - [Make sure to zero-initialize the GValue before G_VALUE_COLLECT_INIT (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9525)
 - [Some minor validate fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9602)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [devtools: Fix memory leak and use of incorrect context (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9349)
 - [dots-viewer: Improve dot file generation and interactivity](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9547)
 - [h265parse: Parse and attach LCEVC metadata to buffers if present](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9335)
 - [validate: http-actions: Replace GUri with GstURI for GLib 2.64 compatibility (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9572)
 - [validate: ges: Fix race condition in deeply nested timeline test](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9608)
 - [videorate: ges: Fix several videorate issue when using time control (setting the `rate` property)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9013)
 - [Update various Rust dependencies (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9397)

### gst-examples

 - [Update various Rust dependencies (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9397)

#### gstreamer-docs

 - [docs: Fix negotiation documentation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9618)

#### Development build environment

 - [ci: Don't forward default variables to downstream cerbero pipeline (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9356)
 - [ci: Fix gst-full breakage due to a typo (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9452)
 - [ci: Fix the abi-check image building](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9382)
 - [ci: Update the kernel version we use with fluster](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9401)
 - [ci: Update to Rust 1.89 and cargo-c 0.10.15](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9503)
 - [ci: Work around PowerShell broken argument parsing (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8717)
 - [ci: add rtsp-server valgrind job](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7811)
 - [debug: Category init should happen in class_init when possible](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9496)
 - [framepositioner: Make zorder controllable and expose it](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5987)
 - [gitattributes: Mark dots-viewer dist files as binary](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9458)
 - [glib: update to 2.82.5 and backport shebangs patch (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9561)
 - [gl/basesrc: support changing caps and add get_gl_context()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9455)
 - [gst-env: only-environment: only dump added and updated vars (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8846)
 - [gst-full: Fix detection of duplicate plugin entries (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9442)
 - [ignore: Exclude build artifacts and minified files from ripgrep](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9459)
 - [win-pkgconfig: Bump to 0.29.2](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9376)
 - [svtjpegxs: Update wrap file](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9426)
 - [Can't build recent GStreamer on GN/Linux because gobject-introspection subproject insists on searching for privative compiler](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4471)
 - [gobject-introspection: Fix introspection failing on Linux with subproject GLib (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9509)
 - [python: Fix compatibility of pygobject patch with 3.42](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9377)
 - [Fix build on windows due to proxy-libintl not being invoked, reduce build size on windows by disabling plugins (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9626)

#### Cerbero build tool and packaging changes in 1.27.2

 - [Library update preliminaries for visionOS (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1889)
 - [android: Update API level to 24 (version 7)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1875)
 - [build: Fix passing multiple steps (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1912)
 - [build: disable LTO on MSVC](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1923)
 - [cache: Fix detection of build tools prefix when using a cache (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1929)
 - [ci: Update windows image](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1927)
 - [cmake: Do not rely on the CERBERO_PREFIX environment variable (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1883)
 - [config: Add property for setting specifically the number of Cargo jobs](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1881)
 - [config: Also apply Cargo properties to the build tools configuration](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1911)
 - [curl: specify OPENSSL_INCLUDE_DIR directly](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1886)
 - [enums: Add is_mobile, is_apple and is_apple_mobile helpers (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1890)
 - [ffmpeg: enable filters needed by avvideocompare (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1925)
 - [git: Normalize all file endings to LF (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1888)
 - [glib-networking: Add missing pkg-config file](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1915)
 - [gst-plugins-bad: Add unixfd to recipe](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1764)
 - [gst-plugins-rs: Fixes for Rust + MSVC build](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1895)
 - [gst-plugins-rs: Implement library melding for smaller binary sizes of Rust plugins](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1916)
 - [gst-plugins-rs: Update version to 0.15.0-alpha.1](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1903)
 - [libxml2: update to 2.14.5](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1910)
 - [msvc: Add static libraries following the Meson convention](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1823)
 - [osx: Update pkgbuild compression algorithms (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1893)
 - [package: Dump cerbero and recipe versions into datadir (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1921)
 - [package: fix --tarball --compress-method=none (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1933)
 - [packaging: Assorted fixes in preparation for deploying split symbols](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1914)
 - [rust: Update to Rust 1.89 and cargo-c 0.10.15](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1918)
 - [tar: Refactor in preparation for xcframework support (backported into 1.26)](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1870)
 - [wavpack: Fix CMake 4.1+ MSVC build breakage](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1931)

#### Contributors to 1.27.2

Adrian Perez de Castro, Amotz Terem, Andrey Khamukhin, Daniel Morin,
Derek Foreman, Doug Nazar, Elliot Chen, François Laignel, Haihua Hu,
Havard Graff, Hou Qi, Ian Napier, Jan Alexander Steffens (heftig),
Jan Schmidt, Jaslo Ziska, Jonathan Lui, Jordan Petridis, Julian Bouzas,
L. E. Segovia, Marc-André Lureau, Mathieu Duponchelle, Matthew Waters,
Marko Kohtala, Monty C, Nicolas Dufresne, Nirbheek Chauhan, Ola Fornander,
Olivier Crête, Philippe Normand, Piotr Brzeziński, Qian Hu (胡骞),
Raghavendra Rao, Rick Ye, Robert Mader, Ruben Gonzalez, Sanchayan Maity,
Sebastian Dröge, Seungha Yang, Slava Sokolovsky, Stéphane Cerveau,
Taruntej Kanakamalla, Thibault Saunier, Tim-Philipp Müller, Tomasz Mikolajczyk,
Víctor Manuel Jáquez Leal, Vivia Nikolaidou, Vivian Lee, Vivienne Watermeier,
Xavier Claessens,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.27.2

- [List of Merge Requests applied in 1.27.2](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.27.2)
- [List of Issues fixed in 1.27.2](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.27.2)

<a id="1.27.1"></a>

### 1.27.1

The first API/ABI-unstable 1.27.x development snapshot release (1.27.1) was released on 8 July 2025.

Any newly-added API in the 1.27.x series may still change or be removed again before 1.28 and should be considered unstable until 1.28 is released.

The 1.27.x release series is for testing and development purposes, and distros should probably not package it.

#### Highlighted changes in 1.27.1

 - Add AMD HIP plugin
 - Add Vulkan H.264 encoder and add 10-bit support to Vulkan H.265 decoder
 - Add LiteRT inference element
 - Aggregator: expose current-level-* properties on sink pads
 - Analytics: add general classifier tensor-decoder, facedetector, and more convenience API
 - alsa: Support enumerating virtual PCM sinks
 - d3d12: Add d3d12remap element
 - Wayland: Add basic colorimetrie support
 - Webkit: New wpe2 plugin making use of the "WPE Platform API"
 - MPEG-TS demuxer: Add property to disable skew corrections
 - qml6gloverlay: support directly passing a QQuickItem for QML the render tree
 - unifxfdsink: Add a property to allow copying to make sink usable with more upstream elements
 - videorate: Revive "new-pref" property for better control in case of caps changes
 - wasapi2: Port to IMMDevice based device selection
 - GstReferenceTimestampMeta can carry additional per-timestamp information now
 - Added GstLogContext API that allows to fix log spam in several components
 - New tracer hook to track when buffers are queued/dequeued in buffer pools
 - gst-inspect-1.0: Prints type info for caps fields now
 - Pipeline graph dot files now contain information about active tracers
 - Python bindings: add Gst.Float wrapper, Gst.ValueArray.append_value(), analytics API improvements
 - cerbero packages: ship vvdec and curl plugins; ship wasapi2 on MingW builds
 - Removed the gstreamer-vaapi module which has now been superseded by the va plugin
 - Countless bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

#### gstreamer

 - [aggregator: add sub_latency_min to pad queue size](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9320)
 - [aggregator: expose current-level-* properties on sink pads](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8731)
 - [baseparse: Add disable-clip property](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8773)
 - [buffer: Add optional info structure to GstReferenceTimestampMeta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9245)
 - [core changes needed for tensor negotiation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9184)
 - [core: gstvalue: fix ANY/EMPTY caps (features) hash](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9037)
 - [general: Stop checking `G_HAVE_GNUC_VARARGS` now that we require on c99](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8990)
 - [Add information about active tracers in dot files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8820)
 - [gst: info: Add a GstLogContext API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6855)
 - [gstmessage: Debug error message is nullable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8943)
 - [gstvalue: add hashing](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8518)
 - [gstvalue: fix gst_value_is_subset_array_array()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9220)
 - [meta: Add g_return_val_if_fail() for NULL valid_tags in gst_meta_api_type_tags_contain_only()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9054)
 - [tracer: Add a hook to track when buffers are queued/dequeued in pools](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8617)
 - [tracer: Make it compile when tracer hooks are disabled](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8638)
 - [Fix log spam in several components](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9122)
 - [Misc changes to avoid build failures with fedora 42](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8979)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)
 - [tests: More valgrind and test fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9115)
 - [gst-inspect-1.0: Added type info for caps fields](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9270)

#### gst-plugins-base

 - [Fix log spam in several components using the new log context API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9122)
 - [alsa: Support enumerating virtual PCM sinks](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8831)
 - [appsink, appsrc: Only notify drop property and not in/out](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8866)
 - [appsink, appsrc: Add some more stats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8824)
 - [decodebin, pbutils: use new GstLogContext API](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6855)
 - [discoverer: Make gst_discoverer_info_from_variant nullable](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8953)
 - [discoverer: Enhance debug logging](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8803)
 - [elements: use set_static_metadata when it's allowed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8905)
 - [general: Stop checking `G_HAVE_GNUC_VARARGS` now that we require on c99](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8990)
 - [gl/window: add support for configuring whether a backing surface is needed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9007)
 - [gl/x11: need to check display type](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8808)
 - [gl: Fix support for dmabuf using a DRM format that we can't emulate with shaders](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9306)
 - [gl: cocoa: Add navigation event support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9276)
 - [gldmabufferpool: disable "free cache" workaround in GstGLBufferPool](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8939)
 - [gldownload: improve logging of gl-dmabuf pool usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8938)
 - [glupload: Promote fixate caps results print to info](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8981)
 - [glvideomixer, compositor: fix mouse event handling to return wether upstream handled the events or not.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9139)
 - [glwindow_cocoa: fix window not closing (w/o user window handle)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9049)
 - [opengl: VA / glimagesink broke in some cases (regression)](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4525)
 - [opengl: Fix DRM format and modifier negotiation regressions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9339)
 - [orc: Update pregenerated files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9067)
 - [unifxfdsink: Add an property to allow copying](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8861)
 - [unixfdsrc: fix allocating FD memory with nonzero offsets](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8025)
 - [video formats: Add DRM equivalents for 10/12/16 bit SW-decoders formats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8965)
 - [video: Add 10bit 422 NV16_10LE40 format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5612)
 - [videorate, imagefreeze: add support for JPEG XS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8601)
 - [videorate: Revive 'new-pref' property](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8579)
 - [webrtcbin: Include all accepted media formats in SDP answers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9117)
 - [gst-device-monitor-1.0: Deinitialize GStreamer before exiting](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8670)
 - [GStreamer with OpenGL creates an empty "OpenGL Renderer" window on Wayland](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/2997)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)
 - [tests: More valgrind and test fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9115)

#### gst-plugins-good

 - [gldownload: improve logging of gl-dmabuf pool usage](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8938)
 - [imagefreeze: Handle EOS from send_event()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9191)
 - [matroskademux: Add support for relative position cues](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5535)
 - [orc: Update pregenerated files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9067)
 - [qml6gloverlay: support directly passing a QQuickItem for QML the render tree](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9180)
 - [rtph265depay: output profile, tier, level in output caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9223)
 - [rtpjpeg: fix copying of quant data if it spans memory segments](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5533)
 - [v4l2object: Make extra-controls property mutable in playing state](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9168)
 - [v4l2object: Provide padding requirements during propose allocation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8971)
 - [video: Add 10bit 422 NV16_10LE40 format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5612)
 - [videorate, imagefreeze: add support for JPEG XS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8601)
 - [y4m: move y4mdec to good to have a single y4m plugin](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8719)
 - [Fix build with -DGST_REMOVE_DEPRECATED](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8901)
 - [Name buffer pools for new buffer pool enqueue/dequeue tracer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8617)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)
 - [elements: use set_static_metadata when it's allowed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8905)
 - [tests: More valgrind and test fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9115)

#### gst-plugins-bad

 - [Fix build with -DGST_REMOVE_DEPRECATED](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8901)
 - [Misc changes to avoid build failures with fedora 42](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8979)
 - [analytics: Add transform function to copy the tensor meta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8825)
 - [analytics: Fix docs of gst_tensor_check_type()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9311)
 - [analytics: Fix transfer annotations of gst_tensor_check_type()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9293)
 - [analytics: add a convenient API to retrieve tensor](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9162)
 - [analytics: add more convenient API to retrieve tensor](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8848)
 - [analytics: classifier tensor decoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8548)
 - [analytics: Move IoU calculation to gstanalytics lib](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8805)
 - [analyticsoverlay: add filled-box mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8592)
 - [cuda: Lower debug log level on nvrtc compilation failure](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9232)
 - [curl: Fix wrong format specifier for macOS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8974)
 - [curl: Recover missing comment](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9213)
 - [d3d12: Add d3d12remap element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8887)
 - [d3d12screencapturesrc: Fix OS handle leaks/random crash in WGC mode](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9153)
 - [d3d12swapchainsink: Add uv-remap and redraw action signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9209)
 - [elements: use set_static_metadata when it's allowed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8905)
 - [general: Stop checking `G_HAVE_GNUC_VARARGS` now that we require on c99](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8990)
 - [h264parse: Drop NAL units that can't be parsed using AU alignment](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8976)
 - [h264parse: Forward LCEVC caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9321)
 - [h265parser: Make gst_h265_parser_link_slice_hdr public](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8679)
 - [hip: Add AMD HIP plugin](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8923)
 - [hip: Add missing #ifdef](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9289)
 - [hip: stream and event integration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9281)
 - [motioncells: fix typo in header comment](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8867)
 - [mpegtsdemux: Add property to disable skew corrections](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9301)
 - [mpegtsmux: Read `prog-map[PMT_ORDER_<PID>]` for PMT order key](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8584)
 - [nice: Don't modify struct borrowed by signal](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8900)
 - [nvjpegenc: Add autogpu mode element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8555)
 - [onnx: Cleanup the session creation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9176)
 - [onnx: Use system installed Eigen to avoid hash mismatch failure](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9229)
 - [onnx: produce tensor caps](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9172)
 - [opengl: Fix DRM format and modifier negotiation regressions](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9339)
 - [orc: Update pregenerated files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9067)
 - [parser: fix spelling of GstAV1SegmentationParams](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8795)
 - [tensordecoder: facedetector: Detect tensor output from the inference of Ultra Light Face Detection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8600)
 - [test: analytics: add more test on tracking mtd](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8868)
 - [tfliteinference: Add LiteRT inference element](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8523)
 - [tfliteinference: initialize means and stddevs arrays appropriately](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9189)
 - [unifxfdsink: Add an property to allow copying](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8861)
 - [unixfdsrc: fix allocating FD memory with nonzero offsets](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8025)
 - [v4l2codecs: Fix typos in the documentation](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8829)
 - [v4l2codecs: Use prop_offset in gst_v4l2_decoder_install_properties](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9179)
 - [va: remove unused headers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8626)
 - [video: Add 10bit 422 NV16_10LE40 format](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5612)
 - [videorate: Revive 'new-pref' property](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8579)
 - [vkerror: add invalid_video_std_parameters message](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9212)
 - [vkh264enc: add Vulkan H264 encoder](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7197)
 - [vkh265dec: add 10 bits support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8282)
 - [vkvideoencodeh26x: don't leak queues and ensure we call teardown() for each test](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9062)
 - [vtenc: Use strlcpy instead of strncpy](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9058)
 - [vulkan: use VK_EXT_debug_utils if available](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9119)
 - [vulkan: Fix drawing too many triangles in fullscreenquad](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9338)
 - [waylandsink: some property handling fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9283)
 - [webrtc: Fix compatibility with LiveKit](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9031)
 - [webrtc: Fix hangup when duplicate sctp association IDs chosen](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8607)
 - [vulkanupload: refactor frame copy](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9222)
 - [wasapi2: Log buffer QPC position and status flags](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8859)
 - [wasapi2: Port to IMMDevice based device selection](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9307)
 - [wayland: Add basic colorimetrie support](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6830)
 - [wayland: Add support for local protocols](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9186)
 - [wayland: Remove custom format mapping](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8983)
 - [waylandsink: Add force-aspect-ratio property](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9210)
 - [waylandsink: some property handling fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9283)
 - [webrtc: Partial revert of !8698](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8787)
 - [webrtc: stats: Fill data-channel transport stats and increase spec compliance for ICE candidate stats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8698)
 - [webrtc: stats: Improve spec compliance for ICE candidate stats](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8792)
 - [webrtc: Fix compatibility with LiveKit](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9031)
 - [webrtcbin: Include all accepted media formats in SDP answers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9117)
 - [webrtcbin: Make mid optional in offers and answers](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8729)
 - [webrtcdsp: Respect disabled feature option](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8424)
 - [wpe2: New WPE plugin making use of the "WPE Platform API"](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8789)
 - [svtjpegxs: print message for architectures unsupported by SVT-JPEG-XS](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9214)
 - [x265enc: Add bitrate tags to the output](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8838)
 - [y4m: move y4mdec to good to have a single y4m plugin](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8719)
 - [Name buffer pools for new buffer pool enqueue/dequeue tracer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8617)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)
 - [tests: More valgrind and test fixes](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9115)

#### gst-plugins-ugly

 - [Name buffer pools for new buffer pool enqueue/dequeue tracer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8617)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)

#### GStreamer Rust plugins

Changes compared to the current stable release (1.26.3) which both track gst-plugins-rs `main` branch for the time being:

 - [aws: s3hlssink: Write to S3 on OutputStream flush](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2330)
 - [gopbuffer: Push GOPs in order of time on EOS](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2335)
 - [gtk4: Promote set_caps debug log to info](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2341)
 - [hlssink3: Use closed fragment location in playlist generation](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2324)
 - [livekit: add room-timeout](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2307)
 - [mp4mux: add TAI timestamp muxing](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2280)
 - [rtpbin2: fix race condition on serialized Queries](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2332)
 - [rtpbin2: sync: fix race condition](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2337)
 - [rtprecv: fix SSRC collision event sent in wrong direction](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2351)
 - [webrtc: sink: avoid recursive locking of the session](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2322)
 - [webrtc: fix Safari addIceCandidate crash](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2039)
 - [webrtcsink: fix deadlock on error setting remote description](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2331)
 - [webrtcsink: add signal to configure mitigation modes](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/2279)

#### gst-libav

 - [Name buffer pools for new buffer pool enqueue/dequeue tracer](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8617)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)

#### gst-rtsp-server

 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)

#### gstreamer-vaapi

 - [Remove gstreamer-vaapi module which has now been superseded by the `va` plugin](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9200)

#### gstreamer-sharp

 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)

#### gst-python

 - [analytics: Add python API to iterate over specific Mtd types.](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8459)
 - [analytics: Add python API to get relation path](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8556)
 - [analytics: Add API iter_direct_related to GstAnalyticsMeta](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8461)
 - [Add Gst.Float wrapper](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8957)
 - [Override Gst.ValueArray.append_value()](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8952)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)

#### gst-editing-services

 - [Enhance debug logging](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8803)
 - [Handle add_control_binding failures](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9126)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)

#### gst-devtools, gst-validate + gst-integration-testsuites

 - [devtools: dots-viewer: Add a button to download the SVG file](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8696)
 - [devtools: dots-viewer: sort static files](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9208)
 - [elements: use set_static_metadata when it's allowed](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8905)
 - [validate: Do not list test files that are not autogenerated in .testlist](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9035)
 - [validate: Minor launcher improvements](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9127)
 - [validate: baseclasses: Reset Test.extra_logfiles when copying to start an iteration](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8640)
 - [validate: launcher: Downgrade non-critical log messages from ERROR to INFO](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9165)
 - [validate: Add a set of tests for checking if videooverlaycomposition reaches the sink](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9024)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)

#### gstreamer-docs

 - [android tutorials: Update provided projects to Gradle 8.11 and API level 24](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9104)

#### Development build environment

 - [Add devcontainer manifest for our CI image!](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/7816)
 - [Some subproject fixes on Windows](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9332)
 - [general: Stop checking `G_HAVE_GNUC_VARARGS` now that we require on c99](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8990)
 - [meson: rename meson_options.txt to meson.options](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8651)
 - [cairo: update wrap to 1.18.4](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8627)
 - [ffmpeg: update wrap to 7.1.1](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8627)
 - [librsvg: Add wrap](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6917)
 - [svtjpegxs: Add wrap](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9214)
 - [wayland-protocols: Update wrap](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/6830)
 - [webrtc-audio-processing: Add patches to wrap to fix compilation with gcc 15](https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/9038)

#### Cerbero build tool and packaging changes in 1.27.1

 - [Add `override_build_tools` property](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1813)
 - [Add vvdec recipe and build/ship vvdec plugin](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1816)
 - [Fix gensdkshell command](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1772)
 - [Fix librsvg recipe FatalError for usupported RUST arch/platform](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1814)
 - [Fixes for MinGW builds with Meson master](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1865)
 - [Local source](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1483)
 - [UX: improve error msg](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1810)
 - [a52dec: update to 0.8.0 and port to Meson](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1862)
 - [bootstrap: linux: Install libatomic on RedHat-based distros](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1751)
 - [build-tools: Update bison and flex](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1795)
 - [build: honor library_type for autotools recipes](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1833)
 - [build: use a list instead of a string for configure options](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1821)
 - [cargo-c: Update to 0.10.13](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1817)
 - [cdparanoia: port to Meson](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1788)
 - [cerbero: Add bindgen for Cargo recipes](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1770)
 - [cerbero: Fix bundle-source bugs](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1836)
 - [cerbero: Handle rust variant on Linux for old binutils versions](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1812)
 - [cmake: respect the configured output library type](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1819)
 - [curl: Add missing payloads](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1857)
 - [curl: add curl support](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1740)
 - [curl: fix install step in Windows when target file exists](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1882)
 - [dvdread: update to 6.1.3 and switch to Meson](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1826)
 - [expat: update to 2.7.1](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1766)
 - [glib, gobject-introspection: Update for MSVC patches](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1858)
 - [gst-devtools, bindgen-cli: Fix install_name_tool relocation error](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1796)
 - [gst-plugins-bad: Ship wasapi2 plugin in MinGW build as well](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1876)
 - [gst-plugins-rs: Force preset LIBCLANG_PATH for bindgen](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1779)
 - [gst-plugins-rs: Update recipe to simplify inheriting](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1646)
 - [libdvdnav: Fix missing build type](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1874)
 - [libdvdnav: Update to 6.1.1 and port to Meson](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1863)
 - [libdvdread: Fix incomplete MSVC compatibility](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1864)
 - [librsvg: Update to 2.60.0](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1797)
 - [libxml2: update to 2.14.2](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1784)
 - [meson: check if Rust variant to configure rustc bin](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1759)
 - [osxrelocator: Add .so to the allowed dylib extensions](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1777)
 - [pixman: update to 0.46.0](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1834)
 - [rust: Update to Rust 1.88 and cargo-c 0.10.14](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1877)
 - [rustup: Implement installer status caching, inplace target installs and upgrades](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1856)
 - [rustup: Work around broken symlink support in CI](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1785)
 - [spandsp: Fix signature compatibility with MSVC x86](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1801)
 - [spandsp: port to Meson](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1669)
 - [svt-av1: fix compatibility with CMake 4](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1828)
 - [y4m: update recipes for the fusion of both plugins](https://gitlab.freedesktop.org/gstreamer/cerbero/-/merge_requests/1781)

#### Contributors to 1.27.1

Adrian Perez de Castro, Aleix Pol, Alexander Slobodeniuk,
Alicia Boya García, Alyssa Ross, Andoni Morales Alastruey,
Andrew Yooeun Chun, Arnout Engelen, Artem Martus, Arun Raghavan,
Ben Butterworth, Biswapriyo Nath, Brad Hards, Branko Subasic, Carlos Bentzen,
Carlos Rafael Giani, César Alejandro Torrealba Vázquez, Changyong Ahn,
Daniel Morin, David Maseda Neira, David Monge, David Smitmanis,
Denis Shimizu, Detlev Casanova, Diego Nieto, Dongyun Seo, Doug Nazar,
Devon Sookhoo, Edward Hervey, Eli Mallon, Elliot Chen, Enock Gomes Neto,
Enrique Ocaña González, Eric, F. Duncanh, François Laignel, Gang Zhao,
Glyn Davies, Guillaume Desmottes, Gustav Fahlen, He Junyan, Hou Qi, Jakub Adam,
James Cowgill, Jan Alexander Steffens (heftig), Jan Schmidt, Jan Tojnar,
Jan Vermaete, Jerome Colle, Jochen Henneberg, Johan Sternerup,
Jordan Petridis, Jordan Yelloz, Jorge Zapata, Julian Bouzas, L. E. Segovia,
Loïc Le Page, Marc Leeman, Marek Olejnik, Mathieu Duponchelle, Matteo Bruni,
Matthew Waters, Michael Grzeschik, Michael Olbrich, Nicolas Dufresne,
Nirbheek Chauhan, Ognyan Tonchev, Olivier Blin, Olivier Crête,
Pablo García, Philippe Normand, Piotr Brzeziński, Pratik Pachange,
Qian Hu (胡骞), Raghavendra Rao, Razvan Grigore, Robert Ayrapetyan,
Robert Mader, Ruben Gonzalez, Santosh Mahto, Sebastian Dröge, Seungha Yang,
Shengqi Yu (喻盛琪), Stefan Andersson, Stéphane Cerveau,
Taruntej Kanakamalla, Théo Maillart, Thibault Saunier, Tim-Philipp Müller,
Vasiliy Doylov, Víctor Manuel Jáquez Leal, Vineet Suryan, Wim Taymans,
Xavier Claessens,

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing. Thank you all!

#### List of merge requests and issues fixed in 1.27.1

- [List of Merge Requests applied in 1.27.1](https://gitlab.freedesktop.org/groups/gstreamer/-/merge_requests?scope=all&utf8=%E2%9C%93&state=merged&milestone_title=1.27.1)
- [List of Issues fixed in 1.27.1](https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&utf8=%E2%9C%93&state=closed&milestone_title=1.27.1)

## Schedule for 1.28

Our next major feature release will be 1.28, and 1.27.x is the unstable
development series leading up to the stable 1.28 release. The development
of 1.27/1.28 will happen in the git `main` branch of the GStreamer mono
repository.

The schedule for 1.28 is yet to be decided, but we're targetting late 2025.

1.28 will be backwards-compatible to the stable 1.26, 1.24, 1.22, 1.20, 1.18, 1.16, 1.14, 1.12, 1.10, 1.8, 1.6, 1.4, 1.2 and 1.0 release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
