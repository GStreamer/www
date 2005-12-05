built_pages = index.html licensing.html rtp.html plugins.html splitup.html gstreamer010.html

plugins.xml:
	for m in gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad; do \
	  cvs -d:pserver:anonymous@cvs.freedesktop.org:/cvs/gstreamer \
	  co -d $$m $$m/docs/plugins/inspect; \
	done
	echo "<plugins>" > plugins.xml
	cat */*.xml >> plugins.xml
	echo "</plugins>" >> plugins.xml
	rm -rf gst-plugins-*

plugins.xml-update:
	rm -f plugins.xml
	make plugins.xml
       
plugins.html: plugins.xsl plugins.xml-update
	xsltproc -o plugins.html $(srcdir)/plugins.xsl plugins.xml

include $(top_srcdir)/html.make
