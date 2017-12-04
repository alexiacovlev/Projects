<%@ Control Language="C#"%>
<div class="fm-dlg-panel fm-dlg">
	<table style="width:100%;" cellspacing="0" cellpadding="4">
		<tr>
			<td>
				<label class="comment">Select the columns to add to this view.</label>
			</td>
		</tr>
		<tr>
			<td class="main">
				<table class="fm-dlg-grid-hdr" cellspacing="0" cellpadding="0">
					<colgroup><col width="22" /><col /><col width="124" /><col width="86"/><col width="17"/></colgroup>
					<tr>
						<td class="clear"><input id="chkAll" type="checkbox" class="fm-chk" /></td>
						<td>Title</td>
						<td>Field Name</td>
						<td>Type</td>
						<td></td>
					</tr>
				</table>
				<div style="height:322px;" class="fm-dlg-grid-panel">
					<table id="panelFields" cellpadding="0" cellspacing="0" class="fm-dlg-grid rmc-vb-fieldList">
						<colgroup><col width="22" /><col /><col width="124" /><col width="85"/></colgroup>
						<tbody></tbody>
					</table>
				</div>
			</td>
		</tr>
	</table>
</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.VB_AddColumns= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.$panelFields= $("#panelFields tbody", this.$p);
		$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
		this.$panelFields.addHandler('click', this.list_click, this);

		this.$chkAll= $("#chkAll", this.$p);
		this.$chkAll.addHandler('click', this.chkAll_click, this);
	}
	RMC.VB_AddColumns.prototype= {

		ShowList: function(viewBuilder) {
			this.$panelFields.html("");
			this.$chkAll.attr('checked', false);
			this._window.show();
			var fields= viewBuilder.getSortedFieldsNodes();

			var cells= viewBuilder.$xnrow.children();
			var existed= new Array();
			for (var i= 0; i < cells.length; i++) existed[cells[i].getAttribute('name')]= true;
			var sb= "";
			var title, name, type, xn;
			for (var i= 0; i < fields.length; i++) {
				xn= fields[i];
				type= xn.getAttribute('type');
				if (type == "EditableGrid" || type == "Checkboxlist") continue;
				if (!viewBuilder.IsEGRID) {
					if (type == "Image" || xn.getAttribute("uimask").charAt(2) == '0') continue;// valid for views
				} else {
					if (xn.getAttribute("uimask").charAt(3) == '0') continue;// valid for forms
				}

				name= xn.getAttribute('name');
				if (existed[name]) continue;
				title= xn.getAttribute('title');
				this.$panelFields.append("<tr><td><input type='checkbox' class='fm-chk'/></td><td>" + title + "</td><td>" + name + "</td><td>" + type + "</td></tr>");
			}

		},

		chkAll_click: function() {
			var b= this.$chkAll.is(":checked");
			$("input", this.$panelFields).each(function() { $(this).attr('checked', b); });
		},

		getChecked: function() {
			var list= [];
			$("input", this.$panelFields).each(function(i) {
				if ($(this).is(':checked')) {
					var td= this.parentNode;
					var td0= td.nextSibling;
					var td1= td0.nextSibling;
					var title= $(td0).text();
					var name= $(td1).text();
					list.push([name, title]);
				}
			});
			return list;
		},

		list_click: function(e) {
			var o= e.target;
			if (o.tagName == 'INPUT') o= o.parentNode;
			if (o.tagName == 'TD') o= o.parentNode;
			if (o.tagName == 'TR') {
				var $tr= $(o);
				var $i= $('input', $tr);
				var checked= $i.is(':checked');
				if (e.target.tagName != "INPUT") {
					checked= !checked;
					$i.attr('checked', checked);
				}
				$tr.css('background-color', checked ? '#8cdaff' : '');
			}
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": this._window.returnValue= this.getChecked(); this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}

	}
</script>