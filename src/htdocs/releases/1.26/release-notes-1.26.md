# GStreamer 1.26 Release Notes

GStreamer 1.26.0 has not been released yet. It will be released in early 2025.

The latest development release towards the upcoming 1.26 stable series is 1.25.1 and was released on 14 January 2025.

<!--

See [https://gstreamer.freedesktop.org/releases/1.26/][latest] for the latest version of this document.

*Last updated: Tuesday 14 January 2025, 00:00 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.26/
[gitlog]: https://gitlab.freedesktop.org/gstreamer/www/commits/main/src/htdocs/releases/1.26/release-notes-1.26.md

-->
 
<a id="introduction"></a>
## Introduction

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with many new features, bug fixes and other improvements.

<a id="highlights"></a>
## Highlights

- to be filled in
- Lots of new plugins, features, performance improvements and bug fixes

<a id="major-changes"></a>
## Major new features and changes

- to be filled in

<a id="new-plugins"></a>
## New elements and plugins

- to be filled in

<a id="new-element-features"></a>
## New element features and additions

- to be filled in

<a id="plugin-library-moves"></a>
## Plugin and library moves

- to be filled in

<a id="plugin-element-removals"></a>
## Plugin and element removals

- to be filled in

<a id="new-api"></a>
## Miscellaneous API additions

### GStreamer Core

- to be filled in

### Other libs

- to be filled in

<a id="optimisations"></a>
## Miscellaneous performance, latency and memory optimisations

- to be filled in

- As always there have been plenty of performance, latency and memory optimisations
  all over the place.

<!--

## Miscellaneous other changes and enhancements

- Nothing that hasn't been mentioned elsewhere already.

-->

<a id="tracing"></a>
## Tracing framework and debugging improvements

- to be filled in

### New tracers

- None in this release.

### Debug logging system improvements

- Nothing major in this cycle.

<a id="tools"></a>
## Tools

- to be filled in

<a id="ffmpeg"></a>
## GStreamer FFmpeg wrapper

- to be filled in

<a id="rtsp"></a>
## GStreamer RTSP server

- to be filled in

<a id="vaapi"></a>
## GStreamer VA-API support

### GstVA

- to be filled in

### GStreamer-VAAPI

- The new GstVA elements (see above) should be preferred when possible.

- **gstreamer-vaapi should be considered deprecated** and may be
  discontinued as soon as the `va` plugin is fully feature equivalent.
  Users who rely on gstreamer-vaapi are encouraged to migrate and
  test the `va` elements at the earliest opportunity.

<a id="v4l2"></a>
## GStreamer Video4Linux2 support

- to be filled in

<a id="ges"></a>
## GStreamer Editing Services and NLE

- to be filled in

<a id="validate"></a>
## GStreamer validate

- to be filled in

<a id="python"></a>
## GStreamer Python Bindings

gst-python is an extension of the regular GStreamer Python bindings based on
gobject-introspection information and PyGObject, and provides "syntactic sugar"
in form of overrides for various GStreamer APIs that makes them easier to use
in Python and more pythonic; as well as support for APIs that aren't available
through the regular gobject-introspection based bindings, such as e.g.
GStreamer's fundamental GLib types such as `Gst.Fraction`, `Gst.IntRange` etc.

- to be filled in

<a id="csharp"></a>
## GStreamer C# Bindings

- to be filled in
  
- GStreamer API added in recent GStreamer releases is now available

<a id="rust"></a>
## GStreamer Rust Bindings and Rust Plugins

The GStreamer Rust bindings and plugins are released separately with a different release
cadence that's tied to the twice-a-year GNOME release cycle.

The latest release of the bindings (0.23) has already been updated for the new GStreamer 1.26 APIs, and works with any GStreamer version starting at 1.14.

`gst-plugins-rs`, the module containing GStreamer plugins written in Rust,
has also seen lots of activity with many new elements and plugins. The GStreamer 1.26 binaries track the 0.13 release series of `gst-plugins-rs`, and fixes from newer versions will be backported as needed to the 0.13 brach for future 1.26.x bugfix releases.

Rust plugins can be used from any programming language. To applications
they look just like a plugin written in C or C++.

<a id="rust-webrtc"></a>
### WebRTC

- to be filled in


<a id="rust-other-elements"></a>
### Other new Rust elements

- to be filled in

<a id="rust-other-improvements"></a>
### Other improvements

- to be filled in

For a full list of changes in the Rust plugins see the
[gst-plugins-rs ChangeLog][rs-changelog] between versions 0.12 (shipped with GStreamer 1.24) and 0.13 (shipped with GStreamer 1.26).

[rs-changelog]: https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/main/CHANGELOG.md

<a id="build-and-deps"></a>
## Build and Dependencies

- Meson >= 1.3 is now required for all modules

- The GLib requirement has been bumped to >= 2.64

- liborc >= 0.4.40 is strongly recommended

- libnice >= 0.1.22 is strongly recommended, as it is required
  for WebRTC **ICE consent freshness** (RFC 7675).

### Monorepo build (née gst-build)

- to be filled in

- The FFmpeg subproject wrap was udpated to 7.1

### gstreamer-full

- to be filled in

### Development environment

- to be filled in

<a id="cerbero"></a>
### Cerbero

Cerbero is a meta build system used to build GStreamer plus dependencies
on platforms where dependencies are not readily available, such as Windows,
Android, iOS, and macOS.

#### General improvements

- to be filled in

#### macOS

- to be filled in

#### iOS

- to be filled in

#### Windows

- to be filled in

#### Linux

- to be filled in

#### Android

- to be filled in

<a id="platform-specific"></a>
## Platform-specific changes and improvements

<a id="android"></a>
### Android

- to be filled in

<a id="apple"></a>
### Apple macOS and iOS

- to be filled in

<a id="windows"></a>
### Windows

- to be filled in

<!--

<a id="linux"></a>
### Linux

- Many improvements which are described in other sections.

-->

<a id="docs"></a>
## Documentation improvements

- to be filled in

<!--

<a id="breaking-changes"></a>
## Possibly Breaking Changes

- to be filled in

<a id="known-issues"></a>
## Known Issues

- None yet

<a id="statistics"></a>
## Statistics

- FIXME

-->

<a id="contributors"></a>

## Contributors

- to be filled in

... and many others who have contributed bug reports, translations,
sent suggestions or helped testing. Thank you all!

## Stable 1.26 branch

After the 1.26.0 release there will be several 1.26.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.26.x bug-fix releases will be made from the git 1.26 branch,
which will be a stable branch.

## Schedule for 1.28

Our next major feature release will be 1.28, and 1.27 will be the unstable
development version leading up to the stable 1.28 release. The development
of 1.27/1.28 will happen in the git `main` branch of the GStreamer mono
repository.

The schedule for 1.28 is yet to be decided.

1.28 will be backwards-compatible to the stable 1.26, 1.24, 1.22, 1.20, 1.18, 1.16, 1.14, 1.12, 1.10, 1.8, 1.6, 1.4, 1.2 and 1.0 release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller with contributions from ....*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*