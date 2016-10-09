# GStreamer 1.10 Release Notes

**NOTE: THESE RELEASE NOTES ARE VERY INCOMPLETE AND STILL WORK-IN-PROGRESS**

**GStreamer 1.10 is scheduled for release in TBD 2016.**

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other
improvements.

See [https://gstreamer.freedesktop.org/releases/1.10/][latest] for the latest
version of this document.

*Last updated: Wednesday 9 Oct 2016, 18:00 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.10/
[gitlog]: https://cgit.freedesktop.org/gstreamer/www/log/src/htdocs/releases/1.10/release-notes-1.10.md

## Introduction

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other
improvements.

## Highlights

- FILL ME

## Major new features and changes

### Noteworthy new API, features and other changes

#### GstStream API and stream selection

#### Audio conversion and resampling API

#### Support for SMPTE timecodes

#### GStreamer OpenMAX IL plugin

- FILL ME

### New Elements

#### decodebin3, urisrcbin, parsebin and playbin3

#### LV2 source element and switch from slv2 to lilv2

#### WebRTC DSP Plugin

#### FDK AAC encoder and decoder

- FILL ME

### Noteworthy element features and additions

#### Major RTP and RTSP improvements

RTX, jitterbuffer, RTSP server fixes, rtspsrc seeking stability
App and protocol specific RTCP

#### Improvements to splitmuxsrc

#### opencv plugins ported to OpenCV 3.1

#### OpenGL/GLES improvements

#### Vulkan

#### QML video sink ported to more platforms

#### KMS video sink

#### Wayland video sink

#### DVB improvements

#### DASH, HLS and adaptivedemux

trick modes, alternative renditions, ...

#### a2dpsink finally works

- FILL ME

### Plugin moves

- FILL ME

### New leaks tracer

- FILL ME

### Property change notification messages

- FILL ME

### GES and NLE changes

- FILL ME

## Miscellaneous

- Additional machine-readable details in error messages, e.g. HTTP status
  codes
- New redirect message
- gst\_element\_call\_async() API
- GstBin suppressed flags API
- GstAdapter PTS/DTS/offset at discont and discont tracking
- New video orientation interface
- appsrc duration in time and try pull API
- gst-libav uses ffmpeg 3.1

## Build and Dependencies

### Experimental meson-based build system

- FILL ME

## Platform-specific improvements

### Android

#### New universal binaries for all supported ABIs

We now provide a "universal" tarball to allow building apps against all the
architectures currently supported (x86, x86-64, armeabi, armeabi-v7a,
armeabi-v8a). This is needed for building with recent versions of the Android
NDK which defaults to building against all supported ABIs. Use [the Android
player example][android-player-example-build] as a reference of the required
changes.

[android-player-example-build]: https://cgit.freedesktop.org/gstreamer/gst-examples/commit/playback/player/android?id=a5cdde9119f038a1eb365aca20faa9741a38e788

#### Miscellaneous

- FILL ME

### OS/X and iOS

- We now support querying available devices on OS/X via the GstDeviceProvider
  API.

- FILL ME

### Windows

- FILL ME

## Contributors

- FILL ME

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing.

## Bugs fixed in 1.10

More than [~9000 bugs][bugs-fixed-in-1.10] have been fixed during
the development of 1.10.

This list does not include issues that have been cherry-picked into the
stable 1.8 branch and fixed there as well, all fixes that ended up in the
1.8 branch are also included in 1.10.

This list also does not include issues that have been fixed without a bug
report in bugzilla, so the actual number of fixes is much higher.

[bugs-fixed-in-1.10]: https://bugzilla.gnome.org/buglist.cgi?bug_status=RESOLVED&bug_status=VERIFIED&classification=Platform&limit=0&list_id=107311&order=bug_id&product=GStreamer&query_format=advanced&resolution=FIXED&target_milestone=1.6.1&target_milestone=1.6.2&target_milestone=1.9.1&target_milestone=1.9.2&target_milestone=1.9.3&target_milestone=1.9.4&target_milestone=1.9.5&target_milestone=1.9.90&target_milestone=1.9.91&target_milestone=1.9.92&target_milestone=1.9.93&target_milestone=1.10.0

## Stable 1.10 branch

After the 1.10.0 release there will be several 1.10.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.10.x bug-fix releases will be made from the git 1.10 branch, which
is a stable branch.

### 1.10.0

1.10.0 was released on TBD 2016.

## Known Issues

- FILL ME

## Schedule for 1.12

Our next major feature release will be 1.12, and 1.11 will be the unstable
development version leading up to the stable 1.12 release. The development
of 1.11/1.12 will happen in the git master branch.

The plan for the 1.12 development cycle is yet to be confirmed, but it is
expected that feature freeze will be around TBD,
followed by several 1.11 pre-releases and the new 1.12 stable release
in September.

1.12 will be backwards-compatible to the stable 1.10, 1.8, 1.6, 1.4, 1.2 and
1.0 release series.

- - -

*These release notes have been prepared by Sebastian Dröge, Arun Raghavan,
Tim-Philipp Müller, ....*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
