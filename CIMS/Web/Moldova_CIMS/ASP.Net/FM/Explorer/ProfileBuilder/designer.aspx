<%@ Page Language="C#"%>
<%@ Register TagPrefix="admin" TagName="DataGridStorage" Src="/ASP.Net/FM/Explorer/ProfileBuilder/Controls/DataGridStorage.ascx" %>
<%@ Register TagPrefix="admin" TagName="ControlStorage" Src="/ASP.Net/FM/Explorer/ProfileBuilder/Controls/ControlStorage.ascx" %>
<%@ Register TagPrefix="admin" TagName="AddNodeContent" Src="/ASP.Net/FM/Explorer/ProfileBuilder/Controls/AddNodeContent.ascx" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div style="position: absolute;top:0;bottom:33px;width:280px;border:solid 1px #a59d9b">
	<div class="fm-toolbar" style="position:absolute;width:100%;height:24px;">
		<div id="_treeButtons" class="fm-menu" style="margin-left:2px;">
		<%= AX.FM.Common.UI.Button.RenderMenuItem("add")%>
		<%= AX.FM.Common.UI.Button.RenderMenuItem("delete")%>
		</div>
	</div>
	<div style="position:absolute;width:100%;top:24px;bottom:0;">
		<div id="_tree" class="fmNavTree" style="height: 100%;background-color:#FFF">
				
		</div>
	</div>
	<div id="panelCreate" style="display:none;position:absolute;bottom:0;left:0;background-color:#ffffd9;height:40px;right:0;padding:4px;margin:2px;" class="fm-shadow">
		The profile is using the configuration for the role <b>Members</b>. To create a copy for the current role, click the button below.
	</div>
</div>
<div style="position:absolute;top:0px;left:285px;right:0px;border:solid 1px #a59d9b">
	<div class="fmNavHeader fm-toolbar" style="width: 100%; height: 24px;">
		<label style="font-size:9pt;position:relative">Folder Properties</label>
		<label style="font-size:9pt;position:relative" id="_nodeName"></label>
		<a class="fm" style="position:absolute;top:4px;right:8px;" id="btnChange">Change Content</a>
	</div>
	<div id="_nodeProperties" style="width:100%;background-color:#FFF;height:60px;">
		<table width="100%" cellpadding="0" cellspacing="0" style="table-layout:fixed">
			<colgroup>
				<col width="70" />
				<col width="300" />
				<col />
			</colgroup>
			<tr>
				<td style="padding-top:7px;padding-left:10px;"><img id="imgLogo" width="48" height="48" /></td>
				<td valign="top" style="padding-top:10px;">
					<div style="white-space:nowrap;"><label class="fm-lbl" style="width:50px;display:inline-block">Title:</label><input id="tbLabel" type="text" class="fm" style="height:22px;border:solid 1px #a3bae9;background-color:#eff4fe;color:blue;font-size:10pt;" /></div>
					<div style="margin-top:5px;margin-left:50px;"><span id="imgIcon"/></div>
				</td>
				<td valign="top" align="right" style="padding:12px 15px 0 0">
					<div style="height:20px;">
						<label class="fm-chk" id="cbGridOnly"><input id="cbAllowAutoCount" class="fm-chk" type="checkbox"/>Show record's count</label>
					</div>
					<a id="btnMore" style="margin-left:20px;" class="fm">more ...</a>
					<!--
					<div style="height:19px;"><div id="cbGridOnly" style="white-space:nowrap;display:none"><label class="fm-chk"><input id="cbAllowAutoCount" class="fm-chk" type="checkbox"/>Show record's count</label>&nbsp;<label class="fm-chk"><input id="cbAllowAutoCount2" class="fm-chk" type="checkbox">track changes</label>&nbsp;<label class="fm-chk"><input id="cbAllowPlaySound" class="fm-chk" type="checkbox">notify with sound</label></div></div>
					<div style="margin-top:4px;"><label class="fm-chk"><input id="cbIsDependOnParentKey" class="fm-chk" type="checkbox"/>Folder dependency</label></div>
					<div style="margin-top:8px;"><a id="btnAutoItems" style="margin-left:20px;" class="fm"></a></div>
					-->
				</td>
			</tr>
		</table>
	</div>
</div>
<div class="fm-dlg" id="_nodeStorage" style="position:absolute;top:88px;left:285px;right:0px;bottom:33px;border: solid 1px #a59d9b;background-color:#fffbff;padding:1px 3px 0 3px;">
	<div style="height:100%;overflow-y:auto;display:none;">
		<admin:DataGridStorage id="Storage1" runat="server" />
	</div>
	<div style="display:none">
		<admin:ControlStorage id="Storage2" runat="server" />
	</div>
	<div style="display:none">
		<admin:AddNodeContent id="AddContent" runat="server" />
	</div>
</div>
<div id="_buttons" style="background-color:#ebebe9;position:absolute;bottom:0px;left:0;right:0;height:32px;">
	<div style="position:absolute;bottom:4px;left:1px;">
		<%= AX.FM.Common.UI.Button.Render("properties", " Properties", "menu_grid.png", "", false)%>
		<a id="btnCreate" class="fm-btn" cmd="create" title="Create Profile for Current Role"><img src="/ASP.Net/Images/ico/ico_16_add_member.png" />&nbsp;</a>
	</div>
	<div style="position:absolute;bottom:4px;right:5px;">
		<%= AX.FM.Common.UI.Button.Render("save", "", false) %>
		<%= AX.FM.Common.UI.Button.Render("saveX", "margin-left:5px;", true) %>
		<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
	</div>
</div>
<div style="position:absolute;bottom:3px;left:180px;font-size:8pt;color:#404040">
	Note: To organize, select a folder and drag-drop it.<br />
	To move inside, hold SHIFT key. To cancel moving press ESC.
</div>
<label id="_nodeInfo" style="font-size:8pt;position:absolute;bottom:36px;right:7px;color:#404040"></label><label id="infoLabel" style="position:absolute;left:292px;bottom:36px;font-weight:bold;color:#463474;display:none;"></label>