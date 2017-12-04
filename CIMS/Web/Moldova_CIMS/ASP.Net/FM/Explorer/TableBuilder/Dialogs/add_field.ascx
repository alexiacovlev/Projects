<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<style type="text/css">
	div.fm-tb-add-field-hdr { 
		font-family:Verdana;margin-top:10px;margin-bottom:2px;
		padding-bottom:2px;
		border-bottom:1px solid #838574;
		display:block;width:100%; color:#606050; font-weight:bold;
		font-size:8pt;
	}
	
	div.fm-tb-add-field {
		
	}
	div.fm-tb-add-field label {
		display:inline-block;
		color:#03527c;
		font-size:8pt;
		margin:8px;
	}

	div.fm-tb-add-hdr {
		color:#606050;
		font-size:8pt;
		font-weight:bold;
		border-bottom:solid 1px #606050;
		padding-bottom:3px;
	}
	a.fm-tb-add-btn {
		cursor:pointer;
		margin:3px 8px 3px 8px;
		display:block;
		height:40px;
		line-height:36px;
		width:210px;
		border:solid 1px #83b0fc;
		border-radius:4px;
		background-image:url(/ASP.Net/FM/Explorer/TableBuilder/Images/btn-bg.png);background-position:0px -40px;background-repeat:repeat-x;
		padding-left:20px;
		color:#1d5a9c;
		box-shadow:2px 2px 4px #4d4d4d;
	}
	a.fm-tb-add-btn:hover {
		background-position:0px 0px;
		color:#2572c7;
	}
	a.fm-tb-add-btn img {
		margin-top:-3px;
		vertical-align:middle;
		width:60px;
	}
	a.fm-tb-add-btn:hover img {
		opacity:0.8;
	}
	a.fm-tb-add-btn span {
		margin-top:2px;
		display:inline-block;
		
		font-family:Verdana;
		font-weight:bold;
		font-size:12px;
		margin-left:8px;
	}
</style>
<div class="fm-dlg" style="position:absolute;top:0px;left:0px;right:0px;bottom:33px;border: solid 1px #a59d9b;background-color:#fffbff;padding:4px;">
	<div id="panel_Types" class="fm-tb-add-field">
		<table style="margin-left:20px;">
			<tr>
				<td colspan="2"><div class="fm-tb-add-hdr">Value Types</div></td>
			</tr>
			<tr>
				<td><a class="fm-tb-add-btn" data="Text/String/"><img src="TableBuilder/Images/text.png" height="19" /><span>Text</span></a></td>
				<td><a class="fm-tb-add-btn" data="Text/String/textarea"><img src="TableBuilder/Images/text-area.png" height="34" /><span>Text area</span></a></td>
			</tr>
			<tr>
				<td><a class="fm-tb-add-btn" data="Integer/Int32/"><img src="TableBuilder/Images/integer.png" height="19" /><span>Integer number</span></a></td>
				<td><a class="fm-tb-add-btn" data="Float/Double/"><img src="TableBuilder/Images/float.png" height="19" /><span>Float number</span></a></td>
			</tr>
			<tr>
				<td><a class="fm-tb-add-btn" data="Boolean/Boolean/checkbox"><img src="TableBuilder/Images/boolean.png" height="19" /><span>Check box</span></a></td>
				<td><a class="fm-tb-add-btn" data="DateTime/DateTime/"><img src="TableBuilder/Images/datetime.png" height="19" /><span>Date-time</span></a></td>
			</tr>
			<tr>
				<td><a class="fm-tb-add-btn" data="Image/Byte[]/attachment:filename=File_FileName,size=File_Size"><img src="TableBuilder/Images/file.png" height="19" /><span>Attachment</span></a></td>
				<td><a class="fm-tb-add-btn" data="Image/Byte[]/"><img src="TableBuilder/Images/image.png" height="34" /><span>Image</span></a></td>
			</tr>

			<tr>
				<td colspan="2" style="padding-top:8px;"><div class="fm-tb-add-hdr">Lookup/Select Fields</div></td>
			</tr>
			<tr>
				<td><a class="fm-tb-add-btn" data="Lookup/Guid/"><img src="TableBuilder/Images/lookup.png" height="19" /><span>Lookup box</span></a></td>
				<td><a class="fm-tb-add-btn" data="Picklist/Int32/"><img src="TableBuilder/Images/picklist.png" height="19" /><span>Drop-down list</span></a></td>
			</tr>
			<tr>
				<td><a class="fm-tb-add-btn" data="Picklist/Int32/radio"><img src="TableBuilder/Images/radiolist.png" height="34" /><span>Radio list</span></a></td>
				<td></td>
			</tr>

			<tr>
				<td colspan="2" style="padding-top:8px;"><div class="fm-tb-add-hdr">Related Fields</div></td>
			</tr>
			<tr>
				<td><a class="fm-tb-add-btn" data="Lookup//multi"><img src="TableBuilder/Images/lookup-multi.png" height="34" style="width:70px" /><span>Multi Lookup</span></a></td>
				<td><a class="fm-tb-add-btn" data="Checkboxlist//multi"><img src="TableBuilder/Images/checkboxlist.png" height="34" /><span>Checkbox group</span></a></td>
			</tr>
			<tr>
				<td><a class="fm-tb-add-btn" data="EditableGrid//"><img src="TableBuilder/Images/editablegrid.png" height="34" style="width:70px" /><span>Embedded Grid</span></a></td>
				<td></td>
			</tr>
		</table>
	</div>
</div>

<div id="_bottomButtons" style="position:absolute;bottom:4px;right:3px;">
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;width:50px;", false)%>
</div>