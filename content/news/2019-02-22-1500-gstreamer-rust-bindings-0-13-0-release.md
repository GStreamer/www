---
title: "GStreamer Rust bindings 0.13.0 release"
date: 2019-02-22T15:00:00Z
---

A new version of the GStreamer Rust bindings, 0.13.0, was released.

This new release is the first to include direct support for
implementing GStreamer elements and other types in Rust. Previously
this was provided via a different crate.\
In addition to this, the new release features many API improvements,
cleanups, newly added bindings and bugfixes.

As usual this release follows the latest [gtk-rs](https://gtk-rs.org/blog/2019/02/21/new-release.html)
release, and a new version of GStreamer plugins written in Rust was also released.

Details can be found in the release notes for [gstreamer-rs](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/blob/490004d9c55d06a3b545ebc15c13a80893937bb9/gstreamer/CHANGELOG.md#0130-2019-02-22)
and [gstreamer-rs-sys](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs-sys/blob/e274b5495bb1698cd9fe48de40ab5f9f2b0e1faa/gstreamer-sys/CHANGELOG.md#070-2019-02-22).

The code and documentation for the bindings is available on the freedesktop.org GitLab

- [GStreamer Rust Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) ([documentation](https://slomo.pages.freedesktop.org/rustdocs/gstreamer/gstreamer/))
- [GStreamer Rust Plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs)
- [GStreamer Rust FFI Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs-sys) ([documentation](https://slomo.pages.freedesktop.org/rustdocs/gstreamer-sys/gstreamer_sys/))

as well as on [crates.io](https://crates.io).

If you find any bugs, missing features or other issues please report them in
[GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/issues/new).
