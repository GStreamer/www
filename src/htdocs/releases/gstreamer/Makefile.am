built_text = 0.7.5
built_pages = 0.6.5.html 0.7.3.html 0.7.4.html 0.7.5.html $(built_text)

style = ../releases.xsl

$(built_pages): $(style) ../text.xsl

%.html: %.xml

%: %.xml
	xsltproc -o $@ $(srcdir)/../text.xsl $<

include $(top_srcdir)/html.make
