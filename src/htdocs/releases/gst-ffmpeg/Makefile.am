built_pages = \
	0.8.2.html 0.8.2 \
	0.8.1.html 0.8.1 \
	0.8.0.html 0.8.0 \
	0.7.1.html 0.7.1

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
