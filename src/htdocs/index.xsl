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
  <table>
    <xsl:for-each select="item">
      <xsl:sort data-type="text" select="date" order="descending" />
         <xsl:if test="position() = 1">
           <tr>
            <td><h1>News - <xsl:value-of select="title"/></h1></td>
            <td align="right"><xsl:value-of select="date"/></td>
           </tr>
           <tr><td colspan="2"><xsl:copy-of select="content"/></td></tr>
           <tr>
            <td><h3>Recent older news:</h3></td>
           </tr>
         </xsl:if>
          <xsl:if test="position() &lt;= 3 and position() != 1">
           <tr>
            <td><xsl:value-of select="title"/></td>
            <td align="right"><xsl:value-of select="date"/></td>
           </tr>
         </xsl:if>
     </xsl:for-each>
           <tr>
            <td>Click for <a href="news/news.php">even older news</a>...</td>
           </tr>

  </table>
  </xsl:template>
</xsl:stylesheet>
