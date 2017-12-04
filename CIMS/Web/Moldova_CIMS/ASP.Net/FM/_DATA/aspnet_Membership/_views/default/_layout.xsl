
	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:rm="http://alfa-xp.com" version="1.0" exclude-result-prefixes="msxsl rm">
	<xsl:output method="html" indent="no"/>
	<xsl:param name="sortCol"/>	
	<xsl:param name="numberFormat"/>
	<xsl:param name="numberFormatMask"/>
	<xsl:param name="currencySymbol"/>
	<xsl:param name="colWidths"/>
	<xsl:param name="fmCommonPath"/>	
	<xsl:param name="fmSettingsPath"/>	

	
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
		<table id="gridBodyTable" onmouseover="RenderToolTip();" onclick="handleClick();" ondblclick="handleDblClick();" cellspacing="0" cellpadding="1" class="gridData" oname="">
			<xsl:attribute name="morerecords"><xsl:choose><xsl:when test="@morerecords = 1">1</xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:attribute>

			
				<col width="20" style="padding-left:0px;"/>
			
					
						<col>
							<xsl:choose>
								<xsl:when test="$sortCol='CreateDate'">
									<xsl:attribute name="style">padding-left:10px;background-color:#f2f2f6;</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="style">padding-left:10px;</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</col>
						
					
						
							<col>
							<xsl:attribute name="width">
								<xsl:choose>
									<xsl:when test="$colWidths">
										<xsl:call-template name="ParseCommaDelimitedString">
											<xsl:with-param name="data" select="$colWidths"/>
											<xsl:with-param name="position" select="2"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>110</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:if test="$sortCol='Email'">
								<xsl:attribute name="style">background-color:#f2f2f6;</xsl:attribute>
							</xsl:if>
						</col>
					
						
							<col>
							<xsl:attribute name="width">
								<xsl:choose>
									<xsl:when test="$colWidths">
										<xsl:call-template name="ParseCommaDelimitedString">
											<xsl:with-param name="data" select="$colWidths"/>
											<xsl:with-param name="position" select="3"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>110</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:if test="$sortCol='IsApproved'">
								<xsl:attribute name="style">background-color:#f2f2f6;</xsl:attribute>
							</xsl:if>
						</col>
					
						
							<col>
							<xsl:attribute name="width">
								<xsl:choose>
									<xsl:when test="$colWidths">
										<xsl:call-template name="ParseCommaDelimitedString">
											<xsl:with-param name="data" select="$colWidths"/>
											<xsl:with-param name="position" select="4"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>110</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:if test="$sortCol='IsLockedOut'">
								<xsl:attribute name="style">background-color:#f2f2f6;</xsl:attribute>
							</xsl:if>
						</col>
					
						
							<col>
							<xsl:attribute name="width">
								<xsl:choose>
									<xsl:when test="$colWidths">
										<xsl:call-template name="ParseCommaDelimitedString">
											<xsl:with-param name="data" select="$colWidths"/>
											<xsl:with-param name="position" select="5"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>110</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:if test="$sortCol='LastLoginDate'">
								<xsl:attribute name="style">background-color:#f2f2f6;</xsl:attribute>
							</xsl:if>
						</col>
					
						
							<col>
							<xsl:attribute name="width">
								<xsl:choose>
									<xsl:when test="$colWidths">
										<xsl:call-template name="ParseCommaDelimitedString">
											<xsl:with-param name="data" select="$colWidths"/>
											<xsl:with-param name="position" select="6"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>110</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:if test="$sortCol='UserId'">
								<xsl:attribute name="style">background-color:#f2f2f6;</xsl:attribute>
							</xsl:if>
						</col>
					
			
			<xsl:for-each select="result">
				<tr>
					<xsl:attribute name="oid"><xsl:value-of select="UserId"/></xsl:attribute>
					
						<td><img>
						<xsl:attribute name="src"><xsl:value-of select="$fmCommonPath"/>Images/Grid/r.gif</xsl:attribute>
						</img></td>
					
	<td><nobr>
	
	
			<xsl:value-of select="CreateDate/@date"/>
			
	</nobr></td>
	

	<td><nobr>
	
	
			<xsl:value-of select="Email"/>
		
	</nobr></td>
	

	<td><nobr>
	
	
			<xsl:value-of select="IsApproved/@name"/>
		
	</nobr></td>
	

	<td><nobr>
	
	
			<xsl:value-of select="IsLockedOut/@name"/>
		
	</nobr></td>
	

	<td><nobr>
	
	
			<xsl:value-of select="LastLoginDate/@date"/>
			
	</nobr></td>
	

	<td><nobr>
	
	
			<xsl:value-of select="UserId"/>
		
	</nobr></td>
	


				</tr>
			</xsl:for-each>
		</table>

	</xsl:template>


	
		<xsl:template name="ParseCommaDelimitedString">
			<xsl:param name="data"/>
			<xsl:param name="position"/>
			<xsl:choose>
				<xsl:when test="contains($data,',')">
					<xsl:choose>
						<xsl:when test="$position = 1">
				
							<!-- Return the first value in the string -->
							<xsl:value-of select="substring-before($data,',')"/>
			
						</xsl:when>
						<xsl:when test="$position > 1">
			
							<!-- Loop through the string until we find the n position -->
							<xsl:call-template name="ParseCommaDelimitedString">
								<xsl:with-param name="data" select="substring-after($data,',')"/>
								<xsl:with-param name="position" select="$position - 1"/>
							</xsl:call-template>
			
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>

					<!-- Return the last value in the string -->
					<xsl:value-of select="$data"/>

				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	



	</xsl:stylesheet>
	
