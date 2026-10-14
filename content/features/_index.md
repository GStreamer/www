---
title: "Features"
---
## Multiplatform

GStreamer works on all major operating systems such as Linux, Android,
Windows, Max OS X, iOS, as well as most BSDs, commercial Unixes, Solaris,
and Symbian. It has been ported to a wide range of operating systems,
processors and compilers. It runs on all major hardware architectures
including x86, ARM, MIPS, SPARC and PowerPC, on 32-bit as well as 64-bit,
and little endian or big endian.

GStreamer can bridge to other multimedia frameworks in order to reuse existing
components (e.g. codecs) and use platform input/output mechanisms:

* Linux/Unix: OpenMAX-IL (via gst-omx)
* Windows: DirectShow
* Mac OS X: QuickTime

## Comprehensive Core Library

* Graph-based structure allows arbitrary pipeline construction
* Based on [GLib 2.0 object model](http://developer.gnome.org/gobject/stable/) for object-oriented design and inheritance
* Compact core library of less than 500KB, about 65 K lines of code
* Multi-threaded pipelines are trivial and transparent to construct
* Clean, simple and stable [API](/data/doc/gstreamer/head/gstreamer/html/) for both plugin and application developers
* Extremely lightweight data passing means very high performance/low latency
* Complete [debugging system](/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstInfo.html) for both core and plugin/app developers
* Clocking to ensure global inter-stream synchronization (a/v sync)
* Quality of service (qos) to ensure best possible quality under high CPU load

## Intelligent Plugin Architecture

* [Dynamically loaded](/data/doc/gstreamer/head/gstreamer/html/GstPlugin.html) plugins provide elements and media types, demand-loaded via a registry cache, similar to ld.so.cache
* [Element interface](/data/doc/gstreamer/head/manual/html/chapter-elements.html) handles all known types of sources, filters and sinks
* [Capabilities system](/data/doc/gstreamer/head/manual/html/section-caps.html) allows verification of element compatibility using MIME types and media-specific properties
* Autoplugging uses capabilities system to complete complex paths automatically
* Pipelines can be visualised by dumping them to a .dot file and creating a PNG image from that
* Resource friendly plugins don't waste memory

## Broad Coverage of Multimedia Technologies

GStreamers capabilities can be extended through new plugins. The features
listed below are just a rough overview what is available using the
GStreamers own plugins, not counting any 3rd party offerings.

* container formats: asf, avi, 3gp/mp4/mov, flv, mpeg-ps/ts, mkv/webm, mxf, ogg
* streaming: http, mms, rtsp
* codecs: FFmpeg, various codec libraries, 3rd party codec packs
* metadata: native container formats with a common mapping between them
* video: various colorspaces, support for progressive and interlaced video
* audio: integer and float audio in various bit depths and multichannel configurations

## Extensive Development Tools

* gst-launch command-line tool for quick prototyping and testing, similar to ecasound
* A lot of [documentation](/documentation/), including partially completed [manual](/data/doc/gstreamer/head/manual/html/index.html) and [plugin writer's guide](/data/doc/gstreamer/head/pwg/html/index.html)
* Large selection of test programs and example code in each module
* Access to GStreamer API with [various programming languages](/bindings/)

GStreamer 1.x is our latest API series and has been stable since 2012.
