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

   <xsl:choose>
    <xsl:when test="count(bug) > 0">

Bugs fixed in this release
     <xsl:for-each select="bug">
      * <xsl:value-of select="id" /> : <xsl:value-of select="summary" />
     </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>

There were no bugs fixed in this release
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

  <!-- this template displays the API changes -->
  <xsl:template match="api">

   <xsl:choose>
    <xsl:when test="count((additions|removals|deprecations)/*) > 0">

API changes in this release
     <xsl:apply-templates select="additions" />

     <xsl:apply-templates select="removals" />

     <xsl:apply-templates select="deprecations" />
    </xsl:when>
    <xsl:otherwise>

There were no API changes in this release.
    </xsl:otherwise>
   </xsl:choose>

  </xsl:template>

  <!-- this template matches the API additions -->
  <xsl:template match="additions">

   <xsl:if test="count(./*) > 0">
 - API additions:
    <xsl:call-template name="item-list">
      <xsl:with-param name="parent">
        <xsl:value-of select="." />
      </xsl:with-param>
    </xsl:call-template>
   </xsl:if>

  </xsl:template>
 
  <!-- this template matches the API removals -->
  <xsl:template match="removals">

   <xsl:if test="count(./*) > 0">
 - API removals:
    <xsl:call-template name="item-list">
      <xsl:with-param name="parent">
        <xsl:value-of select="." />
      </xsl:with-param>
    </xsl:call-template>
   </xsl:if>

  </xsl:template>

  <!-- this template matches the API removals. -->
  <xsl:template match="deprecations">

   <xsl:if test="count(./*) > 0">
 - API deprecations:
    <xsl:call-template name="item-list">
      <xsl:with-param name="parent">
        <xsl:value-of select="." />
      </xsl:with-param>
    </xsl:call-template>
   </xsl:if>

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
Release notes for <xsl:value-of select="module-fancy" />&nbsp;<xsl:value-of select="version" /><xsl:if test="not(normalize-space(name)='')"> "<xsl:value-of select="name" />"</xsl:if>
        <xsl:copy-of select="intro" />
        <xsl:apply-templates select="features" />

        <xsl:apply-templates select="issues" />

        <xsl:apply-templates select="bugs" />

        <xsl:apply-templates select="api" />

==== Download ====

You can find source releases of <xsl:copy-of select="module" /> in the download
directory: &realsite;/src/<xsl:value-of select="module" />/

The git repository and details how to clone it can be found at
http://cgit.freedesktop.org/gstreamer/<xsl:value-of select="module" />/

==== Homepage ====

The project's website is &realsite;/

==== Support and Bugs ====

We use GNOME's bugzilla for bug reports and feature requests:
&gst-bug-report;

Please submit patches via bugzilla as well.

For help and support, please subscribe to and send questions to the
gstreamer-devel mailing list (see below for details).

There is also a #gstreamer IRC channel on the Freenode IRC network.

==== Developers ====

GStreamer is stored in Git, hosted at git.freedesktop.org, and can be cloned
from there (see link above).

Interested developers of the core library, plugins, and applications should
subscribe to the gstreamer-devel list.

        <xsl:apply-templates select="applications" />

        <xsl:apply-templates select="contributors" />

        <xsl:apply-templates select="maintainers" />
&nbsp;</xsl:template>

</xsl:stylesheet>
