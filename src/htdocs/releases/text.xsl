<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % site-entities SYSTEM "../entities.site">
  <!ENTITY % gst-entities SYSTEM "../entities.gst">
  %site-entities;
  %gst-entities;
]>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  version="1.0">

<!-- this template outputs a complete list of items wrapped in a list -->
<xsl:template name="item-list">
  <xsl:param name="parent" />
  <xsl:for-each select="item">
* <xsl:value-of select="." />
  </xsl:for-each>
</xsl:template>

  <!-- transform a release xml file to a text version of release notes -->

  <xsl:output method="text" />
  <!-- this template displays the features -->
  <xsl:template match="features">
Features of this release
    <xsl:for-each select="feature">
      * <xsl:value-of select="." />
    </xsl:for-each>
  </xsl:template>

  <!-- this template displays the issues -->
  <xsl:template match="issues">

Known issues
    <xsl:for-each select="issue">* <xsl:value-of select="." /></xsl:for-each>
  </xsl:template>

  <!-- this template displays the bugs fixed -->
  <xsl:template match="bugs">

Bugs fixed in this release
    <xsl:for-each select="bug">
      * <xsl:value-of select="id" /> : <xsl:value-of select="summary" />
    </xsl:for-each>
  </xsl:template>

  <!-- this template displays the API changes -->
  <xsl:template match="api">

API changed in this release
     <xsl:apply-templates select="additions" />

     <xsl:apply-templates select="removals" />

     <xsl:apply-templates select="depreciations" />

  </xsl:template>

  <!-- this template matches the API additions -->
  <xsl:template match="additions">

- API additions:
    <xsl:call-template name="item-list">
      <xsl:with-param name="parent">
        <xsl:value-of select="." />
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>
 
  <!-- this template matches the API removals -->
  <xsl:template match="removals">

- API removals:
    <xsl:call-template name="item-list">
      <xsl:with-param name="parent">
        <xsl:value-of select="." />
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

  <!-- this template matches the API removals -->
  <xsl:template match="depreciations">

- API depreciations:
    <xsl:call-template name="item-list">
      <xsl:with-param name="parent">
        <xsl:value-of select="." />
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

   <!-- this template displays the contributors -->
  <xsl:template match="contributors">
Contributors to this release
    <xsl:for-each select="person">
      * <xsl:value-of select="." />
    </xsl:for-each>
  </xsl:template>

  <!-- this template displays the maintainers -->
  <xsl:template match="maintainers">
Maintainers
    <xsl:for-each select="person">
      * <xsl:value-of select="." />
    </xsl:for-each>
  </xsl:template>

  <!-- this template displays the application notes -->
  <xsl:template match="applications">
Applications<xsl:copy-of select="." />
  </xsl:template>

  <!-- this template outputs the release notes -->
  <xsl:template match="release">
GStreamer: Release notes for <xsl:value-of select="module-fancy" />&nbsp;<xsl:value-of select="version" /> "<xsl:value-of select="name" />"
        <xsl:copy-of select="intro" />
        <xsl:apply-templates select="features" />

        <xsl:apply-templates select="issues" />

        <xsl:apply-templates select="bugs" />

        <xsl:apply-templates select="api" />

Download

You can find source releases of <xsl:copy-of select="module" /> in the download directory:
&realsite;/src/<xsl:value-of select="module" />/

GStreamer Homepage

More details can be found on the project's website:
&realsite;/

Support and Bugs

We use GNOME's bugzilla for bug reports and feature requests:
&gst-bug-report;

Developers

CVS is hosted on cvs.freedesktop.org.
All code is in CVS and can be checked out from there.
Interested developers of the core library, plug-ins, and applications should
subscribe to the gstreamer-devel list. If there is sufficient interest we
will create more lists as necessary.

        <xsl:apply-templates select="applications" />

        <xsl:apply-templates select="contributors" />

        <xsl:apply-templates select="maintainers" />
&nbsp;</xsl:template>

</xsl:stylesheet>
