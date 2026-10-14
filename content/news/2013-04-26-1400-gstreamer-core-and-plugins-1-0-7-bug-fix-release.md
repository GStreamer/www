---
title: "GStreamer Core and Plugins 1.0.7 bug-fix release"
date: 2013-04-26T14:00:00Z
---

The GStreamer team is pleased to announce another bug-fix release for the
new API and ABI-stable 1.x series of the GStreamer multimedia
framework.

Check out the release notes for
[GStreamer core](/releases/gstreamer/1.0.7.html),
[gst-plugins-base](/releases/gst-plugins-base/1.0.7.html),
[gst-plugins-good](/releases/gst-plugins-good/1.0.7.html),
[gst-plugins-ugly](/releases/gst-plugins-ugly/1.0.7.html),
[gst-plugins-bad](/releases/gst-plugins-bad/1.0.7.html), or
[gst-libav](/releases/gst-libav/1.0.7.html),
or download tarballs for
[gstreamer](/src/gstreamer/gstreamer-1.0.7.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.0.7.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.0.7.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.0.7.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.0.7.tar.xz), or
[gst-libav](/src/gst-libav/gst-libav-1.0.7.tar.xz),

Improvements include:

- better support for static plugins
- streamsynchronizer is now a public element, useful in HLS pipelines for example
- osxaudio plugin ported to 1.0
- androidmedia plugin is ported to 1.0
- internal libav snapshot in gst-libav has been updated to libav 0.8.6
- Now uses frame based threading if possible and disables slice
  based threading until libav 0.9.x is used (as is the case in git master
  already) This provides potentially better performance and fixes some
  display corruptions caused by bugs in the slice based threading
- a number of [bug fixes](https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&target_milestone=1.0.7)
