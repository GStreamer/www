<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="html"/>

  <xsl:include href="page.xsl" />
                                                                               
<!-- recent news template -->

  <xsl:template match="news">
  <table border="0" width="100%">
    <xsl:for-each select="item">
      <xsl:sort data-type="text" select="date" order="descending" />
        <xsl:if test="position() = 1">
          <tr>
            <td colspan="2"><h1>News - <xsl:value-of select="title"/></h1></td>
          </tr>
          <tr>
            <td><xsl:copy-of select="content"/><br /></td>
            <td valign="top" align="right"><xsl:value-of select="date"/></td>
          </tr>
          <tr>
           <td colspan="2"><h3>Recent older news:</h3></td>
          </tr>
        </xsl:if>
        <xsl:if test="position() &lt;= 3 and position() != 1">
          <tr>
           <td><xsl:value-of select="title"/></td>
           <td valign="top" align="right"><xsl:value-of select="date"/></td>
          </tr>
        </xsl:if>
      </xsl:for-each>
      <tr>
        <td>Click for <a href="news/">even older news</a>...</td>
      </tr>
      <tr>
        <td>News feeds: <a href="news/rss-1.0.xml">[RSS 1.0]</a></td>
      </tr>
    </table>
  </xsl:template>
</xsl:stylesheet>
