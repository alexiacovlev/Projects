<%@ Control Language="C#" Inherits="AX.PortalAdmin.AppManager.PermissionsDialog" %>
<div style="width:420px;height:340px;">
	<div class="fm-comment" style="position:relative;top:-1em;left:2em">Use this dialog to define portal's roles which access the tab.</div>
	<table width="95%" cellpadding="4" cellspacing="4">
		<tr>
			<td class="fm-n">This tab is available for:</td>
		</tr>
		<tr>
			<td>
				<div style="margin-left:9px;color:#3a5fbc;font-weight:bold;font-size:0.8em;vertical-align:middle">
					<img src="/ASP.Net/WebAdmin/Images/everyone.png" style="" /> <label><input id="rbEveryone" type="radio" name="Role" />Everyone</label>
				</div>
				<div style="margin:9px 0 0 9px;color:#3a5fbc;font-weight:bold;font-size:0.8em;vertical-align:middle">
					<img src="/ASP.Net/WebAdmin/Images/member.png" /> <label><input id="rbMembers" type="radio" name="Role" />Only Authenticated Users</label>
				</div>
			</td>
		</tr>
		<tr>
			<td class="fm-n" style="padding-bottom:0px;">Except roles:</td>
		</tr>
		<tr>
			<td title="use comma ',' to separate the list"><input id="tbDenyRoles" class="fm" style="margin-left:35px;width:320px;"/></td>
		</tr>
		<tr>
			<td class="fm-n" style="padding-top:1em;">Or is available only for the roles from the list:</td>
		</tr>
		<tr>
			<td>
				<div id="listRoles" style="border:solid 1px #808eb3;overflow-y:scroll;margin-left:35px;width:320px;height:120px;background-color:#FFF;">
					<%= sbRoles %>
				</div>
			</td>
		</tr>
		
	</table>

</div>
