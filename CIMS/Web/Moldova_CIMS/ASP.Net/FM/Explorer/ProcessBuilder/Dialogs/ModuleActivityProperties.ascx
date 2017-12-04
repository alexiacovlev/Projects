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
	
	<fieldset id="panelModule" class="fm-dlg-sec" style="margin-top:15px;padding:10px 5px 9px 12px;">
		<legend>Provider Properties</legend>
		<table cellpadding="3" cellspacing="3" width="100%">
			<colgroup><col width="140" /><col /></colgroup>	
			<tr>
				<td class="n">Assembly Name:</td>
				<td><input id="tbProviderAssembly" class="fm" /></td>
			</tr>				
			<tr>
				<td class="n">Provider Full Type:</td>
				<td><input id="tbProviderTypeName" class="fm" /></td>
			</tr>				
		</table>
	</fieldset>
	<fieldset id="panelStoredProcedure" class="fm-dlg-sec" style="margin-top:15px;padding:10px 5px 9px 12px;">
		<legend>Stored Procedure</legend>
		<table cellpadding="3" cellspacing="3" width="100%">
			<colgroup><col width="140" /><col /></colgroup>	
			<tr>
				<td class="n">Method Name:</td>
				<td><input id="tbSPMethodName" class="fm" /></td>
			</tr>				
		</table>
	</fieldset>
	<fieldset id="panelMail" class="fm-dlg-sec" style="margin-top:15px;padding:5px 5px 2px 12px;">
		<legend>Mail</legend>
		<table cellpadding="3" cellspacing="3" width="100%">
			<colgroup><col width="140" /><col /></colgroup>	
			<tr>
				<td class="n">Recepients (TO):</td>
				<td><input id="tbMailTo" class="fm" /></td>
			</tr>
			<tr>
				<td class="n">Subject:</td>
				<td><input id="tbMailSubject" class="fm" /></td>
			</tr>
			<tr>
				<td class="n">Template Name:</td>
				<td><input id="tbMailTemplate" class="fm" /></td>
			</tr>
			<tr>
				<td colspan="2">Note: You can use [FieldName] for the Process Record data as parameter value.<br />For Multiple Recepients use character ';'</td>
			</tr>
		</table>
	</fieldset>

	<fieldset class="fm-dlg-sec" style="margin-top:15px;padding:10px 5px 9px 12px;">
		<legend>Assign Parameters</legend>
		<div id="assignPanel" style="overflow-y:auto;height:157px;">
			<div style="margin:5px;"><label style='width:133px;font-weight:bold;display:inline-block;color:#0464d0;'></label><label>= </label><input class='fm' style='width:290px'/><img cmd="delete" style='vertical-align:bottom;margin-left:20px;cursor:pointer' src='/ASP.Net/FM/Common/Images/16_delete.gif' /></div>
		</div>
	</fieldset>

</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
FMS.ModuleActivityProperties= function(wnd) {
	FMS.Properties_BaseInit(this, wnd);

	this.$panelModule= $("fieldset#panelModule", this.$p); 
	this.$tbProviderAssembly= $("#tbProviderAssembly", this.$panelModule);
	this.$tbProviderTypeName= $("#tbProviderTypeName", this.$panelModule);

	this.$panelStoredProcedure= $("fieldset#panelStoredProcedure", this.$p);
	this.$tbSPMethodName= $("#tbSPMethodName", this.$panelStoredProcedure);

	this.$panelMail= $("fieldset#panelMail", this.$p);
	this.$tbMailTo= $("#tbMailTo", this.$panelMail);
	this.$tbMailSubject= $("#tbMailSubject", this.$panelMail);
	this.$tbMailTemplate= $("#tbMailTemplate", this.$panelMail);

	// Assign
	this.$panel= $("#assignPanel", this.$p);
	this.assignPanel= new FMS.AssignPanel(this.$panel, true, null, true);
}

FMS.ModuleActivityProperties.prototype= {

	LoadState: function(xd, item) {
		this.xmlDoc= xd;
		this.$panelModule.hide(); this.$panelStoredProcedure.hide(); this.$panelMail.hide();
		var $xn_params= $(item.xn).find('parameters');

		switch (item.box.type) {
			case "Module":
				this.$panel.height(157);
				this.$panelModule.show();
				var pmas= this.getFieldValue($xn_params, "provider").split(',');
				this.$tbProviderAssembly.val(pmas.length==2?pmas[0]:"");
				this.$tbProviderTypeName.val(pmas.length==2?pmas[1]:"");
				break;
			case "StoredProcedure":
				this.$panel.height(185);
				this.$panelStoredProcedure.show();
				this.$tbSPMethodName.val(this.getFieldValue($xn_params, "method"));
				break;
			case "SendMail":
				this.$panel.height(105);
				this.$panelMail.show();
				this.$tbMailTo.val(this.getFieldValue($xn_params, "to"));
				this.$tbMailSubject.val(this.getFieldValue($xn_params, "subject"));
				this.$tbMailTemplate.val(this.getFieldValue($xn_params, "templateName"));
				break;
		}
		FMS.Properties_BaseLoad(this, item);
		var $xn= $(this.xn);
		// Assign
		this.assignPanel.LoadState(xd, $xn);

	},

	SaveState: function() {
		if (!FMS.Properties_BaseSave(this)) return false;
		var $xn= $(this.xn);
		var $xn_params= xml_getOrCreate(this.xmlDoc, $xn, 'parameters');

		switch (this.item.box.type) {
			case "Module":
				var p1= this.$tbProviderAssembly.val().trim();
				var p2= this.$tbProviderTypeName.val().trim();
				this.setFieldValue($xn_params, "provider", (p1 != "" && p2 != "") ? (p1+','+p2) : "");
				break;
			case "StoredProcedure":
				this.setFieldValue($xn_params, "method", this.$tbSPMethodName.val().trim());
				break;
			case "SendMail":
				this.setFieldValue($xn_params, "to", this.$tbMailTo.val().trim());
				this.setFieldValue($xn_params, "subject", this.$tbMailSubject.val().trim());
				this.setFieldValue($xn_params, "templateName", this.$tbMailTemplate.val().trim());
				break;
		}

		// Assign
		this.assignPanel.SaveState(this.xmlDoc, $xn);
		return true;
	},

	getXmlField: function($xn_params, name) {
		if ($xn_params.length == 0) return null;
		var xnl= $xn_params.children();
		for (var i= 0; i < xnl.length; i++) if (xnl[i].getAttribute('name') == name) return xnl[i];
		return null;
	},

	getFieldValue: function($xn_params, name) {
		var xnf= this.getXmlField($xn_params, name);
		return xnf?xnf.getAttribute('value'):"";
	},
	setFieldValue: function($xn_params, name, value) {
		var xnf= this.getXmlField($xn_params, name);
		if (!xnf) {
			xnf= xml_appendNode(this.xmlDoc, $xn_params, 'field')[0];
			xnf.setAttribute('name', name);
		}
		xnf.setAttribute('value', value);
	},
}
</script>