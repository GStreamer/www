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

<!-- this template outputs a complete <a href > for a component and version -->
<xsl:template name="hyperlink">
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
<table border="1">
<tr><td><xsl:value-of select="@id" /></td></tr>

  <xsl:for-each select="milestones/milestone">
<tr>
  <td>
  <xsl:call-template name="hyperlink">
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
<table>
<tr>
<xsl:apply-templates />
</tr>
</table>

<A href="http://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;component=gstreamer+%28core%29&amp;bug_status=UNCONFIRMED&amp;bug_status=NEW&amp;bug_status=ASSIGNED&amp;bug_status=NEEDINFO&amp;bug_status=REOPENED&amp;email1=&amp;emailtype1=substring&amp;emailassigned_to1=1&amp;email2=&amp;emailtype2=substring&amp;emailreporter2=1&amp;changedin=&amp;chfieldfrom=&amp;chfieldto=Now&amp;chfieldvalue=&amp;short_desc=&amp;short_desc_type=substring&amp;long_desc=&amp;long_desc_type=substring&amp;bug_file_loc=&amp;bug_file_loc_type=substring&amp;status_whiteboard=&amp;status_whiteboard_type=substring&amp;keywords=&amp;keywords_type=anywords&amp;op_sys_details=&amp;op_sys_details_type=substring&amp;version_details=&amp;version_details_type=substring&amp;cmdtype=doit&amp;namedcmd=GStreamer&amp;newqueryname=&amp;order=Reuse+same+sort+as+last+time&amp;form_name=query">Unresolved bug list</A>

    </xsl:with-param>
  </xsl:call-template>

</xsl:template>

</xsl:stylesheet>
