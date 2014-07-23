releases = 1.2.0 1.0.0 1.0.0 1.0.0 1.0.0 1.0.0

built_pages = \
        $(releases) \
        $(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
