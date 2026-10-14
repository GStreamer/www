---
title: "GStreamer 0.10 no longer maintained"
date: 2013-03-15T10:00:00Z
---

Since this has never been announced officially outside of the conference
circuit, the GStreamer team would like to
[clarify](http://lists.freedesktop.org/archives/gstreamer-announce/2013-March/000273.html)
that GStreamer 0.10 is no longer maintained. Not by us, nor by anyone else.
There will be no more GStreamer 0.10 releases, not even bug-fix releases.
Bugs will not be investigated unless they also apply to GStreamer 1.x.
Patches will only be reviewed and pushed if they apply to one of the
current 1.x branches or fix an issue that still pertains to 1.x.
Bug fixes have not been backported systematically to 0.10 for a very long
time now, and there are many hundreds of bugs that have only been fixed
in 1.x, and manymore are fixed every week. Any commits to the 0.10 branch
are made purely on an ad-hoc basis now, and we may lock down the branch
completely. No more features will be added to 0.10. However, GStreamer 0.10
support is of course still available on a commercial basis from the usual
suspects.

We realise and regret that this may cause some inconvenience, and we
also understand that there are circumstances where there are valid
reasons not to migrate to 1.0 at this time, or in some cases ever, but
we would also like to dispel any doubt whatsoever that there is any
other way. We have neither the resources, nor the will or the energy to
maintain more than one major version. We must use the little resources
we have on code that has a future.

We are happy to provide help and advice to anyone migrating to 1.0. If
there are plugins that haven't been ported yet that you need, let us
know, maybe we can help get them ported.

Thanks for your understanding.

Happy hacking, see you on the other side!

\- Your GStreamer maintainers and release managers
