built_pages = index.html licensing.html rtp.html plugins.html splitup.html gstreamer010.html

CHECKOUT_DIR = $(abs_top_builddir)/cache/plugin-inspect-checkouts

checkoutdir:
	echo "Check plugin documentation checkout directory $(CHECKOUT_DIR)"; \
	mkdir -p $(CHECKOUT_DIR) || { \
	  echo "Failed to create $(CHECKOUT_DIR)"; \
	  exit 1; \
	}

# Note: using pushd/popd because GIT_DIR doesn't seem to work properly
plugins.xml: checkoutdir
	for m in gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-plugins-gl; do \
	  moduledir=$(CHECKOUT_DIR)/$$m; \
	  if [ -d $$moduledir ] ; then \
	    pushd $$moduledir >/dev/null; \
	    echo "$$m checkout: cleaning"; \
	    git clean -f -d -x || { \
	      echo "Cleaning $$m checkout failed"; exit 1; \
	    } ; \
	    echo "$$m checkout: updating..."; \
	    git pull || { \
	      echo "Updating $$m checkout failed"; exit 1; \
	    } ; \
	    popd >/dev/null; \
	  else \
	    echo "$$m checkout: creating (cloning)"; \
	    git clone git://anongit.freedesktop.org/gstreamer/$$m $$moduledir || { \
	      echo "git clone failed"; exit 1; \
	    } ; \
	  fi; \
	  rm -f $$m\-checkouts\-plugins-inspect 2> /dev/null; \
	  ln -s $$moduledir/docs/plugins/inspect $$m\-checkouts\-plugins-inspect; \
	done
	echo "<plugins>" > plugins.xml
	cat */*.xml >> plugins.xml
	echo "</plugins>" >> plugins.xml
	rm -f *-checkouts-plugins-inspect

plugins.xml-update:
	rm -f plugins.xml
	make plugins.xml

plugins.html: plugins.xsl plugins.xml-update
	xsltproc -o plugins.html $(srcdir)/plugins.xsl plugins.xml

include $(top_srcdir)/html.make
