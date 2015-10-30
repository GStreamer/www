releases = 1.6.1 1.6.0 1.5.91 1.5.90 1.5.2 1.5.1 1.4.5 1.4.4 1.4.3 1.4.2 1.4.1 1.4.0 1.3.91 1.3.90 1.3.3 1.3.2 1.3.1 1.2.4 1.2.4 1.2.3 1.2.2 1.2.1 1.2.0 1.1.90 1.0.10 1.1.4 1.0.9 1.1.3 1.0.8 1.1.2 1.1.1 1.0.7 1.0.6 1.0.5 1.0.4 1.0.3 1.0.2 1.0.1 0.11.92 0.11.91 0.11.90

built_pages = \
        $(releases) \
        $(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
