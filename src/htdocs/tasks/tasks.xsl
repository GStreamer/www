<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="html"/>
  <xsl:include href="../page.xsl"/>
  
  <xsl:template match="tasks">
   <div class="task-nav">
     <A href="gnome.html">[GNOME tasks]</A>&nbsp;
     <A HREF="gstreamer.html">[GStreamer tasks]</A>&nbsp;
     <A href="people.html">[people involved]</A>&nbsp;
   </div>
   <div class="task-header">
     <H3><xsl:value-of select="@title"/></H3>
   </div>
   <UL>
    <xsl:for-each select="task">
     <LI>
      <xsl:element name="a">
        <xsl:attribute name="href">#<xsl:value-of select="@name"/></xsl:attribute>
        <xsl:copy-of select="title/text()"/>
      </xsl:element>
     </LI>
    </xsl:for-each>
   </UL>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="task">
    <div class="task">
      <!-- start task header -->
      <div class="task-header">
        <!-- generate task anchor -->
        <xsl:element name="a">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute>
        </xsl:element>

        <H3><xsl:value-of select="title/text()"/></H3>
      </div>
      <!-- end task header -->

      <!-- start task body -->
      <div class="task-body">
        <div class="task-word">What</div>
        <div class="task-text"><xsl:copy-of select="description/node()"/></div>
        <div class="task-word">Why</div>
        <div class="task-text"><xsl:copy-of select="why/node()"/></div>
        <div class="task-word">How</div>
        <div class="task-text"><xsl:copy-of select="how/node()"/></div>
        <div class="task-word">Where</div>
        <div class="task-text">
          <xsl:if test="count(where/*) > 0">
            <DL>
              <xsl:for-each select="where/*">
                <!-- make a link to a code bit -->
                <DT>
                  <xsl:element name="a">
                    <xsl:attribute name="href">code.html#<xsl:value-of select="@id"/></xsl:attribute>
                    <xsl:copy-of select="name/node()"/>
                  </xsl:element>
                </DT> 
                <DD> 
                  <xsl:value-of select="description/node()"/>
                </DD> 
              </xsl:for-each>
            </DL>
          </xsl:if>
        </div>
    
        <xsl:if test="count(see/*) > 0">
          <div class="task-word">Who to contact</div>
          <div class="task-text">
            <xsl:for-each select="see/*">
              <xsl:element name="a">
                <xsl:attribute name="href">people.html#<xsl:value-of select="text()"/></xsl:attribute>
                <xsl:value-of select="."/>
              </xsl:element>
            <!-- do we need a comma? -->
            <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>
          </div>
        </xsl:if>
        <div class="task-word">Difficulty</div>
        <div class="task-text"><xsl:copy-of select="difficulty/node()"/></div>
        <xsl:if test="count(./submit) > 0">
          <div class="task-word">Submit</div>
          <div class="task-text"><xsl:copy-of select="submit/node()"/></div>
        </xsl:if>
      </div>
      <!-- end task body -->

      <!-- start task footer -->
      <div class="task-footer">
        <div class="task-text">
          <I><xsl:copy-of select="notes/node()"/></I>
        </div>
      </div>
      <!-- end task footer -->
    </div>
  </xsl:template>

  <xsl:template match="people">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="person">
    <div class="task">
      <!-- generate person anchor -->
      <xsl:element name="a">
        <xsl:attribute name="name">
          <xsl:value-of select="@name"/>
        </xsl:attribute>
      </xsl:element>
  
    <div class="task-body">
      <div class="task-word">
        <xsl:value-of select="@name"/>
      </div>
        <TABLE>
        <TR>
          <TD class="task-cell">Real Name</TD>
          <TD class="task-cell"><xsl:value-of select="realname/text()"/></TD>
        </TR>
        <TR>
          <TD class="task-cell">E-mail</TD>
          <TD class="task-cell"><xsl:value-of select="email/text()"/></TD>
        </TR>
        <TR>
          <TD class="task-cell">nick</TD>
          <TD class="task-cell"><xsl:value-of select="nick/text()"/></TD>
        </TR>
        <TR>
          <TD class="task-cell">IRC location</TD>
          <TD class="task-cell"><xsl:value-of select="irc/text()"/></TD>
        </TR>
        <TR>
          <TD class="task-cell">Role</TD>
          <TD class="task-cell"><xsl:value-of select="role/text()"/></TD>
        </TR>
        </TABLE>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="codes">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="code">
    <div class="task">
      <!-- generate code anchor -->
      <xsl:element name="a">
        <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
      </xsl:element>
  
      <div class="task-body">
        <div class="task-word">
          <xsl:value-of select="description/text()"/>
        </div>
        <TABLE>
        <TR>
          <TD class="task-cell">Code location</TD>
          <TD class="task-cell"><xsl:value-of select="repo/text()"/></TD>
        </TR>
        <TR>
          <TD class="task-cell">Code path</TD>
          <TD class="task-cell">
            <!-- provide a link to the code in Git if we have one -->
            <!-- FIXME. there's got to be a better way then looping over all
                 repo location definitions ? -->
            <!-- first we store the id of the repo and the path in that repo -->
            <xsl:variable name="which"><xsl:value-of select="repo/text()"/></xsl:variable>
            <xsl:variable name="dir"><xsl:value-of select="path/text()"/></xsl:variable>
            <!-- then we loop over all repos, selecting where of... = $which -->
              <xsl:for-each select="//repos/repo[@of=$which]">
                <xsl:element name="a">
                  <xsl:attribute name="href">
                    <xsl:value-of select="web/text()"/>
                    <xsl:value-of select="$dir"/>
              </xsl:attribute>
              <xsl:value-of select="$dir"/>
            </xsl:element>
                </xsl:for-each>
          </TD>
        </TR>
        </TABLE>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="repos">
  </xsl:template>

  <!-- fake out title and body so it doesn't get printed verbatim -->
  <xsl:template match="title" />
  <xsl:template match="body" />
  
</xsl:stylesheet>
