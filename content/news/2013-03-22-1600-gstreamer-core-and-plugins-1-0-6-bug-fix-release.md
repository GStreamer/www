---
title: "GStreamer Core and Plugins 1.0.6 bug-fix release"
date: 2013-03-22T16:00:00Z
---

The GStreamer team is pleased to announce a new bug-fix release for the
new API and ABI-stable 1.x series of the GStreamer multimedia
framework.

Check out the release notes for
[GStreamer core](/releases/gstreamer/1.0.6.html),
[gst-plugins-base](/releases/gst-plugins-base/1.0.6.html),
[gst-plugins-good](/releases/gst-plugins-good/1.0.6.html),
[gst-plugins-ugly](/releases/gst-plugins-ugly/1.0.6.html),
[gst-plugins-bad](/releases/gst-plugins-bad/1.0.6.html), or
[gst-libav](/releases/gst-libav/1.0.6.html),
or download tarballs for
[gstreamer](/src/gstreamer/gstreamer-1.0.6.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.0.6.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.0.6.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.0.6.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.0.6.tar.xz), or
[gst-libav](/src/gst-libav/gst-libav-1.0.6.tar.xz),

Improvements include:

- build fixes for out-of-tree autogen.sh and automake 1.13, and recent kernel/video4linux
- gobject-introspection fixes for bindings
- videoscale: Correct DAR and border calculations
- playbin: make sure converters are always plugged when needed, fixes not-negotiated errors with some sinks
- playbin: fix subtitleoverlay caps handling to avoid not-negotiated errors when subtitle plugins are missing
- adder: make "caps" property work properly
- alsasink: don't use 100% CPU in some cases
- reliability fixes for flushing seeks and shutdowns in queue and bastransform
- appsrc: fix locking order
- audiovisualisation fixes
- deinterlace: fix infinite loop on EOS with non-default methods or fields
- avidemux push mode fixes, make dv-in-avidemux work
- level: send a final level message on EOS
- osxvideosink fixes
- ximagesrc: Set the pixel aspect ratio correctly in the output caps
- v4l2: don't check stride for encoded formats
- leak fixes in GstBin, pango, auparse, gdppay
- qtdemux: skip disabled tracks and ignore chapter subtitle tracks
- RTSP and RTP fixes
- Opus audio decoder, encoder and RTP payloader fixes
- codecparser fixes for H.264, MPEG-2 and VC-1 parsing
- opensles, eglglessink, and decklink plugins ported to 1.0
- libav: fix H.264 decoding errors in some files and update to 0.8.5 release
- miscellaneous [bug fixes](https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&target_milestone=1.0.6)
