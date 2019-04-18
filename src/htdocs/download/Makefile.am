built_pages = \
	index.html download.html

index.html: download.html index.xml $(fullstyle) $(entities) $(page_style) $(pics)
	xsltproc $(srcdir)/index.xml -o $@ --path "$(builddir)"

download.html: download.md
	markdown $(srcdir)/download.md > $(builddir)/download.html

include $(top_srcdir)/html.make
