<%@ Control Language="C#" Inherits="AX.PortalAdmin.AppManager.QuickAdd" %>
<div style="background-color:#999999;width:100%;height:100%;position:relative">
<div cmd="<%= this.Command %>" id="dlg-root" class='ax-dlg ax-dlg-wnd' style='display:none;position:relative;top:50px;width:450px;height:280px;'>
	<div class="ax-dlg-hdr">
		<div style="font-size:10pt;font-family:Verdana;color:#000;font-weight:bold;">Append a New Tab</div>
		<div style="margin:10px 0 0 20px;font-size:8pt;">To create a new tab, please type the name.</div>
	</div>
	<div style="border-top:solid 1px #FFF"></div>
	<img style="position:absolute;top:8px;right:5px;" src="/ASP.Net/WebAdmin/Images/48_new_tab.png" width="48" height="48" />
	<table width="95%" cellpadding="4" cellspacing="4" style="margin:0 10px 0 10px">
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="n">Display Label:</td>
			<td><input id="tbTitle" style="width:95%" tabindex="1" /></td>
		</tr>
		<tr>
			<td class="req">Name:</td>
			<td><input id="tbName" style="width:95%" tabindex="2" /></td>
		</tr>
		<tr>
			<td></td>
			<td class="comment">This name is using as part of URL for the tab<br />only A-Z,a-z, 0-9 characters are allowed.</td>
		</tr>
	</table>
	<div class="ax-dlg-footer">
		<div class="ax-dlg-sep"></div>
		<div style="position:absolute;bottom:8px;right:7px;">
			<%= AX.PortalAdmin.Utils.RenderButton("btnOK", "OK", 3)%>
			<%= AX.PortalAdmin.Utils.RenderButton("btnClose", "Close", 4)%>
		</div>
	</div>
</div>
</div>