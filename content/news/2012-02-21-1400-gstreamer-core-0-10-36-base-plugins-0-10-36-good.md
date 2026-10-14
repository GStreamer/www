---
title: "GStreamer Core 0.10.36, Base Plugins 0.10.36, Good Plugins 0.10.31, Ugly Plugins 0.10.19, Bad Plugins 0.10.23 stable releases"
date: 2012-02-21T14:00:00Z
---

The GStreamer team is excited to announce new releases of the GStreamer core module, the gst-plugins-base module, the gst-plugins-good module, the gst-plugins-ugly module, and the gst-plugins-bad module for the 0.10 GStreamer stable release series.

Check out release notes for
[gstreamer](/releases/gstreamer/0.10.36.html),
[gst-plugins-base](/releases/gst-plugins-base/0.10.36.html),
[gst-plugins-good](/releases/gst-plugins-good/0.10.31.html),
[gst-plugins-ugly](/releases/gst-plugins-ugly/0.10.19.html),
[gst-plugins-bad](/releases/gst-plugins-bad/0.10.23.html),
or download tarballs for
[gstreamer](/src/gstreamer/gstreamer-0.10.36.tar.xz),
[gst-plugins-base](/src/gst-plugins-base/gst-plugins-base-0.10.36.tar.xz),
[gst-plugins-good](/src/gst-plugins-good/gst-plugins-good-0.10.31.tar.xz),
[gst-plugins-ugly](/src/gst-plugins-ugly/gst-plugins-ugly-0.10.19.tar.xz),
[gst-plugins-bad](/src/gst-plugins-bad/gst-plugins-bad-0.10.23.tar.xz)
directly.

*Highlights:*

- **GStreamer core:**
  - new muxer/mixer helper class: GstCollectPads2
  - weak ref support for mini objects
  - qdata support for buffers to attach additional metadata
  - input-selector: "sync-streams" property to sync inactive inputs with active one
  - multiqueue: add "sync-by-running-time" property to sync not-linked/deactivated streams by running time (instead of input order of buffers)
- **gst-plugins-base:**
  - new GstAudioDecoder and GstAudioEncoder base classes
  - new GstAudioInfo audio format description API (which matches the new API in 0.11)
  - add support for compressed audio payloading and passhthrough (think S/PDIF, mp3 over bluetooth)
  - new tag convenience API to get info about creative commons licenses
  - new GstTagMux base class
  - new video API to force key units via events
  - new video overlay composition API for subtitles
  - decodebin/playbin2 now plug parsers by default
- **gst-plugins-good:**
  - new souphttpclientsink element
  - new splitfilesrc element to expose multiple files as one single file
  - compressed audio format passthrough support for pulseaudio
  - rtspsrc is now fully async
  - shout2send: support webm streaming
  - rtpsession: Full Intra Requests (FIR) support using new force-key-unit API
  - propagate downstream caps constraints upstream in audio parsers and rtp payloaders
  - many multifile plugin improvements for file/stream splitting
- **gst-plugins-ugly:**
  - most audio decoders and encoders ported to the new base classes (with the exception of mad)
  - lame mp3 and twolame mp2 encoders now output framed mpeg audio (better for muxing)
  - x264enc now supports configuration via downstream caps restrictions (useful for encodebin / rtp etc.)
  - mad doesn't depend on libid3tag any longer (often a hassle on embedded builds)
  - mpeg2dec is more error resilient
  - lots of dvdreadsrc fixes
- **gst-plugins-bad:**
  - new API-unstable video codec parsing library with support for H.264, MPEG-4 (part 2), MPEG-1 and MPEG-2 video, and VC-1
  - video: (API-unstable) video decoder/encoder base classes have seen countless fixes (but some issues still remain before they can be moved into -base)
  - video: new (API unstable) abstract video surface API for hardware-accelerated codecs: GstSurfaceBuffer, GstSurfaceConverter
  - video: new (API unstable) GstVideoContext interface
  - video parsers are consolidated into the videoparserbad plugin and based on new codec parsing library
  - video parsers are ranked for autoplugging now (so they can act as converters where needed)
  - video parsers accept unparsed input as well now (useful for encoding/transcoding pipelines)
  - new audiovisualizers plugin with experimental (and private) audio visualizer base class
  - camerabin2 is no longer considered experimental (and has seen many fixes and improvements)
  - OS/X: new avcsrc to capture DV or HDV video from Firewire port
  - Windows: new d3dvideosink
  - new debugging elements: compare (with memcmp and ssim method) and debugspy
  - new faceoverlay element to overlay an SVG image on top of a face
  - new freeverb element (audio reverb effect)
  - new intermediate surface elements provide stream decoupling
  - within the same pipeline: inter{video,audio,sub}{sink,src}
  - new motioncells element to detect motion in video
  - new Opus audio decoder, encoder, parser and RTP payload/depayloader
  - new removesilence element
  - new rtmpsink element for output to an RTMP server
  - countless other fixes and improvements

... and many other fixes and improvements of course.
