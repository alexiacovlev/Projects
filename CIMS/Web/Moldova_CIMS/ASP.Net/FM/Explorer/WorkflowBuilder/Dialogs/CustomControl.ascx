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

	<fieldset class="fm-dlg-sec-bg" style="padding:8px;margin:14px 5px;">
		<legend>Settings</legend>
		<table cellpadding="2" cellspacing="2" width="100%">
			<colgroup><col width="150" /><col /></colgroup>	
			<tr>
				<td class="n">Control Type:</td>
				<td>
					<select id="listType" class="fm" style="width:150px">
						<option value="SERVERCONTROL">Custom ASCX Control</option>
						<option value="HTML">HTML Template</option>
						<option value="SL">Silverlight Control</option>
						<option value="PROFILE">PROFILE (as final step)</option>
					</select>
					<a id="btnGallery" class="fm" style="margin-left:20px">select from gallery</a>
				</td>
			</tr>
			<tr>
				<td class="n">Assembly/ASCX Path:</td>
				<td><input id="tbInfo" class="fm" /></td>
			</tr>				
		</table>
	</fieldset>

	<fieldset class="fm-dlg-sec" style="padding:8px 3px 8px 8px;margin:14px 5px 0 5px;">
		<legend>Assig Control Properties</legend>
		<div style="height:180px;overflow-y:auto;">
			<div id="panelAssign"></div>
			<a id="btnAdd" class='fm-btn' style='float:right;margin:5px;'><img src='Images/16_plus.png'/>Add property</a>
		</div>
	</fieldset>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>