xml = modules.xml
# for each of the xml sources, we specify stylesheet and resulting files
modules_xsl = modules.xsl
modules_pages = gst-editor.html gst-player.html index.html


$(modules_pages): $(xml) $(modules_xsl) $(top_srcdir)/htdocs/page.xsl
	xsltproc $(srcdir)/$(modules_xsl) $(srcdir)/$(xml)

built_pages = $(modules_pages)

include $(top_srcdir)/html.make
