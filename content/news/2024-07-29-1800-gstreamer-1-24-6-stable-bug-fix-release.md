---
title: "GStreamer 1.24.6 stable bug fix release"
date: 2024-07-29T18:00:00Z
version: "1.24.6"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.24 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes and security fixes and it should be safe
to update from 1.24.x.

**Highlighted bugfixes:**

- Fix compatibility with FFmpeg 7.0
- qmlglsink: Fix failure to display content on recent Android devices
- adaptivedemux: Fix handling of closed caption streams
- cuda: Fix runtime compiler loading with old CUDA tookit
- decodebin3 stream selection handling fixes
- d3d11compositor, d3d12compositor: Fix transparent background mode with YUV output
- d3d12converter: Make gamma remap work as intended
- h264decoder: Update output frame duration for interlaced video when second field frame is discarded
- macOS audio device provider now listens to audio devices being added/removed at runtime
- Rust plugins: audioloudnorm, s3hlssink, gtk4paintablesink, livesync and webrtcsink fixes
- videoaggregator: preserve features in non-alpha caps for subclasses with non-system memory sink caps
- vtenc: Fix redistribute latency spam
- v4l2: fixes for complex video formats
- va: Fix strides when importing DMABUFs, dmabuf handle leaks, and blocklist unmaintained Intel i965 driver for encoding
- waylandsink: Fix surface cropping for rotated streams
- webrtcdsp: Enable multi_channel processing to fix handling of stereo streams
- Various bug fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.24.6 release notes](/releases/1.24/#1.24.6)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
