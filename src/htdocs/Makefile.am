SUBDIRS = apps bindings dev download images \
	lists modules news releases conference \
	features projects \
	artwork security

built_pages = index.html
index_style = index.xsl
css = gstreamer.css

index.html: $(srcdir)/news/news.xml

media pkg src:
	ln -sf ../data/$@ .
data:
	ln -sf ../data .

robots.txt: $(top_srcdir)/copy/robots.txt
	cp $(top_srcdir)/copy/robots.txt $@

toplevel-htaccess: $(top_srcdir)/copy/dot-htaccess
	cp $(top_srcdir)/copy/dot-htaccess .htaccess

all-local: media pkg src data robots.txt toplevel-htaccess

include $(top_srcdir)/html.make
