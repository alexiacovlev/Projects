<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>

<div class="fm-dlg fm-dlg-content" style="top:0">
	
	<fieldset class="fm-dlg-sec-bg" style="padding:8px;margin:14px 5px;">
		<legend>Properties</legend>
		<table cellpadding="3" cellspacing="3" width="100%">
			<colgroup><col width="70"/><col width="80" /><col /></colgroup>	
			<tr>
				<td rowspan="5" style="vertical-align:top"><img src="Images/48/field_editor.png" width="48" height="48" /></td>
				<td class="n">Title:</td>
				<td><input id="tbTitle" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td class="req">Name:</td>
				<td><input id="tbName" class="fm" disabled="disabled" /></td>
			</tr>				
			<tr>
				<td>Description:</td>
				<td><textarea id="tbDescription" class="fm" rows="3" /></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<label class="fm-chk" style="display:block;margin:5px 0;"><input id="cbRoundtrip" type="checkbox" class="fm-chk" />Show Roundtrip</label>
					<label class="fm-chk" style="display:block;margin:5px 0;"><input id="cbTrace" type="checkbox" class="fm-chk" />Trace Enabled (admin/DEBUG only)</label>
					<label class="fm-chk" style="display:block;margin:5px 0;"><input id="cbRefresh" type="checkbox" class="fm-chk" />Force Refresh:&nbsp;<img id="imgInfo" src="/ASP.Net/FM/Common/Images/12_info.png" width="12" height="12"/><div style="display:none;position:absolute;bottom:38px;right:5px;" class="fm-dlg-info fm-shadow">Use this parameter to ensure refresh records grid<br />after Update/Create or Stored Procedure activities.<br />Changes in the Invoke Form are tracking automatically.</div></label>
				</td>
			</tr>
		</table>
	</fieldset>

	<fieldset class="fm-dlg-sec-bg" style="padding:8px;margin:14px 5px;">
		<legend>Invoke Form Buttons</legend>
		<div id="panelHandlers"></div>
	</fieldset>

</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>