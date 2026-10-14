---
title: "GStreamer 1.26.5 stable bug fix release"
date: 2025-08-07T23:00:00Z
version: "1.26.5"
tags: [release]
---

The GStreamer team is pleased to announce another bug fix release
in the new stable 1.26 release series of your favourite cross-platform
multimedia framework!

This release only contains bugfixes, and it should be safe to update from 1.26.x.

**Highlighted bugfixes:**

- audioconvert: Fix caps negotiation regression when using a mix matrix
- aws: Add support for brevity in awstranslate and add option to partition speakers in the transcription output of awstranscriber2
- speechmatics speech-to-text: Expose mask-profanities property
- cea708mux: Add support for discarding select services on each input
- cea608overlay, cea708overlay: Accept GPU memory buffers if downstream supports the overlay composition meta
- d3d12screencapture source element and device provider fixes
- decodebin3: Don't error on an incoming ONVIF metadata stream
- uridecodebin3: Fix potential crash when adding URIs to messages, e.g. if no decoder is available
- v4l2: Fix memory leak for dynamic resolution change
- VA encoder fixes
- videorate, imagefreeze: Add support for JPEG XS
- Vulkan integration fixes
- wasapi2 audio device monitor improvements
- webrtc: Add WHEP client signaller and add whepclientsrc element on top of webrtcsrc using that
- threadshare: Many improvements and fixes to the generic threadshare and RTP threadshare elements
- rtpbin2 improvements and fixes
- gst-device-monitor-1.0 command line tool improvements
- Various bug fixes, build fixes, memory leak fixes, and other stability and reliability improvements

See the [GStreamer 1.26.5 release notes](/releases/1.26/#1.26.5)
for more details.

Binaries for Android, iOS, Mac OS X and Windows will be available shortly.
