<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % site-entities SYSTEM "entities.site">
  %site-entities;
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="html"/>

  <xsl:include href="header.xsl" />

<!-- this template outputs a complete <a href > construction given the href -->
<xsl:template name="hyperlink">
  <xsl:param name="href" />
  <!-- if no text param specified, we default to the href value -->
  <xsl:param name="text" select="$href"/>
  <xsl:element name="a">
    <xsl:attribute name="href">
      <xsl:value-of select="$href" />
    </xsl:attribute>
    <xsl:value-of select="$text" />
  </xsl:element>
</xsl:template>



<!-- page template -->
<!-- call with content variable containing html content to paste verbatim -->
<xsl:template name="page">
<xsl:param name="title" select="GStreamer" />
<xsl:param name="content" />
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
    <link rel="stylesheet" type="text/css"
          href="&site;/gstreamer.css" title="default" />
    <link rel="shortcut icon" href="&site;/images/favicon.png" />
    <title><xsl:value-of select="$title" /></title>
  </head>
  <body bgcolor="#FFFFFF" text="#000000"
        link="#3399CC" vlink="#551A8B" alink="#FF0000" leftmargin="0"
        topmargin="0" marginwidth="0" marginheight="0" rightmargin="0">

  <!-- this is the top table with our logo -->
  <table border="0" width="100%" cellpadding="0" cellspacing="0">
    <tr>
      <td bgcolor="#000000">
        <a href="&site;/"><img src="&site;/images/header-logo-top.png"
           height="53" width="351" alt="GStreamer" border="0" /></a>
      </td>
      <td align="right" bgcolor="#000000"></td>
    </tr>
    <tr>
      <td colspan="2">
        <a href="/"><img src="&site;/images/header-logo-bottom.png" height="23" width="277" border="0" alt="" /></a>
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <img src="&site;/images/header-osmf.png" height="14" width="527" alt="open source multimedia framework" />
      </td>
    </tr>
  </table>

  <!-- this is the page table start, where we put menu and content -->
  <table border="0" width="100%" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top" width="146"> 
        <!-- insert menu contents here -->
        <xsl:apply-templates select="document('header.xml')" />
      </td>
      <!-- white spacing between menu on left and page content --> 
      <td width="22"><img src="&site;/images/1x1.gif" alt="" border="0" width="22" height="2" /></td>
      <td valign="top"><br/>
      <!-- paste the page content passed with a param here -->
      <xsl:copy-of select="$content" />
      </td>
      <!-- close the page table -->
    </tr>
    <tr>
      <td width="22"><img src="&site;/images/1x1.gif" alt="" border="0" width="22" height="2" /></td>
      <td valign="top"><br/></td>
    </tr>
  </table>

  <div style="background: #FF3333; height: 2px; width: 100%;"></div>
  <div style="background: #339933; height: 2px; width: 100%;"></div>
  <div style="background: #3333CC; height: 2px; width: 100%;"></div>

    </body>
    </html>
</xsl:template>

<!-- index page contents -->
  <xsl:template match="page">
    <xsl:call-template name="page">
      <xsl:with-param name="content">
        <xsl:apply-templates select="document('news/news.xml')" />
        <xsl:apply-templates />
        <!-- copy contents of body verbatim -->
        <xsl:copy-of select="body/node()" />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- by default we ignore the news, unless another stylesheet includes us
       and overrides the news template, like index.xsl -->
  <xsl:template match="news" />
  <xsl:template match="title" />
  <xsl:template match="body" />
</xsl:stylesheet>
