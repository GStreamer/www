%.xml:
	cp $(top_srcdir)/copy/releases/$@ $@
%.ics:
	cp $(top_srcdir)/copy/releases/$@ $@

all-local:	releases.rss10.xml releases.rss20.xml releases.ics

SUBDIRS = \
	gnonlin \
	gst-editor \
	gst-ffmpeg \
	gst-monkeysaudio \
	gst-player \
	gst-plugins \
	gst-plugins-base \
	gst-plugins-good \
	gst-plugins-ugly \
	gst-plugins-bad \
	gst-python \
	gstreamer
