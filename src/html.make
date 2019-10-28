### rules to make html, included from all of the subdirs

# set sources to either the %_sources variable, or the logical default of %.xml
%.html: sources = $(if $($*_sources), $($*_sources), $*.xml)

# set fullsources to a list of each file in sources prefixed with srcdir
%.html: fullsources = $(foreach source, $(sources), $(srcdir)/$(source))

# set fullstyle to either the %_style variable, prefixed with srcdir,
# or the style variable, prefixed with srcdir
# or the logical default of the toplevel index.xsl stylesheet
%.html: fullstyle = $(if $($*_style), \
                      $(srcdir)/$($*_style), \
                      $(if $(style), \
                        $(srcdir)/$(style), \
                        $(top_srcdir)/htdocs/index.xsl))

page_style = \
	$(top_builddir)/htdocs/gstreamer.css \
	$(top_srcdir)/htdocs/page.xsl \
	$(top_srcdir)/htdocs/header.xml \
	$(top_srcdir)/htdocs/header.xsl

entities = \
	$(top_srcdir)/htdocs/entities.site \
	$(top_srcdir)/htdocs/entities.gst

$(entities):
	@echo Please make sure $(entities) exist.
	@echo Have you read HACKING ?
	@exit 1

# generate html page from xml source
# BUG: somehow specifying $(fullsources) as a prereq doesn't really work to
#       make the target rebuild when one of them gets changed,
#       so we put %.xml in there for safety
#       my guess is $(fullsources) is only defined for the action, not the
#       rule, since it's a pattern-dependant variable
#
%.html: %.xml $($*_sources) $(fullstyle) $(entities) $(page_style)
	xsltproc @XSLTPROC_ARGS@ $(fullsources) -o $@

%.html-debug: 
	echo xml: $@
	echo sources: $($*_sources)
	echo fullstyle: $(fullstyle)
	echo entities: $(entities)
	echo page_style: $(page_style)

# copy files from copy when needed
# we used to depend on the origin so it got autoupdated, but
# that didn't work for srcdir=builddir because it recursed
%.png:
	cp $(top_srcdir)/copy/images/$@ $@

%.gif:
	cp $(top_srcdir)/copy/images/$@ $@

%.jpg:
	cp $(top_srcdir)/copy/images/$@ $@

$(top_builddir)/htdocs/gstreamer.css: $(top_srcdir)/copy/gstreamer.css
	cp $< $@
#gstreamer.css: $(top_srcdir)/copy/gstreamer.css
#	cp $< $@

# copy .htaccess preserving hierarchy
# set htaccess in htdocs/ Makefile.am to get these in
%/.htaccess: $(top_srcdir)/copy/$@
	cp $</$@ $@


# create new variables to use in automake targets so automake
# doesn't complain when these variables are emtpy
am_pages = $(if $(built_pages), $(built_pages), )
am_images = $(if $(images), $(images), )
am_documents = $(if $(documents), $(documents), )
am_css = $(if $(css), $(css), )
am_htaccess = $(if $(htaccess), $(htaccess), )

noinst_DATA = $(am_pages) $(am_images) $(am_css) $(am_htaccess) $(am_documents)
CLEANFILES = $(noinst_DATA)
