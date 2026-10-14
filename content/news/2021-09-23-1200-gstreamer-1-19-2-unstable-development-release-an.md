---
title: "GStreamer 1.19.2 unstable development release and git monorepo transition"
date: 2021-09-23T12:00:00Z
version: "1.19.2"
tags: [release]
---

**GStreamer 1.19.2 unstable development release**

The GStreamer team is pleased to announce the second development release in
the unstable 1.19 release series.

The unstable 1.19 release series adds new features on top of the current
stable 1.18 series and is part of the API and ABI-stable 1.x release series
of the GStreamer multimedia framework.

The unstable 1.19 release series is for testing and development purposes in
the lead-up to the stable 1.20 series which is scheduled for release in a
few weeks time. Any newly-added API can still change until that point, although
it is rare for that to happen.

Full release notes will be provided in the near future, highlighting all the
new features, bugfixes, performance optimizations and other important changes.

This development release is primarily for distributors and early
adaptors and anyone who still needs to update their build/packaging
setup for Meson.

Packagers: please note that plugins may have moved between modules, so please
take extra care and make sure inter-module version dependencies are such that
users can only upgrade all modules in one go, instead of seeing a mix of 1.19
and 1.18 on their system. Also, gst-plugins-good 1.19.2 depends on 1.19.2
gst-plugins-base (even if the meson dependency check claims otherwise).

Binaries for Android, iOS, Mac OS X and Windows will also be available shortly at the
[usual location](https://gstreamer.freedesktop.org/pkg/).

Release tarballs can be downloaded directly here:

- [gstreamer-1.19.2.tar.xz](/src/gstreamer/gstreamer-1.19.2.tar.xz)
- [gst-plugins-base-1.19.2.tar.xz](/src/gst-plugins-base/gst-plugins-base-1.19.2.tar.xz)
- [gst-plugins-good-1.19.2.tar.xz](/src/gst-plugins-good/gst-plugins-good-1.19.2.tar.xz)
- [gst-plugins-ugly-1.19.2.tar.xz](/src/gst-plugins-ugly/gst-plugins-ugly-1.19.2.tar.xz)
- [gst-plugins-bad-1.19.2.tar.xz](/src/gst-plugins-bad/gst-plugins-bad-1.19.2.tar.xz)
- [gst-libav-1.19.2.tar.xz](/src/gst-libav/gst-libav-1.19.2.tar.xz)
- [gst-rtsp-server-1.19.2.tar.xz](/src/gst-rtsp-server/gst-rtsp-server-1.19.2.tar.xz)
- [gst-python-1.19.2.tar.xz](/src/gst-python/gst-python-1.19.2.tar.xz)
- [gst-editing-services-1.19.2.tar.xz](/src/gst-editing-services/gst-editing-services-1.19.2.tar.xz)
- [gst-devtools-1.19.2.tar.xz](/src/gst-devtools/gst-devtools-1.19.2.tar.xz),
- [gstreamer-vaapi-1.19.2.tar.xz](/src/gstreamer-vaapi/gstreamer-vaapi-1.19.2.tar.xz)
- [gst-omx-1.19.2.tar.xz](/src/gst-omx/gst-omx-1.19.2.tar.xz)
- [gstreamer-docs-1.19.2.tar.xz](/src/gstreamer-docs/gstreamer-docs-1.19.2.tar.xz)

As always, please let us know of any issues you run into by filing an
issue in [Gitlab](https://gitlab.freedesktop.org/gstreamer).

**Git monorepo transition**

Following the 1.19.2 release all git `master` branches in git are now
frozen and will stay frozen. as we embark on some infrastructure
plumbing that will see many of our git modules merged into a mono
repository, which should massively streamline and improve our developer
experience.

Expect a few days of disruptions, but we'll do our best to get the show
back on the road as quickly as possible!

We'll let you know when it's all done and will post more details and
migration instructions once everything's in place.

When we emerge on the other side there will be a shiny new `main` branch
in the GStreamer repository and development will continue there.

Nothing will happen to the existing stable branches and repositories,
and the existing master branches will also stay in place for the time
being, but will no longer be updated.

There will still be separate release tarballs for the various modules.

More details soon, stay tuned.
