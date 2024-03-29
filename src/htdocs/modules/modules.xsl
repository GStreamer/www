<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % gst-entities SYSTEM "../entities.gst">
  %gst-entities;
  <!ENTITY % site-entities SYSTEM "../entities.site">
  %site-entities;
]>


<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  version="1.0">

<xsl:include href="../page.xsl" />

<!-- this template writes the index file -->
<xsl:template name="write.index">
  <xsl:variable name="dotext">.html</xsl:variable>
  <exsl:document href="index{$dotext}" method="html">
    <xsl:call-template name="page">
      <xsl:with-param name="title">GStreamer: Modules</xsl:with-param>
      <xsl:with-param name="content">
<h2>Modules</h2>
<p>
GStreamer is a large project, so it's split up into several modules.
Most people need at least gstreamer, gst-plugins-base and gst-plugins-good
to do anything useful.
</p>
<p>
Here's a quick overview of all of our modules :
                                                                                
<table width="95%" border="1" cellspacing="0" cellpadding="2">
<tr>
  <th>module</th>
  <th>description</th>
  <th>stable version</th>
  <th>devel version</th>
  <th>status</th>
</tr>

        <xsl:for-each select="module">
<tr>
  <td>
          <xsl:call-template name="hyperlink">
            <xsl:with-param name="href"><xsl:value-of select="id" />.html</xsl:with-param>
            <xsl:with-param name="text"><xsl:value-of select="id" /></xsl:with-param>
          </xsl:call-template>
  </td>
  <td><xsl:value-of select="blurb" /></td>
  <td>
    <!-- add link to gitlab if it says 'git main'; no link if it says 'N/A' -->
    <xsl:choose>
      <xsl:when test="versions/stable/text() = string('git main')">
        <xsl:call-template name="hyperlink">
          <xsl:with-param name="href">http://gitlab.freedesktop.org/gstreamer/<xsl:value-of select="repo-path" />/</xsl:with-param>
          <xsl:with-param name="text">git main</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>

        <xsl:choose>
          <xsl:when test="versions/stable/text() = string('N/A')">
            N/A
          </xsl:when>
          <xsl:otherwise>

            <xsl:choose>
              <xsl:when test="versions/stable/text() = string('obsolete')">
                obsolete
              </xsl:when>
              <xsl:otherwise>

              <xsl:choose>
                <xsl:when test="id = string('qt-gstreamer')">
                  <xsl:value-of select="versions/stable" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="id = string('orc')">
                      <xsl:value-of select="versions/stable" />
                    </xsl:when>
                    <xsl:otherwise>

                      <xsl:call-template name="hyperlink">
                        <xsl:with-param name="href">
                          &site;/releases/&gst-branch-stable;/#<xsl:value-of select="versions/stable" /></xsl:with-param>
                        <xsl:with-param name="text"><xsl:value-of select="versions/stable" /></xsl:with-param>
                      </xsl:call-template>

                    </xsl:otherwise>
                  </xsl:choose>

                </xsl:otherwise>
              </xsl:choose>

            </xsl:otherwise>
          </xsl:choose>

          </xsl:otherwise>
        </xsl:choose>

      </xsl:otherwise>
      &#160;
    </xsl:choose>
  </td>
  <td>
    <!-- add link to gitlab if it says 'git main'; no link if it says 'N/A' -->
    <xsl:choose>
      <xsl:when test="versions/devel/text() = string('git main')">
        <xsl:call-template name="hyperlink">
          <xsl:with-param name="href">http://gitlab.freedesktop.org/gstreamer/<xsl:value-of select="repo-path" />/</xsl:with-param>
          <xsl:with-param name="text">git main</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>

        <xsl:choose>
          <xsl:when test="versions/devel/text() = string('N/A')">
            N/A
          </xsl:when>
          <xsl:otherwise>

            <xsl:choose>
              <xsl:when test="versions/stable/text() = string('obsolete')">
                obsolete
              </xsl:when>
              <xsl:otherwise>

                <xsl:call-template name="hyperlink">
                  <xsl:with-param name="href">
                    &site;/releases/<xsl:value-of select="id" />/<xsl:value-of select="versions/devel" />.html</xsl:with-param>
                  <xsl:with-param name="text">
                    <xsl:value-of select="versions/devel" />
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>

           </xsl:otherwise>
        </xsl:choose>

      </xsl:otherwise>
      &#160;
    </xsl:choose>
  </td>
  <td><xsl:value-of select="status" /></td>
</tr>
 
        </xsl:for-each>
</table>
</p>
      </xsl:with-param>
    </xsl:call-template>
  </exsl:document>
</xsl:template>

<!-- this template writes a separate file for each module -->
<xsl:template name="write.module">
  <xsl:variable name="id"><xsl:copy-of select="id"/></xsl:variable> 
  <xsl:variable name="dotext">.html</xsl:variable>
  <exsl:document href="{concat ($id, $dotext)}" method="html">
    <xsl:call-template name="page">
      <xsl:with-param name="content">
<h1><xsl:value-of select="title" /></h1>
<table>
<tr>
<td colspan="2">
<xsl:copy-of select="description/node()" />
<p>
<br/>
</p>
</td>
</tr>

<tr>
  <td>Maintainer</td>
  <td>
    <xsl:choose>
      <xsl:when test="not(maintainer)">N/A</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="maintainer" />
      </xsl:otherwise>
    </xsl:choose>
  </td>
</tr>

<tr>
  <td>browse Git</td>
  <td>
    <xsl:choose>
      <xsl:when test="not(repo-path)">N/A</xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="hyperlink">
          <xsl:with-param name="href">&gst-repo-http;<xsl:value-of select="repo-path" />
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </td>
</tr>
<tr>
  <td>Source download</td>
  <td>
    <xsl:call-template name="hyperlink">
      <xsl:with-param name="href">&site;/src/<xsl:value-of select="id" /></xsl:with-param>
    </xsl:call-template>
  </td>
</tr>

<!--only show screenshot if there is a screenshot entry -->
<xsl:if test="screenshot">
<tr>
<td colspan="2">
  <p>
  <br/>
  </p>
  <xsl:element name="img">
    <xsl:attribute name="src">
      &site;/data/images/<xsl:value-of select="screenshot/src" />
    </xsl:attribute>
    <xsl:attribute name="alt"><xsl:value-of select="screenshot/@alt"/></xsl:attribute>
    <xsl:attribute name="width"><xsl:value-of select="screenshot/@width"/></xsl:attribute>
    <xsl:attribute name="height"><xsl:value-of select="screenshot/@height"/></xsl:attribute>
    <xsl:attribute name="border">1</xsl:attribute>
  </xsl:element>
</td>
</tr>
</xsl:if>
</table>
      </xsl:with-param>
    </xsl:call-template>
  </exsl:document>
</xsl:template>

<xsl:template match="modules">
  <xsl:call-template name="write.index">
    <xsl:with-param name="dotext">.html</xsl:with-param>
  </xsl:call-template>
  <xsl:for-each select="module">
    <xsl:call-template name="write.module">
      <xsl:with-param name="dotext">.html</xsl:with-param>
  </xsl:call-template>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
