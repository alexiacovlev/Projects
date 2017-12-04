
	<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" version="1.0" exclude-result-prefixes="msxsl">
	<xsl:output method="html" indent="no"/>	
	<xsl:param name="currencySymbol"/>
	<xsl:param name="numberFormat"/>
	<xsl:param name="numberFormatMask"/>
	<xsl:param name="privilegeId"/>
	<xsl:param name="timeFormat"/>
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


	<xsl:template match="/Data">

		<table width="100%" cellspacing="0" cellpadding="0">
				
					<tr><td class="formDesc"></td>
					
					<td align="right"><xsl:value-of disable-output-escaping="yes" select="QuickDesignLink"/></td>
					
					</tr>
				
				
				<tr>
					<td valign="top" colspan="2">
						

							<div class="tab" id="tab0" style="display:inline;">
								<table width="100%" cellspacing="0" cellpadding="3" style="table-layout:fixed;">
									<col width="120"/><col/><col width="120" style="padding-left:20px;"/><col/>
										
													<tr>
														
    	<td class="n" style="vertical-align:top;">
    		Message	
    	</td>
    	
			<td class="f" colspan="3">
				
				<textarea tabindex="5" rows="4" name="Message" maxlength="2000">
				<xsl:value-of select="Message"/>
				</textarea>
			
    	</td>
		
													</tr>
												
													<tr>
														
    	<td class="n">
    		Login	
    	</td>
    	
			<td class="f">
				
						<input tabindex="10" type="text" name="UserName" maxlength="255" value="">
						<xsl:attribute name="value"><xsl:value-of select="UserName"/></xsl:attribute>
						</input>
						
    	</td>
		
    	<td class="n">
    		Full Name	
    	</td>
    	
			<td class="f">
				
				<table cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed;">
				<tr>
				<td nowrap="">
				<div class="lu" lookupclass="UM_Users" handlermode="readonly">
				<xsl:for-each select="UserId/item">
				<span class="lui" otype="UM_Users">
				<xsl:attribute name="oid">
				<xsl:value-of select="."/>
				</xsl:attribute>
				<xsl:attribute name="otype">
				<xsl:value-of select="@type"/>
				</xsl:attribute>
				<xsl:attribute name="onclick">fmOpenLookup();</xsl:attribute>

				<img class="lui"><xsl:attribute name="src"><xsl:value-of select="$fmSettingsPath"/>_LOOKUP/UM_Users/<xsl:value-of select="@type"/>.gif</xsl:attribute>
				</img>
				<xsl:value-of select="@name"/>
				</span><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</xsl:for-each>
				<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</div>
				</td>
				<td width="25" style="text-align: right;" valign="top">

				
						<img tabindex="30" class="lu" fieldname="UserId"
						
						 lookupbrowse="" lookupstyle="" lookupclass="UM_Users" lookupobjects="">
						<xsl:attribute name="src"><xsl:value-of select="$fmCommonPath"/>Images/btn_off_lookup.gif</xsl:attribute>
						</img>
					
				<span>
				<xsl:for-each select="UserId/item">
				<input crmType="lu" type="hidden" name="UserId" otype="UM_Users">
				<xsl:attribute name="value"><xsl:value-of select="@data"/></xsl:attribute>
				</input>
				</xsl:for-each>
				<xsl:if test="not(UserId)">
				<input crmType="lu" type="hidden" name="UserId" otype="UM_Users"/>
				</xsl:if>
				</span>

				</td>

				</tr>
				</table>
			
    	</td>
		
													</tr>
												
													<tr>
														
    	<td class="n">
    		EventTime	
    	</td>
    	
			<td class="f">
				
								
    									<table cellpadding="0" cellspacing="0" width="100%" style="table-layout:fixed;">
    									<col/><col width="40"/>
    									<tr>
    										<td>
    											<input tabindex="15" type="text" crmType="dtm" class="dtm" name="EventTime" maxlength="10">
    												<xsl:attribute name="value">
    													<xsl:if test="EventTime"><xsl:value-of select="EventTime/@date"/></xsl:if>
    												</xsl:attribute>
    												<xsl:attribute name="returnValue">
    													<xsl:value-of select="EventTime"/>
    												</xsl:attribute>
    											</input>
    										</td>
    										<td style="padding-left:4px;">
    											<img class="dtm" id="EventTimeImg">
								<xsl:attribute name="src"><xsl:value-of select="$fmCommonPath"/>Images/btn_off_cal.gif</xsl:attribute>
								</img>
    										</td>
    									</tr>
    								</table>
    								

							
    	</td>
		
    	<td class="n">
    		IP Address	
    	</td>
    	
			<td class="f">
				
						<input tabindex="35" type="text" name="IPAddress" maxlength="15" value="">
						<xsl:attribute name="value"><xsl:value-of select="IPAddress"/></xsl:attribute>
						</input>
						
    	</td>
		
													</tr>
												
													<tr>
														
    	<td class="n">
    		EventType	
    	</td>
    	
			<td class="f">
				
						<input tabindex="20" type="text" name="EventType" maxlength="50" value="">
						<xsl:attribute name="value"><xsl:value-of select="EventType"/></xsl:attribute>
						</input>
						
    	</td>
		
																		<td></td>
																		<td></td>
																	
													</tr>
												
									</table>
							</div>
						
					</td>
				</tr>
				
			
		</table>
			
	</xsl:template>
	</xsl:stylesheet>
