<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>

<div class="fm-dlg fm-dlg-content" style='top:0;background-color:#eaf3ff'>
	<table style="width:100%;height:100%;">
		<tr style="height:24px">
			<td style="font-weight:bold;width:50%;padding-left:5px">Source</td>
			<td style="font-weight:bold;padding-left:5px">Available data fields and variables</td>
		</tr>
		<tr style="height:92%">
			<td style="padding-right:1px;">
				<div id="sourceList" class="fm_list" style="height:330px;overflow-y:auto;">
				
				</div>
			</td>
			<td style="padding-left:1px;">
				<div id="itemsList" class="fm_list" style="height:330px;width:260px;overflow-y:scroll;overflow-x:auto;">
				
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input class="fm" id="tbValue" style="height:24px;font-size:9pt;" />
			</td>
		</tr>
	</table>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:50px;margin-left:5px;", false) %>
</div>