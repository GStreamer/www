# GStreamer 1.27.x Release Notes

GStreamer 1.27.x is an API/ABI-unstable development series leading up to the stable 1.28 series.

GStreamer 1.28.0 has not been released yet. It will be released in late 2025.

The current stable series is 1.26.

The latest development release towards the upcoming 1.28 stable series is [1.27.2](#1.27.2) and was released on 07 September 2025.

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
