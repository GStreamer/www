---
title: "GStreamer 1.28.3 stable bug fix release"
date: 2026-05-11T23:00:00Z
version: "1.28.3"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.28 release series of your favourite cross-platform
multimedia framework!

This release only contains bug fixes as well as a number of
[security fixes](/security/). It should be safe to update
from 1.28.x, and we recommend you do so at your earliest convenience.

**Highlighted bugfixes:**

- Various [security fixes](/security/) and playback fixes
- applemedia: vtdec stability, MoltenVK integration and planar video format handling fixes
- audioresample: Fix regression on armv7hf
- bpmdetect: Fixes for stereo and multi-channel modes
- devicemonitor: wait for start thread to finish when listing devices so all the info is there for e.g. v4l2 provider
- fallbacksrc: Add fallback-source and enable-dummy properties
- nvidia: fix cudaconvert performance regression and nvdec device creation regression
- opengl: add GBRA swizzle support, and fix glcolorconvert vertical flip issue on crop
- rtspsrc: include user-agent property in HTTP tunnel requests and fix mikey regression
- threadshare: add leaky mode to dataqueue-based elements
- v4l2: fix negotiation error when trying to force stateful decoders to output dmabufs
- webrtcsink: Add support imx8mp vpuenc_hevc hardware H.265 encoder
- cerbero: Extend gst-plugins-rs melding to Darwin platforms for smaller binary sizes and static linking improvements
- inno Windows installer fixes, including silent install mode via the command line
- macOS: provide script to allow uninstalling the package; relocate absolute paths to Python.framework in wheels
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.28.3 release notes](/releases/1.28/#1.28.3)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
