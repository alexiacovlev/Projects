<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-tabbar">
	<span class="tab tabOn">General</span><span class="tab">Handlers</span><span class="tab">Additional</span>
</div>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;">
	<div class="tab" style="display:block">
		
			<table cellpadding="0" cellspacing="2" width="100%">
				<colgroup><col width="120"/><col /></colgroup>	
				<tr style="height:20px">
					<td></td>
					<td><label class="comment">Provide a name, title and description for this editable grid.</label></td>
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
		</div>

		<div class="tab">

			<table cellpadding="4" cellspacing="4" style="width:100%;">
				<colgroup><col width="98"/><col /></colgroup>	
				<tr>
					<td class="req">Edit Mode:</td>
					<td style="font-weight:bold" colspan="2" id="panelEditMode"><label><input type="radio" class="fm-chk" name="EditMode" value="[ROW]"/>Inline</label><label style="margin-left:20px;"><input type="radio" name="EditMode" class="fm-chk" value="[WINDOW]" />External Window</label></td>
				</tr>
			</table>

			<div style="margin-top:5px;padding:5px;">
				<label style="padding:10px;font-weight:bold;"><input id="cb_create" type="checkbox" class="fm-chk" />Allow Append Row</label>

				
				<label id="lblAutoNewRow" style="padding:10px;margin-left:20px;"><input id="cbAutoNewRow" type="checkbox" class="fm-chk" />Auto New Row</label>
			
				<table cellpadding="3" cellspacing="3" style="width:90%;">
					<colgroup><col width="95"/><col /></colgroup>	
					<tr>
						<td align="right">Button Text:</td>
						<td><input id="tb_create_text" class="fm" /></td>
					</tr>
					<tr id="rowCreateHandler1">
						<td align="right">Handler:</td>
						<td><input id="tb_create" class="fm" /></td>
					</tr>
					<tr id="rowCreateHandler2">
						<td align="right"></td>
						<td><div id="div_create_window" /></td>
					</tr>
				</table>

			</div>

			<div id="rowSelectHandler" style="margin-top:5px;padding:5px;">
				<label style="padding:10px;font-weight:bold"><input id="cb_select" type="checkbox" class="fm-chk" />Allow Open Row</label>

				<table cellpadding="3" cellspacing="3" style="width:90%;">
					<colgroup><col width="95"/><col /></colgroup>	
					<tr>
						<td align="right">Handler:</td>
						<td><input id="tb_select" class="fm" /></td>
					</tr>
					<tr>
						<td align="right"></td>
						<td><div id="div_select_window"></div></td>
					</tr>
				</table>
				
			</div>

			<div style="margin-top:5px;padding:5px;">

				<label style="padding:10px;font-weight:bold"><input id="cb_delete" type="checkbox" class="fm-chk" />Allow Delete Row</label>

			</div>

			

	</div>

	<div class="tab">
		
		<fieldset style="margin-top:15px;padding:8px;">
			<legend>READONLY Behavior</legend>

			<label class="comment">In Readonly state Editable grid is rendering as list without handlers.<br />You can enable record preview or other handler using the settings below.<br />Default: FORM:default/READONLY</label>

			<table cellpadding="3" cellspacing="3" style="width:90%;">
				<colgroup><col width="95"/><col /></colgroup>	
				<tr>
					<td align="right">Allow Open:</td>
					<td><input id="cb_select_ro" type="checkbox" class="fm-chk" /></td>
				</tr>
				<tr>
					<td align="right">Handler:</td>
					<td><input id="tb_select_ro" class="fm" /></td>
				</tr>
				<tr>
						<td align="right"></td>
						<td><div id="div_select_ro_window"></div></td>
					</tr>
			</table>
				
		</fieldset>
		
		<fieldset style="margin-top:15px;padding:8px;">
			<legend>Calculate Total Sum</legend>

			<table cellpadding="3" cellspacing="3" style="width:90%;">
				<colgroup><col width="95"/><col /></colgroup>	
				<tr>
					<td align="right">Field Name:</td>
					<td><dialogs:FieldLookupControl id="tbTotalField" runat="server" DialogType="FIELD/NUMBER" WindowTitle="Numeric Field List" /></td>
				</tr>
			</table>
				
		</fieldset>
			
	</div>

</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.VB_EGRID_ViewProperties = function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.tabBar= new FM.Tabbar($("div.fm-dlg-tabbar", this.$p));
		$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);

		this.viewName= $("#viewName", this.$p);
		this.viewTitle= $("#viewTitle", this.$p)
		this.viewDesc= $("#viewDesc", this.$p);

		this.panelEditMode= new FM.RadioGroup($("#panelEditMode", this.$p));

		$("#panelEditMode", this.$p).addHandler('change', this.toggleUI, this);

		this.div_select_window= new FM.WindowParameters($("#div_select_window", this.$p));
		this.div_create_window= new FM.WindowParameters($("#div_create_window", this.$p));
		this.div_select_ro_window= new FM.WindowParameters($("#div_select_ro_window", this.$p));

		this.tbTotalField= new FM.LookupTextControl($("#tbTotalField", this.$p));
	}
	RMC.VB_EGRID_ViewProperties.prototype = {

		LoadState: function(viewBuilder) {
			var $p= this.$p;
			this._window.show();
			this._vb= viewBuilder;
			var $xnview= this._vb.$xnview;
			var $xnh= $("handlers", $xnview);
						
			this.viewName.val(viewBuilder.viewName);
			this.viewTitle.val($xnview.find('header').attr('title'));
			this.viewDesc.val($xnview.find('description').attr('title'));
			
			var $xnselect= $("select", $xnh);
			var $xnselect_ro= $("select_ro", $xnh);
			var $xncreate= $("create", $xnh);
			var $xndelete= $("delete", $xnh);

			var create_enabled= $xncreate.attr('enabled') != 'false';
			var create_h= $xncreate.text();
			var select_enabled= $xnselect.attr('enabled') == 'true';
			var select_h= $xnselect.text();
			var select_ro_enabled= $xnselect_ro.attr('enabled') == 'true';
			var select_ro_h= $xnselect_ro.text();

			$("#cb_create", $p).prop('checked', create_enabled);
			$("#tb_create", $p).val(create_h);
			this.div_create_window.setValue($xncreate.attr('window'));
			$("#cb_select", $p).prop('checked', select_enabled);
			$("#tb_select", $p).val(select_h);
			this.div_select_window.setValue($xnselect.attr('window'));
			$("#cb_select_ro", $p).prop('checked', select_ro_enabled);
			$("#tb_select_ro", $p).val(select_ro_h);
			this.div_select_ro_window.setValue($xnselect_ro.attr('window'));
			$("#cb_delete", $p).prop('checked', $xndelete.attr('enabled') != 'false');

			$("#tb_create_text", $p).val($xncreate.attr('title'));
			this.tbTotalField.parentValue= viewBuilder.tableName;
			this.tbTotalField.setValue($("totalField", $xnview).text());
			
			
			var mode= "[ROW]";
			if (create_enabled && create_h) mode= "[WINDOW]";
			else if (select_enabled) mode= "[WINDOW]";
			this.panelEditMode.setValue(mode);
			this.toggleUI();
			
			if (mode == "[ROW]") {
				var $xnauto= $("autoNewRow", $xnview);
				$("#cbAutoNewRow", $p).prop('checked', $xnauto.text() != 'off');
			}

		},

		toggleUI: function() {
			var mode= this.panelEditMode.getValue();
			var $p= this.$p;
			var isRow= (mode == "[ROW]");
			$("#rowCreateHandler1", $p).css('display', isRow?'none':'');
			$("#rowCreateHandler2", $p).css('display', isRow?'none':'');
			$("#rowSelectHandler", $p).css('display', isRow?'none':'');
			$("#lblAutoNewRow", $p).css('display', !isRow?'none':'');
		},

		SaveState: function() {
			var xd = this._vb.xmlDoc;
			var $xnview = this._vb.$xnview;
			var $p= this.$p;
			
			var mode= this.panelEditMode.getValue();
			var WINDOW_MODE= (mode=="[WINDOW]");
			
			if (WINDOW_MODE) {
				var b_create= $("#cb_create", $p).is(':checked') && ($("#tb_create", $p).val().trim() != "");
				var b_select= $("#cb_select", $p).is(':checked');
				if (!b_create && !b_select) { AX.Window.alert("Save Properties Message", "You've selected 'External Window' for edit row.<br/><br/>Please, define 'Append Row' or 'Open Row' handler and mark 'Enabled' checkbox.<br/>Or you can change the Edit Mode to 'Inline'.<br/>"); return; }
			} else {
				$("#cb_select", $p).prop('checked', false);
			}

			xml_setNodeAttr(xd, $xnview, "header", 'title', this.viewTitle.val().trim(), true);
			xml_setNodeAttr(xd, $xnview, "description", 'title', this.viewDesc.val().trim(), true);

			var $xnh= $("handlers", $xnview);
			var hnd_exists= !$isNull($xnh);
			if (!hnd_exists) $xnh= xml_createNode(xd, "handlers");

			var b1= this.updateHandlerNode($xnh, "create", "tb_create_text", true, WINDOW_MODE, WINDOW_MODE?this.div_create_window:null, true);
			var b2= this.updateHandlerNode($xnh, "select", null,						 WINDOW_MODE, WINDOW_MODE, WINDOW_MODE?this.div_select_window:null, false);
			var b3= this.updateHandlerNode($xnh, "select_ro", null,					 true, true, this.div_select_ro_window, false);
			var b4= this.updateHandlerNode($xnh, "delete", null,						 true, false, null, false);

			if (!b1&& !b2 && !b3 && !b4) $xnh.remove();
			else if (!hnd_exists) $xnview.append($xnh);

			//alert($xnh[0].xml);

			if (mode == "[ROW]") {
				var $xnauto= $("autoNewRow", $xnview);
				var auto_exists= !($isNull($xnauto));
				var s= $("#cbAutoNewRow", $p).is(':checked')?"":"off";
				if (s != "") {
					if (!auto_exists) $xnauto= xml_appendNode(xd, $xnview, "autoNewRow");
					$xnauto.text(s);
				} else if (auto_exists) $xnauto.remove();
			}

			var $xntotal= $("totalField", $xnview);
			var total_exists= !($isNull($xntotal));
			var s= this.tbTotalField.getValue();
			if (s != "") {
				if (!total_exists) $xntotal= xml_appendNode(xd, $xnview, "totalField");
				$xntotal.text(s);
			} else if (total_exists) $xntotal.remove();

			this._window.close();
		},

		updateHandlerNode: function($xnh, name, button_id, add_enabled, add_handler, div_window, keep_empty) {
			var $p= this.$p;
			var xd = this._vb.xmlDoc;
			var keep= false;

			var $xn= $(name, $xnh);
			var exists= !$isNull($xn);
			if (!exists) $xn= xml_createNode(xd, name);

			var enabled= $("#cb_"+name, $p).is(':checked')?'true':'false';

			if (div_window) xml_updateAttr($xn, "window", div_window.getValue());
			else xml_updateAttr($xn, "window", "");

			if (add_handler) {
				var h= $("#tb_"+name, $p).val().trim();
				if (name == 'create' && enabled=='true' && h == '') h= 'FORM:default';
				$xn.text(h);
				if (h != '') keep= true;
				else $xn.empty();
			} else {
				$xn.empty();
			}

			if (name == "delete")	{
				xml_updateAttr($xn, "enabled", enabled=='false'?'false':'');
				keep= enabled=='false';
			} else if (add_enabled) {
				
				xml_updateAttr($xn, "enabled", enabled);
				if (enabled == 'false' && keep_empty) keep= true;
				if (enabled == 'true' && !keep_empty) keep= true;

			} else if (keep_empty) {
				xml_updateAttr($xn, "enabled", "false");
			}

			if (button_id) {
				var title= $("#"+button_id, $p).val().trim();
				xml_updateAttr($xn, "title", title);
				if (title != '') keep= true;
			}

			if (keep) {
				if (!exists) $xnh.append($xn);
			} else {
				if (!keep_empty) $xn.remove();
			}

			return keep;
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": this.SaveState(); break;
				case "X": this._window.close(); break;
			}
		},

	}
</script>