built_pages = index.html gstreamer-conference-timetable.html speakers.html

images = \
	sponsor_150x45_UbiCast.png     \
	sponsor_150x49_collabora.png   \
	sponsor_149x36_fluendo.png     \
	sponsor_150x50_google.png

documents = \
	Prague-Food.pdf \
	Prague-Nightlife.pdf \
	gstreamer-sponsor.pdf

gstreamer-sponsor.pdf:
	cp $(top_srcdir)/copy/documents/gstreamer-sponsor-2011.pdf gstreamer-sponsor.pdf

Prague-Nightlife.pdf:
	cp $(top_srcdir)/copy/documents/$@ $@

Prague-Food.pdf:
	cp $(top_srcdir)/copy/documents/$@ $@

include $(top_srcdir)/html.make
