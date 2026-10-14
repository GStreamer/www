---
title: "GStreamer 1.0 released"
date: 2012-09-24T18:00:00Z
---

The GStreamer project is pleased to announce the very first release of
the new API and ABI-stable 1.x series of the GStreamer multimedia
framework.

The 1.x series is a stable series targeted at end users. It is not API
or ABI compatible with the 0.10.x series. It can, however, be installed
in parallel with the 0.10.x series and will not affect an existing
0.10.x installation.

Major improvements include:

- more flexible memory handling
- extensible and negotiable metadata for buffers
- caps negotiation and renegotiation mechanisms, decoupled from buffer allocation
- improved caps renegotiation
- automatic re-sending of state for dynamic pipelines
- reworked and more fine-grained pad probing
- simpler and more descriptive audio and video caps
- more efficient allocation of buffers, events and other mini objects
- improved timestamp handling
- support for gobject-inspection-based language bindings
- countless other improvements

An overview of the architectural changes can be found in
[Wim Tayman's GStreamer 1.0 keynote](http://gstconf.ubicast.tv/videos/keynote-gstreamer-10/)
from the GStreamer Conference 2012 in San Diego (click on the 'Share' tab for other video formats).

Most of these changes involve the GStreamer plugin API. The application
API has changed comparatively little, and most applications should be
fairly easy to port to the new API. There is a
[porting guide](http://cgit.freedesktop.org/gstreamer/gstreamer/tree/docs/random/porting-to-1.0.txt)
available.

The GStreamer team would like to thank everyone who helped bring this
release about, whether by submitting patches, reporting bugs, testing,
sponsoring development, attending hackfests, or simply supplying moral
support.

This is the end of a long development process, but also the beginning of
one. This release does not mark the pinnacle of perfection, but the
point where the team is content with the API and stability and quality
of the code base in general, especially compared to the old 0.10 series.

There will be bugs to fix, and starting from this release there will be
distinct bug-fixing and feature development cycles, with the goal of
getting bug-fixes out quicker and unencumbered by other more risky
changes. See the
[ReleasePlanning/RoadMap page on the wiki](/wiki/ReleasePlanning/RoadMap)
for a tentative road map and possible schedule.

Please also note that we may still need to fine-tune some minor aspects
of plugin behaviour in the next development cycle (e.g. bufferpool
draining on renegotiation), so keep an eye out for that when porting
elements over.

Release tarballs can be downloaded directly here:
[gstreamer](/src/gstreamer/gstreamer-1.0.0.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.0.0.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.0.0.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.0.0.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.0.0.tar.xz), and
[gst-libav](/src/gst-libav/gst-libav-1.0.0.tar.xz) (formerly gst-ffmpeg).

Packages should be available shortly in debian sid, fedora 18, ubuntu
quantal, and other distros.
