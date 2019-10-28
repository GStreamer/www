releases = 0.11.2 0.11.1 0.10.13 0.10.12 0.10.11 0.10.10 0.10.9 0.10.8 0.10.7 0.10.6 0.10.5 0.10.4 0.10.3 0.10.2 0.10.1 0.10.0 0.9.7 0.9.6 0.9.5 \
	0.7.1 \
	0.8.0 0.8.1 0.8.2 0.8.3 0.8.4 0.8.5 0.8.6 0.8.7 \
        0.9.3 0.9.4

built_pages = \
        $(releases) \
        $(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc @XSLTPROC_ARGS@ -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
