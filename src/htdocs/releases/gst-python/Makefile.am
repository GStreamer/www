releases = \
	0.7.90 0.7.91 0.7.92 0.7.93 0.7.94 \
	0.8.0 0.8.1 0.8.2 \
	0.9.3

built_pages = \
        $(releases) \
        $(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
