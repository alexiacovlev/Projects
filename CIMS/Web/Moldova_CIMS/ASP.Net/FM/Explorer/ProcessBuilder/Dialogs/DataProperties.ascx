<%@ Control Language="C#" %>
<div class="fm-dlg fm-dlg-content" style="top:0;border:0;">
	<fieldset class="fm-dlg-sec-bg" style="padding:4px;margin:0px;">
		<table cellpadding="3" cellspacing="3" width="100%">
			<colgroup><col width="70"/><col width="80" /><col /></colgroup>	
			<tr>
				<td rowspan="3" valign="top"><img src="Images/48/field_editor.png" width="48" height="48" /></td>
				<td class="n">Title:</td>
				<td><input id="tbTitle" class="fm" maxlength="100" style="font-size:10pt;height:22px;"/></td>
			</tr>
			<tr>
				<td class="n">Name:</td>
				<td><input id="tbName" class="fm" disabled="disabled" /></td>
			</tr>				
			<tr>
				<td valign="top" style="padding-top:4px;">Description:</td>
				<td><textarea id="tbDescription" class="fm" rows="4"></textarea></td>
			</tr>	
		</table>
	</fieldset>

	<div style="overflow-y:auto;height:285px;margin-top:2px;">

		<fieldset class="fm-dlg-sec-bg" style="margin-top:15px;padding:10px 5px 9px 12px;">
			<legend>Current State Assignment</legend>
			<div id="panelAssignState"></div>
		</fieldset>
		<fieldset style="margin-top:12px;padding:10px 5px 9px 12px;">
			<legend>Global Schema Assignment</legend>
			<div id="panelGlobalState"></div>
		</fieldset>
		<fieldset style="margin-top:12px;padding:10px 5px 9px 12px;">
			<legend>Panel Assignment</legend>
			<div id="panelSwimlane"></div>
		</fieldset>

	</div>

</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
FMS.DataProperties= function(wnd) {
	FMS.Properties_BaseInit(this, wnd);

	// Assign State
	this.assign= new FMS.StateAssignContainer(this.$p);
}

FMS.DataProperties.prototype= {

	LoadState: function(xd, item, lane) {
		this.xmlDoc= xd;
		FMS.Properties_BaseLoad(this, item);
		var $xn= $(this.xn);
		// Assign
		this.assign.LoadState(xd, $xn, lane);
	},

	SaveState: function() {
		if (!FMS.Properties_BaseSave(this)) return false;
		var $xn= $(this.xn);
		// Assign
		this.assign.SaveState(this.xmlDoc, $xn);
		return true;
	}
}
</script>