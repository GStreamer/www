---
title: "GStreamer 1.18.0 new major stable release"
date: 2020-09-08T00:30:00Z
version: "1.18.0"
tags: [release]
---

The GStreamer team is excited to announce a new major feature release of
your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other improvements.

The 1.18 release series adds new features on top of the previous 1.16 series
and is part of the API and ABI-stable 1.x release series of the GStreamer
multimedia framework.

**Highlights:**

- `GstTranscoder`: new high level API for applications to transcode media files from one format to another
- High Dynamic Range (HDR) video information representation and signalling enhancements
- Instant playback rate change support
- Active Format Description (AFD) and Bar Data support
- ONVIF trick modes support in both GStreamer RTSP server and client
- Hardware-accelerated video decoding on Windows via DXVA2 / Direct3D11
- Microsoft Media Foundation plugin for video capture and hardware-accelerated video encoding on Windows
- `qmlgloverlay`: New overlay element that renders a `QtQuick` scene over the top of an input video stream
- New `imagesequencesrc` element to easily create a video stream from a sequence of jpeg or png images
- `dashsink`: Add new sink to produce DASH content
- `dvbsubenc`: DVB Subtitle encoder element
- TV broadcast compliant MPEG-TS muxing with constant bitrate muxing and SCTE-35 support
- `rtmp2`: new RTMP client source and sink element implementation
- `svthevcenc`: new \[SVT-HEVC\](https://github.com/OpenVisualCloud/SVT-HEVC)-based H.265 video encoder
- `vaapioverlay` compositor element using VA-API
- `rtpmanager` support for Google's Transport-Wide Congestion Control (twcc) RTP extension
- `splitmuxsink` and `splitmuxsrc` gained support for auxiliary video streams
- `webrtcbin` now contains some initial support for renegotiation involving stream addition and removal
- New RTP source and sink elements to set up RTP streaming via `rtp://` URIs
- New Audio Video Transport Protocol (AVTP) plugin for Time-Sensitive Applications
- Support for the Video Services Forum's Reliable Internet Stream Transport (RIST) TR-06-1 Simple Profile
- Universal Windows Platform (UWP) support
- `rpicamsrc` element for capturing from the Raspberry Pi camera
- RTSP Server TCP interleaved backpressure handling improvements as well as support for Scale/Speed headers
- GStreamer Editing Services gained support for nested timelines, per-clip speed rate control and the \[OpenTimelineIO\](https://opentimelineio.readthedocs.io) format.
- Autotools build system has been removed in favour of Meson
- Many performance improvements

Full release notes can be found [here](/releases/1.18/).

Binaries for Android, iOS, Mac OS X and Windows will be provided in due course.

You can download release tarballs directly here:
[gstreamer](/src/gstreamer/gstreamer-1.18.0.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-1.18.0.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-1.18.0.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-1.18.0.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-1.18.0.tar.xz),
[gst-libav](/src/gst-libav/gst-libav-1.18.0.tar.xz),
[gst-rtsp-server](/src/gst-rtsp-server/gst-rtsp-server-1.18.0.tar.xz),
[gst-python](/src/gst-python/gst-python-1.18.0.tar.xz),
[gst-editing-services](/src/gst-editing-services/gst-editing-services-1.18.0.tar.xz),
[gst-devtools](/src/gst-devtools/gst-devtools-1.18.0.tar.xz),
[gstreamer-vaapi](/src/gstreamer-vaapi/gstreamer-vaapi-1.18.0.tar.xz),
[gstreamer-sharp](/src/gstreamer-sharp/gstreamer-sharp-1.18.0.tar.xz),
[gst-omx](/src/gst-omx/gst-omx-1.18.0.tar.xz), or
[gstreamer-docs](/src/gstreamer-docs/gstreamer-docs-1.18.0.tar.xz).
