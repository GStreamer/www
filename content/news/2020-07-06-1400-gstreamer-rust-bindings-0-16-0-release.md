---
title: "GStreamer Rust bindings 0.16.0 release"
date: 2020-07-06T14:00:00Z
---

A new version of the GStreamer Rust bindings, 0.16.0, was released.

As usual this release follows the latest [gtk-rs](https://gtk-rs.org/blog/2020/07/04/new-release.html)
release.

This is the first version that includes optional support for new GStreamer
1.18 APIs. As GStreamer 1.18 was not released yet, these new APIs might
still change. The minimum supported version of the bindings is still
GStreamer 1.8 and the targetted GStreamer API version can be selected by
applications via feature flags.

Apart from this, new version features mostly features API cleanup and the
addition of a
few missing APIs. The focus of this release was to make usage of GStreamer
from Rust as convenient and complete as possible.

The new release also brings a lot of bugfixes, most of which were
already part of the 0.15.x bugfix releases.

A new release of the [GStreamer Rust plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs) will follow in the next days.

Details can be found in the release notes for [gstreamer-rs](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/-/blob/f40821ba662e6ba29ddb72915ea30ee4191da3ea/gstreamer/CHANGELOG.md#0160-2020-07-06)
and [gstreamer-rs-sys](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs-sys/-/blob/92a1771db0bcfa8a8d17824b757432c97b9f9b32/gstreamer-sys/CHANGELOG.md#090-2020-07-05).

The code and documentation for the bindings is available on the freedesktop.org GitLab

- [GStreamer Rust Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) ([documentation](https://gstreamer.pages.freedesktop.org/gstreamer-rs/gstreamer/))
- [GStreamer Rust FFI Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs-sys) ([documentation](https://gstreamer.pages.freedesktop.org/gstreamer-rs/gstreamer_sys/))

as well as on [crates.io](https://crates.io).

If you find any bugs, notice any missing features or other issues please
report them in
[GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/issues/new).
