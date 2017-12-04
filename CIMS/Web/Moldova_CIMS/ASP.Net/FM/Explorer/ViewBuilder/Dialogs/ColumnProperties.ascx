<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-panel fm-dlg">
	<table width="100%" style="TABLE-LAYOUT:fixed" cellpadding="4" cellspacing="4">
		<colgroup><col width="100" /><col /></colgroup>
		<tr style="height:24px;">
			<td></td>
			<!--td><label class="comment">You can change the title and layout for the column.</label></td-->
		</tr>
		<tr style="height:24px;">
			<td class="n">Title:</td>
			<td><dialogs:AdminResTitleControl ID="tbTitle" runat="server" /></td>
		</tr>
		<tr style="height:24px;">
			<td>Schema Name</td>
			<td><label id="schemaName" style="font-weight:bold"></label>
				&nbsp;&nbsp;(&nbsp;<label id="fieldType"></label>&nbsp;)
			</td>
		</tr>
		<tr style="height:24px;">
			<td>Alignment</td>
			<td>
				<div id="dataAlign" style="display:inline-block">
					<label><input type="radio" class="fm-chk" name="dataAlign" value="left"/>left</label>
					<label style="margin-left:10px"><input type="radio" class="fm-chk" name="dataAlign" value="center"/>center</label>
					<label style="margin-left:10px"><input type="radio" class="fm-chk" name="dataAlign" value="right"/>right</label>
				</div>
				<div style="display:inline-block;margin-left:40px;">
					<input id="cbNoWrap" type="checkbox" class="fm-chk" /><i>Prevent Text Wrapping</i>
				</div>
			</td>
		</tr>				
		<tr id="trFormat" style="DISPLAY:none;height:24px;">
			<td>Display Format:</td>
			<td id="Format" width="100"></td>
		</tr>
				
		<tr id="trLookupIcon" style="display:none;height:24px;">
			<td>Lookup Icon:</td>
			<td><input id="chShowIcon" type="checkbox" class="fm-chk" /><i> - show lookup icon near the cell text</i></td>
		</tr>
		<tr id="trCustomIcon1" style="display:none;">
			<td style="padding-bottom:0">Render Icon:</td>
			<td style="padding-bottom:0"><input id="chIcon" type="checkbox" class="fm-chk" /><i> - render cell as specified icon based on the cell value</i></td>
		</tr>
		<tr id="trCustomIcon2" style="display:none;">
			<td style="padding-bottom:0" align="right">Image Type:</td>
			<td style="padding-bottom:0"><div style="width:180px"><dialogs:ImageTypeControl id="tb_imagetype" runat="server" /></div></td>
		</tr>
		
		<tr id="trHandler" style="DISPLAY:none;height:24px;">
			<td>Lookup Link:</td>
			<td><input id="chAllowHandler" type="checkbox" class="fm-chk" /><i> - allow quick open (based on lookup handlers)</i></td>
		</tr>

		<tr style="height:24px;">
			<td>Filter</td>
			<td><input id="chAllowFilter" type="checkbox" class="fm-chk" /><i> - allow filtering by the data from this column</i></td>
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
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.VB_ColumnProperties = function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		this.$tbTitle= $("#tbTitle", this.$p);
		this.resTitle= new FM.ResTitle(this.$tbTitle);
		this.$schemaName= $("#schemaName", this.$p);
		this.$fieldType= $("#fieldType", this.$p);
		this.dataAlign= new FM.RadioGroup($("#dataAlign", this.$p));
		this.cbNoWrap= $("#cbNoWrap", this.$p);
		
		var sType= "";
		var showLookupIconPanel= false;
		var showCustomIconPanel= false;

		$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
		$("#rdCustom", this.$p).addHandler('mousedown', this.custom_click, this);
		this.$tbCustom= $("#tbCustom", this.$p);
		this.$tbCustom.addHandler('click', this.custom_click, this);


		this.trLookupIcon= $("#trLookupIcon", this.$p);
		this.trHandler= $("#trHandler", this.$p);
		this.chShowIcon= $("#chShowIcon", this.$p);
		this.chAllowHandler= $("#chAllowHandler", this.$p);

		this.trCustomIcon2= $("#trCustomIcon2", this.$p);
		this.chIcon= $("#chIcon", this.$p);
		this.chIcon.addHandler('change', function() { this.trCustomIcon2.toggle(this.chIcon.is(':checked')); }, this);
		this.tb_imagetype= new FM.LookupTextControl($("#tb_imagetype", this.$p));

		this.chAllowFilter= $("#chAllowFilter", this.$p);
		
	}
	RMC.VB_ColumnProperties.prototype = {

		LoadState: function(xn, settings) {
			this.xn= xn;
			this.resTitle.setValue(xn.getAttribute('title')); this.resTitle.setResValue(xn.getAttribute('restitle'));

			this._window.show();
			this.$tbTitle.focus();

			this.$schemaName.text(xn.getAttribute('name'));
			var fieldType = settings.getAttribute("type");
			this.$fieldType.text(fieldType);
			this.dataAlign.setValue(xn.getAttribute('align'), 'left');
			this.cbNoWrap.prop('checked', xn.getAttribute('nowrap'));

			//Lookup Icon and Handler
			this.showLookupPanel= (fieldType == "Lookup");
			this.trLookupIcon.toggle(this.showLookupPanel);
			this.trHandler.toggle(this.showLookupPanel);
			var showLookupIcon= this.showLookupPanel ? (xn.getAttribute('showicon') == 'true') : false;
			var allowHandler= this.showLookupPanel ? (xn.getAttribute('handler') == 'true') : false;
			this.chShowIcon.prop('checked', showLookupIcon);
			this.chAllowHandler.prop('checked', allowHandler);

			// Picklist icon and image type
			this.showIconPanel= (fieldType == "Picklist" || fieldType == "Integer" || fieldType == "Boolean");
			$("#trCustomIcon1", this.$p).toggle(this.showIconPanel);
			var imagetype= this.showIconPanel ? (xn.getAttribute('imagetype')||'') : '';
			
			this.chIcon.attr('checked', imagetype != '');
			this.trCustomIcon2.toggle(imagetype != '');
			this.tb_imagetype.setValue(imagetype);

			//
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

			var align = xn.getAttribute('align');
			if (align == null) align = this.getDefaultAlign(fieldType);
			$("#Align_" + align, this.$p).attr('checked', true);

			this.chAllowFilter.prop('checked', xn.getAttribute('filter')=='true');
		},

		getDefaultAlign: function(type) {
			if (type == "Integer" || type == "Float" || type == "Money") return "right";
			return "left";
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
			xml_updateAttribute(xn, 'restitle', this.resTitle.getResValue());

			if ($("#tblWidth", this.$p).css('display') != 'none') {
				var width= this.getSelectedWidth();
				if (width != xn.getAttribute('width')) this._window.returnValue= 'width';
				xml_updateAttribute(xn, 'width', width);
			}

			var align= this.dataAlign.getValue('left');	// if value=='left' reset it to <empty>
			xml_updateAttribute(xn, 'align', align);		// and remove attribute for <empty> value
			
			if (this.showIconPanel) {
				xml_updateAttribute(xn, 'imagetype', (this.chIcon.is(':checked') ? this.tb_imagetype.getValue() : ''));
			}

			if (this.showLookupPanel) {
				xml_updateAttribute(xn, 'showicon', this.chShowIcon.is(':checked')?'true':'');
				xml_updateAttribute(xn, 'handler', this.chAllowHandler.is(':checked')?'true':'');
			}

			xml_updateAttribute(xn, 'nowrap', this.cbNoWrap.is(':checked')?'true':'');
			xml_updateAttribute(xn, 'filter', this.chAllowFilter.is(':checked')?'true':'');
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": this.SaveState(); this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}

	}
</script>