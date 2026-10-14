---
title: "GStreamer Rust bindings 0.23 / Rust Plugins 0.13 release"
date: 2024-07-17T13:00:00Z
---

Version 0.23 of the [GStreamer Rust bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) was released,
together with version 0.13 of the [GStreamer Rust plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs).

As usual this release follows the latest [gtk-rs 0.20 release](https://gtk-rs.org/blog/2024/07/17/new-release.html) and the corresponding API changes.

This release features relatively few changes and mostly contains the
addition of some convenience APIs, the addition of bindings for some minor
APIs, addition of bindings for new GStreamer 1.26 APIs, and various optimizations.

The new release also brings a lot of bugfixes, most of which were
already part of the bugfix releases of the previous release series.

Details can be found in the release notes for [gstreamer-rs](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/-/blob/main/gstreamer/CHANGELOG.md#0230---2024-07-11).

The code and documentation for the bindings is available on the freedesktop.org GitLab

- [GStreamer Rust Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) ([documentation](https://gstreamer.pages.freedesktop.org/gstreamer-rs/stable/0.23/docs/gstreamer))

as well as on [crates.io](https://crates.io).

The new 0.13 version of the GStreamer Rust plugins features many
improvements to the existing plugins as well as various new plugins. A
majority of the changes were already backported to the 0.12 release series
and its bugfix releases, which is part of the GStreamer 1.24 binaries.

A full list of available plugins can be seen in the repository's [README.md](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/0.13/README.md).

Details for this release can be found in the release notes for [gst-plugins-rs](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/main/CHANGELOG.md#0130---2024-07-16).

If you find any bugs, notice any missing features or other issues please
report them in GitLab for the [bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/issues/new)
or the [plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/issues/new).
