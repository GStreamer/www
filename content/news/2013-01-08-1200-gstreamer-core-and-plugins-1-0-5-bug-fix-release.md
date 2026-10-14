---
title: "GStreamer Core and Plugins 1.0.5 bug-fix release"
date: 2013-01-08T12:00:00Z
---

The GStreamer team is pleased to announce a new bug-fix release for the
new API and ABI-stable 1.x series of the GStreamer multimedia
framework.

Check out the release notes for
[GStreamer core](/releases/gstreamer/1.0.5.html),
[gst-plugins-base](/releases/gst-plugins-base/1.0.5.html),
[gst-plugins-good](/releases/gst-plugins-good/1.0.5.html),
[gst-plugins-ugly](/releases/gst-plugins-ugly/1.0.5.html),
[gst-plugins-bad](/releases/gst-plugins-bad/1.0.5.html), or
[gst-libav](/releases/gst-libav/1.0.5.html),
or download tarballs for
[gstreamer](/src/gstreamer/gstreamer-1.0.5.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.0.5.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.0.5.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.0.5.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.0.5.tar.xz), or
[gst-libav](/src/gst-libav/gst-libav-1.0.5.tar.xz),

Improvements include:

- rtspsrc: fix regression that make rtspsrc hang when stopping
- alsasrc: don't output buffers without timestamps or with bogus timestamps
- add GST_CLOCK_TYPE_OTHER clock type
- discoverer, decodebin: fix state change re-sync race that might lead to deadlocks
- add GST_BIN_FLAG_NO_RESYNC flag that disables a resync when
  an element is added, removed or linked in the bin; this is
  interesting for complex bins that dynamically add elements
  to themselves and want to manage the state of those elements
  without interference from state resync threads (which may
  cause deadlocks)
- video: fix crashes with and frame sizes of A420 video format
- fix VP6-alpha video playback
- jpegenc: pass flow returns upstream
- audio/video parsers: fix negotiation with encoders in some transcoding cases
- qtdemux: fix pixel-aspect-ratio of some files with ProRes video
- cairo: port cairooverlay to 1.0
- psdemux: tentative port to 1.0; take into account both DTS and PTS
- shm: Actually get the permissions on get_property
- waylandsink: do not default to fullscreen mode
- build: fix build with new automake 1.13
- build: pass CC, LD, AS, AR and NM to the libav configure if set
- miscellaneous [bug fixes](https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&target_milestone=1.0.5)
