releases = \
	0.7.1 \
	0.8.0 0.8.1 0.8.2 0.8.3 0.8.4 0.8.5 0.8.6 \
        0.9.3

built_pages = \
        $(releases) \
        $(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
