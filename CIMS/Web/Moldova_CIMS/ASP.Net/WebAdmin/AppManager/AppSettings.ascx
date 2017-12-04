<%@ Control Language="C#" Inherits="AX.PortalAdmin.AppManager.AppSettings" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.PortalAdmin.Controls" Assembly="AX.PortalAdmin" %>
<div style="width:620px;height:320px" 
	id="appSettings"
	apptitle="<%= appTitle %>" restitle="<%= resTitle %>"
	appdescription="<%= appDescription %>" resdescription="<%= resDescription %>"
>
	<table width="90%" cellpadding="3" cellspacing="3" style="margin-left:30px;">
		<tr>
			<td class="fm-req" style="width:30%">Site Header</td>
			<td><dialogs:ResTitleControl ID="tbTitle" runat="server" /></td>
		</tr>
		<tr>
			<td class="fm-n" >Description</td>
			<td><dialogs:ResTitleControl ID="tbDescription" runat="server" /></td>
		</tr>
		
		<tr>
			<td></td>
			<td class="fm-comment" style="padding-bottom:1em">
			Note: Application header and description support inline translation syntax.<br />Example: (1033:site header in english).
			</td>
		</tr>
		
		<tr>
			<td class="fm-n">UI Theme</td>
			<td>
				<select class="fm-select" style="width:50%" id="listThemes">
					<%= listThemes %>
				</select>
			</td>
		</tr>
		<tr>
			<td class="fm-n">Db Preffix</td>
			<td>
				<input class="fm" id="tbDbPrefix" style="width:50%" value="<%= dbprefix %>" />
			</td>
		</tr>

	</table>

</div>