built_pages = gstreamer010.html index.html

%.xml: $(top_srcdir)/copy/releases/$@
	cp $(top_srcdir)/copy/releases/$@ $@
%.ics: $(top_srcdir)/copy/releases/$@
	cp $(top_srcdir)/copy/releases/$@ $@

all-local:	releases.rss10.xml releases.rss20.xml releases.ics

index.html: releases.html index.xml $(fullstyle) $(entities) $(page_style) $(pics)
	xsltproc $(srcdir)/index.xml -o $@ --path "$(builddir)"

releases.html: releases.md
	markdown $(srcdir)/releases.md > $(builddir)/releases.html

SUBDIRS = \
	1.16 \
	1.14 \
	1.12 \
	1.10 \
	1.8 \
	1.6 \
	gnonlin \
	gst-editor \
	gst-ffmpeg \
	gst-libav \
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
	gstreamer-vaapi \
	gstreamer-sharp \
	gst-editing-services \
	gst-rtsp-server \
	gst-validate \
	gst-omx

include $(top_srcdir)/html.make
