<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-tabbar">
	<span class="tab tabOn">Display</span><span class="tab">Value Binding</span><span class="tab">Automatization</span><span class="tab">Metadata</span><span class="tab">Help</span>
</div>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;">
	<div class="tab" style="display:block">
		
		<fieldset class="fm-dlg-sec-bg" style="padding:8px">
			<legend>Title</legend>
			<table cellpadding="0" cellspacing="0" width="100%">
				<colgroup><col width="70"/><col /></colgroup>	
				<tr>
					<td rowspan="2"><img src="Images/48/field_editor.png" width="48" height="48" /></td>
					<td>
						<dialogs:AdminResTitleControl ID="tbTitle" runat="server" />
					</td>
				</tr>
				<tr>
					<td style="text-align:right;padding-right:4px;line-height:12px;">
						<label style="display:inline-block;">Text Alignment:</label>
						<span id="panelAlignment">
							<label class="fm-chk"><input class="fm-chk" type="radio" name="TextAlignment" value="" />Left</label>
							<label class="fm-chk"><input class="fm-chk" type="radio" name="TextAlignment" value="center" />Center</label>
							<label class="fm-chk"><input class="fm-chk" type="radio" name="TextAlignment" value="right" />Right</label>
						</span>
					</td>
				</tr>
			</table>
		</fieldset>

		<fieldset style="margin-top:12px;padding:8px 5px 5px 5px;">
			<legend>Layout</legend>
			<label class="comment">Select the number of columns the field occupies:</label>
			<table id="panelLayout" cellpadding="0" cellspacing="0" style="width:400px;margin:2px 0 5px 5px">
				<colgroup><col /><col /><col /></colgroup>	
				<tr>
					<td style="text-align:center"><label><input type="radio" name="Columns" value="1" style="margin:5px 8px 0 0;" />One column<br /><img src="Images/layout/layout2_column_1.png" width="90" height="36" style="margin-left:20px;margin-top:2px;" /></label></td>
					<td style="text-align:center"><label><input type="radio" name="Columns" value="2" style="margin:5px 8px 0 0;" />Two columns<br /><img src="Images/layout/layout2_column_2.png" width="90" height="36" style="margin-left:20px;margin-top:2px;" /></label></td>
					<td id="tdColumns3" style="text-align:center;display:none"><label><input type="radio" name="Columns" value="3" style="margin:5px 8px 0 0;" />Three columns<br /><img src="Images/layout/layout3_column_3.png" width="90" height="36" style="margin-left:20px;margin-top:2px;" /></label></td>
				</tr>
			</table>

			<div style="text-align:right;margin-right:10px">
				<label class="comment">Input the number of rows the field occupies:</label>
				<input id="tbRowCount" class="fm" style="width:30px;text-align:center;padding:0;" maxlength="2" />
			</div>
			<div style="margin-top:6px;line-height:12px;">
				<label style="display:inline-block;width:110px;">Label Position:</label>
				<span id="panelTitlePos">
					<label class="fm-chk"><input class="fm-chk" type="radio" name="TitlePos" value="" />Left (default)</label>
					<label class="fm-chk"><input class="fm-chk" type="radio" name="TitlePos" value="top" style="margin-left:12px;" />Top oriented</label>
					<label class="fm-chk"><input class="fm-chk" type="radio" name="TitlePos" value="off" style="margin-left:12px;" />Hide</label>
				</span>
			</div>

		</fieldset>

		<fieldset style="margin-top:12px;padding:8px 5px 2px 5px;">
			<legend>Business levels</legend>
			<label id="lblRequired" class="comment">Select the business requirement level.</label>
			<div id="panelRequiredLevel" style="margin:6px;">
				<label class="fm-chk" style="color:#990000;"><input class="fm-chk" type="radio" name="RequiredLevel" value="required" />Required</label>
				<label class="fm-chk"><input class="fm-chk" type="radio" name="RequiredLevel" value="recommended" style="margin-left:12px;" />Recommended</label>
				<label class="fm-chk"><input class="fm-chk" type="radio" name="RequiredLevel" value="" style="margin-left:12px;" />No constraint</label>
			</div>
			<label id="lblReadonly" class="comment">Select the editing level.</label>
			<div id="panelReadonly" style="margin:6px;">
				<label class="fm-chk"><input class="fm-chk" type="radio" name="Readonly" value="" />Editable</label>
				<label class="fm-chk"><input class="fm-chk" type="radio" name="Readonly" value="true" style="margin-left:10px;" />Readonly</label>
				<label class="fm-chk"><input class="fm-chk" type="radio" name="Readonly" value="control" style="margin-left:10px;" />Disabled control (value can be modified)</label>
			</div>
		</fieldset>

		<fieldset id="trWatermark" style="margin-top:12px;padding:8px 5px 5px 8px;">
			<table style="width:100%">
				<colgroup><col width="110" /><col /></colgroup>
				<tr>
					<td class="n">Watermark</td><td><input id="tbWatermark" class="fm" style="background:#e1e7f7" /></td>
				</tr>
			</table>

		</fieldset>
			
	</div>

	<div class="tab">
		
		<fieldset style="margin-top:12px;padding:12px">
			<legend>Value Binding</legend>
			<div class="comment">Specify the value that will be applied for this field on creating<br />new record and on record update. You can assign dynamic run-time variable value or type the constant value for the field.</div>
			<table style="width:90%;margin-top:5px;" cellpadding="3" cellspacing="3">
				<colgroup><col width="140" /><col /></colgroup>
				<tr>
					<td class="n">OnCreateValue:</td><td style="padding-right:0"><dialogs:AdminPickTextControl id="tbOnCreateValue" runat="server" DialogType="VARIABLES" /></td>
				</tr>
				<tr>
					<td class="n">OnUpdateValue:</td><td style="padding-right:0"><dialogs:AdminPickTextControl id="tbOnUpdateValue" runat="server" DialogType="VARIABLES" /></td>
				</tr>
			</table>
		</fieldset>

		<fieldset id="panelOnClick" style="margin-top:12px;padding:12px">
			<legend>Item details</legend>
			<div style="margin:5px;"><label class="fm-chk"><input id="cbOnClick" type="checkbox" class="fm-chk" /> Allow open details window for the lookup item</label></div>
			<div class="comment">Note: By default will be opened default form in the READONLY state.<br />You can customize the behavior using Lookup View editor.</div>
		</fieldset>

		<fieldset id="panelSuggestions" style="margin-top:12px;padding:12px">
			<legend>Suggestions</legend>
			<table style="width:90%;margin-top:5px;" cellpadding="3" cellspacing="3">
				<colgroup><col width="140" /><col /></colgroup>
				<tr>
					<td colspan="2"><label class="fm-chk"><input id="cbSuggestions" type="checkbox" class="fm-chk" /> Allow auto suggestion list for the field.</label></td>
				</tr>
				<tr id="rowForText">
					<td class="n">Lookup Evidence:</td>
					<td><input id="tbTextBoxLookup" class="fm" title="Example: CRM_Contact/default" /></td>
				</tr>

			</table>
		</fieldset>

		<fieldset id="panelNumbers" style="margin-top:12px;padding:12px;display:none">
			<legend>Input Restrictions</legend>
			<div class="comment">Specify the minimum and maximum for the form's input value</div>
			<table style="width:90%;margin-top:5px;" cellpadding="3" cellspacing="3">
				<colgroup><col width="140" /><col /></colgroup>
				<tr>
					<td class="n">Minumum:</td><td><input id="tbNumMin" class="fm" type="number" style="width:100px" /></td>
				</tr>
				<tr>
					<td class="n">Maximum:</td><td><input id="tbNumMax" class="fm" type="number" style="width:100px" /></td>
				</tr>
			</table>
		</fieldset>
		<fieldset id="panelText" style="margin-top:12px;padding:12px;display:none">
			<legend>Input Restrictions</legend>
			<div class="comment">Specify the validation regex pattern for filtering input values</div>
			<table style="width:90%;margin-top:5px;" cellpadding="3" cellspacing="3">
				<colgroup><col width="140" /><col /></colgroup>
				<tr>
					<td class="n">Validation Format:</td>
					<td>
						<select id="ddlValidationType" class="fm">
							<option value="">No validation</option>
							<option value="email">Email</option>
							<option value="phone">Phone Number</option>
							<option value="custom">Custom Regular Expression</option>
						</select>
					</td>
				</tr>
				<tr>
					<td></td><td><input type="text" class="fm" id="tbTextExp" /></td>
				</tr>
			</table>
		</fieldset>
		
	</div>

	<div class="tab">

		<fieldset style="margin-top:12px;padding:12px 6px 6px 6px">
			<legend>On change event</legend>
			<div class="comment">To automatizate form, use script language of ECMAScript standard<br />and Form Object Model.</div>
			<div style="margin:5px 0 8px 0;">
				<label class="fm-chk"><input id="cbEventEnabled" type="checkbox" class="fm-chk" /> Is enabled</label>
			</div>
			<a id="linkScriptEditor" class="fm-btn" cmd="script-editor" style="position:absolute;right:6px;top:41px;">Define form's common functions</a>
			<textarea id="tbEvent" class="fm" style="height:210px"></textarea>
			
			<div style="font-weight:bold;margin-bottom:5px;margin-top:10px;">Examples</div>
			<div style="color:blue;line-height:16px;margin-left:2px;margin-bottom:15px;position:relative">
// <b>frm</b> - is available variable inside script block <br/>
// and contains the reference to the Form object<br/>
var s= frm.getValue("field1");<br/>
if (s == "") { alert("Field 'field1' is required "); frm.focusField("fiedl1"); } <br/>
frm.setValue("field2", "[Value is empty]");
				<a id="linkScriptHelp" class="fm-btn" cmd="script-help" style="position:absolute;right:2px;top:0px;">Form Documentation</a>
			</div>
		</fieldset>
		
	</div>

	<div class="tab">
		
		<fieldset style="margin-top:12px;padding:12px 6px 6px 6px">
			<legend>Schema</legend>

			<div class="comment">Metadata properties are common for all form's instances. You can modify it by using 'Metadata properties' button below</div>
			
			<table style="width:100%;margin-top:5px;" cellpadding="2" cellspacing="2">
				<colgroup><col width="120" /><col /></colgroup>
				<tr>
					<td class="n">Name:</td><td><input id="tbSchemaName" class="fm" disabled="disabled" style="font-weight:bold" /></td>
				</tr>
				<tr>
					<td class="n">Type:</td><td><input id="tbSchemaType" class="fm" disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="n">Db Type:</td><td><input id="tbSchemaDbType" class="fm" disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="n">Default Title:</td><td><input id="tbSchemaTitle" class="fm" disabled="disabled" /></td>
				</tr>
				<tr>
					<td class="n">Description:</td><td><textarea id="tbSchemaDesc" class="fm" disabled="disabled" style="height:60px"></textarea></td>
				</tr>
				<tr>
					<td style="text-align:right;padding-right:2px;padding-top:5px;" colspan="2"><a class="fm-btn" style="width:140px;" id="linkMetadata" cmd="metadata">Metadata properties</a></td>
				</tr>


			</table>

		</fieldset>
		
	</div>

	<div class="tab">
		
		<fieldset style="margin-top:12px;padding:8px;">
			<legend>Help Information</legend>
			<div class="comment">Mark checkbox to show "i" button near the field title.<br />You can type your custom comment for this field below</div>
			
			<table style="width:100%;margin-top:5px;" cellpadding="2" cellspacing="2">
				<colgroup><col width="130" /><col /></colgroup>
				<tr>
					<td style="vertical-align:top">
						<label><input id="cbShowHelp" class="fm-chk" type="checkbox" /> Show button <img src="../Common/Images/12_info.png" width="12" height="12" style="vertical-align:bottom" /></label>
					</td>
					<td><textarea id="tbDescription" class="fm" style="height:130px"></textarea></td>
				</tr>
				<tr>
					<td style="padding-top:8px;color:#5c6a89;line-height:16px;" colspan="2">
						Note: You can use inline translation syntax for this item.<br />
						Example: <br />
						1033:English tooltip<br />
						1049:Подсказка на русском языке<br />
						<br />
						By default will be shown general description of the field from <br/> the table settings (see tab 'Metadata')
					</td>
				</tr>


			</table>


		</fieldset>
		
	</div>

</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>