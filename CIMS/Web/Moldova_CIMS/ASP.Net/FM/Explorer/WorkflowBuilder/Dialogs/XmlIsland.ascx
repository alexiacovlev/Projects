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
			<colgroup><col width="100" /><col width="200" /><col /></colgroup>	
			<tr>
				<td class="n">Data Source:</td>
				<td><select id="listProvider" class="fm"><option value="">Database</option><option value="CODE">Code Data Provider</option></select></td>
				<td></td>
			</tr>
			<tr id="row1">
				<td class="n">Table Name:</td>
				<td><dialogs:TableLookupControl id="lookupTableName" runat="server" /></td>
				<td>&nbsp;</td>
			</tr>
			<tr id="row2" style="display:none">
				<td class="n">Code Provider:</td>
				<td colspan="2"><input id="tbProvider" class="fm" /></td>
			</tr>
		</table>
	</fieldset>

	<fieldset class="fm-dlg-sec-bg" style="padding:8px;margin:14px 5px;position:relative">
		<legend>Select field list</legend>
		<div id="panelFieldSet" style="height:120px;overflow-y:auto;">
		</div>
		<a id="btnFieldSet" class='fm-btn' style='position:absolute;top:10px;right:10px;margin:5px;'><img src='Images/16_plus.png'/>Add</a>

	</fieldset>

	<fieldset class="fm-dlg-sec" style="padding:8px 3px 8px 8px;margin:14px 5px 0 5px;">
		<legend id="lblAssignText">Filter</legend>
		<div style="height:110px;overflow-y:auto;">
			<div style="margin:3px 0 10px 2px;display:none" id="panelAssignType"><label style="font-weight:bold;color:#666666">Select Record by&nbsp;</label><label class="fm-chk" style="font-weight:bold"><input class="fm-chk" type="radio" name="assignFilterType" value="primarykey" />Primary Key&nbsp;</label><label class="fm-chk"><input class="fm-chk" type="radio" name="assignFilterType" value="custom" />or by Custom Filter</label></div>
			<div id="panelAssign"></div>
			<a id="btnAdd" class='fm-btn' style='float:right;margin:5px;'><img src='Images/16_plus.png'/>Add field</a>
		</div>
	</fieldset>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>