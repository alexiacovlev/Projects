
	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:crm="http://mscrm" version="1.0" exclude-result-prefixes="msxsl crm">
	<xsl:output method="html" indent="no"/>
	<xsl:param name="sortCol"/>	
	<xsl:param name="numberFormat"/>
	<xsl:param name="numberFormatMask"/>
	<xsl:param name="currencySymbol"/>

	
	<xsl:decimal-format name="us" grouping-separator="," decimal-separator="."/>
	<xsl:decimal-format name="eu" grouping-separator="." decimal-separator=","/>
	<xsl:decimal-format name="fr" grouping-separator=" " decimal-separator=","/>
	<xsl:decimal-format name="nz" grouping-separator="'" decimal-separator="."/>
	
	
	<xsl:template name="replace">
		<xsl:param name="source" />
		<xsl:param name="oldVal" />
		<xsl:param name="newVal" />
		<xsl:variable name="temp" select="$source" />
		<xsl:variable name="first" select="substring-before($temp, $oldVal)" />
		<xsl:variable name="rest" select="substring-after($temp, $oldVal)" />
		<xsl:value-of select="concat($first, $newVal)" />
		<xsl:choose>
			<xsl:when test="(substring-before($rest, $oldVal)) or (substring-after($rest, $oldVal))">
				<xsl:call-template name="replace">
					<xsl:with-param name="source" select="$rest" />
					<xsl:with-param name="oldVal" select="$oldVal" />
					<xsl:with-param name="newVal" select="$newVal" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$rest" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	

	<xsl:template match="resultset">
		<table id="gridBodyTable" cellspacing="0" cellpadding="1" class="gridData" oname="">

			
						<col style="padding-left:5px;"/>
					
						<col width="100">
							<xsl:if test="$sortCol='Email'">
								<xsl:attribute name="style">background-color:#ffffff;</xsl:attribute>
							</xsl:if>
						</col>
					
						<col width="100">
							<xsl:if test="$sortCol='IsApproved'">
								<xsl:attribute name="style">background-color:#ffffff;</xsl:attribute>
							</xsl:if>
						</col>
					
						<col width="100">
							<xsl:if test="$sortCol='IsLockedOut'">
								<xsl:attribute name="style">background-color:#ffffff;</xsl:attribute>
							</xsl:if>
						</col>
					
						<col width="100">
							<xsl:if test="$sortCol='LastLoginDate'">
								<xsl:attribute name="style">background-color:#ffffff;</xsl:attribute>
							</xsl:if>
						</col>
					
						<col width="100">
							<xsl:if test="$sortCol='UserId'">
								<xsl:attribute name="style">background-color:#ffffff;</xsl:attribute>
							</xsl:if>
						</col>
					

			<xsl:for-each select="result">
				<tr>
					<xsl:attribute name="style">background-color:<xsl:choose><xsl:when test="1 = position() mod 2">#ffffff;</xsl:when><xsl:otherwise>#f2f2f6;</xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:attribute name="oid"><xsl:value-of select="UserId"/></xsl:attribute>

					
						<td>
							
			
			<xsl:value-of select="CreateDate/@date"/>
			
			
				<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><xsl:value-of select="CreateDate/@time"/>
			
						</td>
					
						<td>
							
		
			<xsl:value-of select="Email"/>
					
		
						</td>
					
						<td>
							
			<xsl:value-of select="IsApproved"/>
		
						</td>
					
						<td>
							
			<xsl:value-of select="IsLockedOut"/>
		
						</td>
					
						<td>
							
			
			<xsl:value-of select="LastLoginDate/@date"/>
			
			
				<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text><xsl:value-of select="LastLoginDate/@time"/>
			
						</td>
					
						<td>
							
			
			<xsl:value-of select="UserId"/>
			
		
						</td>
					
				</tr>
			</xsl:for-each>
		</table>

	</xsl:template>

	</xsl:stylesheet>
	
