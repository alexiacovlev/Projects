<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-tabbar">
	<span class="tab tabOn">General</span><span class="tab">Record Details</span><span id="tab_hdr_lookup" class="tab">Handlers</span><span class="tab">Display Mode</span><span class="tab">Additional</span>
</div>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;">
	<div class="tab" style="display:block">
		<table cellpadding="0" cellspacing="2" width="100%">
			<colgroup><col width="110"/><col /></colgroup>	
			<tr style="height:20px">
				<td></td>
				<td><label class="comment">Provide a name, title and description for this view.</label></td>
			</tr>
			<tr style="height:25px">
				<td class="req">Name:</td>
				<td><input disabled id="viewName" type="text" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td class="n">Title:</td>
				<td><input id="viewTitle" type="text" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td class="n" style="padding-top:5px;vertical-align:top">Description:</td>
				<td><textarea id="viewDesc" class="fm" maxlength="200" style="overflow-y:scroll;height:50px;margin-top:4px;"></textarea></td>
			</tr>
		</table>
		<table id="lookupPanel1" cellpadding="0" cellspacing="2" style="width:100%;display:none;">
			<colgroup><col width="110"/><col /></colgroup>	
			<tr style="height:20px">
				<td></td>
				<td><label class="comment">Specify dialog properties (for single typed views).</label></td>
			</tr>
			<tr>
				<td class="n">Title:</td>
				<td><input id="dialogTitle" type="text" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td class="n" style="padding-top:5px;vertical-align:top">Description:</td>
				<td><textarea id="dialogDesc" class="fm" maxlength="200" style="OVERFLOW-Y:scroll;height:50px;margin-top:4px;"></textarea></td>
			</tr>
		</table>
	</div>
	<div class="tab">
		<fieldset><legend>Grid View Features</legend>
			<table width="100%" cellpadding="3" cellspacing="3" style="table-layout:fixed;">
			<colgroup><col width="170"/><col /></colgroup>
			<tr>
				<td>Allow "Select All" checkbox:</td>
				<td><input class="fm-chk" id="chSelect" type="checkbox"/></td>
			</tr>
			<tr>
				<td>Show Record Icon:</td>
				<td><input class="fm-chk" id="chIcon" type="checkbox"/></td>
			</tr>

			<tr id="panelIconSettings">
				<td colspan="2" style="padding-left:2px;">
					<div class="desc">
						You can specify the default icon, that will be reflect the record.
					</div>
					<div style="padding:4px 0 4px 10px">
						<span id="imgIcon"/>
					</div>

					<div class="desc">
						Or you can specify the typed icon, that will be reflect the record state based on "Dynamic Record Field".
						To completly define this feature you have to specify 'Image Type' and 'Field (picklist, boolean)' below.
					</div>
					<table cellpadding="1" cellspacing="1" style="table-layout:fixed;">
						<colgroup><col width="150"/><col width="180" /></colgroup>
						<tr>
							<td>Icon Image Type:</td>
							<td><dialogs:ImageTypeControl id="tb_imagetype" runat="server" /></td>
						</tr>
						<tr>
							<td>Dynamic Record Field:</td>
							<td><dialogs:FieldLookupControl id="tb_recordtypefield" runat="server" DialogType="FIELD/PICKLIST" WindowTitle="Typed Fields" /></td>
						</tr>
					</table>
				</td>
			</tr>
			</table>
		</fieldset>
		
	</div>

	<div class="tab">
		<div class="desc" style="margin-bottom:14px;margin-top:5px;">You can define handlers for the dialog bottom buttons: <b>Property</b> and <b>Create</b><br />
			To show the buttons, mark the checkbox and specify <br />handler (form, workflow or custom control) to open the selected record or create new one.
		</div>
		<fieldset>
			<legend>Property button</legend>
			<label style="padding:10px;"><input id="cb_property" type="checkbox" class="fm-chk" /> Allow</label>

			<table cellpadding="1" cellspacing="1" style="width:95%;">
				<colgroup><col width="95"/><col /><col width="90"/><col width="100"/></colgroup>	
				<tr>
					<td align="right">Handler: </td>
					<td colspan="3"><input id="tb_property" class="fm" /></td>
				</tr>
				<tr>
					<td align="right"></td>
					<td><div id="div_property_window" /></td>
					<td>Button Label:</td>
					<td><input id="tb_property_text" class="fm" /></td>
				</tr>
			</table>
		</fieldset>

		<fieldset>
			<legend>Create button</legend>
			<label style="padding:10px;"><input id="cb_create" type="checkbox" class="fm-chk" /> Allow</label>

			<table cellpadding="1" cellspacing="1" style="width:95%;">
				<colgroup><col width="95"/><col /><col width="90"/><col width="100"/></colgroup>	
				<tr>
					<td align="right">Handler: </td>
					<td colspan="3"><input id="tb_create" class="fm" /></td>
				</tr>
				<tr>
					<td align="right"></td>
					<td><div id="div_create_window" /></td>
					<td>Button Label:</td>
					<td><input id="tb_create_text" class="fm" /></td>
				</tr>
			</table>
		</fieldset>

		<fieldset style="margin-bottom:4px;">
			<legend>Item OnClick</legend>
			<div class="desc" style="margin-bottom:5px;">Specify <b>OnClick</b> handler for the lookup item in the form control in editable and readonly states.
				To enable/disable, use the properties dialog in the FormBuilder for this field.
			</div>
			<table cellpadding="1" cellspacing="1" style="width:95%;">
				<colgroup><col width="95"/><col /><col width="40"/><col /></colgroup>	
				<tr>
					<td align="right">Handler: </td>
					<td><input id="tb_view" class="fm" /></td>
					<td align="right">RO: </td>
					<td title="For lookup control in READONLY state, if empty uses: FORM:default/READONLY"><input id="tb_view_ro" class="fm" /></td>
				</tr>
				<tr>
					<td align="right"></td>
					<td><div id="div_view_window" /></td>
					<td align="right"></td>
					<td><div id="div_view_ro_window" /></td>
				</tr>
			</table>
		</fieldset>

		<div style="font-style:italic;padding-left:5px;">Examples: FORM:default, FORM:info/READONLY - open in the readonly state, WORKFLOW:AX_PersonInfo - open workflow.</div>

	</div>

	<div class="tab">
		<fieldset>
			<legend>Display Mode</legend>
			<div class="desc">
				Specify grid render mode.
			</div>
			<div id="displayMode" style="margin:5px;">
				<label class="fm-chk-block"><input type="radio" class="fm-chk" name="dm" value="" />Grid view (default)</label>
				<label class="fm-chk-block"><input type="radio" class="fm-chk" name="dm" value="List" />Detailed form view</label>
				<label class="fm-chk-block"><input type="radio" class="fm-chk" name="dm" value="Grouping" /><span>Grouped list view</span><a id="linkGrouping" style="margin-left:10px;display:none">(click to customize)</a></label>
				<label class="fm-chk-block"><input type="radio" class="fm-chk" name="dm" value="Hierarchy" /><span>Hierarchy tree view</span><a id="linkHierarchy" style="margin-left:10px;display:none">(click to customize)</a></label>
			</div>
		</fieldset>
		
		<fieldset>
			<legend>Record Expand Mode</legend>
			<div class="desc">
				You can add preview button to allow user to quick view additional record details data,
				or you can include Master/Detail mechanism to view related sub-records in grid view.
			</div>
			<div id="expandMode" style="margin:5px;">
				<label class="fm-chk-block"><input type="radio" class="fm-chk" name="em" value="" />Default View</label>
				<label class="fm-chk-block"><input type="radio" class="fm-chk" name="em" value="Info" />Quick Preview Icon</label>
				<label class="fm-chk-block" id="rbMasterDetail"><input type="radio" class="fm-chk" name="em" value="MasterDetail" /><span>Related Sub-Records (Master Detail)</span><a id="linkMasterDetail" style="margin-left:10px;display:none">(click to customize)</a></label>
			</div>
		</fieldset>

		<fieldset id="fsRecordDetails" style="display:none"><legend>Record Quick View</legend>
			<div class="desc" style="width:100%">
				You can customize record quick preview using the following link<br>
				<br /><br />
				&nbsp;&nbsp;&nbsp;<label id="lblDefaultTemplate" style="display:none;cursor:pointer;color:#001080"><img src="<%= AX.FM.Explorer.Utils.Path %>Images/ico/ico_16_preview.gif" align="absmiddle" />&nbsp;Customize Template For Default View</label>
				&nbsp;&nbsp;&nbsp;<label onclick="OpenPreviewBuilder(_TableName.value, viewName.value);" style="cursor:pointer;color:#800000"><img src="<%= AX.FM.Explorer.Utils.Path %>Images/ico/ico_16_preview.gif" align="absmiddle" />&nbsp;Customize Details Template</label>
			</div>
			<br />
		</fieldset>
			
		<fieldset id="trRowActions" style="margin-top:20px">
			<legend>Record Inline Actions</legend>
			<table width="100%" cellpadding="3" cellspacing="3" style="table-layout:fixed;">
			<colgroup><col width="170"/><col /></colgroup>
				<tr>
					<td>Add OPEN button:</td>
					<td><input id="cb_aOpen" type="checkbox" class="fm-chk" /></td>
				</tr>
				<tr>
					<td>Add DELETE button:</td>
					<td><input id="cb_aDelete" type="checkbox" class="fm-chk" /></td>
				</tr>
			
			</table>
		</fieldset>			
		

	
	</div>
	<div class="tab">
		
		<fieldset>
			<legend>Print</legend>
		
			<table cellpadding="4" cellspacing="4" width="100%">
				<colgroup><col width="120"/></colgroup>	
				<tr>
					<td style="padding-top:10px;vertical-align:top">Print Title:</td>
					<td><textarea id="printHeader" class="fm" maxlength="200" style="overflow-y:scroll;height:30px;margin-top:4px;"></textarea></td>
				</tr>
				<tr>
					<td>Show row order:</td>
					<td><label style="font-style:italic"><input class="fm-chk" id="chOrderNumber" type="checkbox">- show row order number on print records</label></td>
				</tr>

			</table>
		</fieldset>
	</div>
</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>