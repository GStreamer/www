---
title: "GStreamer Core 0.10.33, Base Plugins 0.10.33, Good Plugins 0.10.29, Ugly Plugins 0.10.18, Bad Plugins 0.10.22 stable releases"
date: 2011-05-10T12:00:00Z
---

The GStreamer team is excited to announce new releases of the GStreamer core module, the gst-plugins-base module, the gst-plugins-good module, the gst-plugins-ugly module, and the gst-plugins-bad module for the 0.10 GStreamer stable release series.

Check out release notes for
[gstreamer](/releases/gstreamer/0.10.33.html),
[gst-plugins-base](/releases/gst-plugins-base/0.10.33.html),
[gst-plugins-good](/releases/gst-plugins-good/0.10.29.html),
[gst-plugins-ugly](/releases/gst-plugins-ugly/0.10.18.html),
[gst-plugins-bad](/releases/gst-plugins-bad/0.10.22.html),
or download tarballs for
[gstreamer](/src/gstreamer/gstreamer-0.10.33.tar.bz2),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-0.10.33.tar.bz2),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-0.10.29.tar.bz2),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-0.10.18.tar.bz2),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-0.10.22.tar.bz2)
directly.

*Highlights:*

- **GStreamer core:**
  - new parser base class: GstBaseParse
  - new core element: funnel
  - OSX multi-arch fixes
  - new QoS type for QoS events
  - new progress message API to notify applications of asynchronous operations
- **gst-plugins-base:**
  - support for 16-bit-per-component video formats
  - playbin2 fixes and improvements for custom and non-raw sinks
  - oggmux muxes based on running time now
  - orc 0.4.14 or newer recommended
- **gst-plugins-good:**
  - amrparse, aacparse, ac3parse, flacparse, mpegaudioparse, dcaparse audio parsers (moved from -bad)
  - muxers now mux based on running time
  - ISO MP4 muxers: mp4mux/3gppmux/qtmux/mj2mux (moved from -bad)
  - new matroskaparse element
  - new v4l2radio element
  - rtpsession: support RTCP Early Feedback (the AVPF profile)
  - orc 0.4.14 or newer recommended
- **gst-plugins-ugly:**
  - x264enc: allow changing bitrate and quantizers dynamically at runtime
  - x264enc: proxy downstream caps restrictions upstream via get_caps()
  - lamemp3enc: proxy downstream rate/channels restrictions upstream via get_caps()
  - mad: allow build without libid3tag (which isn't really needed anyway)
- **gst-plugins-bad:**
  - hlsdemux: Add HTTP live streaming parser/demuxer element
  - new elements: h263parse, zebrastripe, patchdetect
  - scenechange: new scene change detection element
  - removed audioparsersbad plugin, it has been moved to -good
  - make opencv plugin work with OpenCV 2.2
  - countless (still experimental) camerabin2 fixes and improvements
  - experimental VP8 RTP payloader/depayloader (RTP payloading not finalised yet)
  - curlsink: add libcurl-based sink element (acts as client, not server)
  - decklink: add decklink plugin
  - linsys: add plugin for Linear Systems SDI boards
  - sdi: add raw SDI muxing/demuxing elements
  - camerabin now relies on muxers to mux based on running time (ie. latest base/good/ugly releases)

... and many other fixes and improvements of course.
