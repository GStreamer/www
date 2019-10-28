built_pages = 0.8.0.html 0.8.0 0.7.0.html 0.7.0

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc @XSLTPROC_ARGS@ -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
