releases = \
	0.9.1 0.9.2 0.9.3

built_pages = \
	$(releases) \
	$(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
