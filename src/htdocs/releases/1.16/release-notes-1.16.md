# GStreamer 1.16 Release Notes

GStreamer 1.16 has not been released yet. It is scheduled for release
around September 2018.

1.15.0.1 is the unstable development version that is being developed
in the git master branch and which will eventually result in 1.16.

The plan for the 1.16 development cycle is yet to be confirmed, but it is
expected that feature freeze will be around August 2017
followed by several 1.15 pre-releases and the new 1.16 stable release
in September.

1.16 will be backwards-compatible to the stable 1.14, 1.12, 1.10, 1.8, 1.6,
1.4, 1.2 and 1.0 release series.

See [https://gstreamer.freedesktop.org/releases/1.16/][latest] for the latest
version of this document.

*Last updated: Tuesday 20 March 2018, 01:30 UTC [(log)][gitlog]*

[latest]: https://gstreamer.freedesktop.org/releases/1.16/
[gitlog]: https://cgit.freedesktop.org/gstreamer/www/log/src/htdocs/releases/1.16/release-notes-1.16.md

## Introduction

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other
improvements.

## Highlights

- this section will be completed in due course

## Major new features and changes

### Noteworthy new API

- this section will be filled in in due course

### New Elements

- this section will be filled in in due course

### New element features and additions

- this section will be filled in in due course

### Plugin and library moves

- this section will be filled in in due course

### Plugin removals

- this section will be filled in in due course


## Miscellaneous API additions

- this section will be filled in in due course

### GstPlayer

- this section will be filled in in due course

## Miscellaneous changes

- this section will be filled in in due course

### OpenGL integration

- this section will be filled in in due course

## Tracing framework and debugging improvements

- this section will be filled in in due course

## Tools

- this section will be filled in in due course

## GStreamer RTSP server

- this section will be filled in in due course

## GStreamer VAAPI

- this section will be filled in in due course

## GStreamer Editing Services and NLE

- this section will be filled in in due course

## GStreamer validate

- this section will be filled in in due course

## GStreamer Python Bindings

- this section will be filled in in due course

## Build and Dependencies

- this section will be filled in in due course

## Platform-specific changes and improvements

### Android

- this section will be filled in in due course

- The way that GIO modules are named has changed due to upstream GLib natively
  adding support for loading static GIO modules. This means that any GStreamer
  application using gnutls for SSL/TLS on the Android or iOS platforms (or any
  other setup using static libraries) will fail to link looking for the
  `g_io_module_gnutls_load_static()` function. The new function name is now
  `g_io_gnutls_load(gpointer data)`. data can be NULL for a static library.
  Look at [this commit][gio-gnutls-static-link-example] for the necessary
  change in the examples.

### macOS and iOS

- this section will be filled in in due course

- The way that GIO modules are named has changed due to upstream GLib natively
  adding support for loading static GIO modules. This means that any GStreamer
  application using gnutls for SSL/TLS on the Android or iOS platforms (or any
  other setup using static libraries) will fail to link looking for the
  `g_io_module_gnutls_load_static()` function. The new function name is now
  `g_io_gnutls_load(gpointer data)`. data can be NULL for a static library.
  Look at [this commit][gio-gnutls-static-link-example] for the necessary
  change in the examples.

[gio-gnutls-static-link-example]: insert gst-examples/tutorial commit (FIXME)

### Windows

- this section will be filled in in due course

## Contributors

- this section will be filled in in due course

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing.

## Bugs fixed in 1.16

- this section will be filled in in due course

More than [XXX bugs][bugs-fixed-in-1.16] have been fixed during
the development of 1.16.

This list does not include issues that have been cherry-picked into the
stable 1.16 branch and fixed there as well, all fixes that ended up in the
1.16 branch are also included in 1.16.

This list also does not include issues that have been fixed without a bug
report in bugzilla, so the actual number of fixes is much higher.

[bugs-fixed-in-1.16]: https://bugzilla.gnome.org/buglist.cgi?bug_status=RESOLVED&bug_status=VERIFIED&classification=Platform&limit=0&list_id=213265&order=bug_id&product=GStreamer&query_format=advanced&resolution=FIXED&target_milestone=1.14.1&target_milestone=1.14.2&target_milestone=1.12.3&target_milestone=1.14.4&target_milestone=1.15.1&target_milestone=1.15.2&target_milestone=1.15.3&target_milestone=1.15.4&target_milestone=1.15.90&target_milestone=1.15.91&target_milestone=1.16.0

## Stable 1.16 branch

After the 1.16.0 release there will be several 1.16.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.16.x bug-fix releases will be made from the git 1.16 branch,
which is a stable branch.

### 1.16.0

1.16.0 is scheduled to be released around September/October 2018.

## Known Issues

- The `webrtcdsp` element is currently not shipped as part of the Windows
  binary packages due to a [build system issue][bug-770264].

[bug-770264]: https://bugzilla.gnome.org/show_bug.cgi?id=770264

## Schedule for 1.18

Our next major feature release will be 1.18, and 1.17 will be the unstable
development version leading up to the stable 1.18 release. The development
of 1.17/1.18 will happen in the git master branch.

The plan for the 1.18 development cycle is yet to be confirmed, but it is
expected that feature freeze will be around February 2019
followed by several 1.17 pre-releases and the new 1.18 stable release
in March/April.

1.18 will be backwards-compatible to the stable 1.16, 1.14, 1.12, 1.10, 1.8,
1.6, 1.4, 1.2 and 1.0 release series.

- - -

*These release notes have been prepared by Tim-Philipp Müller.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
