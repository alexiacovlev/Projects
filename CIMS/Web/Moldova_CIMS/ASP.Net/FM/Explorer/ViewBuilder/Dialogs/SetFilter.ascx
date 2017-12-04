<%@ Control Language="C#"%>
<div class="fm-dlg-panel fm-dlg">
	<table style="width:100%;" cellspacing="0" cellpadding="4">
		<tr>
			<td>
				<label class="comment">Configure the filtering and search criteria used by this view.</label>
			</td>
		</tr>
		<tr>
			<td class="main">
				<table class="fm-dlg-grid-hdr" cellspacing="0" cellpadding="0">
					<colgroup><col width="203" /><col width="153"/><col /><col width="17" /></colgroup>
					<tr>
						<td class="clear">Field</td>
						<td>Condition</td>
						<td>Value</td>
						<td></td>
					</tr>
				</table>
				<div style="height:128px;" class="fm-dlg-grid-panel">
					<table id="panelCond" cellpadding="2" cellspacing="2" class="rmc-vb-condList" style="width: 100%; table-layout: fixed;">
						<colgroup><col width="200" /><col width="150"/><col /><col width="20" /></colgroup>
						<tbody></tbody>
					</table>
				</div>
				<a id="_addRow" class="fm" cmd="add" style="display:inline-block;margin-top:8px">Add Filter Row</a>
			</td>
		</tr>
	</table>
</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.VB_SetFilter= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		this.$panelCond= $("table#panelCond", this.$p);
		this.$tbody= $("tbody", this.$panelCond);
		
		$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
		$("a#_addRow", this.$p).addHandler('click', this.add_click, this);
	}

	RMC.VB_SetFilter.prototype= {

		Show: function(viewBuilder) {
			this._vb= viewBuilder;
			this.$tbody.html("");
			this.fieldListHtml= null;// reset field list;
			this._window.show();
			this.$xnfilter= $("filter:first", this._vb.$xnfetch);

			var xnl= this.$xnfilter.children();
			if (xnl.length > 0) {
				var xn;
				var cond_json= "";
				this.$panelCond.css('opacity', 0.1);
				for (var i= 0; i < xnl.length; i++) {
					if (i > 0) cond_json += ",";
					var xn= xnl[i];
					cond_json += "{" + jsonParam("name", xn.getAttribute('attribute')) + "," + jsonParam("op", xn.getAttribute('operator')) + "," + jsonParam("val", xn.getAttribute('value')) + "}";
					this.appendRow(xn);
				}
				//FM.ProgressBar("Loading ...", true);
				var data= "{" + jsonParam("tableName", this._vb.tableName) + ",\"conditions\":[" + cond_json + "]}";
				ExecuteService(data, RMC.Path + "ViewBuilder/SupportService.asmx/Filter_LoadExistedRowHtml", $.proxy(this.onLoadExistedRowHtml, this), _fm_onHandlerError);
			} else {
				this.appendRow(null);
			}
		},

		appendRow: function(xncond) {
			var $row= $("<tr><td></td><td></td><td></td><td><img class='fm-ico' title='Delete' src='/ASP.Net/FM/Common/Images/Menu/16_delete2.png'></td></tr>");
			this.$tbody.append($row);
			this.$currentRow= $row;
			$row[0].xncond= xncond;

			var mas= $row.children();
			$("IMG", mas[3]).addHandler('click', this.DELETE_click, this);

			var name= (xncond) ? xncond.getAttribute("attribute") : "";
			this.createFieldList($(mas[0]), name);
		},

		onLoadExistedRowHtml: function(result) {
			//FM.ProgressBar("Loading ...", false);
			var rows_data= result.d;
			var rows= this.$tbody.children();
			for (var i= 0; i < rows_data.length; i++) {
				var row= rows[i];
				this.initRowControls(row, rows_data[i].Data, rows_data[i].Value, rows_data[i].Error);
			}
			this.$panelCond.animate({'opacity':1}, 200);
		},

		initRowControls: function(row, cond_html, input_html, error) {
			var cells= row.cells;
			var $cond_cell= $(cells[1]);
			var $value_cell= $(cells[2]);
			if (error != null) { row.hasError= true; $value_cell.html(error); return; }
			row.hasError= false;
			var $cond_list= $(cond_html);
			// select by index or value
			var index= $cond_list.attr('index');
			if (index != "") $cond_list[0].selectedIndex= parseInt(index);
			else if ($cond_list.attr('data')) this.setListValue($cond_list, $cond_list.attr('data'));
			//
			$cond_cell.empty();
			$cond_cell.append($cond_list);
			$cond_list.change($createDelegate(this.COND_onchange, this));

			$value_cell.empty();
			$value_cell.html(input_html);

			$cond_list.change();
		},

		setListValue: function($l, v) {
			var index= -1;
			var opts= $l[0].options;
			for (var i= 0; i < opts.length; i++) {
				if (opts[i].value == v) { index= i; break; }
			}
			if (index == -1) {
				index= opts.length;
				$l.append("<option value='"+v+"' mode='4' selected='selected'>"+v+"</option>");
			}
			$l[0].selectedIndex= index;
		},

		createFieldList: function($cell, name) {
			var $f= $(this.getFieldListHtml());
			var i= 0;
			if (name != "") {
				i= this._fieldIndexes[name];
				if (!i) { $f.append("<option value=\"" + name + "\" type=\"Text\">" + name + "- not registerd field!</option>"); i= $f.children().length - 1; }
			}
			$f[0].selectedIndex= i;
			$cell.append($f);
			$f.addHandler('change', this.FIELDS_onchange, this);
		},
		getFieldListHtml: function() {
			if (this.fieldListHtml) return this.fieldListHtml;
			this._fieldIndexes= new Array();
			var fields= this._vb.getSortedFieldsNodes();
			var index= 0;
			var sb= "<select class='fm'>";
			sb+= "<option value=\"\"></option>";
			index++;

			var name, type;
			for (var i= 0; i < fields.length; i++) {
				xn= fields[i]; type= xn.getAttribute('type');
				if (type == "EditableGrid" || type == "Checkboxlist" || type == "Image" || xn.getAttribute("uimask").charAt(2) == '0') continue;
				name= xn.getAttribute('name');
				title= xn.getAttribute('title');
				sb += "<option value=\"" + name + "\" type=\"" + type + "\">" + title + "</option>";
				this._fieldIndexes[name]= index++;
			}
			sb+= "</select>";
			this.fieldListHtml= sb;
			return sb;
		},


		FIELDS_onchange: function(e) {
			var row= e.target.parentNode.parentNode;
			var name= $(e.target).val();
			if (name != "") {
				this._currentRow= row;
				var data= "{" + jsonParam("tableName", this._vb.tableName) + "," + jsonParam("fieldName", name) + "}";
				ExecuteService(data, RMC.Path + "ViewBuilder/SupportService.asmx/Filter_LoadFieldRowHtml", $.proxy(this.onLoadFieldRowHtml, this), _fm_onHandlerError);
			} else {
				$(row.cells[1]).empty();
				$(row.cells[2]).empty();
			}
		},
		onLoadFieldRowHtml: function(result) {
			var row_data= result.d;
			var row= this._currentRow; this._currentRow= null;
			this.initRowControls(row, row_data.Data, row_data.Value, row_data.Error);
		},

		COND_onchange: function(e) {
			var index= e.target.selectedIndex;
			var mode= e.target.options[index].getAttribute('mode');
			var value_cell= e.target.parentNode.nextSibling;
			$(value_cell).css('visibility', mode == '4' ? 'hidden' : 'visible');
		},

		add_click: function(e) {
			this.appendRow(null);

			var $panel= $("#panelCond");
			var h= $panel.height();
			$panel.parent().animate({ scrollTop: h }, 500);
		},
		DELETE_click: function(e) {
			var tr= e.target.parentNode.parentNode;
			if (!tr.xncond) $(tr).remove();
			else tr.style.display= 'none';
		},

		SaveState: function() {
			var rows= this.$tbody.children();
			if ($isNull(this.$xnfilter) && rows.length > 0) {
				this.$xnfilter= $(this._vb.xmlDoc.createElement("filter"));
				this._vb.$xnfetch.append(this.$xnfilter);
			}
			for (var i= 0; i < rows.length; i++) {
				var xncond= rows[i].xncond;
				var name= $(rows[i].cells[0].firstChild).val();
				if (rows[i].style.display == 'none' || name == "") {
					if (xncond) $(xncond).remove();
				} else {
					if (rows[i].hasError) continue;
					if (!xncond) {
						xncond= this._vb.xmlDoc.createElement("condition");
						this.$xnfilter.append(xncond);
						rows[i].xncond= xncond;
					}

					var condBox= rows[i].cells[1].firstChild;
					var op= "";
					var mode= "0";
					if (condBox.selectedIndex != -1) {
						var option= condBox.options[condBox.selectedIndex];
						op= option.getAttribute("value");
						mode= option.getAttribute("mode");
					}
					var val= "";
					if (mode != "4") {
						var inputBox= rows[i].cells[2].firstChild;
						val= inputBox.value.trim();

						if (val != "") { // for 'Text' field
							if (mode == "1") val= val + "%";
							else if (mode == "2") val= "%" + val;
							else if (mode == "3") val= "%" + val + "%";
						}
					}

					xncond.setAttribute('attribute', name);
					xncond.setAttribute('operator', op);
					xncond.setAttribute('value', val);
				}
			}
			if (!$isNull(this.$xnfilter) && (this.$xnfilter.children().length == 0)) this.$xnfilter.remove();
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": this.SaveState(); this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}

	}

</script>