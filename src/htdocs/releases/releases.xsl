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

  <xsl:include href="../page.xsl" />

  <!-- this template displays the features -->
  <xsl:template match="features">
    <h2>Features of this release</h2>
    <ul>
    <xsl:for-each select="feature">
      <li><xsl:value-of select="." /></li>
    </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- this template displays the issues -->
  <xsl:template match="issues">
    <h2>Known issues</h2>
    <ul>
    <xsl:for-each select="issue">
      <li><xsl:value-of select="." /></li>
    </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- this template displays the bugs fixed -->
  <xsl:template match="bugs">
    <xsl:choose>
     <xsl:when test="count(bug) > 0">
       <h2>Bugs fixed in this release</h2>
       <ul>
       <xsl:for-each select="bug">
         <li>
           <xsl:call-template name="hyperlink">
             <xsl:with-param name="href">http://bugzilla.gnome.org/show_bug.cgi?id=<xsl:value-of select="id" /></xsl:with-param>
             <xsl:with-param name="text"><xsl:value-of select="id" /></xsl:with-param>
           </xsl:call-template>
           : <xsl:value-of select="summary" />
         </li>
       </xsl:for-each>
       </ul>
     </xsl:when>
     <xsl:otherwise>
       <h2> No bugs were fixed in this release </h2>
     </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- this template displays the API changes -->
  <xsl:template match="api">
   <xsl:choose>
    <xsl:when test="count((additions|removals|deprecations)/*) > 0">
      <h2>API changes</h2>
      <ul>
        <xsl:apply-templates select="additions" />
        <xsl:apply-templates select="removals" />
        <xsl:apply-templates select="deprecations" />
      </ul>
    </xsl:when>
    <xsl:otherwise>
      <h2> There were no API changes in this release </h2>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

  <!-- this template matches the API additions -->
  <xsl:template match="additions">
    <xsl:if test="count(./*) > 0">
     <li>API additions
       <xsl:call-template name="item-list">
         <xsl:with-param name="parent">
           <xsl:value-of select="." />
         </xsl:with-param>
       </xsl:call-template>
     </li>
    </xsl:if>
  </xsl:template>
  <!-- this template matches the API removals -->
  <xsl:template match="removals">
    <xsl:if test="count(./*) > 0">
     <li>API removals
       <xsl:call-template name="item-list">
         <xsl:with-param name="parent">
           <xsl:value-of select="." />
         </xsl:with-param>
       </xsl:call-template>
     </li>
    </xsl:if>
  </xsl:template>
  <!-- this template matches the API deprecations -->
  <xsl:template match="deprecations">
    <xsl:if test="count(./*) > 0">
     <li>API deprecations
       <xsl:call-template name="item-list">
         <xsl:with-param name="parent">
           <xsl:value-of select="." />
         </xsl:with-param>
       </xsl:call-template>
     </li>
    </xsl:if>
  </xsl:template>

  <!-- this template displays the contributors -->
  <xsl:template match="contributors">
    <h2>Contributors to this release</h2>
    <ul>
    <xsl:for-each select="person">
      <li><xsl:value-of select="." /></li>
    </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- this template displays the maintainers -->
  <xsl:template match="maintainers">
    <h2>Maintainers</h2>
    <ul>
    <xsl:for-each select="person">
      <li><xsl:value-of select="." /></li>
    </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- this template displays the application notes -->
  <xsl:template match="applications">
    <h2>Applications</h2>
    <xsl:copy-of select="." />
  </xsl:template>

  <!-- this template outputs the release notes -->
  <xsl:template match="release">
    <xsl:call-template name="page">
      <xsl:with-param name="title">
Release notes for
<xsl:value-of select="module-fancy" />&nbsp;<xsl:value-of select="version" />
"<xsl:value-of select="name" />"
      </xsl:with-param>
      <xsl:with-param name="content">
<h1>
Release notes for
<xsl:value-of select="module-fancy" />&nbsp;<xsl:value-of select="version" />
<xsl:if test="not(normalize-space(name)='')">
"<xsl:value-of select="name" />"
</xsl:if>
</h1>
        <xsl:copy-of select="intro" />

        <xsl:apply-templates select="features" />
        <xsl:apply-templates select="issues" />
        <xsl:apply-templates select="bugs" />
        <xsl:apply-templates select="api" />

<h2>Download</h2>

<p>
You can find source releases of <xsl:copy-of select="module" /> in the
<xsl:call-template name="hyperlink">
  <xsl:with-param name="href">&realsite;/src/<xsl:value-of select="module" />/</xsl:with-param>
  <xsl:with-param name="text"><xsl:value-of select="module" /> download directory</xsl:with-param>
</xsl:call-template>.
</p>
<p>
The git repository and details how to clone it can be found at
 <xsl:choose>
  <xsl:when test="module = 'gst-validate'">
    <xsl:call-template name="hyperlink">
      <xsl:with-param name="href">http://cgit.freedesktop.org/gstreamer/gst-devtools/</xsl:with-param>
      <xsl:with-param name="text">git.freedesktop.org</xsl:with-param>
    </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
    <xsl:call-template name="hyperlink">
      <xsl:with-param name="href">http://cgit.freedesktop.org/gstreamer/<xsl:value-of select="module" />/</xsl:with-param>
      <xsl:with-param name="text">git.freedesktop.org</xsl:with-param>
    </xsl:call-template>
  </xsl:otherwise>
 </xsl:choose>
.
</p>


<h2>Homepage</h2>

The project's website is <a href="&realsite;">&realsite;</a>.

<h2>Support and Bugs</h2>

<p>
We use GNOME's bugzilla for
<a href="&gst-bug-report;">bug reports and feature requests</a>.
</p>
<p>
Please submit patches via bugzilla as well.
</p>
<p>
For help and support, please subscribe to and send questions to the
gstreamer-devel mailing list (see below for details).
</p>
<p>
Find us on IRC at #gstreamer.
</p>

<h2>Developers</h2>

<p>
Git is hosted on git.freedesktop.org.  You can
 <xsl:choose>
  <xsl:when test="module = 'gst-validate'">
    <xsl:call-template name="hyperlink">
    <xsl:with-param name="href">&gst-repo-http;gst-devtools/</xsl:with-param>
    <xsl:with-param name="text">browse the gst-devtools repository (where gst-validate lives).</xsl:with-param>
    </xsl:call-template>.
  </xsl:when>
  <xsl:otherwise>
    <xsl:call-template name="hyperlink">
    <xsl:with-param name="href">&gst-repo-http;<xsl:value-of select="module" />/</xsl:with-param>
    <xsl:with-param name="text">browse the <xsl:value-of select="module" /> repository</xsl:with-param>
    </xsl:call-template>.
  </xsl:otherwise>
 </xsl:choose>

</p>
<p>
All code is in Git and can be checked out from there.
</p>
<p>
Interested developers of the core library, plugins, and applications should
subscribe to the gstreamer-devel list.
</p>

        <xsl:apply-templates select="applications" />

        <xsl:apply-templates select="contributors" />

        <xsl:apply-templates select="maintainers" />

      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
