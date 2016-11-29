<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
                                                                                
  <xsl:output method="html"/>

  <xsl:template match="alerts">
      <p><table width="95%" border="0" cellspacing="0" cellpadding="2">
      <xsl:for-each select="advisory">
        <xsl:sort data-type="text" select="date" order="descending" />
        <xsl:variable name="w3cdtf">
          <xsl:value-of select="substring(date,1,10)"/>
          <xsl:text>T</xsl:text>
          <xsl:value-of select="substring(date,12,16)"/>
          <xsl:text>:00Z</xsl:text>
        </xsl:variable>
        <xsl:variable name="detail-file">
            <xsl:text>sa-</xsl:text>
            <xsl:value-of select='id'/>
            <xsl:text>.html</xsl:text>
        </xsl:variable>
        <tr>
            <td valign="top"><h3 id="{$w3cdtf}">GStreamer-SA-<xsl:value-of select="id"/>
            <xsl:for-each select="alternate-name">
            (<xsl:value-of select="text()"/>)
            </xsl:for-each>
            </h3></td>
          <td valign="top" align="right"><xsl:value-of select="date"/></td>
        </tr>
        <tr><td colspan="2"><xsl:copy-of select="summary/node()"/>&nbsp;<a href="{$detail-file}">Details</a>
        </td></tr>
      </xsl:for-each>
  </table></p>
  </xsl:template>

</xsl:stylesheet>
