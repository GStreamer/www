xml = bugs.xml

bugs_xsl = bugs.xsl
bugs_pages = index.html

$(bugs_pages): $(xml) $(bugs_xsl) $(top_srcdir)/htdocs/page.xsl
	xsltproc @XSLTPROC_ARGS@ $(srcdir)/$(bugs_xsl) $(srcdir)/$(xml) > index.html
                                                                                
built_pages = $(bugs_pages)
                                                                                
include $(top_srcdir)/html.make

