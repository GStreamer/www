SUBDIRS = apps images news dev documentation lists modules tasks features

built_pages = index.html
index_style = index.xsl
css = gstreamer.css
htaccess = tasks/.htaccess

media pkg src:
	ln -sf ../data/$@ .
data:
	ln -sf ../data .


all-local: media pkg src data

include $(top_srcdir)/html.make
