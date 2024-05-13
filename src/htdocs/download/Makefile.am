built_pages = \
	index.html download.html

index.html: download.html index.xml tabs.js $(fullstyle) $(entities) $(page_style) $(pics)
	xsltproc @XSLTPROC_ARGS@ $(srcdir)/index.xml -o $@ --path "$(builddir)"

download.html: download.md
	cmark-gfm @CMARK_ARGS@ $(srcdir)/download.md > $(builddir)/download.html

include $(top_srcdir)/html.make
