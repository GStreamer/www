built_text = \
	0.7.5 0.7.6 \
	0.8.0 0.8.1 0.8.2
built_pages = \
	0.6.5.html \
	0.7.3.html 0.7.4.html 0.7.5.html 0.7.6.html \
	0.8.0.html 0.8.1.html 0.8.2.html \
	$(built_text)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
