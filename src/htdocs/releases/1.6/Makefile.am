built_pages = index.html

index.html: release-notes-1.6.html index.xml $(fullstyle) $(entities) $(page_style)
	xsltproc $(srcdir)/index.xml -o $@ --path "$(builddir)"

release-notes-1.6.html: release-notes-1.6.md
	markdown $(srcdir)/release-notes-1.6.md > $(builddir)/release-notes-1.6.html

include $(top_srcdir)/html.make
