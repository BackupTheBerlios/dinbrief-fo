<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Root element. -->
  <xsl:template match="letters">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="letter" page-height="297mm" page-width="210mm">
          <fo:region-body margin-top="11cm" margin-bottom="20mm" margin-left="24mm" margin-right="25mm"/>
          <fo:region-before extent="12cm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <xsl:apply-templates/>
    </fo:root>
  </xsl:template>

  <!-- Letter. -->
  <xsl:template match="letter">
    <xsl:for-each select="recipients/recipient">
      <fo:page-sequence master-reference="letter">
        <fo:static-content flow-name="xsl-region-before">
          <!-- Folding marks. -->
          <fo:block-container position="absolute" left="0cm" top="10.5cm" width="0.5cm" height="0cm" border-bottom="solid" border-bottom-width="0.1pt"><fo:block/></fo:block-container>
          <fo:block-container position="absolute" left="0cm" top="21cm" width="0.5cm" height="0cm" border-bottom="solid" border-bottom-width="0.1pt"><fo:block/></fo:block-container>

          <fo:block-container position="absolute" left="2cm" top="4.5cm" width="8.5cm" height="4.5cm">
            <!-- Sender. -->
            <fo:block font-size="6pt" border-bottom="solid" border-bottom-width="1pt" text-align="center"><xsl:apply-templates select="../../sender/returnline"/></fo:block>

            <!-- Recipient. -->
            <fo:block font-size="10pt" space-before.optimum="3em"><xsl:apply-templates select="name"/></fo:block>
            <xsl:if test="additionalline">
              <fo:block font-size="10pt"><xsl:apply-templates select="additionalline"/></fo:block>
            </xsl:if>
            <fo:block font-size="10pt"><xsl:apply-templates select="street"/></fo:block>
            <fo:block font-size="10pt"><xsl:if test="country != 'DE'"><xsl:apply-templates select="country"/>-</xsl:if><xsl:apply-templates select="postcode"/><xsl:text> </xsl:text><xsl:apply-templates select="city"/></fo:block>
          </fo:block-container>
1
          <fo:block font-size="10pt" margin-left="3cm" margin-right="45mm" space-before.optimum="12.5mm" space-after.optimum="2em"></fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <!-- Subject. -->
          <fo:block font-size="10pt" font-weight="bold" space-after.optimum="2em" text-align="justify"><xsl:value-of select="../../subject"/></fo:block>

          <!-- Salutation and body text. -->
          <xsl:apply-templates select="../../salutation"/>

          <xsl:apply-templates select="../../text"/>

          <xsl:apply-templates select="../../closing"/>
        </fo:flow>
      </fo:page-sequence>
    </xsl:for-each>
  </xsl:template>

  <!-- Salutation. -->
  <xsl:template match="salutation">
    <fo:block font-size="10pt" space-after.optimum="1em" text-align="justify"><xsl:apply-templates/></fo:block>
  </xsl:template>

  <!-- Paragraph. -->
  <xsl:template match="para">
    <fo:block font-size="10pt" space-after.optimum="1em" text-align="justify"><xsl:apply-templates/></fo:block>
  </xsl:template>

  <!-- Unnumbered list. -->
  <xsl:template match="ul">
    <fo:list-block font-size="10pt" space-after.optimum="1em" provisional-distance-between-starts="1.5em" provisional-label-separation="0.5em">
      <xsl:for-each select="li">
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()"><fo:block>&#8211;</fo:block></fo:list-item-label>
          <fo:list-item-body start-indent="body-start()"><fo:block text-align="justify"><xsl:value-of select="."/></fo:block></fo:list-item-body>
        </fo:list-item>
      </xsl:for-each>
    </fo:list-block>
  </xsl:template>

  <!-- Closing. -->
  <xsl:template match="closing">
    <fo:block font-size="10pt" space-after.optimum="3em" text-align="justify"><xsl:apply-templates/></fo:block>
    <fo:block font-size="10pt" text-align="justify"><xsl:value-of select="../sender/name"/></fo:block>
  </xsl:template>
</xsl:stylesheet>
