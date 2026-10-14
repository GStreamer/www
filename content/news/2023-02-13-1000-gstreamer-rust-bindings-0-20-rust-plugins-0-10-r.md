---
title: "GStreamer Rust bindings 0.20 / Rust Plugins 0.10 release"
date: 2023-02-13T10:00:00Z
---

Version 0.20 of the [GStreamer Rust bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) was released.
Together with the bindings, also version 0.10 of the [GStreamer Rust plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs) was released.

As usual this release follows the latest [gtk-rs 0.17 release](https://gtk-rs.org/blog/2023/02/10/new-release.html) and the corresponding API changes.

This release features relatively few changes and mostly contains the
addition of some convenience APIs, the addition of bindings for some minor
APIs and various optimizations.

As part of the optimizations there will be a lot fewer temporary allocations
with the new version (especially for NUL-terminated strings), and improved
code generation which does not only improve performance but also reduces the
size of the resulting binaries considerably. Various GStreamer plugins saw
size reductions of 15-20%.

The new release also brings a lot of bugfixes, most of which were
already part of the 0.19.x bugfix releases.

Details can be found in the release notes for [gstreamer-rs](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/-/blob/main/gstreamer/CHANGELOG.md#0200-2023-02-10).

The code and documentation for the bindings is available on the freedesktop.org GitLab

- [GStreamer Rust Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) ([documentation](https://gstreamer.pages.freedesktop.org/gstreamer-rs/stable/0.20/docs/))

as well as on [crates.io](https://crates.io).

The new 0.10 version of the GStreamer Rust plugins features many
improvements to the existing plugins as well as a few new plugins. A
majority of the changes were already backported to the 0.9 release series
and its bugfix releases, which is part of GStreamer 1.22.

A full list of available plugins can be seen in the repository's [README.md](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/0.10/README.md).

Details for this release can be found in the release notes for [gst-plugins-rs](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/blob/main/CHANGELOG.md#0100-2023-02-10).

If you find any bugs, notice any missing features or other issues please
report them in GitLab for the [bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/issues/new)
or the [plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/issues/new).
