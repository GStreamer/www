---
title: "GStreamer Core and Plugins 1.0.4 bug-fix release"
date: 2012-12-18T23:00:00Z
---

The GStreamer team announces a new bug-fix release for the
new API and ABI-stable 1.x series of the GStreamer multimedia
framework.

Check out the release notes for
[GStreamer core](/releases/gstreamer/1.0.4.html),
[gst-plugins-base](/releases/gst-plugins-base/1.0.4.html),
[gst-plugins-good](/releases/gst-plugins-good/1.0.4.html),
[gst-plugins-ugly](/releases/gst-plugins-ugly/1.0.4.html),
[gst-plugins-bad](/releases/gst-plugins-bad/1.0.4.html), or
[gst-libav](/releases/gst-libav/1.0.4.html),
or download tarballs for
[gstreamer](/src/gstreamer/gstreamer-1.0.4.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.0.4.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.0.4.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.0.4.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.0.4.tar.xz), or
[gst-libav](/src/gst-libav/gst-libav-1.0.4.tar.xz),

Improvements include:

- basesrc: fix potential leaks when re-activating in a different mode
- bindings: make all pad probe types work with bindings
- bindings: fix gst_event_parse_stream_start() annotation, fixing crash
- bindings: fix annotation for gst_app_src_push_buffer(), fixing crash
- bindings: add several missing annotations for GstRtspMessage API
- documentation improvements
- playbin: fix occasional not-negotiated errors when switching visualisations
- ssaparse: ignore invalid UTF-8 in SSA/ASS subtitles init sections in matroska files
- streamsynchronizer: better timestamp and gap handling at EOS, fixing potential OOM in baseaudiosink
- deinterleave: properly set srcpad channel position
- osxvideosink: Fix resizing the Cocoa window on receiving new caps
- rtspsrc fixes
- shout2send: also accept audio/webm in addition to video/webm
- videobox: fix border filling for planar YUV formats
- webmmux: fix linking to shout2send
- v4l2: fix build on FreeBSD
- siddec: initialize debug category
- mpeg4videoparse: also parse divx 4/5
- mpeg4videoparse: export number of sprite warping points in caps (decoders might have no or only limited GMC support)
- mpegtsmux: propagate flow returns upstream; don't crash when reused
- rtmpsrc: disable seeking if the configured url specifies live=true
- build fixes for OS/X (shm) and Windows (d3dvideosink)
- libav G.726 decoder fixes
- miscellaneous [bug fixes](https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&target_milestone=1.0.4)
- some memory leak fixes
