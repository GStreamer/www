---
title: "GStreamer 1.28.5 stable bug fix release"
date: 2026-07-08T23:50:00Z
version: "1.28.5"
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
- Fix subtitles cause green flickering with VA decoders on AMD GPUs
- core: Fix sticky event raciness when pads are linked mid-push
- appsrc: Uniformly handle EOS events being pushed
- audio-resampler-neon fails to build for targets with neon but without thumb
- avtp: Correct ptime generation from avtp timestamp
- fmp4mux: Various fixes for splitting at fragment boundaries
- gldownload: fix wrong DRM format negotiation causing R/B channel swap
- gdkpixbufdec: Drop rank to NONE and handle resolution/format changes
- gopbuffer: add support for H.266/VVC
- h265decoder: Fix HEVC with alpha decoding
- mp4mux: fix AC-3 template caps so muxer can accept input from ac3parse
- mpegtsmux: Always assign PTS to output buffers in CBR mode
- mpegtsmux: Output buffers with PCR-only bitrate-padding packets have wrong PTS
- rtcpbuffer: Fix parsing of SR+SDES compound packets (regression from security fix)
- rtspsrc2: Allow disabling SRTP/SRTCP encryption and SRTP authentication
- tsdemux: Improve PTS rollover handling in ignore-pcr mode, fixing intermittent corruption with YouTube HLS streams
- textaccumulate: output joined single buffer, add list as meta
- threadshare: add ts-clocksync
- webrtcsink: negotiation fixes and improvements
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.28.5 release notes](/releases/1.28/#1.28.5)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly and
will be published on the [Downloads page](/download/).
