<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg" style="position:absolute;top:0px;left:0px;right:0px;bottom:33px;border: solid 1px #a59d9b;background-color:#fffbff;padding:4px;">
<fieldset>
	<legend class="sec">General</legend>
	<table style="table-layout: fixed;margin-left:10px;" cellspacing="3">
		<colgroup><col width="120"/><col width="290"/></colgroup>
		<tr>
			<td class="n">Title:</td>
			<td><input id="tb_title" class="fm" /></td>
		</tr>
		<tr>
			<td class="req">Name:</td>
			<td><input id="tb_name" class="fm ro" readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="n">Description:</td>
			<td><textarea id="tb_description" class="fm"></textarea></td>
		</tr>
		
	</table>
</fieldset>

<fieldset id="panelText" style="margin-top:14px;display:none">
	<legend class="sec">Text Attributes</legend>
	<div style="margin-left:10px;margin-top:5px;vertical-align:middle;">
		Max Length:<input id="tb_text_length" class="fm" style="width:40px;" /> chars or <label style="vertical-align:middle;"><input id="cb_text_max" type="checkbox" style="vertical-align:top" />MAX</label>
	</div>
	<div style="margin:10px;">
		<label class="fm-chk" style="margin:5px 5px 0px 0px;"><input id="cb_text_unicode" type="checkbox" class="fm-chk" />Support non-english symbols (unicode)</label>
	</div>
	<div style="margin:0px 5px 5px 10px;">
		<label class="comment_gray">* Require modification in the database</label>
	</div>

	<div style="margin:10px;">
		<label class="fm-chk" style="margin:5px 5px 0px 0px;"><input id="cb_text_textarea" type="checkbox" class="fm-chk" />Allow multi-line content (textarea)</label>
	</div>
</fieldset>

<fieldset id="panelNumber" style="margin-top:14px;display:none">
	<legend class="sec">Number Attributes</legend>
	<table style="table-layout: fixed;margin-left:10px;margin-bottom:3px;width:100%" cellspacing="3">
		<colgroup><col width="120"/><col width="50" /><col /></colgroup>
		<tr>
			<td class="n">Format:</td>
			<td colspan="2" id="panel_FloatFormat">
				<label><input type="radio" name="field-type" class="fm-chk" value="Float" />Float number</label>
				<label><input type="radio" name="field-type" class="fm-chk" value="Money" style="margin-left:8px;" />Currency</label>
			</td>
		</tr>
		<tr>
			<td class="n">Precision:</td>
			<td><select id="ddl_precision" class="fm"><option value="1">1</option><option value="">2</option><option value="3">3</option><option value="4">4</option></select></td>
			<td></td>
		</tr>
		<tr>
			<td class="n">Currency Sign:</td>
			<td><input id="tb_sign" class="fm" /></td>
			<td></td>
		</tr>
	</table>
</fieldset>

<fieldset id="panelPicklist" style="margin-top:14px;display:none">
	<table style="table-layout: fixed;" cellspacing="3">
		<colgroup><col width="130"/><col width="290"/></colgroup>
		<tr>
			<td class="n" style="padding-left:10px;">Render Mode:</td>
			<td id="rb_picklist_mode">
				<label><input type="radio" class="fm-chk" name="picklist_mode" value=""/>Drop-down list</label>
				<label style="margin-left:20px;"><input type="radio" class="fm-chk" name="picklist_mode" value="radio"/>Radio list</label>
			</td>
		</tr>

		<tr>
			<td class="n" style="padding-left:10px;">Data Source:</td>
			<td colspan="2">
				<select id="listPicklistSource" class="fm">
					<option value="">Static options list</option>
					<option value="DB">Database lookup table</option>
				</select>
			</td>
		</tr>
		<tr id="tr_picklist_1">
			<td class="n"></td>
			<td style="padding:4px" colspan="2"><a id="linkOptions" class="fm">Click here to add/remove/modify options</a></td>
		</tr>
		<tr id="tr_picklist_2" style="display:none">
			<td></td>
			<td>
				<table style="table-layout: fixed;">
					<colgroup><col width="90"/><col width="205"/></colgroup>
					<tr>
						<td style="text-align:right;padding-right:2px;">Lookup Table:</td>
						<td><dialogs:TableLookupControl id="lookup_extract_table2" runat="server" /></td>
					</tr>
					<tr>
						<td style="text-align:right;padding-right:2px;">View:</td>
						<td><input id="tb_extract_view2" class="fm" /></td>
					</tr>
				</table>
			</td>
		</tr>
		
	</table>
	
</fieldset>

<fieldset id="panelExtract" style="margin-top:14px;display:none">
	<legend class="sec">Lookup Data Source</legend>
	<table style="table-layout: fixed;" cellspacing="3">
		<colgroup><col width="130"/><col width="290"/></colgroup>
		<tr>
			<td colspan="2"><label class="comment_gray">Specify settings for lookup dialog.</label></td>
		</tr>
		<tr>
			<td class="n" style="padding-left:10px;">Table Name:</td>
			<td><dialogs:TableLookupControl id="lookup_extract_table" runat="server" /></td>
		</tr>
		<tr>
			<td class="n" style="padding-left:10px;">Lookup View:</td>
			<td><input id="tb_extract_view" class="fm" /></td>
		</tr>
	</table>
	
</fieldset>

<fieldset id="panelRelation" style="margin-top:14px;display:none">
	<legend class="sec">Relation Dialog Settings</legend>
	
	<table style="table-layout:fixed;" cellspacing="3">
		<colgroup><col width="130"/><col width="290"/></colgroup>
		<tr>
			<td colspan="3"><label class="comment_gray">The data for related lookup are stored in the separate table using <br />many-to-many relation type.</label></td>
		</tr>
		<tr style="min-height:24px">
			<td style="padding-left:18px;">Relation Db Table:</td>
			<td><label id="labelRelationTable" style="display:inline-block;font-weight:bold;"></label><a id="linkRelation" class="fm" style="display:inline-block;margin-left:14px;">click to configure... </a></td>
		</tr>
	</table>

	<table id="panelRelationLookup" style="table-layout:fixed;display:none" cellspacing="3">
		<colgroup><col width="130"/><col width="290"/></colgroup>
		<tr>
			<td colspan="3" style="padding-top:0"><label class="comment_gray">Specify the type for the lookup dialog.</label></td>
		</tr>
		<tr style="height:24px">
			<td style="padding-left:18px;">Dialog Format:</td>
			<td id="rb_lookup_mode">
				<label><input type="radio" class="fm-chk" name="lookup_mode" value="multi"/>Multi select</label>
				<label><input style="margin-left:10px;" type="radio" class="fm-chk" name="lookup_mode" value=""/>Single (one related record)</label>
			</td>
		</tr>
		<tr>
			<td colspan="3"><label class="comment_gray">To use records with different types (or from diffrent tables),
				<br />you must configure multi-typed collection.</label>
			</td>
		</tr>
		<tr style="height:22px">
			<td style="padding-left:18px;">Multi-Typed Dialog: </td>
			<td style="padding:0;">
				<input id="cb_extract_dialog" type="checkbox" style="vertical-align:middle;" />
				<input id="tb_extract_dialog" class="fm" style="width:150px;display:none;vertical-align:middle;" />
			</td>
		</tr>
	</table>
</fieldset>

<fieldset id="panelDateTime" style="margin-top:14px;display:none">
	<legend class="sec">DateTime Attributes</legend>
	<table style="table-layout: fixed;margin-bottom:3px;" cellspacing="3">
		<colgroup><col width="130"/><col width="290"/></colgroup>
		<tr>
			<td class="n" style="padding-left:10px;vertical-align:top;padding-top:5px;">Display Mode:</td>
			<td id="rb_datetime_mode">
				<label><input type="radio" class="fm-chk" name="datetime_mode" value=""/>Date only</label>
				<label style="margin-left:20px;"><input type="radio" class="fm-chk" name="datetime_mode" value="datetime"/>Date and Time</label>
				<label style="display:block;margin-top:8px;"><input type="radio" class="fm-chk" name="datetime_mode" value="custom"/>Custom format: <input id="tb_format" class="fm" style="width:150px;" maxlength="20" /></label>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<div id="list_formats" style="padding-left:110px;cursor:pointer;line-height:15px;">
					<a style="display:block" format="dd MMM yy">24 Aug 79</a>
					<a style="display:block" format="dd MMMM yyyy, HH:dd">01 January 2017, 18:00</a>
					<a style="display:block" format="MMM, yyyy">Apr, 2008</a>
				</div>
				<div style="font-style:italic;margin-top:3px;margin-left:10px;">For more, see DateTime formatting</div>
			</td>
		</tr>
	</table>
</fieldset>

<fieldset id="panelBoolean" style="margin-top:14px;display:none">
	<legend class="sec">Boolean Attributes</legend>
	<table style="table-layout: fixed;margin-bottom:3px;" cellspacing="3">
		<colgroup><col width="130"/><col width="290"/></colgroup>
		<tr>
			<td class="n" style="padding-left:10px;">Display Mode:</td>
			<td id="rb_boolean_mode">
				<label><input type="radio" class="fm-chk" name="boolean_mode" value=""/>Radio box</label>
				<label style="margin-left:20px;"><input type="radio" class="fm-chk" name="boolean_mode" value="checkbox"/>Check box</label>
			</td>
		</tr>
	</table>
</fieldset>

<fieldset id="panelFile" style="margin-top:14px;display:none">
	<legend class="sec">File Attributes</legend>
	<table style="table-layout: fixed;margin-bottom:3px;" cellspacing="3">
		<colgroup><col width="130"/><col width="290"/></colgroup>
		<tr>
			<td id="rb_image_mode" colspan="2" style="padding:8px;">
				<label><input type="radio" class="fm-chk" name="image_mode" value="photo"/>Photo</label>
				<label style="margin-left:20px;"><input type="radio" class="fm-chk" name="image_mode" value="attachment"/>Attachment</label>
			</td>
		</tr>
		<tr>
			<td class="n" style="padding-left:10px;">Settings:</td>
			<td><input id="tb_file" class="fm" /></td>
		</tr>
		<tr>
			<td class="n" style="padding-left:10px;"></td>
			<td style="font-style:italic">Define properties columns for the attachment:<br /> filename=Attachment_Name,<br />size=Attachment_Size,<br />extension=Attachment_Ext,<br />contenttype=Attachment_Type<br /></td>
		</tr>
	</table>
</fieldset>

<fieldset id="panelEditableGrid" style="margin-top:14px;display:none">
	<legend class="sec">Slave Grid Properties</legend>
	<table style="table-layout:fixed;" cellspacing="3">
		<colgroup><col width="130"/><col width="180"/><col width="100" /></colgroup>
		<tr>
			<td colspan="3"><label class="comment_gray">The data for the editable grid are stored in the separate table.</label></td>
		</tr>
		<tr>
			<td class="n" style="padding-left:10px;">Table Name:</td>
			<td><dialogs:TableLookupControl id="lookup_slavegrid_table" runat="server" /></td>
			<td></td>
		</tr>
		<tr>
			<td class="n" style="padding-left:10px;">Grid View:</td>
			<td><input id="tb_slavegrid_view" class="fm" /></td>
			<td></td>
		</tr>
		<tr>
			<td colspan="3" style="padding-top:8px;"><label class="comment_gray">The slave grid is linked with the base table by the Key Field.</label></td>
		</tr>
		<tr>
			<td class="n" style="padding-left:10px;">Parent Key:</td>
			<td><input id="tb_slavegrid_parentkey" class="fm" /></td>
			<td></td>
		</tr>
		<tr>
			<td colspan="3"><label class="comment_gray" style="display:block;margin-top:5px;">You can add additional links with the base table</label></td>
		</tr>
		<tr>
			<td colspan="3" id="panel_eg_list"></td>
		</tr>
	</table>
</fieldset>

<div style="position:absolute;bottom:0px;left:10px;right:10px;">
	<div class="sec" style="font-weight:bold;">Data Entry State</div>
	<div style="padding:5px 0px 5px 7px;">
		<label class="fm-chk" style="margin:2px;display:block"><input id="cb_required" type="checkbox" class="fm-chk" /><span>Is System Required<span style="color:red">*</span></span></label>
		<label class="fm-chk" style="margin:2px;display:block"><input id="cb_readonly" type="checkbox" class="fm-chk" /><span>Readonly (prevent from modifying)</span></label>
	</div>


	<div id="panelDbType" style="display:none">
		<div class="sec" style="font-weight:bold;margin-top:0px;">Database Registration</div>

		<div style="margin:7px;">
			<span>Register with DB Type:</span>
			<select id="listDbType" class="fm" style="width:85px;">
			</select>
			<label style="margin-left:7px;">OR <input id="cbVirtual" type="checkbox" class="fm-chk" style="vertical-align:middle;"/>Create as virtual</label>
		</div>
	
	</div>

</div>


</div>
<div id="_bottomButtons" style="position:absolute;bottom:4px;right:3px;">
	<%= AX.FM.Common.UI.Button.Render("OK", "margin-left:5px;width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;width:50px;", false)%>
</div>
<a id="btnChangeType" class="fm" style="position:absolute;bottom:8px;left:8px;">Change Type</a>