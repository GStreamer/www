<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
                                                                                
  <xsl:output method="html"/>
  <xsl:include href="../page.xsl" />

  <xsl:template match="advisory">
  <xsl:call-template name="page">

      <xsl:with-param name="content">
      <div>
          <h1>Security Advisory <xsl:value-of select="id"/>
            <xsl:for-each select="alternate-name">
            (<xsl:value-of select="text()"/>)
            </xsl:for-each>
          </h1>
          <div>
              <table>
                  <tr><td><strong>Summary</strong></td>
                      <td><xsl:copy-of select="summary/node()"/></td>
                  </tr>
                  <tr><td><strong>Date</strong></td>
                      <td><xsl:value-of select="date"/></td>
                  </tr>
                  <tr><td valign="top"><strong>Affected Versions</strong></td>
                      <td><xsl:copy-of select="affected-versions/node()"/></td>
                  </tr>
                  <tr><td><strong>ID</strong></td>
                      <td>GStreamer-SA-<xsl:value-of select="id"/></td>
                  </tr>
                  <xsl:for-each select="alternate-name">
                      <tr><td><strong><xsl:value-of select="@type"/></strong></td>
                          <td><xsl:value-of select="text()"/></td></tr>
            </xsl:for-each>
              <tr><td></td></tr>
              </table>
          </div>

          <h2>Details</h2>
          <xsl:copy-of select="details/node()"/>
          <h2>Impact</h2>
          <xsl:copy-of select="impact/node()"/>
          <h2>Threat mitigation</h2>
          <xsl:copy-of select="mitigation/node()"/>
          <h2>Workarounds</h2>
          <xsl:copy-of select="workarounds/node()"/>
          <h2>Solution</h2>
          <xsl:copy-of select="solution/node()"/>
          <xsl:for-each select="references">
          <div class="references">
          <h2>References</h2>
            <xsl:for-each select="reference">
                <h3><xsl:value-of select="title" /></h3>
                <div><xsl:copy-of select="content/node()" /></div>
            </xsl:for-each>
          </div>
          </xsl:for-each>
      </div>
      </xsl:with-param>
    </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>
