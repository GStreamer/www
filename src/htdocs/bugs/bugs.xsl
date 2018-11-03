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
https://gitlab.freedesktop.org/gstreamer/<xsl:value-of select="component" />/issues/?scope=all&amp;state=all&amp;milestone_title=<xsl:value-of select="$milestone" /></xsl:attribute>
    <xsl:value-of select="$milestone" />
  </xsl:element>
</xsl:template>


<xsl:template match="module">
<!--
<td valign="top">
<table border="1" cellspacing="0" cellpadding="2">
-->
<tr>

<!-- component -->
<td><b><xsl:value-of select="@id" /></b></td>

<!-- create a new bug for this component -->
<!-- <tr> -->
  <td>
    <xsl:element name="a">
      <xsl:attribute name="href">
https://gitlab.freedesktop.org/gstreamer/<xsl:value-of select="component" />/issues/new</xsl:attribute>
create issue
    </xsl:element>
  </td>
<!-- </tr> -->


<!-- blocker bugs for this component -->
<!-- <tr> -->
  <td>
    <xsl:element name="a">
      <xsl:attribute name="href">
https://gitlab.freedesktop.org/gstreamer/<xsl:value-of select="component" />/issues?scope=all&amp;state=opened&amp;label_name[]=Blocker</xsl:attribute>
blockers
    </xsl:element>
  </td>
<!-- </tr> -->


<!-- unresolved bugs for this component -->
<!-- <tr> -->
  <td>
    <xsl:element name="a">
      <xsl:attribute name="href">
https://gitlab.freedesktop.org/gstreamer/<xsl:value-of select="component" />/issues?scope=all&amp;state=opened</xsl:attribute>
open
    </xsl:element>
  </td>
<!-- </tr> -->

  <xsl:for-each select="milestones/milestone">
<!-- <tr> -->
  <td>
  <xsl:call-template name="hyperlink.bug">
    <xsl:with-param name="id"><xsl:value-of select="../../@id" /></xsl:with-param>
    <xsl:with-param name="component"><xsl:value-of select="../../component" /></xsl:with-param>
    <xsl:with-param name="milestone"><xsl:value-of select="." /></xsl:with-param>
  </xsl:call-template>
  </td>
<!-- </tr> -->
  </xsl:for-each>
</tr>
<!--
</table>
</td>
-->
</xsl:template>

<xsl:template match="buglists">
  <xsl:call-template name="page">
    <xsl:with-param name="title">GStreamer: Bug Lists</xsl:with-param>
    <xsl:with-param name="content">
<h1>Bug Search</h1>
<p>
  <!-- This might come in handy when someone figures out how to make it
       find bugs where the short_desc OR the long_desc matches the search terms
       rather than all bugs where both match. Add this to the form element:
         onSubmit="CopyValue(short_desc,long_desc)"
       For now we just search the bug titles.
  <script>
   function CopyValue(obj1, obj2)
   {
     var visibleField = obj1;
     obj2.value = visibleField.value;
   }
  </script>
  -->
  <form name="f" action="https://gitlab.freedesktop.org/groups/gstreamer/-/issues" method="get">
    <input type="hidden" name="scope" value="all" />
    <input type="hidden" name="state" value="opened" />
    <input id="show" type="submit" value="search" />
  </form>
</p>

<h1>Bug Lists</h1>
<table border="0" cellspacing="10" cellpadding="2">
<tr><td>
<a href="https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&amp;state=opened">All unresolved issues</a>
</td></tr>
<tr><td>
<a href="https://gitlab.freedesktop.org/gstreamer/gstreamer-project/issues?scope=all&amp;state=opened">All unresolved issues not assigned to a component</a>
</td></tr>
<tr><td>
<a href="https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&amp;state=closed&amp;milestone_title=No+Milestone">Fixed issues which need to be reassigned to the right milestone</a>
</td></tr>
<tr><td>
<a href="https://gitlab.freedesktop.org/groups/gstreamer/-/issues?scope=all&amp;sort=updated_desc&amp;state=all">All issues sorted by last update</a>,
</td></tr>
<tr><td>
<a href="https://gitlab.freedesktop.org/gstreamer">GStreamer gitlab overview</a>
</td></tr>
</table>

<h1>Bugs per Module</h1>
<table border="0" cellspacing="10" cellpadding="2">
<xsl:apply-templates />
</table>

    </xsl:with-param>
  </xsl:call-template>

</xsl:template>

</xsl:stylesheet>
