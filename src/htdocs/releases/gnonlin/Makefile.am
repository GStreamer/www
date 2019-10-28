releases = 1.4.0 1.3.90 1.3.90 1.2.1 1.2.1 1.2.1 1.2.0 1.1.90 0.10.17 0.10.16 0.10.15 0.10.14 0.10.13 0.10.12 0.10.11 0.10.10 0.10.9 0.10.8 0.10.7 0.10.6 0.10.5 0.10.4 0.10.3 0.10.2 0.10.1

built_pages = \
	$(releases) \
	$(releases:=.html)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%: %.xml
	xsltproc @XSLTPROC_ARGS@ -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
