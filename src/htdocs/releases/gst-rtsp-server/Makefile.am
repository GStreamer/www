releases = 1.4.5 1.4.4 1.4.4 1.4.3 1.4.2 1.4.1 1.4.0 1.3.91 1.3.90 1.3.3 1.3.2 1.3.1 1.2.3 1.2.3 1.2.3 1.2.3

built_pages = \
        $(releases) \
        $(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
