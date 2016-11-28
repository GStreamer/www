built_pages = licensing.html plugins.html gstreamer010.html

CHECKOUT_DIR = $(top_builddir)/cache/plugin-inspect-checkouts

# the top_builddir here is not quite right, but should work for now
FIX_UNDOCUMENTED_PLUGIN_LINKS = $(top_builddir)/bin/fix-undocumented-plugins-links

checkoutdir:
	echo "Check plugin documentation checkout directory $(CHECKOUT_DIR)"; \
	mkdir -p $(CHECKOUT_DIR) || { \
	  echo "Failed to create $(CHECKOUT_DIR)"; \
	  exit 1; \
	}

# Note: using pushd/popd because GIT_DIR doesn't seem to work properly
plugins.xml: checkoutdir
	for m in gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad; do \
	  moduledir=$(CHECKOUT_DIR)/$$m; \
	  branch="master"; \
	  if [ -d $$moduledir ] ; then \
	    pushd $$moduledir >/dev/null; \
	    echo "$$m checkout: cleaning"; \
	    git clean -f -d -x || { \
	      echo "Cleaning $$m checkout failed"; exit 1; \
	    } ; \
	    if test "x$$GST_WWW_SKIP_DOC_CHECKOUT_UPDATES" != "x"; then \
	      echo "$$m checkout: skipping update (GST_WWW_SKIP_DOC_CHECKOUT_UPDATES is set)"; \
	    else \
	      echo "$$m checkout: updating..."; \
	      git checkout $$branch && git pull || { \
	        echo "Updating $$m checkout failed"; exit 1; \
	      } ; \
	    fi; \
	    popd >/dev/null; \
	  else \
	    echo "$$m checkout: creating (cloning)"; \
	    git clone --depth 1 -b $$branch git://anongit.freedesktop.org/gstreamer/$$m $$moduledir || { \
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
	$(FIX_UNDOCUMENTED_PLUGIN_LINKS) plugins.html $(top_builddir) > plugins-fixed.html
	mv plugins-fixed.html plugins.html

include $(top_srcdir)/html.make
