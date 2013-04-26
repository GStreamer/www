releases = 1.0.7 1.0.6 1.0.5 1.0.4 1.0.3 1.0.2 1.0.1 0.11.92 0.11.91 0.11.90

built_pages = \
        $(releases) \
        $(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
