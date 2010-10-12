%.xml: $(top_srcdir)/copy/releases/$@
	cp $(top_srcdir)/copy/releases/$@ $@
%.ics: $(top_srcdir)/copy/releases/$@
	cp $(top_srcdir)/copy/releases/$@ $@

all-local:	releases.rss10.xml releases.rss20.xml releases.ics

SUBDIRS = \
	gnonlin \
	gst-editor \
	gst-ffmpeg \
	gst-monkeysaudio \
	gst-openmax \
	gst-player \
	gst-plugins \
	gst-plugins-bad \
	gst-plugins-base \
	gst-plugins-gl \
	gst-plugins-good \
	gst-plugins-ugly \
	gst-python \
	gstreamer \
	gstreamer-sharp
