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
https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;component=<xsl:value-of select="$component" /><![CDATA[&]]>target_milestone=<xsl:value-of select="$milestone" /></xsl:attribute>
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
https://bugzilla.gnome.org/enter_bug.cgi?product=GStreamer&amp;component=<xsl:value-of select="component" />
      </xsl:attribute>
create bug
    </xsl:element>
  </td>
<!-- </tr> -->


<!-- blocker bugs for this component -->
<!-- <tr> -->
  <td>
    <xsl:element name="a">
      <xsl:attribute name="href">
https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;component=<xsl:value-of select="component" />&amp;bug_status=UNCONFIRMED&amp;bug_status=NEW&amp;bug_status=ASSIGNED&amp;bug_status=NEEDINFO&amp;bug_status=REOPENED&amp;bug_severity=blocker&amp;form_name=query
      </xsl:attribute>
blockers
    </xsl:element>
  </td>
<!-- </tr> -->


<!-- unresolved bugs for this component -->
<!-- <tr> -->
  <td>
    <xsl:element name="a">
      <xsl:attribute name="href">
https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;component=<xsl:value-of select="component" />&amp;bug_status=UNCONFIRMED&amp;bug_status=NEW&amp;bug_status=ASSIGNED&amp;bug_status=NEEDINFO&amp;bug_status=REOPENED&amp;form_name=query
      </xsl:attribute>
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
  <form name="f" action="https://bugzilla.gnome.org/buglist.cgi" method="get">
    <input type="hidden" name="query_format" value="advanced" />
    <input type="hidden" name="product" value="GStreamer" />
    <input type="hidden" name="bug_status" value="UNCONFIRMED" />
    <input type="hidden" name="bug_status" value="NEW" />
    <input type="hidden" name="bug_status" value="ASSIGNED" />
    <input type="hidden" name="bug_status" value="REOPENED" />
    <input type="hidden" name="bug_status" value="NEEDINFO" />
    <input type="hidden" name="long_desc_type" value="allwordssubstr" />
    <input type="hidden" name="long_desc" value="" id="long_desc" />
    <input type="hidden" name="short_desc_type" value="allwordssubstr" />
    <input type="text" name="short_desc" id="short_desc" />
    <input id="show" type="submit" value="Search" />
  </form>
</p>

<h1>Bug Lists</h1>
<table border="0" cellspacing="10" cellpadding="2">
<tr><td>
<a href="https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;bug_status=UNCONFIRMED&amp;bug_status=NEW&amp;bug_status=ASSIGNED&amp;bug_status=NEEDINFO&amp;bug_status=REOPENED&amp;form_name=query">All unresolved bugs</a>
</td></tr>
<tr><td>
<a href="https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;component=don%27t%20know&amp;bug_status=UNCONFIRMED&amp;bug_status=NEW&amp;bug_status=ASSIGNED&amp;bug_status=NEEDINFO&amp;bug_status=REOPENED&amp;form_name=query">All unresolved bugs not assigned to a component</a>
</td></tr>
<tr><td>
<a href="https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;bug_status=RESOLVED&amp;resolution=FIXED&amp;resolution=VERIFIED&amp;target_milestone=HEAD&amp;target_milestone=HEART&amp;target_milestone=1.0.x&amp;target_milestone=1.1.x&amp;target_milestone=1.2.x&amp;target_milestone=1.3.x&amp;target_milestone=1.4.x&amp;target_milestone=2.x&amp;form_name=query">Fixed bugs which need to be reassigned to the right milestone</a>
</td></tr>
<tr><td>
All bugs changed within the last
<a href="https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=1">24 hours</a>,
<a href="https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=2">48 hours</a>,
<a href="https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=3">72 hours</a>,
<a href="https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=7">1 week</a>,
<a href="https://bugzilla.gnome.org/buglist.cgi?product=GStreamer&amp;changedin=14">2 weeks</a>
</td></tr>
<tr><td>
<a href="https://bugzilla.gnome.org/browse.cgi?product=GStreamer">GStreamer bugzilla overview</a>
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
