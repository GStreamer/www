SUBDIRS = apps bugs dev documentation images \
	lists modules news releases \
	tasks features

built_pages = index.html
index_style = index.xsl
css = gstreamer.css

htaccess = \
	releases/gstreamer/.htaccess \
	releases/gst-player/.htaccess \
	releases/gst-plugins/.htaccess \
	data/pkg/.htaccess \
	tasks/.htaccess


media pkg src:
	ln -sf ../data/$@ .
data:
	ln -sf ../data .


all-local: media pkg src data

include $(top_srcdir)/html.make
