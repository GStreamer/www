<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
                                                                                
 <xsl:output method="html"/>

  <xsl:template match="news">
  <table>
    <xsl:for-each select="item">
      <xsl:sort data-type="text" select="date" order="descending" />
      <xsl:variable name="w3cdtf">
        <xsl:value-of select="substring(date,1,10)"/>
        <xsl:text>T</xsl:text>
        <xsl:value-of select="substring(date,12,16)"/>
        <xsl:text>:00Z</xsl:text>
      </xsl:variable>
      <tr>
        <td><h3 id="{$w3cdtf}"><xsl:value-of select="title"/></h3></td>
        <td align="right"><xsl:value-of select="date"/></td>
      </tr>
      <tr><td colspan="2"><xsl:copy-of select="content"/></td></tr>
    </xsl:for-each>
  </table>
  </xsl:template>

</xsl:stylesheet>
