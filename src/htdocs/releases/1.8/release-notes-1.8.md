# GStreamer 1.8 Release Notes

**NOTE: THESE RELEASE NOTES ARE VERY INCOMPLETE AND STILL WORK-IN-PROGRESS**

**GStreamer 1.8 is scheduled for release in early February 2016.**

The GStreamer team is proud to announce a new major feature release in the
stable 1.x API series of your favourite cross-platform multimedia framework!

As always, this release is again packed with new features, bug fixes and other
improvements.

See
[http://gstreamer.freedesktop.org/releases/1.8/](http://gstreamer.freedesktop.org/releases/1.8/)
for the latest version of this document.

*Last updated: Thursday 24 December 2015, 11:00 UTC [(log)](http://cgit.freedesktop.org/gstreamer/www/log/src/htdocs/releases/1.8/release-notes-1.8.md)*

## Highlights

- FILL ME

## Major new features and changes

### Adaptive streaming: DASH, HLS and MSS improvements

FIXME

- loading of external periods/adaptationsets/etc.?

### Noteworthy new API, features and other changes

-

### Noteworthy element features and additions

FIXME

### GStreamer OpenGL support improvements

FIXME

### GStreamer Editing Services

FIXME

### GstValidate

FIXME


### cerbero build tool for SDK binary packages

FIXME

cerbero is a custom build too that builds GStreamer plus dependencies on
non-Linux operating systems such as Windows, OS/X, iOS and Android, and
produces SDK binary packages for those systems. This is needed because
GStreamer depends on a large number of external libraries, all of which in
turn have dependencies of their own. These dependent libraries are usually
not present or available on non-unix operating systems, so everything GStreamer
needs has to be pretty much built from scratch so that it can be used on on
those systems.

FIXME

## Miscellaneous

FIXME

## Platform-specific improvements

### Android

- the OpenGL-based QML video sink can now also be used on Android

### OS/X and iOS

FIXME

### Windows

FIXME

### Linux

FIXME

## Contributors

FIXME

... and many others who have contributed bug reports, translations, sent
suggestions or helped testing.

## Bugs fixed in 1.8

More than [~9999 bugs FIXME)](https://bugzilla.gnome.org/buglist.cgi?bug_status=RESOLVED&bug_status=VERIFIED&classification=Platform&limit=0&order=bug_id&product=GStreamer&query_format=advanced&resolution=FIXED&target_milestone=1.7.1&target_milestone=1.7.2&target_milestone=1.7.3&target_milestone=1.7.4&target_milestone=1.7.90&target_milestone=1.7.91&target_milestone=1.7.92&target_milestone=1.7.x&target_milestone=1.8.0)
 have been fixed during the development of 1.8.

This list does not include issues that have been cherry-picked into the
stable 1.6 branch and fixed there as well, all fixes that ended up in the
1.6 branch are also included in 1.8.

This list also does not include issues that have been fixed without a bug
report in bugzilla, so the actual number of fixes is much higher.

## Stable 1.8 branch

After the 1.8.0 release there will be several 1.8.x bug-fix releases which
will contain bug fixes which have been deemed suitable for a stable branch,
but no new features or intrusive changes will be added to a bug-fix release
usually. The 1.8.x bug-fix releases will be made from the git 1.8 branch, which
is a stable branch.

### 1.8.0

1.8.0 was released on XX February 2016. (FIXME)

### 1.8.1

The first 1.8 bug-fix release (1.8.1) is planned for FIXME 2016.

## Schedule for 1.10

Our next major feature release will be 1.10, and 1.9 will be the unstable
development version leading up to the stable 1.10 release. The development
of 1.9/1.10 will happen in the git master branch.

The plan for the 1.10 development cycle is to get a first 1.9 development
release out by June 2016 and have our first 1.10 release candidate ready
in July 2016, so that we can release 1.10 in August 2016.

1.10 will be backwards-compatible to the stable 1.8, 1.6, 1.4, 1.2 and 1.0
release series.

- - -

*These release notes have been prepared by Sebastian Dröge and
Tim-Philipp Müller with contributions from FIXME.*

*License: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)*
