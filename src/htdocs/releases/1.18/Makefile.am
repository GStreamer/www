built_pages = index.html

#gdb-gst-print.png
pics =

release-notes-1.18.html: release-notes-1.18.md
	cmark-gfm @CMARK_ARGS@ $(srcdir)/release-notes-1.18.md > $(builddir)/release-notes-1.18.html

index.html: release-notes-1.18.html index.xml $(fullstyle) $(entities) $(page_style) $(pics)
	for pic in $(pics); do cp $(srcdir)/$$pic $(builddir)/$$pic; done
	xsltproc @XSLTPROC_ARGS@ $(srcdir)/index.xml -o $@ --path "$(builddir)"

include $(top_srcdir)/html.make
