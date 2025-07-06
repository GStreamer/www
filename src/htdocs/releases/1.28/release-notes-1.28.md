# GStreamer 1.27.x Release Notes

GStreamer 1.27.x is an API/ABI-unstable development series leading up to the stable 1.28 series.

GStreamer 1.28.0 has not been released yet. It will be released in late 2025.

The current stable series is 1.26.

The latest development release towards the upcoming 1.28 stable series is [1.27.1](#1.27.1) and was released on 8 July 2025.

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
