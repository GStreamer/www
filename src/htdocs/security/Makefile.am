NULL = 

ALERTS = \
	sa-2016-0001.md \
	sa-2016-0002.md \
	sa-2019-0001.md \
	sa-2021-0001.md \
	sa-2021-0002.md \
	sa-2021-0003.md \
	sa-2021-0004.md \
	sa-2021-0005.md \
	sa-2022-0001.md \
	sa-2022-0002.md \
	sa-2022-0003.md \
	sa-2022-0004.md \
	sa-2023-0001.md \
	sa-2023-0002.md \
	sa-2023-0003.md \
	sa-2023-0004.md \
	sa-2023-0005.md \
	sa-2023-0006.md \
	sa-2023-0007.md \
	sa-2023-0008.md \
	sa-2023-0009.md \
	sa-2023-0010.md \
	sa-2023-0011.md \
	sa-2024-0001.md \
	sa-2024-0002.md \
	sa-2024-0003.md \
	sa-2024-0004.md \
	sa-2024-0005.md \
	sa-2024-0006.md \
	sa-2024-0007.md \
	sa-2024-0008.md \
	sa-2024-0009.md \
	sa-2024-0010.md \
	sa-2024-0011.md \
	sa-2024-0012.md \
	sa-2024-0013.md \
	sa-2024-0014.md \
	sa-2024-0015.md \
	sa-2024-0016.md \
	sa-2024-0017.md \
	sa-2024-0018.md \
	sa-2024-0019.md \
	sa-2024-0020.md \
	sa-2024-0021.md \
	sa-2024-0022.md \
	sa-2024-0023.md \
	sa-2024-0024.md \
	sa-2024-0025.md \
	sa-2024-0026.md \
	sa-2024-0027.md \
	sa-2024-0028.md \
	sa-2024-0029.md \
	sa-2024-0030.md \
	sa-2025-0001.md \
	sa-2025-0002.md \
	sa-2025-0003.md \
	sa-2025-0004.md \
	sa-2025-0005.md \
	sa-2025-0006.md \
	sa-2025-0007.md \
	$(NULL)

security_pages = $(patsubst %.md,%.html,$(ALERTS))

all: index.html $(security_pages)

index.html: security.html $(top_srcdir)/htdocs/page.xsl
	xsltproc @XSLTPROC_ARGS@ $(srcdir)/index.xml -o $@ --path "$(builddir)"
	rm security.html

security.html: security.md
	cmark-gfm @CMARK_ARGS@ $< > $@

# We want to go .md -> .html, but we need to use the .xsl page layout template...
# This creates a temporary .xml file, fills it with bare minimum needed to import the layout,
# adds our markdown content converted to HTML and finally runs xsltproc on it.
# Quite janky, but works.
sa-%.html: sa-%.md $(top_srcdir)/htdocs/page.xsl
	@echo "<?xml version=\"1.0\"?>" > $@.xml
	@echo "<!DOCTYPE xml" >> $@.xml
	@echo "[" >> $@.xml
	@echo "  <!ENTITY % site-entities SYSTEM \"$(top_srcdir)/htdocs/entities.site\">" >> $@.xml
	@echo "  %site-entities;" >> $@.xml
	@echo "]>" >> $@.xml
	@echo "<?xml-stylesheet href=\"$(top_srcdir)/htdocs/page.xsl\" type=\"text/xsl\"?>" >> $@.xml
	@echo "<page>" >> $@.xml
	@echo "<title>GStreamer Security Advisory</title>" >> $@.xml
	@echo "<body>" >> $@.xml
	@echo "<div class=\"markdown\">" >> $@.xml
	@cmark-gfm @CMARK_ARGS@ $< >> $@.xml
	@echo "</div>" >> $@.xml
	@echo "</body>" >> $@.xml
	@echo "</page>" >> $@.xml
	xsltproc @XSLTPROC_ARGS@ $@.xml -o $@ --path "$(builddir)"
	rm $@.xml

built_pages = index.html $(security_pages)

include $(top_srcdir)/html.make

