<?xml version='1.0'?> <!--*- mode: xml -*-->
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % site-entities SYSTEM "../entities.site">
  %site-entities;
]>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  version="1.0">
  <xsl:output method="html" />
  <xsl:include href="../page.xsl" />

  <!-- toplevel node -->
  <xsl:template match="plugins">
    <xsl:call-template name="page">
      <xsl:with-param name="content">
        <h1>Overview of available plug-ins</h1>
        <xsl:element name="table">
          <xsl:attribute name="border" value="1" />
          <xsl:for-each select="plugin">
            <xsl:sort select="name" />
            <xsl:call-template name="plugin" />
          </xsl:for-each>
        </xsl:element>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- for all plugins -->
  <xsl:template name="plugin">

    <!-- hyperlink to the actual plugin documentation -->
    <xsl:element name="tr">
      <td>Plugin</td>

      <!-- td with link to plugin documentation -->
      <xsl:element name="td">
        <xsl:attribute name="colspan">2</xsl:attribute>
        <xsl:element name="a">
          <xsl:attribute name="href">&site;/data/doc/gstreamer/head/<xsl:value-of select="source" />-plugins/html/<xsl:value-of select="source" />-plugins-plugin-<xsl:value-of select="name"/>.html</xsl:attribute>
          <xsl:value-of select="name"/>
        </xsl:element>
      </xsl:element>

      <!-- td with description -->
      <xsl:element name="td">
        <xsl:value-of select="description" />
      </xsl:element>

      <!-- td with link to and name of the source module -->
      <xsl:element name="td">
        <xsl:element name="a">
          <xsl:attribute name="href">&site;/modules/<xsl:value-of select="source" />.html</xsl:attribute>
          <xsl:value-of select="source" />
        </xsl:element>
      </xsl:element>

      <!-- td with version of the source module -->
      <xsl:element name="td">
        <xsl:value-of select="version"/>
      </xsl:element>
    </xsl:element>

    <!-- elements in this plugin -->
    <xsl:for-each select="elements">
      <xsl:apply-templates name="element" />
    </xsl:for-each>
  </xsl:template>

  <!-- for every element -->
  <xsl:template match="element">
    <xsl:element name="tr">
      <td colspan="2"></td>

      <!-- td with link to the element documentation -->
      <xsl:element name="td">
        <xsl:attribute name="alignment">right</xsl:attribute>
        has 
        <xsl:element name="a">
          <xsl:attribute name="href">&site;/data/doc/gstreamer/head/<xsl:value-of select="../../source" />-plugins/html/<xsl:value-of select="../../source" />-plugins-<xsl:value-of select="name"/>.html</xsl:attribute>
          <xsl:value-of select="name"/>
        </xsl:element>
      </xsl:element>

      <!-- td with description -->
      <xsl:element name="td">
        <xsl:value-of select="description"/>
      </xsl:element>

    </xsl:element> <!-- tr -->
  </xsl:template>

</xsl:stylesheet>
