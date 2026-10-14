---
title: "GStreamer VAAPI is now part of upstream GStreamer"
date: 2016-02-10T15:00:00Z
---

The GStreamer-VAAPI module which provides support for hardware-accelerated
video decoding, encoding and post-processing on Intel (and other) graphics hardware
on Linux has moved from its previous home at the Intel Open Source Technology Center (01.org)
to the upstream GStreamer repositories, where it will in future be maintained
as part of the upstream GStreamer project and released in lockstep with the
other GStreamer modules.

The current maintainers will continue to spearhead the development at the new location:\
\
[https://cgit.freedesktop.org/gstreamer/gstreamer-vaapi/](https://cgit.freedesktop.org/gstreamer/gstreamer-vaapi/)

GStreamer-VAAPI relies heavily on certain GStreamer infrastructure API that
is still in flux such as the OpenGL integration API or the codec parser
libraries, and one of the goals of the move was to be able to leverage
new developments early and provide tighter integration with the latest
developments of those APIs and other graphics-related APIs provided by
GStreamer, which should hopefully improve performance even further and in
some cases might also provide better stability.

Thanks to everyone involved in making this move happen!

*New Versioning scheme and Supported GStreamer Versions*

The version numbering has been changed to match the GStreamer version
numbering to avoid confusion: there is a new gstreamer-vaapi 1.6.0 release
and a 1.6 branch that is roughly equivalent to the previous 0.7.0 version.
Future releases 1.7.x and 1.8.x will be made alongside GStreamer releases.

Whilst it was possible and supported by previous releases to build against
a whole range of different GStreamer versions (such as 1.2, 1.4, 1.6 or 1.7/1.8),
in future there will only be one target branch, so that git master will
track GStreamer git master, 1.8.x will target GStreamer 1.8, and
1.6.x is targetting the 1.6 series.

*Miscellaneous Changes*

All GStreamer-VAAPI functionality is now provided solely by its GStreamer
elements. There is no more public library exposing GstVaapi API, this API
was only ever meant for private use by the elements. Parts of it may be
resurrected again in future if needed, but for now it has all been made
private.

GStreamer-VAAPI now unconditionally uses the codecparser library in
gst-plugins-bad instead of shipping its own internal copy. Similarly,
it no longer ships its own codec parsers but relies on the upstream
codec parser elements.

The GStreamer-VAAPI encoder elements have been renamed from vaapiencode_foo
to vaapifooenc, so encoders are now called vaapih264enc, vaapih265enc,
vaapimpeg2enc, vaapijpegenc, and vaapivp8enc.

*Bug Tracking*

Bugs had already been tracked on [GNOME bugzilla](http://bugzilla.gnome.og)
but will be moved from the gstreamer-vaapi product into a new gstreamer-vaapi
component of the GStreamer product in bugzilla. Please file new bugs against
the new component in the GStreamer product from now on.

*Pending Patches*

The code base has been re-indented to the GStreamer code style, which
affected some files more than others. This means that some of the patches
in bugzilla might not apply any longer, so if you have any unmerged patches
sitting in bugzilla please consider checking if they still apply cleany and
refresh them if not. Sorry for any inconvenience this may cause.

*More Information*

Also see [Víctor's blog post](http://blogs.igalia.com/vjaquez/2016/02/09/gstreamer-va-api-under-the-umbrella-of-gstreamer/).
