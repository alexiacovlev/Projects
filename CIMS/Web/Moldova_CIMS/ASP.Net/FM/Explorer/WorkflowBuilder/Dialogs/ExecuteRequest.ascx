<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>

<div class="fm-dlg fm-dlg-content" style="top:0">
	<div style="padding:2px;margin:5px;">
		<table cellpadding="3" cellspacing="3" width="100%">
			<colgroup><col width="70"/><col width="80" /><col /></colgroup>	
			<tr>
				<td rowspan="2"><img src="Images/48/field_editor.png" width="48" height="48" /></td>
				<td class="n">Title:</td>
				<td><input id="tbTitle" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td class="req">Name:</td>
				<td><input id="tbName" class="fm" /></td>
			</tr>				
		</table>
	</div>

	<fieldset class="fm-dlg-sec-bg" style="padding:8px;margin:14px 5px;height:55px;">
		<legend>Settings</legend>
		<table cellpadding="2" cellspacing="2" width="100%">
			<colgroup><col width="70" /><col width="200" /><col /><col width="30" /></colgroup>	
			<tr>
				<td class="n">Type:</td>
				<td>
					<select id="ExecuteRequest_Type" class="fm">
						<option value="">Web Request</option>
						<option value="WebService">Web Service</option>
						<option value="NotificationService">Send Online Notification</option>
					</select>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr id="trUrl" style="display:none">
				<td class="n">Url:</td>
				<td colspan="2"><input id="ExecuteRequest_Url" style="width:300px" class="fm" /> / <input id="ExecuteRequest_Method" style="width:100px" class="fm" disabled="disabled" /></td>
				<td><a id="linkUrl" class="fm">select</a></td>
			</tr>				
		</table>
	</fieldset>

	<fieldset class="fm-dlg-sec" style="padding:8px 3px 8px 8px;margin:14px 5px 0 5px;">
		<legend>Assign Input Parameters</legend>
		<div style="height:160px;overflow-y:auto;">
			<div id="panelAssign"></div>
			<a id="btnAdd" class='fm-btn' style='float:right;margin:5px;'><img src='Images/16_plus.png'/>Add parameter</a>
		</div>
	</fieldset>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>