releases = 0.10.5 0.10.4 0.10.3 0.10.2 0.10.1 0.10.0 0.9.7 0.9.6 0.9.5 \
	0.9.1 0.9.2 0.9.3 0.9.4

built_pages = \
	$(releases) \
	$(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
