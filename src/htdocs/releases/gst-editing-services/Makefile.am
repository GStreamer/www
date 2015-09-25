releases = 1.6.0 1.5.91 1.5.90 1.5.2 1.4.0 1.3.90 1.3.90 1.4.0 1.4 1.2.1 1.2.0 1.2.0 1.2.0 1.2.0 1.2.0 1.2.0 1.1.90 0.10.1

built_pages = \
        $(releases) \
        $(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
