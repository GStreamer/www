built_pages = index.html licensing.html rtp.html plugins.html splitup.html gstreamer010.html

plugins.xml:
	for m in gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad; do \
	  git clone --depth 1 git://anongit.freedesktop.org/gstreamer/$$m $$m-checkouts.git; \
	  ln -s $$m-checkouts.git/docs/plugins/inspect $$m\-checkouts\-plugins-inspect; \
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
