<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<fieldset>
	<legend class="sec">Data Source</legend>
	<table style="width: 100%; table-layout: fixed;margin-bottom:5px;" cellspacing="3">
		<colgroup>
			<col width="140"/>
			<col width="280"/>
			<col />
		</colgroup>
		<tbody>
			<tr>
				<td class="n">
					Data Object:
				</td>
				<td>
					<dialogs:TableLookupControl id="tbTableName" runat="server" />
				</td>
				<td style="padding-left:5px;">
					<label class="comment">Define table name for grid</label>
				</td>
			</tr>
			<tr>
				<td class="n">
					View Name:
				</td>
				<td>
					<dialogs:ViewLookupControl id="tbViewName" runat="server" />
				</td>
				<td style="padding-left:5px;">
					<label class="comment">Define view name for grid</label>
				</td>
			</tr>
			
		</tbody>
	</table>
</fieldset>

<fieldset style="margin-top:15px;">
	<legend class="sec">Open/Create actions</legend>
	<table style="width: 100%; table-layout: fixed;" cellspacing="3">
		<colgroup>
			<col width="140"/>
			<col width="280"/>
			<col />
		</colgroup>
		<tbody>
			<tr>
				<td colspan="3">
					<label class="comment">Define Form, Navigator, Workflow for open (dbl-click) and for create action and specify window parameters</label>
				</td>
			</tr>
			<tr>
				<td class="n">
					Action for Open:
				</td>
				<td>
					<dialogs:ActionSelectorControl id="tbSelectAction" runat="server" />
				</td>
				<td style="padding-left:5px;">
					<div id="paramsSelect"></div>
				</td>
			</tr>
			<tr>
				<td class="n">
					Action for Create:
				</td>
				<td>
					<dialogs:ActionSelectorControl id="tbCreateAction" runat="server" />
				</td>
				<td style="padding-left:5px;">
					<div id="paramsCreate"></div>
				</td>
			</tr>
		</tbody>
	</table>
</fieldset>

<fieldset style="margin-top:15px;">
	<legend class="sec">Toolbar actions</legend>
	<table style="width: 100%; table-layout: fixed;" cellspacing="0" cellpadding="0">
		<colgroup>
			<col width="130"/>
			<col width="60"/>
			<col width="155"/>
			<col />
		</colgroup>
		<tbody>
			<tr>
				<td style="height:20px;" colspan="3">
					<label class="comment">Select the main actions</label>
				</td>
				<td style="height:20px;padding-left:5px;">
					<label class="comment">Extra commands (<a id="lnkMore" class="fm"> click to show settings </a>)</label>
				</td>
			</tr>
			<tr style="height:20px;">
				<td><label class="fm-chk"><input type="checkbox" class="fm-chk" id="cbAddCreate" />Add CREATE button</label></td>
				<td><label>with label</label></td>
				<td><input type="text" class="fm" id="tbAddCreate" /></td>
				<td rowspan="5" style="padding-left:5px;" valign="top">
					<textarea id="tbMoreActions" class="fm" style="width:98%;height:70px;display:none"></textarea>
					<a id="btnMenu" class="fm-btn" style="width:130px;margin-left:20px;margin-top:5px;"><img src="/ASP.Net/FM/Common/Images/menu/16_edit.png">Menu Designer</a>
				</td>
			</tr>
			<tr style="height:20px;">
				<td><label class="fm-chk"><input type="checkbox" class="fm-chk" id="cbAddDelete" />Add DELETE button</label></td>
				<td><label>with label</label></td>
				<td><input type="text" class="fm" id="tbAddDelete" /></td>
			</tr>
			<tr style="height:20px;">
				<td><label class="fm-chk"><input type="checkbox" class="fm-chk" id="cbAddExport"/>Add EXPORT button</label></td>
				<td></td>
				<td></td>
				
			</tr>
			<tr style="height:20px;">
				<td colspan="3">
					<label class="fm-chk"><input type="checkbox" class="fm-chk" id="cbShowActionsMenu" />Show Menubar</label>
				</td>
			</tr>
			<!--tr style="height:20px;">
				<td colspan="3">
					<label class="fm-chk"><input type="checkbox" class="fm-chk" />Add Header text</label>
					<label class="fm-chk"><input type="checkbox" class="fm-chk" disabled="disabled"/>and show on grid load</label>
				</td>
			</tr-->
			<tr style="height:20px;">
				<td><label>Double click behaviour</label></td>
				<td></td>
				<td>
					<select id="cbOnRecordOpen" class="fm">
						<option value="">Default</option>
						<option value="OpenAsReadonly">Open Readonly (form only)</option>
						<option value="DoNothing">Disable</option>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
</fieldset>

<fieldset style="margin-top:15px;position:relative">
	<legend class="sec">Advanced</legend>
	<table style="width: 100%; table-layout: fixed;" cellspacing="2">
		<colgroup>
			<col width="140"/>
			<col width="280" />
			<col />
		</colgroup>
		<tbody>
			<!--tr>
				<td colspan="2">
					<label class="comment">Define search panel (by single field or by list of fields)</label>
				</td>
				<td></td>
			</tr-->
			<tr>
				<td class="n">
					Search Panel:
				</td>
				<td>
					<div id="panelSearchMode">
						<label class="fm-chk"><input class="fm-chk" type="radio" name="SearchMode" value="None" />Hidden</label>
						<label class="fm-chk"><input class="fm-chk" type="radio" name="SearchMode" value="" />Quick Search Panel</label>
						<label class="fm-chk"><input class="fm-chk" type="radio" name="SearchMode" value="ByForm" />Filter Form</label>
						<!--label class="fm-chk" style="color:gray"><input type="radio" name="SearchMode" value="ByGrid" disabled="disabled" />By Grid</label-->
					</div>
				</td>
				<td style="padding-left:5px">
					<div id="panelSearchParams" style="visibility:hidden">
						<label class="fm-chk"><input type="checkbox" class="fm-chk" id="cbResultsByRequestOnly" />Load records only on demand</label><br />
						<label class="fm-chk"><input type="checkbox" class="fm-chk" id="cbSearchStore" />Store user query</label><br />
					</div>
				</td>
			</tr>
			<tr>
				<td class="n">
					Additional Panels:
				</td>
				<td colspan="2">
					<label class="fm-chk"><input type="checkbox" class="fm-chk" id="cbShowChart" />Show Charting Panel</label>
					<a class="fm" id="linkChart">(settings)</a>
					<label class="fm-chk" style="margin-left:10px;"><input type="checkbox" class="fm-chk" id="cbShowInfo" />Show Info Panel</label>
				</td>
			</tr>
		</tbody>
	</table>

	<table style="width: 100%; table-layout: fixed;" cellspacing="2" cellpadding="2">
		<colgroup>
			<col width="145"/>
			<col width="280"/>
			<col />
		</colgroup>
		<tbody>
			<tr>
				<td colspan="3">
					<label class="comment">External dependency filter criteria, for common view's filtering use 'Customize view' on the toolbar</label>
				</td>
			</tr>
			<tr>
				<td class="n">
					Dependency Filter:&nbsp;<img id="imgFilterHelp" src="/ASP.Net/FM/Common/Images/12_info.png" width="12" height="12"/><div style="display:none;position:absolute;top:-40px;left:130px;" class="fm-dlg-info fm-shadow">Example:<br />'ProjectID'<br />or<br />'ProjectID=$id,FolderID=$folder_id,Status=1'<br /><br />$id - input key value of the record in the navigator<br />$folder_id - key value for the parent record in the profile tree<br />Status=1 - constant filter value</div>
				</td>
				<td>
					<dialogs:FieldLookupControl id="tbInputFilterField" runat="server" />
				</td>
				<td style="padding-left:5px;">
				</td>
			</tr>
		</tbody>
	</table>
</fieldset>
