---
title: "GStreamer Rust bindings 0.19 / Rust Plugins 0.9 release"
date: 2022-10-24T18:00:00Z
---

Version 0.19 of the [GStreamer Rust bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) was released.
Together with the bindings, also version 0.9 of the [GStreamer Rust plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs) was released.

As usual this release follows the latest [gtk-rs 0.16 release](https://gtk-rs.org/blog/2022/10/18/new-release.html) and the corresponding API changes.

This release includes optional support for the latest new GStreamer
1.22 APIs. As GStreamer 1.22 was not released yet, these new APIs might
still change. The minimum supported version of the bindings was updated to
GStreamer 1.14 and the targetted GStreamer API version can be selected by
applications/plugins via feature flags.

Apart from this, the new version features a lot of API cleanup and
improvements, and the addition of a few missing bindings. Like in the past,
the focus of this release was to make usage of GStreamer from Rust as
convenient and complete as possible.

The new release also brings a lot of bugfixes, most of which were
already part of the 0.18.x bugfix releases.

Details can be found in the release notes for [gstreamer-rs](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/-/blob/main/gstreamer/CHANGELOG.md#0190-2022-10-22).

The code and documentation for the bindings is available on the freedesktop.org GitLab

- [GStreamer Rust Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) ([documentation](https://gstreamer.pages.freedesktop.org/gstreamer-rs/stable/0.19/docs/))

as well as on [crates.io](https://crates.io).

The new 0.9 version of the GStreamer Rust plugins features many improvements to the existing plugins as well as many new plugins.
The full list of available plugins can be seen in the repository's [README.md](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/0.9/README.md).

If you find any bugs, notice any missing features or other issues please
report them in GitLab for the [bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/issues/new)
or the [plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/issues/new).
