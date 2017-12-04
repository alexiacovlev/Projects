<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
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

	<div class="fm-dlg-tabbar" style="position:absolute;top:140px;">
		<span class="tab tabOn" style="width:100px">Presentation</span>
	</div>
	<div class="fm-dlg-tabs fm-dlg" style="top:164px;bottom:0px;padding:0;">
		<div class="tab" style="padding:15px;display:block">
			<div class="comment" style="margin-bottom:10px;">
				The start in the process can be represented by FORM with handled record data or by forms sequence.
			</div>
			<table cellpadding="2" cellspacing="2" width="100%">
				<colgroup><col width="130" /><col /></colgroup>	
				<tr>
					<td class="n">Handler Type:</td>
					<td>
						<select id="ddlHandlerType" class="fm" style="width:200px">
							<option value="">Nothing</option>
							<option value="WORKFLOW">Human Workflow</option>
							<option value="FORM">Data Form</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="n" align="right"></td>
					<td><input id="tbHandlerValue" class="fm" style="width:200px" /></td>
				</tr>
			</table>
		</div>

	</div>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
FMS.StartProperties= function(wnd) {
	wnd.setHeader("Start Properties");
	wnd.setSize(530, 400);
	FMS.Properties_BaseInit(this, wnd);

	// Presentation
	this.$ddlHandlerType= $("#ddlHandlerType", this.$p); 
	this.$tbHandlerValue= $("#tbHandlerValue", this.$p); 
	this.$ddlHandlerType.change($createDelegate(this.ddlHandlerType_onchange, this));
}

FMS.StartProperties.prototype= {

	LoadState: function(xd, item, lane) {
		this.xmlDoc= xd;
		FMS.Properties_BaseLoad(this, item);

		var $xn= $(this.xn);
		// Presentation
		var ui= this._ui= this.xn.getAttribute("ui")||'';
		var ui_type= '', ui_val= ''
		if (ui && ui.indexOf(':') != -1) { ui_type= ui.substr(0, ui.indexOf(':')); ui_val= ui.substr(ui.indexOf(':')+1); }
		this.$ddlHandlerType.val(ui_type); this.$tbHandlerValue.val(ui_val); 
		this.$tbHandlerValue.toggle(ui != '');

	},

	ddlHandlerType_onchange: function() {
		var h= this.$ddlHandlerType.val();
		var v= this.$tbHandlerValue.val();
		var name= this.item.box.name;
		if (h=='WORKFLOW') {
			this.$tbHandlerValue.val(name);
		} else if (h=='FORM') {
			this.$tbHandlerValue.val('default');
		} else {
			this.$tbHandlerValue.val('');
		}
		this.$tbHandlerValue.toggle(h != "");
	},

	SaveState: function() {
		if (!FMS.Properties_BaseSave(this)) return false;
		var $xn= $(this.xn);

		// Presentation
		var ui_type= this.$ddlHandlerType.val();
		var ui_val= this.$tbHandlerValue.val().trim();
		var ui= (ui_type != '') ? (ui_type + ':' + ui_val) : '';
		if (this._ui != ui) {
			this.xn.setAttribute('ui', ui);
			this.item.box.handler= ui;
			this.item.box.ui_ico= ui_type.length;
			this._window.returnValue= true;
		}

		return true;
	}

}


</script>
