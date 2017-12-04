<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 33px; border: solid 1px #a59d9b; background-color: #fffbff; padding: 4px;">
	<fieldset id="fsAuditTrail">
		<legend>Audit Trail</legend>
		<table cellpadding="8">
			<tr>
				<td><div class="comment">Allow save change tracking information for the data record after specified events occured.</div></td>
			</tr>
			<tr>
				<td>
					<label><input id="chAuditCreate" class="fm-chk" type="checkbox"/>&nbsp;Track on Create</label>
				</td>
			</tr>
			<tr>
				<td>
					<label><input id="chAuditUpdate" class="fm-chk" type="checkbox"/>&nbsp;Track changes on Update</label>
				</td>
			</tr>
			<tr>
				<td>
					<label><input id="chAuditDelete" class="fm-chk" type="checkbox"/>&nbsp;Track on Delete</label>
					</td>
			</tr>
		</table>
	</fieldset>
</div>

<div id="_bottomButtons" style="position: absolute; bottom: 4px; right: 3px;">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true)%>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;width:50px;", false)%>
</div>
