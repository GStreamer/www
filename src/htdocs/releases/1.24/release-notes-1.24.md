# GStreamer 1.24 Release Notes

GStreamer 1.24 has not been released yet. It is scheduled for release ASAP.

GStreamer 1.23.90 is the first release candidate (rc1) for 1.24.

1.24 will be backwards-compatible to the stable 1.22, 1.20, 1.18, 1.16, 1.14,
1.12, 1.10, 1.8, 1.6,, 1.4, 1.2 and 1.0 release series.

See [https://gstreamer.freedesktop.org/releases/1.24/][latest] for the latest version of this document.

*Last updated: Friday 23 February 2024, 13:00 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.24/
[gitlog]: https://gitlab.freedesktop.org/gstreamer/www/commits/main/src/htdocs/releases/1.24/release-notes-1.24.md

## Introduction

The GStreamer team is proud to announce a new major feature release in the stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with many new features, bug fixes and other improvements.

## Highlights

- This section will be completed in due course

## Major new features and changes

- This section will be completed in due course

## New elements and plugins

- This section will be completed in due course

## New element features and additions

- This section will be completed in due course

## Plugin and library moves

- This section will be completed in due course

## Plugin removals

- This section will be completed in due course

## Miscellaneous API additions

- This section will be completed in due course

## Miscellaneous performance, latency and memory optimisations

- This section will be completed in due course

- liborc 0.4.35 (latest: 0.4.37) adds support for AVX/AVX2 and contains improvements for the SSE backend.

- as always there have been plenty of performance, latency and memory optimisations all over the place.

## Miscellaneous other changes and enhancements

- This section will be completed in due course

## Tracing framework and debugging improvements

### New tracers

- This section will be completed in due course

### Debug logging system improvements

- This section will be completed in due course

## Tools

- This section will be completed in due course

## GStreamer FFMPEG wrapper

- This section will be completed in due course

## GStreamer RTSP server

- This section will be completed in due course

## GStreamer VA-API support

- This section will be completed in due course

## GStreamer Video4Linux2 support

- This section will be completed in due course

## GStreamer OMX

- The gst-omx module has been removed. The OpenMAX standard is long dead and
  even the Raspberry Pi OS no longer supports it. There has not been any
  development since 1.22 was released. Users of these elements should switch
  to the Video4Linux-based video encoders and decoders which have been the
  standard on embedded Linux for quite some time now.

## GStreamer Editing Services and NLE

- This section will be completed in due course

## GStreamer validate

- This section will be completed in due course

## GStreamer Python Bindings

- This section will be completed in due course

## GStreamer C# Bindings

- This section will be completed in due course

## GStreamer Rust Bindings and Rust Plugins

The GStreamer Rust bindings are released separately with a different release
cadence that's tied to `gtk-rs`, but the latest release has already been
updated for the new GStreamer 1.24 API.

`gst-plugins-rs`, the module containing GStreamer plugins written in Rust, has also seen lots of activity with many new elements and plugins

- Rust plugins can be used from any programming language. To the outside they look just like a plugin written in C or C++.

## New Rust plugins and elements

- This section will be completed in due course

## Cerbero Rust support

- This section will be completed in due course

## Build and Dependencies

- This section will be completed in due course

### Monorepo build (neé gst-build)

- This section will be completed in due course

### Cerbero

Cerbero is a meta build system used to build GStreamer plus dependencies on platforms where dependencies are not readily available, such as Windows, Android, iOS, and macOS.

#### General improvements

- This section will be completed in due course

#### macOS / iOS

- This section will be completed in due course

#### Windows

- This section will be completed in due course

#### Linux

- This section will be completed in due course

#### Android

- This section will be completed in due course

## Platform-specific changes and improvements

### Android

- This section will be completed in due course

### Apple macOS and iOS

- This section will be completed in due course

### Windows

- This section will be completed in due course

### Linux

- This section will be completed in due course

## Documentation improvements

- This section will be completed in due course

## Possibly Breaking Changes

- This section will be completed in due course

## Known Issues

- This section will be completed in due course

## Statistics

- This section will be completed in due course

## Contributors

- This section will be completed in due course

## Stable 1.24 branch

After the 1.24.0 release there will be several 1.24.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.24.x bug-fix releases will be made from the git 1.24 branch,
which will be a stable branch.

<a id="1.24.0"></a>

### 1.24.0

1.24.0 has not yet been released.

## Schedule for 1.26

Our next major feature release will be 1.26, and 1.25 will be the unstable
development version leading up to the stable 1.26 release. The development
of 1.25/1.25 will happen in the git `main` branch of the GStreamer mono
repository.

The schedule for 1.26 is yet to be confirmed. We're still busy getting 1.24 out!

1.26 will be backwards-compatible to the stable 1.24, 1.22, 1.20, 1.18, 1.16, 1.14, 1.12, 1.10, 1.8, 1.6, 1.4, 1.2 and 1.0 release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
