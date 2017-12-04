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

	<fieldset class="fm-dlg-sec-bg" style="padding:8px;margin:14px 5px 0 5px;">
		<legend>Assign Mail Properties</legend>
		<table cellpadding="3" cellspacing="3" width="100%">
			<colgroup><col width="135"/><col /><col width="110" /></colgroup>	
			<tr>
				<td class="n">From:</td>
				<td colspan="2"><input id="tbFrom" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td class="n">To:</td>
				<td colspan="2"><input id="tbTo" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td class="n">CC:</td>
				<td colspan="2"><input id="tbCC" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td class="n">Subject:</td>
				<td colspan="2"><input id="tbSubject" class="fm" maxlength="300"/></td>
			</tr>
			<tr>
				<td class="n">Mail Body Template:</td>
				<td><dialogs:MailTemplateControl id="lookupTemplate" runat="server" /></td>
				<td><a id="btnPreview" class="fm" style="margin-left:5px;">preview template</a></td>
			</tr>
			<tr>
				<td colspan="3">
					<label class="comment">You can type mail body below:</label><br />
					<textarea class="fm" id="tbBody" style="margin-top:3px;height:160px;background-color:#fffff0"></textarea>
				</td>
			</tr>
			<tr>
				<td class="n">Attachments:</td>
				<td colspan="2"><input id="tbAttachments" class="fm" maxlength="900"/></td>
			</tr>
		</table>
	</fieldset>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>