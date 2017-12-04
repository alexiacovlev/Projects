<%@ Control Language="C#"%>
<div class="fm-dlg-tabbar">
	<span class="tab tabOn">General</span><span class="tab">Form Control Properties</span><span class="tab">Automatization</span>
</div>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;">
	<div class="tab" style="display:block">
		
	<table width="100%" style="TABLE-LAYOUT:fixed" cellpadding="4" cellspacing="4">
		<colgroup><col width="100" /><col /></colgroup>
		<tr style="height:24px;">
			<td></td>
			<td><label class="comment">You can change the title and layout for the column.</label></td>
		</tr>
		<tr style="height:24px;">
			<td class="n">Title:</td>
			<td><input id="tbTitle" class="fm" /></td>
		</tr>
		<tr style="height:24px;">
			<td>Schema Name</td>
			<td><label id="schemaName" style="font-weight:bold"></label>
				&nbsp;&nbsp;(&nbsp;<label id="fieldType"></label>&nbsp;)
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<div style="MARGIN-TOP:20px;FONT-WEIGHT:bold;BORDER-BOTTOM:#999999 1px solid">Select a width for this column:</div>
				<table id="tblWidth" width="100%" cellspacing="0" cellpadding="2" style="MARGIN-TOP:10px">
					<colgroup><col /><col width="52"/><col width="52"/><col width="52"/><col width="52"/><col width="52"/><col width="52"/><col width="52"/><col width="52"/><col /></colgroup>
					<tr id="trWidth">
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rdAuto" value="" /></td>
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rd25" value="25" /></td>
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rd50" value="50" /></td>
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rd75" value="75" /></td>
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rd100" value="100" /></td>
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rd125" value="125" /></td>
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rd150" value="150" /></td>
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rd200" value="200" /></td>
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rd300" value="300" /></td>
						<td align="center"><input type="radio" class="radio" name="rdWidth" id="rdCustom" value="custom"/></td>
						<td>&nbsp;</td>
					</tr>
					<tr style="COLOR:#555577">
						<td align="center"><label for="rdAuto" style="font-weight:bold">Auto</label></td>
						<td align="center"><label for="rd25">25px</label></td>
						<td align="center"><label for="rd50">50px</label></td>
						<td align="center"><label for="rd75">75px</label></td>
						<td align="center"><label for="rd100">100px</label></td>
						<td align="center"><label for="rd125">125px</label></td>
						<td align="center"><label for="rd150">150px</label></td>
						<td align="center"><label for="rd200">200px</label></td>
						<td align="center"><label for="rd300">300px</label></td>
						<td align="center"><input class="fm" id="tbCustom" style="width:40px;" size="5"/></td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div style="DISPLAY:none" id="divAuto">
					<br />
					This is the auto-sized column. Its width is set automatically.
					<br />You can set other column as auto sized and after modify this column size.
				</div>
			</td>
		</tr>
	</table>

	</div>
	<div class="tab">

	
		<fieldset>
			<legend>Constraint Levels</legend>
			<div class="desc">If field is not system required, you can change this property.</div>
			<div id="panelRequired" style="margin:8px;">
				<label class="fm-chk" style="color:#c10000"><input class="fm-chk" type="radio" name="Required" value="required" />Required</label>
				<label class="fm-chk"><input type="radio" class="fm-chk" name="Required" value="recommanded" />Recommended</label>
				<label class="fm-chk"><input type="radio" class="fm-chk" name="Required" value="" />No constraint</label>
			</div>
			<br />
			<div class="desc">Select the editing level for the cell.</div>
			<div id="panelReadonly" style="margin:8px;">
				<label class="fm-chk"><input type="radio" class="fm-chk" name="Readonly" value="" />Editable</label>
				<label class="fm-chk"><input type="radio" class="fm-chk" name="Readonly" value="true" />Readonly</label>
				<label class="fm-chk"><input type="radio" class="fm-chk" name="Readonly" value="control" />Disabled control (value can be modified)</label>
			</div>
		</fieldset>

		<fieldset style="margin-top:15px;">
			<legend>Value Binding</legend>
			<div class="desc">
					Specify the values that will be applied for the field on appending new row<br />and after updating existed one.
			</div>
			<table width="98%" cellpadding="2" cellspacing="2" style="table-layout:fixed;">
				<colgroup><col width="170"/><col /></colgroup>
				<tr>
					<td>&nbsp;&nbsp;OnCreateValue:</td>
					<td><input class="fm" id="tbOnCreateValue"/></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;OnUpdateValue:</td>
					<td><input class="fm" id="tbOnUpdateValue"/></td>
				</tr>
			</table>
		</fieldset>

		<fieldset id="panelLookup" style="margin-top:15px;display:none">
			<legend>Lookup OnClick Action</legend>
			<div class="desc">
				You can activate special OnClick behavior for lookup item.
			</div>
			<div style="padding:10px;">
				<label><input id="cbAllowLookupClick" type="checkbox" class="fm-chk" />Allow Item Click Action</label>
			</div>

	</div>

	<div class="tab">
		<div style="margin:4px;font-weight:bold;">On change event</div>
		<div class="desc">To automatizate form, use scripting language of ECMAScript standart,<br />and Form Object Model.</div>
		<div style="margin:6px;">
			<label><input type="checkbox" id="cbEvent" class="fm-chk" />Is enabled</label>
		</div>
		<div style="margin:4px;"><textarea class="fm" id="tbEvent" style="height:150px;"></textarea></div>

		<div style="margin:8px 4px;">
			<label style="font-weight:bold;">Example</label><br />
			<div style="color:blue">
				// <b>frm</b> - reference to the Form Object<br />
				// <b>row</b> - reference to the current Form Row<br />
				var s1= row.getValue("field1");<br />
				var s2= row.getValue("field2");<br />
				if (s1 != s2) { <br />
				&nbsp;&nbsp;row.alert('Field2 not match Field1');<br />
				&nbsp;&nbsp;row.setValue("field2", ""); row.focusField('field2'); <br />
				}
			</div>
		</div>
				
	</div>

</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:50px;margin-left:5px;", false)%>
</div>

<script type="text/javascript">
	RMC.VB_EGRID_ColumnProperties = function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;

		this.tabBar= new FM.Tabbar($("div.fm-dlg-tabbar", this.$p));

		this.$tbTitle= $("#tbTitle", this.$p);
		this.$schemaName= $("#schemaName", this.$p);
		this.$fieldType= $("#fieldType", this.$p);

		$("#rdCustom", this.$p).addHandler('mousedown', this.custom_click, this);
		this.$tbCustom= $("#tbCustom", this.$p);
		this.$tbCustom.addHandler('click', this.custom_click, this);

		this.$tbOnCreateValue= $("#tbOnCreateValue", this.$p);
		this.$tbOnUpdateValue= $("#tbOnUpdateValue", this.$p);

		var $panelRequired= $("#panelRequired", this.$p);
		this.required_inputs= $("INPUT", $panelRequired);
		this.panelRequired= new FM.RadioGroup($panelRequired);
		this.panelReadonly= new FM.RadioGroup($("#panelReadonly", this.$p));

		this.$panelLookup= $("#panelLookup", this.$p);

		this.$cbEvent= $("#cbEvent", this.$p);
		this.$tbEvent= $("#tbEvent", this.$p);
		
		$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);

	}
	RMC.VB_EGRID_ColumnProperties.prototype = {

		LoadState: function(xmlDoc, xn, settings) {
			this.xmlDoc= xmlDoc;
			this.xn = xn;
			this.$tbTitle.val(xn.getAttribute('title'));

			this._window.show();
			this.$tbTitle.focus();

			this.$schemaName.text(xn.getAttribute('name'));
			this.fieldType= settings.getAttribute("type");
			this.$fieldType.text(this.fieldType);

			var width = xn.getAttribute('width');
			this.$tbCustom.val("");
			if (width == null || width == "") {
				$("#tblWidth", this.$p).hide();
				$("#divAuto", this.$p).show();
				$("#rdAuto", this.$p).attr('checked', true);
			} else {
				$("#tblWidth", this.$p).show();
				$("#divAuto", this.$p).hide();
				var rdID;
				switch (width) {
					case "": rdID = "rdAuto"; break;
					case "25": case "50": case "75": case "100":
					case "125": case "150": case "200": case "300":
						rdID = "rd" + width;
						break;
					default:
						rdID = "rdCustom";
						this.$tbCustom.val(width+'px');
						break;
				}
				$("#" + rdID, this.$p).attr('checked', true);
			}

			var $xn_prop= $("properties", xn);
			var $xn_event= $("event", xn);

			// Form Control Properties
			this.$tbOnCreateValue.val($xn_prop.attr('oncreatevalue'));
			this.$tbOnUpdateValue.val($xn_prop.attr('onupdatevalue'));

			this.is_required= (settings.getAttribute("required")=='true');
			this.required_inputs.prop('disabled', this.is_required);
			this.panelRequired.setValue(this.is_required ? "required" : $xn_prop.attr('requiredlevel'));
			this.panelReadonly.setValue($xn_prop.attr('readonly'));

			this.$panelLookup.css('display', this.fieldType == 'Lookup'?'':'none');
			if (this.fieldType == "Lookup") {
				$("#cbAllowLookupClick", this.$p).prop('checked', $xn_prop.attr('handlermode') == 'editable');
			}

			// Event
			if (!$isNull($xn_event)) {
				this.$cbEvent.prop('checked', $xn_event.attr('enabled')!='false');
				this.$tbEvent.val($xn_event.text());
			} else {
				this.$cbEvent.prop('checked', true);
				this.$tbEvent.val('');
			}
		
		},

		getSelectedWidth: function() {
			var s = "100";
			var list = $("#trWidth input", this.$p);
			for (var i = 0; i < list.length; i++) if ($(list[i]).is(":checked")) { s = list[i].value; break; }
			if (s == "custom") s = this.$tbCustom.val().trim().replace('px','');
			return s;
		},

		custom_click: function() {
			var s= this.getSelectedWidth();
			if (this.$tbCustom.val() == "") this.$tbCustom.val(s+'px');
			$("#rdCustom", this.$p).attr('checked', 'checked');
		},

		SaveState: function() {
			var xn = this.xn;

			var title= this.$tbTitle.val().trim();
			if (title != xn.getAttribute('title')) this._window.returnValue= 'title';
			xn.setAttribute('title', title);
			if ($("#tblWidth", this.$p).css('display') != 'none') {
				var width= this.getSelectedWidth();
				if (width != xn.getAttribute('width')) this._window.returnValue= 'width';
				xml_updateAttribute(xn, 'width', width);
			}

			
			var $xn_prop= $("properties", xn);
			var $xn_event= $("event", xn);

			var prop_exists= !$isNull($xn_prop);
			if (!prop_exists) $xn_prop= xml_createNode(this.xmlDoc, "properties");

			// Form Control Properties
			xml_updateAttr($xn_prop, 'oncreatevalue', this.$tbOnCreateValue.val().trim());
			xml_updateAttr($xn_prop, 'onupdatevalue', this.$tbOnUpdateValue.val().trim());
			if (!this.is_required) xml_updateAttr($xn_prop, 'requiredlevel', this.panelRequired.getValue());
			xml_updateAttr($xn_prop, 'readonly', this.panelReadonly.getValue());
			
			if (this.fieldType == "Lookup") {
				xml_updateAttr($xn_prop, 'handlermode', $("#cbAllowLookupClick", this.$p).is(':checked')?'editable':'');
			}

			// add or delete <properties/>
			var prop_has_data= $xn_prop[0].attributes.length>0;
			if (!prop_exists && prop_has_data) $(xn).append($xn_prop);
			else if (prop_exists && !prop_has_data) $xn_prop.remove();


			// Event
			var event_exists= !$isNull($xn_event);
			var code= this.$tbEvent.val().trim();
			if (code != "") {
				if (!event_exists) {
					$xn_event= xml_createNode(this.xmlDoc, "event");
					$(xn).append($xn_event);
				}
				$xn_event.text(code);
			} else if (event_exists) {
				$xn_event.remove();
			}

		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": this.SaveState(); this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}

	}
</script>