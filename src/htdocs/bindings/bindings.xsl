<?xml version='1.0'?>
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

<xsl:include href="../page.xsl" />

<!-- this template writes the index file -->
<xsl:template name="write.index">
  <xsl:variable name="dotext">.html</xsl:variable>
  <exsl:document href="index{$dotext}" method="html">
    <xsl:call-template name="page">
      <xsl:with-param name="title">GStreamer: Bindings</xsl:with-param>
      <xsl:with-param name="content">
<h2>Bindings</h2>
<p>
There are bindings for GStreamer for quite a few languages already.
</p>
<p>
Here's a quick overview of all of our bindings :
                                                                                
<table width="95%" border="1" cellspacing="0" cellpadding="2">
<tr>
  <th>language</th>
  <th>status</th>
</tr>

        <xsl:for-each select="binding">
<tr>
  <td>
          <xsl:call-template name="hyperlink">
            <xsl:with-param name="href"><xsl:value-of select="id" />.html</xsl:with-param>
            <xsl:with-param name="text"><xsl:value-of select="name" /></xsl:with-param>
          </xsl:call-template>
  </td>
  <td><xsl:copy-of select="status" /></td>
</tr>
 
        </xsl:for-each>
</table>
</p>
      </xsl:with-param>
    </xsl:call-template>
  </exsl:document>
</xsl:template>

<!-- this template writes a separate file for each binding -->
<xsl:template name="write.binding">
  <xsl:variable name="id"><xsl:copy-of select="id"/></xsl:variable> 
  <xsl:variable name="dotext">.html</xsl:variable> 
  <exsl:document href="{concat ($id, $dotext)}" method="html">
    <xsl:call-template name="page">
      <xsl:with-param name="content">
<h1>Bindings for <xsl:value-of select="name" /></h1>
<table>
<tr>
<td colspan="2">
<xsl:copy-of select="body/node()" />
<p>
<br/>
</p>
</td>
</tr>

<xsl:apply-templates select="news" />

<xsl:apply-templates select="issues" />

<xsl:apply-templates select="contacts" />

</table>
      </xsl:with-param>
    </xsl:call-template>
  </exsl:document>
</xsl:template>

<!-- this template matches contacts sections -->
<xsl:template match="contacts">
<TR>
  <TD>
    <H2>Contact Information</H2>
<DL>
  <xsl:for-each select="person">
  <DT><xsl:value-of select="realname" /></DT>
  <DD><xsl:value-of select="email" /></DD>
  </xsl:for-each>
</DL>
<p>
<br/>
</p>
  </TD>
</TR>
</xsl:template>

<!-- this template matches issues sections -->
<xsl:template match="issues">
<TR>
  <TD>
    <H2>Issues</H2>
    <UL>
      <xsl:for-each select="issue">
        <LI><xsl:value-of select="." /></LI>
      </xsl:for-each>
    </UL>
<p>
<br/>
</p>
  </TD>
</TR>
</xsl:template>

<!-- this template matches news sections -->
<xsl:template match="news">
<TR>
  <TD>
    <H2>News</H2>
    <DL>
      <xsl:for-each select="item">
        <DT><xsl:value-of select="date" /></DT>
        <DD><xsl:value-of select="text" /></DD>
      </xsl:for-each>
    </DL>
<p>
<br/>
</p>
  </TD>
</TR>
</xsl:template>


<!-- this is the entry template -->
<xsl:template match="bindings">
  <xsl:call-template name="write.index">
    <xsl:with-param name="dotext">.html</xsl:with-param>
  </xsl:call-template>
  <xsl:for-each select="binding">
    <xsl:call-template name="write.binding">
      <xsl:with-param name="dotext">.html</xsl:with-param>
  </xsl:call-template>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
