<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % site-entities SYSTEM "../entities.site">
  %site-entities;
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:output method="xml"/>

<xsl:template match="news">
<rdf:RDF
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns="http://purl.org/rss/1.0/"
>
<channel rdf:about="http://www.gstreamer.net/news/">
  <title>GStreamer News</title>
  <link>&site;/news/</link>
  <description>Latest news from the GStreamer project</description>
  <items>
    <rdf:Seq>
      <rdf:li rdf:resource="..."/>
<xsl:for-each select="item">
  <xsl:sort data-type="text" select="date" order="descending" />
  <xsl:variable name="w3cdtf">
    <xsl:value-of select="substring(date,1,10)"/>
    <xsl:text>T</xsl:text>
    <xsl:value-of select="substring(date,12,16)"/>
    <xsl:text>:00Z</xsl:text>
  </xsl:variable>
  <rdf:li rdf:resource="&site;/news/#{$w3cdtf}"/>
</xsl:for-each>
    </rdf:Seq>
  </items>
</channel>

<xsl:for-each select="item">
  <xsl:sort data-type="text" select="date" order="descending" />
  <xsl:variable name="w3cdtf">
    <xsl:value-of select="substring(date,1,10)"/>
    <xsl:text>T</xsl:text>
    <xsl:value-of select="substring(date,12,16)"/>
    <xsl:text>:00Z</xsl:text>
  </xsl:variable>
  <item rdf:about="&site;/news/#{$w3cdtf}">
    <title><xsl:value-of select="title"/></title>
    <link>&site;/news/</link>
    <dc:date><xsl:value-of select="$w3cdtf"/></dc:date>
    <content:encoded><xsl:value-of select="content"/></content:encoded>
  </item>
</xsl:for-each>
</rdf:RDF>

</xsl:template>

</xsl:stylesheet>
