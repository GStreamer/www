built_pages = index.html

pics =

index.html: release-notes-1.10.html index.xml $(fullstyle) $(entities) $(page_style) $(pics)
	for pic in $(pics); do cp $(srcdir)/$$pic $(builddir)/$$pic; done
	xsltproc @XSLTPROC_ARGS@ $(srcdir)/index.xml -o $@ --path "$(builddir)"

release-notes-1.10.html: release-notes-1.10.md
	cmark-gfm @CMARK_ARGS@ $(srcdir)/release-notes-1.10.md > $(builddir)/release-notes-1.10.html

include $(top_srcdir)/html.make
