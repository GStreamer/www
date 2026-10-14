---
title: "GStreamer Rust bindings 0.15.0 release"
date: 2019-12-18T17:00:00Z
---

A new version of the GStreamer Rust bindings, 0.15.0, was released.

As usual this release follows the latest [gtk-rs](https://gtk-rs.org/blog/2019/12/15/new-release.html)
release, and a new version of the GStreamer plugins written in Rust was also released.

This new version features a lot of newly bound API for creating subclasses
of various GStreamer types: GstPreset, GstTagSetter, GstClock,
GstSystemClock, GstAudioSink, GstAudioSrc, GstDevice, GstDeviceProvider,
GstAudioDecoder and GstAudioEncoder.

In addition to that, a lot of bugfixes and further API improvements have
happened over the last few months that should make development of
GStreamer applications or plugins in Rust as convenient as possible.

A new release of the [GStreamer Rust plugins](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs) will follow in the next days.

Details can be found in the release notes for [gstreamer-rs](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/blob/d26ffc2c219ca821aefbc9eababcc7ceb11ec83f/gstreamer/CHANGELOG.md#0150-2019-12-18)
and [gstreamer-rs-sys](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs-sys/blob/0002f2e5310960c564398f7e31e3ee02f7383b0c/gstreamer-sys/CHANGELOG.md#081-2019-12-16).

The code and documentation for the bindings is available on the freedesktop.org GitLab

- [GStreamer Rust Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs) ([documentation](https://slomo.pages.freedesktop.org/rustdocs/gstreamer/gstreamer/))
- [GStreamer Rust FFI Bindings](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs-sys) ([documentation](https://slomo.pages.freedesktop.org/rustdocs/gstreamer-sys/gstreamer_sys/))

as well as on [crates.io](https://crates.io).

If you find any bugs, missing features or other issues please report them in
[GitLab](https://gitlab.freedesktop.org/gstreamer/gstreamer-rs/issues/new).
