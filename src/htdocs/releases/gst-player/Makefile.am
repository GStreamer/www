built_pages = 0.6.0.html 0.8.0.html 0.8.0

style = ../releases.xsl

%.html: %.xml $(style)

$(built_pages): $(style) ../text.xsl
                                                                                
%: %.xml
	xsltproc @XSLTPROC_ARGS@ -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
