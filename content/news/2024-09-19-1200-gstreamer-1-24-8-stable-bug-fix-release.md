---
title: "GStreamer 1.24.8 stable bug fix release"
date: 2024-09-19T12:00:00Z
version: "1.24.8"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe
to update from 1.24.x.

**Highlighted bugfixes:**

- decodebin3: collection handling fixes
- encodebin: Fix pad removal (and smart rendering in gst-editing-services)
- glimagesink: Fix cannot resize viewport when video size changed in caps
- matroskamux, webmmux: fix firefox compatibility issue with Opus audio streams
- mpegtsmux: Wait for data on all pads before deciding on a best pad unless timing out
- splitmuxsink: Override LATENCY query to pretend to downstream that we're not live
- video: QoS event handling improvements
- voamrwbenc: fix list of bitrates
- vtenc: Restart encoding session when certain errors are detected
- wayland: Fix ABI break in WL context type name
- webrtcbin: Prevent crash when attempting to set answer on invalid SDP
- cerbero: ship vp8/vp9 software encoders again, which went missing in 1.24.7; ship transcode plugin
- Various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.8 release notes](/releases/1.24/#1.24.8)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
