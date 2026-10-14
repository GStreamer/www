---
title: "GStreamer Core and Plugins 1.0.3 bug-fix release"
date: 2012-11-21T13:00:00Z
---

The GStreamer team announces a new bug-fix release for the
new API and ABI-stable 1.x series of the GStreamer multimedia
framework.

Check out the release notes for
[GStreamer core](/releases/gstreamer/1.0.3.html),
[gst-plugins-base](/releases/gst-plugins-base/1.0.3.html),
[gst-plugins-good](/releases/gst-plugins-good/1.0.3.html),
[gst-plugins-ugly](/releases/gst-plugins-ugly/1.0.3.html),
[gst-plugins-bad](/releases/gst-plugins-bad/1.0.3.html), or
[gst-libav](/releases/gst-libav/1.0.3.html),
or download tarballs for
[gstreamer](/src/gstreamer/gstreamer-1.0.3.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.0.3.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.0.3.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.0.3.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.0.3.tar.xz), or
[gst-libav](/src/gst-libav/gst-libav-1.0.3.tar.xz),

Improvements include:

- bufferpool: fix deadlock
- baseparse: forward stream-start event in push mode, fixing issues with streamsynchronizer
- basesink: reset START_TIME when needed, fixing position reporting after seeking beyond end
- typefind: detect isml ftyp as iso-fragmented video/quicktime
- typefinding improvements fixing playback of some wavpack files
- textoverlay rendering fixes
- gobject-introspection annotation fixes
- API: gst_video_decoder_get_qos_proportion()
- rtspsrc: numerous improvements
- build fix for gst-plugins-base installed in non-default prefix
- multifilesink: post messages in max-size mode as well
- vp8dec: improve robustness on decoding errors, e.g. for videocalling
- cdio: try to handle CD-TEXT in non-UTF8 encodings
- xingmux, siddec, dvdlpcmdec and dvdsubdec fixes
- mpegtsmux: fix DTS/PTS confusion
- tsdemux, tsparse: seeking fixes
- tsdemux, tsparse: fix timestamping with push-based input
- h264parse: fix PPS insertion
- mpg123audiodec: fix leaks from not chaining up in the finalize function
- avcodecmap: Y41B is YUV411P, not YUV410P
- numerous [bug fixes](https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&target_milestone=1.0.3)
- some memory leak fixes
