built_pages = 0.7.90.html 0.7.90

style = ../releases.xsl

%.html: %.xml $(style)

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
