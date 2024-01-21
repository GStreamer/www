built_pages = index.html rss-1.0.xml

rss-1.0.xml: $(srcdir)/news.xml $(srcdir)/news2rss-1.0.xsl
	xsltproc @XSLTPROC_ARGS@ -o $@ $(srcdir)/news2rss-1.0.xsl $<

index_style = index.xsl

images = discourse.png

include $(top_srcdir)/html.make
