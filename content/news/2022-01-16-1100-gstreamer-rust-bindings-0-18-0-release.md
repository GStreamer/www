---
title: "GStreamer Rust bindings 0.18.0 release"
date: 2022-01-16T11:00:00Z
---

A new version of the [GStreamer Rust bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs), 0.18.0, was released.
Together with the bindings, also a new version of the [GStreamer Rust plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs) was released.

As usual this release follows the latest [gtk-rs 0.15 release](https://gtk-rs.org/blog/2022/01/16/new-release.html) and the corresponding API changes.

This release includes optional support for the latest new GStreamer
1.20 APIs. As GStreamer 1.20 was not released yet, these new APIs might
still change. The minimum supported version of the bindings is still
GStreamer 1.8 and the targetted GStreamer API version can be selected by
applications via feature flags.

Apart from this, the new version features a lot of API cleanup and
improvements, and the addition of a few missing bindings. As
usual, the focus of this release was to make usage of GStreamer from Rust as
convenient and complete as possible.

The new release also brings a lot of bugfixes, most of which were
already part of the 0.17.x bugfix releases.

Details can be found in the release notes for [gstreamer-rs](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/-/blob/0.18.0/gstreamer/CHANGELOG.md#0180-2022-01-16).

The code and documentation for the bindings is available on the freedesktop.org GitLab

- [GStreamer Rust Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) ([documentation](https://gstreamer.pages.freedesktop.org/gstreamer-rs/stable/0.18/docs/))

as well as on [crates.io](https://crates.io).

If you find any bugs, notice any missing features or other issues please
report them in
[GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/issues/new).
