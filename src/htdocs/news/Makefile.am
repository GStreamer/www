built_pages = index.html rss-1.0.xml #atom.xml

rss-1.0.xml: $(srcdir)/news.xml $(srcdir)/news2rss-1.0.xsl
	xsltproc -o $@ $(srcdir)/news2rss-1.0.xsl $<

#atom.xml: news.xml news2atom.xsl
#	xsltproc -o $@ $(srcdir)/news2atom.xsl $<

index_style = index.xsl

include $(top_srcdir)/html.make
