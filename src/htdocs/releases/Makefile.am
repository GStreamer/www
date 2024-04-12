built_pages = index.html

index.html: releases.html index.xml $(fullstyle) $(entities) $(page_style) $(pics)
	xsltproc @XSLTPROC_ARGS@ $(srcdir)/index.xml -o $@ --path "$(builddir)"

releases.html: releases.md
	cmark-gfm @CMARK_ARGS@ $(srcdir)/releases.md > $(builddir)/releases.html

SUBDIRS = \
	1.24 \
	1.22 \
	1.20 \
	1.18 \
	1.16 \
	1.14 \
	1.12 \
	1.10 \
	1.8 \
	1.6

include $(top_srcdir)/html.make
