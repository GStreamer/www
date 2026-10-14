---
title: "Bindings for Qt"
binding: true
legacy: true
weight: 7
name: "Qt"
status: "Unmaintained. See the [qt-gstreamer](/modules/qt-gstreamer.html) module."
---
## About

QtGStreamer provides C++ bindings for GStreamer with a Qt-style API,
plus some helper classes for integrating GStreamer better in Qt
applications.

## Status

**The QtGStreamer C++ bindings are very out of date and unmaintained.**

For integration with the Qt toolkit there is the
[qmlgl plugin](https://gstreamer.freedesktop.org/documentation/qmlgl/)
in gst-plugins-good which provides the following elements:

* `qmlglsink`: a video sink that renders to a QQuickItem in a QML application
* `qmlglsrc`:  A video src that captures a window from a QML view
* `qmlgloverlay`:  afilter that renders a QML scene onto a video stream

## Features

* uses QtCore helper classes (QString, QList, etc..) where it can, to ease integration with Qt
* provides proper Qt event loop integration for GstBus, which is useful for platforms where Qt is not compiled with GLib event loop support
* provides a video widget for plugging several GStreamer video sinks into Qt GUI applications (outdated, see above)
* provides support for connecting arbitrary GObject signals to C++ slots in a type safe manner, without knowing the signals interface at compile time. This is especially useful for connecting signals from element plugins
* provides bindings that completely hide the GStreamer ABI, so your application doesn’t need to link to GStreamer itself

## Links

* [qt-gstreamer git repository](https://cgit.freedesktop.org/gstreamer/qt-gstreamer)
* [Release tarballs](/src/qt-gstreamer/) (last release: July 2014)
