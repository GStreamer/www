built_pages = \
	0.7.3.html 0.7.4.html 0.7.5.html \
	0.7.5

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
