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
  <p>Security notifications or problems can be sent to our security email address. The GStreamer project encourages responsible disclosure of security issues.</p>
  <p><strong>Email:</strong>&nbsp; <a href="mailto:gstreamer-security@lists.freedesktop.org">gstreamer-security@<!-- -->lists.freedesktop.org</a></p>
  <p>This list is read only by GStreamer maintainers. If desired, emails to the security list can be encrypted using either of these GPG keys:
      <ul>
          <li>4096R/86C2D7B5 fingerprint 7F4B C7CC 3CA0 6F97 336B BFEB 0668 CC14 86C2 D7B5 (Sebastian Dröge sebastian@centricular.com)</li>
          <li>4096R/8625F39E fingerprint B32B 24B4 8737 B503 47EC 9491 4A9D C757 8625 F39E (Jan Schmidt jan@centricular.com)</li>
      </ul>
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
