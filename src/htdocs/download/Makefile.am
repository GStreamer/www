built_pages = \
	index.html \
	fedora5.html \
	fedora.html \
	redhat.html

copied = gstreamer-0.10-deps.repo gstreamer-0.10-gst.repo gstreamer-0.10-apps.repo

all-local:
	for c in $(copied); do cp $(top_srcdir)/copy/download/$$c .; done

include $(top_srcdir)/html.make
