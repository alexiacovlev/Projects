<%@ Control Language="C#" CodeBehind="LoginsActivityList.ascx.cs" Inherits="AX.PortalShell.Controls.LoginsActivityList" %>
<div style="width:500px;margin:20px auto 0 auto;padding:10px;" class="fm-dlg-form">
	<div class="fm-sec">
		<label class="fm-sec-lbl"><%= Translate("info_LoginActivityHistory", "Login Activity History")%></label>
		<table style="width:95%;table-layout:fixed;" cellspacing="8">
			<colgroup><col width="150"/><col /><col width="80"/></colgroup>
			<tbody>
			<tr>
				<td></td>
			</tr>
			<%= sbList %>
			</tbody>
		</table>
	</div>
	<div style="text-align:right"><label>Your IP Address: </label><b><%= IPAddress %></b></div>
</div>