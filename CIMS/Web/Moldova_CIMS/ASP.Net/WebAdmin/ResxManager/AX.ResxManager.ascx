<%@ Control Language="C#" Inherits="AX.PortalAdmin.Modules.ResxManagerControl" %>
<div style="position:relative;height:100%;">
	<div class="rx-bg" style="height:60px;position:absolute;width:100%;">
		<div style="font-size:10pt;color:#37377c;text-decoration:underline;font-weight:bold;margin:10px;">Resx Manager</div>
		<div style="margin:10px 0 10px 20px;font-style:italic"><label><%= FileName %></label><label style="margin-left:5px;" id="lblCount">(..)</label><%= (IsSystem=="true")?"<label> - system protected":"" %><label id="panelInfo" style="font-weight:bold;display:<%= (IsUnpublished?"":"none") %>"> - unpublished</label></div>
		<img src="/ASP.Net/System/Images/48_alert.png" style="display:none"/>
	</div>
	<div style="position:absolute;top:60px;width:100%;">
		<table id="panelAdd" style="display:none" cellspacing="6">
			<tr><td colspan="2" class="hdr">Resource Key / Default Text</td></tr>
			<tr>
				<td><label>Name:</label><label style="color:red">*</label></td><td style="width:250px"><input class="fm" /></td>
			</tr>
			<tr><td colspan="2" class="hdr">Translations:</td></tr>
			<%= sbAdd_Rows.ToString() %>
			<tr id="Msg" style="display:none;"><td colspan="2" style="color:#990000;text-align:right;font-style:italic">Please, enter the Resource Key</td></tr>			
		</table>
		<div id="_toolbar" class="fm-dg-toolbar" style="height:24px;padding:0;font-family:Verdana;font-size:11px;margin:0;border-top:solid 1px #adadad;border-bottom:solid 1px #adadad">
			<div>
				<% if (IsSystem != "true") { %>
				<a cmd="add" style="cursor:pointer;"><img src="/ASP.Net/Images/ico/create_record.png" style="height:16px;position:relative;top:4px;margin-right:3px;margin-left:3px;">Add&nbsp;</a>
				<i class="V"></i>&nbsp;&nbsp;
				<% } %>
				<div style="display:inline-block;margin-left:2px;"><label>Quick Find:</label><input id="tbSearch" style="width:180px;margin:3px 0 0 5px;display:inline-block;font-family:Verdana;font-size:11px;" /></div>
				<a cmd="find" style="padding-left:6px;cursor:pointer;"><img src="/ASP.Net/Images/ico/page_find.png" style="width:16px;position:relative;top:4px;"/>&nbsp;</a>
				<label id="searchMsg" style="display:none;color:#05568b">No matches found</label>
			</div>
			<div class="fm-menu" style="position:absolute;right:0;top:1px;display:none;" id="panelMenu">
				<i class="V"></i>&nbsp;
				<a cmd="publish" style="cursor:pointer"><img src="/ASP.Net/Images/ico/ico_16_customAttributeMap.png" width="16">Publish Recource File&nbsp;</a>
			</div>
		</div>
		<table class="rx-dg-header" cellspacing="0" cellpadding="0" style="height:28px;">
			<colgroup><col /><%= sbHeader_Cols.ToString() %><col width="17" /></colgroup>
			<tr id="rowHdr">
				<td class="rx-dg-hdr">Name (Resource Key)</td><%= sbHeader_Cells.ToString() %><td>&nbsp;</td>
			</tr>
		</table>
	</div>
	<div style="position:absolute;top:112px;left:0;right:0;bottom:0px;" class="rx-grid-panel" id="listTables" resx="<%= FileName %>" system="<%= IsSystem %>">
		
	</div>
</div>