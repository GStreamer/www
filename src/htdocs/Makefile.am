SUBDIRS = apps bindings bugs dev documentation download images \
	lists modules news releases conference \
	tasks features \
	planet artwork

built_pages = index.html
index_style = index.xsl
css = gstreamer.css

htaccess = \
	releases/gstreamer/.htaccess \
	releases/gst-player/.htaccess \
	releases/gst-plugins/.htaccess \
	releases/gst-ffmpeg/.htaccess \
	tasks/.htaccess


index.html: $(srcdir)/news/news.xml

media pkg src:
	ln -sf ../data/$@ .
data:
	ln -sf ../data .

robots.txt: $(top_srcdir)/copy/robots.txt
	cp $(top_srcdir)/copy/robots.txt $@

all-local: media pkg src data robots.txt

include $(top_srcdir)/html.make
