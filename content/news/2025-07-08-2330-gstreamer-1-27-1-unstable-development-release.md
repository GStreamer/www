---
title: "GStreamer 1.27.1 unstable development release"
date: 2025-07-08T23:30:00Z
version: "1.27.1"
tags: [release]
---

The GStreamer team is pleased to announce the first development release in
the API/ABI-unstable 1.27 release series.

The API/ABI-unstable 1.27 release series is for testing and development purposes
in the lead-up to the stable 1.28 series which is scheduled for release in late
2025\. Any newly-added API can still change until that point.

This development release is primarily for developers and early adopters, and
distros should probably not package it.

**Highlighted changes:**

- Add AMD HIP plugin
- Add Vulkan H.264 encoder and add 10-bit support to Vulkan H.265 decoder
- Add LiteRT inference element
- Aggregator: expose current-level-\* properties on sink pads
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
- Countless bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

Binaries for Android, iOS, Mac OS X and Windows will be made available shortly
at the [usual location](https://gstreamer.freedesktop.org/pkg/).

Release tarballs can be downloaded directly here:

- [gstreamer-1.27.1.tar.xz](/src/gstreamer/gstreamer-1.27.1.tar.xz)
- [gst-plugins-base-1.27.1.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.27.1.tar.xz)
- [gst-plugins-good-1.27.1.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.27.1.tar.xz)
- [gst-plugins-ugly-1.27.1.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.27.1.tar.xz)
- [gst-plugins-bad-1.27.1.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.27.1.tar.xz)
- [gst-libav-1.27.1.tar.xz](/src/gst-libav/gst-libav-1.27.1.tar.xz)
- [gst-rtsp-server-1.27.1.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.27.1.tar.xz)
- [gst-python-1.27.1.tar.xz](/src/gst-python/gst-python-1.27.1.tar.xz)
- [gst-editing-services-1.27.1.tar.xz](/src/gst-editing-services/gst-editing-services-1.27.1.tar.xz)
- [gst-devtools-1.27.1.tar.xz](/src/gst-devtools/gst-devtools-1.27.1.tar.xz),
- [gstreamer-docs-1.27.1.tar.xz](/src/gstreamer-docs/gstreamer-docs-1.27.1.tar.xz)

As always, please give it a spin and let us know of any issues you run into by filing an
issue in [GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer/).
