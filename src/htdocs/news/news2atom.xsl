<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % site-entities SYSTEM "../entities.site">
  %site-entities;
]>
<!--

FIXME!!!

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:output method="xml"/>

<xsl:template match="news">
<feed version="0.3" xmlns="http://purl.org/atom/ns#">
  <title>GStreamer News</title>
  <link rel="alternate" type="text/html" href="&site;/news/"/>
  <modified><xsl:value-of select="item/date"/></modified>
  <author>
    <name>The GStreamer Developers</name>
  </author>
  <xsl:for-each select="item">
    <xsl:sort data-type="text" select="date" order="descending" />
    <entry>
      <title><xsl:value-of select="title"/></title>
      <link rel="alternate" type="text/html" href="&site;/news/"/>
      <id>tag:gstreamer.net<xsl:value-of select="date"/></id>
      <issued><xsl:value-of select="date"/></issued>
      <modified><xsl:value-of select="date"/></modified>
      <content><xsl:value-of select="content"/></content>
    </entry>
  </xsl:for-each>
</feed>
</xsl:template>

</xsl:stylesheet>
