<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="html"/>

  <xsl:include href="../page.xsl" />
  <xsl:include href="alerts.xsl" />

  <xsl:template match="page">
    <xsl:call-template name="page">
      <xsl:with-param name="content">
  <h1>Security Center</h1>
  <h2>Security Contacts</h2>
  <p>
     Security notifications or problems should be reported in <a href="https://gitlab.freedesktop.org/gstreamer">GitLab</a>
     by <u><a href="https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/new?issue[confidential]=true">filing an issue</a></u>
     and marking it as <i>confidential</i> before submitting it (if you follow the link on the left the confidential checkbox should already be ticked).
  </p>
  <p>
     If you have patches, please attach them to the confidential issue and not via a merge requests, as merge requests are always public immediately.
  </p>
  <p>
     The GStreamer project encourages <a href="https://en.wikipedia.org/wiki/Responsible_disclosure">responsible disclosure</a>
     of security issues.
  </p>

  <h2>Security Advisories</h2>
  <xsl:apply-templates select="document('alerts.xml')" />
        <xsl:apply-templates />
        <!-- copy contents of body verbatim -->
        <xsl:copy-of select="body/node()" />
      </xsl:with-param>
      <xsl:with-param name="title">
        <xsl:value-of select="title" />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
