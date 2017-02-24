releases = 1.11.2 1.10.4 1.10.3 1.11.1 1.10.2 1.10.1 1.10.0 1.9.90 1.9.2 1.8.3 1.9.1 1.9.1 1.8.2 1.8.1 1.8.1 1.8.0 1.7.91 1.7.90 1.7.90 1.7.90

built_pages = \
        $(releases) \
        $(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
