---
title: "GStreamer 1.26.4 stable bug fix release"
date: 2025-07-16T19:00:00Z
version: "1.26.4"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.26 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes as well,
and it should be safe to update from 1.26.x.

**Highlighted bugfixes:**

- adaptivedemux2: Fixed reverse playback
- d3d12screencapture: Add support for monitor add/remove in device provider
- rtmp2src: various fixes to make it play back AWS medialive streams
- rtph265pay: add profile-id, tier-flag, and level-id to output rtp caps
- vp9parse: Fix handling of spatial SVC decoding
- vtenc: Fix negotiation failure with \`profile=main-422-10\`
- gtk4paintablesink: Add YCbCr memory texture formats and other improvements
- livekit: add room-timeout
- mp4mux: add TAI timestamp muxing support
- rtpbin2: fix various race conditions, plus other bug fixes and performance improvements
- threadshare: add a \`ts-rtpdtmfsrc\` element, implement run-time input switching in \`ts-intersrc\`
- webrtcsink: fix deadlock on error setting remote description and other fixes
- cerbero: WiX installer: fix missing props files in the MSI packages
- smaller macOS/iOS package sizes
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.4 release notes](/releases/1.26/#1.26.4)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
