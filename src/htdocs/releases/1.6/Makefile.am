built_pages = index.html

pics = \
	bilinear-1.4.png \
	bilinear2-1.6.png \
	colorbars-bayer-1.6.png \
	colorbars-nodither-1.6.png \
	colors-bayer-1.6.png \
	scale-1.4-nogamma.png \
	scale-1.6-gamma.png \
	scale-1.6-nogamma.png \
	scale-method2-1.4.png \
	scale-method2-1.6.png

index.html: release-notes-1.6.html index.xml $(fullstyle) $(entities) $(page_style) $(pics)
	for pic in $(pics); do cp $(srcdir)/$$pic $(builddir)/$$pic; done
	xsltproc $(srcdir)/index.xml -o $@ --path "$(builddir)"

release-notes-1.6.html: release-notes-1.6.md
	markdown $(srcdir)/release-notes-1.6.md > $(builddir)/release-notes-1.6.html

include $(top_srcdir)/html.make
