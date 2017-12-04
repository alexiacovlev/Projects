<%@ Control Language="C#" Inherits="AX.PortalAdmin.AppManager.AppManagerControl" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.PortalAdmin.Controls" Assembly="AX.PortalAdmin" %>
<style type="text/css">
	.ax-admin-group { padding:0px 5px 5px 15px; cursor:default; }
	.ax-admin-folder { padding:6px 3px 6px 8px; border-radius:3px; border: solid 1px #FFF; cursor:default; margin:1px 0; }
	.ax-admin-folder:hover { background-color:#bbddff;border-color:#97abfb;color:#000; }
	.ax-admin-folder-dis { color:gray; font-style:italic; }
	.ax-admin-folder-sel { background-color:#0075bb;color:white;border-color:#00588c; }
	.ax-admin-top { border-bottom:solid 3px #FFF; padding-bottom:4px; line-height:1px; }
	.ax-admin-folder-drag { border-bottom:solid 3px black; padding-bottom:4px; }
	.ax-admin-perm-row { position:relative;display:block;cursor:default;color:#000;font-size:0.8em; }
	.ax-admin-perm-chk { outline:0;padding:0;margin-right:5px; vertical-align:sub; }
</style>


	<div class="ax-dlg-hdr">
		<div style="color:#000;font-weight:bold;">Application Site Map</div>
		<div style="margin:10px 0 0 20px;font-size:0.8em;">Use this dialog to reorganize tabs or links and customize the properties.</div>
		<div style="position:absolute;top:22px;right:90px;">Theme: <a class="fm-a" cmd="theme" id="theme"></a></div>
		<img style="position:absolute;top:8px;right:12px;" src="/ASP.Net/WebAdmin/Images/settings.jpg" width="48" height="48" />
	</div>

	<div style="position:absolute;left:20px;top:85px;bottom:20px;width:300px;background-color:#ffffff;overflow-y:scroll;border:solid 1px #a59d9b;">

		<div id="panelMenu" style="display:none">
			<div style="padding:5px 5px 0 5px;position:relative"><label class="fm-dlg-sec">Main Navigation</label><a cmd="add-tab" title="Add Tab Item" style="position:absolute;top:4px;right:0.8em;" class="fm-a">add</a></div>
			<div class="ax-admin-group" id="tabsItems">
				<div class="ax-admin-top" n="[TABS-TOP]"></div>
				<%= sbTabs %>
			</div>
			<div style="padding:5px 5px 0 5px;position:relative"><label class="fm-dlg-sec">Extra Menu</label><a cmd="add-link" title="Add Link Item" style="position:absolute;top:4px;right:0.8em;" class="fm-a">add</a></div>
			<div class="ax-admin-group" id="linksItems">
				<div class="ax-admin-top" n="[LINKS-TOP]"></div>
				<%= sbLinks %>
			</div>
		</div>
	
	</div>

	<div class="fm-dlg-form" style="position: absolute; top: 85px; left:340px;right:20px;bottom:20px;">
		<table id="panelProperties" cellpadding="0" cellspacing="0" style="table-layout:fixed;width:100%;display:none">
			<colgroup>
				<col width="180" />
				<col width="400" />
				<col />
			</colgroup>
			<tr>
				<td colspan="3">
					<div class="fm-dlg-sec">Properties</div>
				</td>
			</tr>
			<tr>
				<td class="fm-n" style="padding:1em 2em">Title:</td>
				<td style="padding:1em"><dialogs:ResTitleControl ID="tbTitle" runat="server" /></td>
				<td style="text-align:right;padding-right:1em;"><a tabindex="21" class="fm-a" cmd="delete">Delete Item</a></td>
			</tr>
			<tr>
				<td class="fm-n" style="padding:0em 2em;">Name:</td>
				<td style="padding:0 1em"><input class="fm" id="tbName" maxlength="30" disabled="disabled" /></td>
				<td>
					<div id="logoIcon" title="Logo Icon" style="position:absolute;top:44px;padding:5px;background-color:#fff;color:#333;border-radius:3px;cursor:pointer;box-shadow:0px 0px 5px #333;font-size:1.2em">&nbsp;</div>
				</td>
			</tr>

			<tr>
				<td colspan="3" style="padding-top:1em;">
					<div class="fm-dlg-sec">Availability</div>
				</td>
			</tr>
			<tr>
				<td class="fm-n" style="padding:1em 0 1em 2em">Access for Roles:</td>
				<td style="padding:1em"><a id="linkRoles" class="ax-dlg-link" cmd="permissions" title="Change Permissions"></a></td>
				<td style="text-align:right;padding-right:1em;"><a tabindex="22" class="fm-a" cmd="permissions">Change Permissions</a></td>
			</tr>
			<tr>
				<td class="fm-n" style="padding:0em 2em">Menu Visibility:</td>
				<td style="padding:0 1em">
					<input id="cbVisibility" type="checkbox" /></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="3" style="padding-top:1em;">
					<div class="fm-dlg-sec">Content</div>
				</td>
			</tr>
			<tr>
				<td class="fm-n" style="padding:1em 2em;">Type:</td>
				<td style="padding:1em; overflow: hidden;"><a id="linkType" cmd="content" class="ax-dlg-link" title="Change Content"></a></td>
				<td style="text-align:right;padding-right:1em;">
					<a tabindex="23" class="fm-a" cmd="content">Change Content</a>
				</td>
			</tr>

			<tr id="rowContent" style="display: none">
				<td class="fm-n" style="padding:0 0 0 2em;" id="lblContent">Content Settings:</td>
				<td style="padding:0 1em;overflow: hidden;"><input id="tbContent" class="fm" /></td>
				<td class="comment"></td>
			</tr>

			<tr>
				<td colspan="3">
					<div id="panelSetters" style="max-height:15em; overflow-y: auto;"></div>
				</td>
			</tr>

		</table>
		

		<div style="position:absolute;bottom:8px;left:7px;">
			<a tabindex="9" class="fm-btn" cmd="appsettigns">Application Settings</a>
		</div>
		<div style="position:absolute;bottom:8px;right:7px;">
			<label style="margin-right:3em;">Note: The changes are saving automatically.</label>
			<a tabindex="10" class="fm-btn fm-btn-saveclose" cmd="save" style="width:80px">OK</a>&nbsp;
			<a tabindex="11" class="fm-btn" cmd="close">Close</a>
		</div>

	</div>
	<div id="panelAppend" style="display: none">
		<div>
			<table width="420px" cellpadding="4" cellspacing="4" style="margin: 0 10px 0 10px;table-layout:fixed">
				<colgroup><col width="130" /><col /></colgroup>
				<tr>
					<td class="fm-n">Display Label:</td>
					<td><input id="panelAppend_tbTitle" class="fm" style="width: 95%" /></td>
				</tr>
				<tr>
					<td class="fm-req">Name:</td>
					<td><input id="panelAppend_tbName" class="fm" style="width: 95%" /></td>
				</tr>
				<tr>
					<td></td>
					<td class="fm-comment">This name is using as part of URL for the tab<br />
						only A-Z,a-z, 0-9 characters are allowed.</td>
				</tr>
			</table>
		</div>


	</div>

