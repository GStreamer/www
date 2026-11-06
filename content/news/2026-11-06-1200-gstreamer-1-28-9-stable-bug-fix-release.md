---
title: "GStreamer 1.28.9 stable bug fix release"
date: 2026-11-06T12:00:00Z
version: "1.28.9"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.28 release series of your favourite cross-platform
multimedia framework!

This release only contains bug fixes as well as a number of
[security fixes](/security/). It should be safe to update
from 1.28.x, and we recommend you do so at your earliest convenience.

This release also contains follow-up fixes for two security issues addressed
in earlier releases: an incomplete fix for an out-of-bounds read in the MPEG-4
video parser (GST-SA-2026-0049), and a use-after-free and race condition in
the RTP session DoS protection (GST-SA-2026-0074).

**Highlighted bugfixes:**

- Various [security fixes](/security/) and playback fixes
- decodebin3, playbin3: fix assertion that would crash music players with certain files and sources
- qtdemux: fix seeking beyond the end of file in push mode
- flvdemux: don't prematurely EOS on AVC/audio sequence end
- rtspsrc: Reuse non-compliant URL fallback across tracks
- H.264 and H.265 RTP depayloader header extension tracking fixes
- level: Add 24 bits support
- gtk4paintablesink: Mark EGL display as foreign to not terminate it
- amfcodec: fix rate_control (H.265, AV1) and gop_size (H.265) properties
- asio: fix stopping asio element causing crashes
- cuda: Correctly save alpha and blend on property change
- HLS: fix awss3hlssink EXT-X-PROGRAM-DATE-TIME moving at twice the speed of the target duration
- hlssink3: Fix stream writing regression for CMAF and WebVTT sinks
- isobmff: Fix NTP seconds roll-over past 2036
- Fix gap event regression in MPEG-PS demuxer with certain subtitle streams
- qsv, d3d11, d3d12: Build fixes on latest msys2 environment
- va: do not advertise unsupported formats in encoder caps
- v4l2 video decoder fixes including delay negotiation for H.264 and H.265 for better decodebin2 compatibility
- wayland: output hotplug fixes
- webrtcsink: add support of mpph264enc encoder (rockchip)
- Rust plugins: enable cross-compilation with sysroot in Meson build
- cerbero: update ca-certificates and pip, and fix issue with rolling distro versions
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.28.9 release notes](/releases/1.28/#1.28.9)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
