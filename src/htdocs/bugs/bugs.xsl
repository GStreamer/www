<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY % site-entities SYSTEM "../entities.site">
  %site-entities;
]>


<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  version="1.0">

<xsl:include href="../page.xsl" />

<!-- this template outputs a complete <a href > for a component and milestone -->
<xsl:template name="hyperlink.bug">
  <xsl:param name="id" />
  <xsl:param name="component" />
  <xsl:param name="milestone" />

  <xsl:element name="a">
    <xsl:attribute name="href">
http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;component=<xsl:value-of select="$component" /><![CDATA[&]]>target_milestone=<xsl:value-of select="$milestone" /></xsl:attribute>
    <xsl:value-of select="$milestone" />
  </xsl:element>
</xsl:template>


<xsl:template match="module">
<td valign="top">
<table border="1" cellspacing="0" cellpadding="2">
<tr><th><xsl:value-of select="@id" /></th></tr>

<!-- create a new bug for this component -->
<tr>
  <td>
    <xsl:element name="a">
      <xsl:attribute name="href">
http://bugzilla.gnome.org/enter_bug.cgi?product=GStreamer&amp;component=<xsl:value-of select="component" />
      </xsl:attribute>
create bug
    </xsl:element>
  </td>
</tr>


<!-- blocker bugs for this component -->
<tr>
  <td>
    <xsl:element name="a">
      <xsl:attribute name="href">
http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;component=<xsl:value-of select="component" />&amp;bug_status=UNCONFIRMED&amp;bug_status=NEW&amp;bug_status=ASSIGNED&amp;bug_status=NEEDINFO&amp;bug_status=REOPENED&amp;bug_severity=blocker&amp;form_name=query
      </xsl:attribute>
blocker
    </xsl:element>
  </td>
</tr>


<!-- unresolved bugs for this component -->
<tr>
  <td>
    <xsl:element name="a">
      <xsl:attribute name="href">
http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;component=<xsl:value-of select="component" />&amp;bug_status=UNCONFIRMED&amp;bug_status=NEW&amp;bug_status=ASSIGNED&amp;bug_status=NEEDINFO&amp;bug_status=REOPENED&amp;form_name=query
      </xsl:attribute>
unresolved
    </xsl:element>
  </td>
</tr>

  <xsl:for-each select="milestones/milestone">
<tr>
  <td>
  <xsl:call-template name="hyperlink.bug">
    <xsl:with-param name="id"><xsl:value-of select="../../@id" /></xsl:with-param>
    <xsl:with-param name="component"><xsl:value-of select="../../component" /></xsl:with-param>
    <xsl:with-param name="milestone"><xsl:value-of select="." /></xsl:with-param>
  </xsl:call-template>
  </td>
</tr>
  </xsl:for-each>
</table>
</td>
</xsl:template>

<xsl:template match="buglists">
  <xsl:call-template name="page">
    <xsl:with-param name="title">GStreamer: Bug Lists</xsl:with-param>
    <xsl:with-param name="content">
<h1>Bug Lists</h1>
<table border="0">
<tr>
  <td colspan="4">
<a href="http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;bug_status=UNCONFIRMED&amp;bug_status=NEW&amp;bug_status=ASSIGNED&amp;bug_status=NEEDINFO&amp;bug_status=REOPENED&amp;form_name=query">All unresolved bugs</a>
  </td>
</tr>
<tr>
  <td colspan="4">
<a href="http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;component=don%27t%20know&amp;bug_status=UNCONFIRMED&amp;bug_status=NEW&amp;bug_status=ASSIGNED&amp;bug_status=NEEDINFO&amp;bug_status=REOPENED&amp;form_name=query">All unresolved bugs not assigned to a component</a>
  </td>
</tr>
<tr>
  <td colspan="4">
<a href="http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;bug_status=RESOLVED&amp;resolution=FIXED&amp;target_milestone=HEAD&amp;form_name=query">All fixed in HEAD bugs (need to reassign to milestones)</a>
  </td>
</tr>
<tr>
  <td colspan="6">
All bugs changed within the last
<a href="http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=1">24 hours</a>, 
<a href="http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=2">48 hours</a>,
<a href="http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=3">72 hours</a>,
<a href="http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=7">1 week</a>,
<a href="http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=14">2 weeks</a>
  </td>
</tr>
<tr>
  <td colspan="4">
<a href="http://bugzilla.gnome.org/browse.cgi?product=GStreamer">GStreamer bugzilla overview</a>
  </td>
</tr>
<tr>
<xsl:apply-templates />
</tr>
</table>

    </xsl:with-param>
  </xsl:call-template>

</xsl:template>

</xsl:stylesheet>
