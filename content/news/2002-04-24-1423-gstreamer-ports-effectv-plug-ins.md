---
title: "GStreamer ports effecTV plug-ins"
date: 2002-04-24T14:23:00Z
---

[EffecTV](http://effectv.sourceforge.net/) is a cool project which allows you to add real-time effects to a video stream captured from a v4l-device. Combining this with GStreamer allows you to use any effecTV plugin in any pipeline. This can easily let you do really nice things. Here's an example.

Starting from [Alien Song](/media/medium/alien.mpg), we first run the pipeline

```
gst-launch gnomevfssrc location="/media/medium/alien.mpg" ! mpegdemux video_%02d!
{ queue ! mpeg2dec ! colorspace ! agingTV ! colorspace !
mpeg2enc ! disksink location=alien-age.mpg }
```

to re-encode the movie with the agingTV effect. This is the [result](http://gstreamer.net/media/alien-age.mpg).

Next, we re-encode the same video using the edgeTV plug-in :

```
gst-launch gnomevfssrc location="/media/medium/alien.mpg" ! mpegdemux video_%02d!
{ queue ! mpeg2dec ! colorspace ! edgeTV ! colorspace !
mpeg2enc ! disksink location=alien-edge.mpg }
```

This is the [result.](http://gstreamer.net/media/alien-edge.mpg)

Finally, we add the effects; we create an aged version of the edgy version. This is where GStreamer really shines; in effectv you have to use loopback v4l devices.

```
gst-launch gnomevfssrc location="/media/medium/alien.mpg" ! mpegdemux video_%02d!
{ queue ! mpeg2dec ! colorspace ! edgeTV !
agingTV ! colorspace ! mpeg2enc ! disksink location=alien-edge-age.mpg }
```

And here's the [result.](http://gstreamer.net/media/alien-edge-age.mpg)

We hope to work with the effecTV authors to provide a convenient library which will allow easy access to these great effects.

The effecTV plug-ins : soon coming to a gst-enabled video editor near you !

*sample created movies lack sound and encoding has been ctrl-c'd at random moments because I'm lazy. Colorspace is necessary because the effecTV plugins work in the RGB colorspace and MPEG video works in the YUV colorspace. The effecTV have just been added to CVS code and will be in the next stable GStreamer release.*

Here's screenshots of three different effects applied on the alien-song movie:

![The EffecTV Age effect](/images/age.png)\
*The Age Effect*
![The EffecTV Edge effect](/images/edge.png)\
*The Edge Effect*
![The EffecTV Edge/Age effects combined](/images/age_edge.png)\
*The Age/Edge Effects Together*
