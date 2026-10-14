---
title: "GStreamer 1.24.12 stable bug fix release"
date: 2025-01-29T23:30:00Z
version: "1.24.12"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and it should be safe to update from 1.24.x.

**Highlighted bugfixes:**

- d3d12: Fix shaders failing to compile with newer dxc versions
- decklinkvideosink: Fix handling of caps framerate in auto mode; also a decklinkaudiosink fix
- devicemonitor: Fix potential crash macOS when a device is unplugged
- gst-libav: Fix crash in audio encoders like avenc_ac3 if input data has insufficient alignment
- gst-libav: Fix build against FFmpeg 4.2 as in Ubuntu 20.04
- gst-editing-services: Fix Python library name fetching on Windows
- netclientclock: Don't store failed internal clocks in the cache, so applications can re-try later
- oggdemux: Seeking and duration fixes
- osxaudiosrc: Fixes for failing init/no output on recent iOS versions
- qtdemux: Use mvhd transform matrix and support for flipping
- rtpvp9pay: Fix profile parsing
- splitmuxsrc: Fix use with decodebin3 which would occasionally fail with an assertion when seeking
- tsdemux: Fix backwards PTS wraparound detection with ignore-pcr=true
- video-overlay-composition: Declare the video/size/orientation tags for the meta and implement scale transformations
- vtdec: Fix seeks occasionally hanging on macOS due to a race condition when draining
- webrtc: Fix duplicate payload types with RTX and multiple video codecs
- win32-pluginloader: Make sure not to create any windows when inspecting plugins
- wpe: Various fixes for re-negotiation, latency reporting, progress messages on startup
- x264enc: Add missing data to AvcDecoderConfigurationRecord in codec_data for high profile variants
- cerbero: Support using ccache with cmake if enabled
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.12 release notes](/releases/1.24/#1.24.12)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
