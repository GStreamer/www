---
title: "GStreamer Rust bindings 0.14.0 release"
date: 2019-06-24T20:00:00Z
---

A new version of the GStreamer Rust bindings, 0.14.0, was released.

Apart from updating to GStreamer 1.16, this release is mostly focussed on
adding more bindings for various APIs and general API cleanup and bugfixes.\
The most notable API additions in this release are bindings for gst::Memory and
gst::Allocator as well as bindings for gst_base::BaseParse and gst_video::VideoDecoder
and VideoEncoder. The latter also come with support for implementing subclasses and
the gst-plugins-rs module contains an video decoder and parser (for CDG), and a
video encoder (for AV1) based on this.

As usual this release follows the latest [gtk-rs](https://gtk-rs.org/blog/2019/06/22/new-release.html)
release, and a new version of the GStreamer plugins written in Rust was also released.

Details can be found in the release notes for [gstreamer-rs](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/blob/28a24a4fc06b45a713f159d17cd4e8526ae3eae2/gstreamer-sdp/CHANGELOG.md#0140-2019-06-24)
and [gstreamer-rs-sys](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs-sys/blob/3dc291d51abf1401622382b7e51a80424cd0f86e/gstreamer-sys/CHANGELOG.md#080-2019-06-24).

The code and documentation for the bindings is available on the freedesktop.org GitLab

- [GStreamer Rust Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) ([documentation](https://slomo.pages.freedesktop.org/rustdocs/gstreamer/gstreamer/))
- [GStreamer Rust Plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs)
- [GStreamer Rust FFI Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs-sys) ([documentation](https://slomo.pages.freedesktop.org/rustdocs/gstreamer-sys/gstreamer_sys/))

as well as on [crates.io](https://crates.io).

If you find any bugs, missing features or other issues please report them in
[GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/issues/new).
