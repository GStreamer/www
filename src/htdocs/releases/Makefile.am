built_pages = index.html

%.xml: $(top_srcdir)/copy/releases/$@
	cp $(top_srcdir)/copy/releases/$@ $@
%.ics: $(top_srcdir)/copy/releases/$@
	cp $(top_srcdir)/copy/releases/$@ $@

all-local:	releases.rss10.xml releases.rss20.xml releases.ics

index.html: releases.html index.xml $(fullstyle) $(entities) $(page_style) $(pics)
	xsltproc @XSLTPROC_ARGS@ $(srcdir)/index.xml -o $@ --path "$(builddir)"

releases.html: releases.md
	markdown $(srcdir)/releases.md > $(builddir)/releases.html

SUBDIRS = \
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
