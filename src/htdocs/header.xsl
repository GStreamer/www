<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % site-entities SYSTEM "entities.site">
  %site-entities;
]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- transform the menu using the site entity for links -->
<xsl:template match="menu">

<!-- actual menu -->
  <table border="0" width="146" cellpadding="0" cellspacing="0">
    <tr><td><img src="&site;/images/backslash.png" alt="" height="48" width="100%" /></td></tr>
    <tr>
      <td bgcolor="#666666" valign="top">
        <!-- table inside the graphics for menu items -->
        <table border="0" cellpadding="2" cellspacing="0">
          <tr><td colspan="2"><img src="&site;/images/1x1.gif" alt="" border="0" width="2" height="2" /></td></tr>
          <xsl:for-each select="item">
          <tr>
            <td width="140" bgcolor="#CCCCCC" align="center">
              <xsl:choose>
                <xsl:when test="substring(@href, 1, 7) = 'http://'">
              <b><a href="{@href}" class="gstnavside">
                 <xsl:value-of select="." /></a></b>
                </xsl:when>
                <xsl:otherwise>
              <b><a href="&site;{@href}" class="gstnavside">
                 <xsl:value-of select="." /></a></b>
                </xsl:otherwise>
              </xsl:choose>
            </td>
            <td><img src="&site;/images/1x1.gif" border="0" width="2" height="2" alt="" /></td>
          </tr>
          <tr><td colspan="2"><img src="&site;/images/1x1.gif" border="0" width="2" height="2" alt="" /></td></tr>
          </xsl:for-each>
        </table>
      </td>
    </tr>
    <tr><td><img src="&site;/images/slash.png" alt="" height="41" width="100%" /></td></tr>
  </table>

</xsl:template>

</xsl:stylesheet>
