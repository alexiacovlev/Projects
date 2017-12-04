<%@ Page Language="C#"%>
<%@ Register TagPrefix="ui" Namespace="AX.FM.Common.UI" Assembly="AX.FM.Common" %>

<img style="position:absolute;top:5px;left:5px;" src="/ASP.Net/FM/Explorer/Images/48/48_grid.png" width="48" height="48" />
<div style="position:absolute;left:60px;top:0;right:0;">
	<table style="width:98%;table-layout:fixed" cellpadding="2" cellspacing="2">
		<colgroup><col width="110" /><col /></colgroup>
		<tr style="height:24px;">
			<td>Database Table:</td><td><label id="info_TableName" style="font-weight:bold;font-size:9pt;">&nbsp;</label><label id="info_TableInfo" style="font-size:9pt;margin-left:20px;"></label></td>
		</tr>
		<tr style="height:24px;">
			<td>Title:</td><td><input class="fm" id="info_Title" /></td>
		</tr>
		<tr>
			<td>Description:</td><td><textarea id="info_Description" class="fm"></textarea></td>
		</tr>
	</table>
</div>

<div style="position:absolute;top:100px;left:5px;right:5px;bottom:40px;">
	<div class="fm-dlg-tabbar">
		<span class="tab tabOn" style="width:180px;"><label>Database fields</label> (<label id="count_Database"/>)</span><span class="tab" style="width:180px;"><label>Related fields</label> (<label id="count_Related"/>)</span><span class="tab" style="width:180px"><label>User-defined fields</label> (<label id="count_UserDefined"/>)</span>
	</div>
	<div class="fm-dlg-tabs" style="bottom:0;">

		<div class="tab" style="display:block">
			<table class="fm-dlg-grid-hdr" cellspacing="0" cellpadding="0">
				<colgroup><col width="30" /><col width="210" /><col width="150"/><col /><col width="80" /></colgroup>
				<tr>
					<td class="clear">&nbsp;</td><td>Name</td><td>Type</td><td>Properties</td><td style="padding-left:10px;font-weight:bold"><a id="btnAdd_Database" class="fm" cmd="add">Add Field</a></td>
				</tr>
			</table>
			<div style="height:383px;" class="fm-dlg-grid-panel">
				<table id="panel_Database" cellpadding="0" cellspacing="0" class="fm-dlg-grid rmc-tb-fieldList">
					<colgroup><col width="31" /><col width="210" /><col width="150"/><col /><col width="150" /></colgroup>
					<tbody></tbody>
				</table>
			</div>
		</div>

		<div class="tab">
			<table class="fm-dlg-grid-hdr" cellspacing="0" cellpadding="0">
				<colgroup><col width="30" /><col width="210" /><col width="150"/><col /><col width="80" /></colgroup>
				<tr>
					<td class="clear">&nbsp;</td><td>Name</td><td>Type</td><td>Properties</td><td style="padding-left:10px;font-weight:bold"><a id="btnAdd_Related" class="fm" cmd="add" style="">Add Field</a></td>
				</tr>
			</table>
			<div style="height:383px;" class="fm-dlg-grid-panel">
				<table id="panel_Related" cellpadding="0" cellspacing="0" class="fm-dlg-grid rmc-tb-fieldList">
					<colgroup><col width="31" /><col width="210" /><col width="150"/><col /><col width="150" /></colgroup>
					<tbody></tbody>
				</table>
			</div>
		</div>

		<div class="tab">
			<table class="fm-dlg-grid-hdr" cellspacing="0" cellpadding="0">
				<colgroup><col width="30" /><col width="210" /><col width="150"/><col /><col width="80" /></colgroup>
				<tr>
					<td class="clear">&nbsp;</td><td>Name</td><td>Type</td><td>Properties</td><td style="padding-left:10px;font-weight:bold"><a id="btnAdd_UserDefined" class="fm" cmd="add" style="">Add Field</a></td>
				</tr>
			</table>
			<div style="height:383px;" class="fm-dlg-grid-panel">
				<table id="panel_UserDefined" cellpadding="0" cellspacing="0" class="fm-dlg-grid rmc-tb-fieldList">
					<colgroup><col width="31" /><col width="210" /><col width="150"/><col /><col width="150" /></colgroup>
					<tbody></tbody>
				</table>
			</div>
		</div>

	</div>

	<div style="position:absolute;bottom:5px;left:8px;color:gray;font-style:italic;">Note: To modify field settings, use single click on the field's row.</div>

</div>

<div class="fm-dlg-footer">
	<div style="position:absolute;bottom:5px;left:5px;">
		<a class="fm-btn" cmd="sync" title="Synchronize xml settings with database"><img src="/ASP.Net/FM/Explorer/Images/16_sync.png">&nbsp;Synchronize</a>
		<a class="fm-btn" cmd="audit" title="Customize Audit Trail Settings"><img src="/ASP.Net/FM/Explorer/Images/16_info.gif">&nbsp;Audit Trail</a>
		<a class="fm-btn" cmd="wf_events" title="Run workflow after add/update record in the database" style="margin-left:5px;"><img src="/ASP.Net/FM/Images/Explorer/ico_workflow.png">&nbsp;WF Events</a>
	</div>
	<label id="lblInfo" style="font-weight:bold;color:#463474;position:absolute;bottom:45px;right:10px;display:none;"></label>
	<div style="position:absolute;bottom:5px;right:5px;">
		<%= AX.FM.Common.UI.Button.Render("save", "margin-left:5px;", false) %>
		<%= AX.FM.Common.UI.Button.Render("saveX", "margin-left:5px;", true) %>
		<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
	</div>
</div>