---
title: "GStreamer Editor now plays video !"
date: 2002-09-03T02:55:00Z
---

**Andy Wingo**, our demon coder from hell, has put in the missing code that finally allows the editor to play video ! Not only that, but he also added an option that parses the GStreamer command pipelines you're all used to. The next release of gst-editor (the first using GNOME 2 technology) is bound to kick serious ass !

See these screenshots for a sneak preview :

| | |
|---|---|
| the result of launching '`gst-editor -l filesrc location=/home/thomas/gst/media/AlienSong.mpg ! mpegdemux video_%02d! { queue ! mpeg2dec ! colorspace ! xvideosink disable-xv=true } mpegdemux0.audio_%02d! { queue ! mad ! osssink }`' (I set disable-xv to true to take the screenshot) | [![](/images/gst-editor-0.4.1-launched.gif)](/images/gst-editor-0.4.1-launched.png) |
| a manually re-ordered pipeline window to show the structure | [![](/images/gst-editor-0.4.1-clean.gif)](/images/gst-editor-0.4.1-clean.png) |
