built_pages = index.html

pics =

index.html: release-notes-1.12.html index.xml $(fullstyle) $(entities) $(page_style) $(pics)
	for pic in $(pics); do cp $(srcdir)/$$pic $(builddir)/$$pic; done
	xsltproc $(srcdir)/index.xml -o $@ --path "$(builddir)"

release-notes-1.12.html: release-notes-1.12.md
	markdown $(srcdir)/release-notes-1.12.md > $(builddir)/release-notes-1.12.html

include $(top_srcdir)/html.make
