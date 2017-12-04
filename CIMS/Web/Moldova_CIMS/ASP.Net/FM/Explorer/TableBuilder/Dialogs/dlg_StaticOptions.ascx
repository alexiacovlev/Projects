<%@ Control Language="C#" %>
<div class="fm-dlg-panel fm-dlg">
	<div style="margin:5px;"><label class="comment">Items will appear in the same order as they appear in the list below.</label></div>
	<table style="width:100%">
		<tr>
			<td>
				<table class="fm-dlg-grid-hdr" cellspacing="0" cellpadding="0" style="border-color:#7b9ebd">
					<colgroup><col width="60" /><col /></colgroup>
					<tr>
						<td class="clear">Value</td><td>Text</td>
					</tr>
				</table>
				<div id="panelContainer" style="height:280px;border-color:#7b9ebd;" class="fm-dlg-grid-panel">
					<table cellpadding="0" cellspacing="0" class="fm-dlg-grid">
						<colgroup><col width="5" /><col width="54" /><col /></colgroup>
						<tbody id="panelList"></tbody>
					</table>
				</div>
			</td>
			<td style="vertical-align:top;padding-left:5px;width:65px;">
				<a class="fm-btn" cmd="up" style="display:block;">Up</a>
				<a class="fm-btn" cmd="down" style="display:block;margin-top:4px;">Down</a>
				<a class="fm-btn" cmd="add" style="display:block;margin-top:14px;">Add</a>
				<a class="fm-btn" cmd="delete" style="display:block;margin-top:4px;">Delete</a>

			</td>
		</tr>
	</table>
	<div style="color:gray;margin:5px;">Note: The changes are applied for all form instances.</div>
</div>
<div class="fm-dlg-buttons" style="position: absolute; bottom: 5px; right: 5px;">
	<%= AX.FM.Common.UI.Button.Render("save", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.StaticOptionsEditor= function (wnd, tableName, name) {
		this._window= wnd;
		this.$p= wnd.$content;
		this.$panelList= $("tbody#panelList", this.$p);

		this.btn_click= function(e) {
			switch (_fm_getCommand(e)) {
				case "save":
					var list= [];
					var rows= this.$panelList.children();
					for (var i= 0; i < rows.length; i++) {
						var row= rows[i];
						var val= row.cells[1].firstChild.value.trim();
						var text= row.cells[2].firstChild.value.trim();
						if (!val && !text) continue;
						if (!val || !text) {AX.Window.alert("Please, fill the value for the row.");return;}
						list.push({Value:val, DefaultTitle:text, ResourceKey: null});
					}
					// Save options
					var o= { tableName:tableName, name:name, options:list};
					ExecuteService(JSON.stringify(o), RMC.Path + "TableBuilder/SupportService.asmx/SaveStaticOptions", $createDelegate(this.onSave, this));
					break;
				case "X": 
					this._window.close(); 
					break;

				case "add":
					this.addRow("", "", true);
					break;
				case "delete":
					if (!this.selected) return;
					var row= this.selected;
					$(row).remove();
					this.selected= null;
					var rows= this.$panelList.children();
					if (rows.length > 0) this.panel_click({ target:rows[rows.length-1] });
					break;
				case "up":
					if (!this.selected) return;
					var row= this.selected;
					var row0= this.selected.previousSibling;
					if (!row0) return;
					$(this.selected).insertBefore($(row0));
					break;
				case "down":
					if (!this.selected) return;
					var row= this.selected;
					var row1= this.selected.nextSibling;
					if (!row1) return;
					$(row1).insertBefore($(this.selected));
					break;
			}
		}

		this.panel_click= function(e) {
			var o= e.target;
			if (o.tagName == 'INPUT') o= o.parentNode;
			if (o.tagName == 'TD') o= o.parentNode;
			if (o.tagName == 'TR') { 
				if (this.selected) this.selected.className= '';
				this.selected= o;
				this.selected.className= 'sel';
			}
		}

		this.addRow= function(v, t, scroll) {
			if (scroll) v= this.getNextValue();
			var $row= $("<tr><td></td><td><input class='fm' value='"+v+"'/></td><td><input class='fm' value='"+t+"'/></td></tr>");
			this.$panelList.append($row);
			if (scroll) {
				this.panel_click({ target:$row[0] });
				FM.DialogUtils.scrollBottom($("div#panelContainer", this.$p));
			}
		}

		this.onLoad= function(result) {
			var options= result.d;
			var o;
			for (var i= 0; i < options.length; i++) {
				o= options[i];
				this.addRow(o.Value, o.DefaultTitle, false);
			}
		}

		this.onSave= function(result) {
			this._window.close();
		}

		this.getNextValue= function() {
			var rows= this.$panelList.children();
			var max= 0;
			
			for (var i= 0; i < rows.length; i++) {
				var row= rows[i];
				var val= row.cells[1].firstChild.value.trim();
				if (!val || isNaN(val)) continue;
				var n= parseInt(val, 10);
				if (n > max) max= n;
			}
			return max+1;
		}

		$('a', this.$p).addHandler('click', this.btn_click, this);
		this.$panelList.addHandler('mousedown', this.panel_click, this);

		// Load options
		var data= "{\"tableName\":\"" + tableName + "\",\"name\":\"" + name + "\"}";
		ExecuteService(data, RMC.Path + "TableBuilder/SupportService.asmx/LoadStaticOptions", $createDelegate(this.onLoad, this));
	}
</script>
