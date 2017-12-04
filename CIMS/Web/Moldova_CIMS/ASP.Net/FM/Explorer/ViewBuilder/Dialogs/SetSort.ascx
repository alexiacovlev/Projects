<%@ Control Language="C#"%>
<div class="fm-dlg-panel fm-dlg">
	<table style="width:100%;" cellspacing="0" cellpadding="5">
		<tr>
			<td>
				<label class="comment">Select the columns to sort on by default.</label>
			</td>
		</tr>
		<tr>
			<td class="main">
				<table class="fm-dlg-grid-hdr" cellspacing="0" cellpadding="5" style="width:100%;table-layout:fixed">
					<colgroup><col /><col width="180" /><col width="24"/></colgroup>
					<tr>
						<td class="clear">Column</td>
						<td>Order</td>
						<td></td>
					</tr>
				</table>
				<div class="fm-dlg-grid-panel" style="overflow-y:hidden;">
					<table id="tableSort" cellpadding="3" cellspacing="3" style="width:100%;table-layout:fixed;">
						<colgroup><col /><col width="175" /><col width="20"/></colgroup>
						<tbody></tbody>
					</table>
				</div>
				<a id="_add" class="fm" cmd="add" style="display:inline-block;margin-top:8px">Add Sorting Level</a>
			</td>
		</tr>
	</table>
</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.VB_SetSort= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		this.$tbody= $("#tableSort tbody", this.$p);
		$("#_add", this.p).addHandler('click', this.add_click, this);
		$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
	}
	RMC.VB_SetSort.prototype= {

		Show: function(viewBuilder) {
			this._window.show();
			this.$tbody.html("");

			this.xmlDoc= viewBuilder.xmlDoc;
			this.$xnrow= viewBuilder.$xnrow;
			this.$xnview= viewBuilder.$xnview;
			this.$xnfetch= viewBuilder.$xnfetch;
			this.$xnsort= this.$xnfetch.find("sort");
			
			this._index= 0;
			var sort_cells= this.$xnsort.children();
			for (var i= 0; i < sort_cells.length; i++) this.appendLevel(sort_cells[i], true);
		},

		appendLevel: function(xncolumn, exists) {
			var index= this._index++;
			var name= "";
			var asc= "checked";
			var desc= "";
			if (exists) {
				name= xncolumn.getAttribute("name"); ;
				if (xncolumn.getAttribute("ascending") != "true") { desc= "checked"; asc= ""; }
			}
			var options= "<option value=\"\"></option>";
			var selected= false;
			var cells= this.$xnrow.children();
			for (var i= 0; i < cells.length; i++) {
				xn= cells[i];
				var n= xn.getAttribute('name');
				options += "<option ";
				if (!selected && n == name) { selected= true; options += "selected " }
				options += "value=\"" + n + "\">" + xn.getAttribute('title') + "</option>";
			}
			if (!selected) options += "<option value=\"" + name + "\" selected>" + name + "</option>";

			var sb= "<tr>";
			sb += "<td><select class=\"fm\">" + options + "</select></td>";
			sb += "<td><label><input type='radio' class='fm-chk' name='sort" + index + "' " + asc + "/>Ascending</label><label style='margin-left:10px;'><input type='radio' class='fm-chk' name='sort" + index + "' " + desc + "/>Descending</label></td>";
			sb += "<td><img class='fm-ico' title='Delete' src='/ASP.Net/FM/Common/Images/Menu/16_delete2.png'></td>";
			sb += "</tr>";
			var $tr= $(sb);
			this.$tbody.append($tr);
			$tr.find("img").addHandler('click', this.delete_click, this);
			$tr[0].xncolumn= xncolumn;
		},

		add_click: function(e) {
			if (this._index >= 4) { AX.Window.alert("Confirmation", "You exceed max sorting count."); return; }
			var $xn= $(this.xmlDoc.createElement("column"));
			this.appendLevel($xn[0], false);
		},
		delete_click: function(e) {
			this._index -= 1;
			var tr= e.target.parentNode.parentNode;
			$(tr.xncolumn).remove();
			$(tr).remove();
		},

		SaveState: function() {
			var rows= this.$tbody.children();
			for (var i= 0; i < rows.length; i++) {
				var xncolumn= rows[i].xncolumn;
				var name= $("select", rows[i]).val();
				if (name == "") continue;
				var bAsc= $("input:first", rows[i]).is(":checked");
				if (xncolumn.getAttribute("name") == null) {// created on add_click without name
					if ($isNull(this.$xnsort)) {
						if ($isNull(this.$xnfetch)) {
							this.$xnfetch= $(this.xmlDoc.createElement("fetch"));
							this.$xnview.append(this.$xnfetch);
						}
						this.$xnsort= $(this.xmlDoc.createElement("sort"));
						this.$xnfetch.append(this.$xnsort);
					}
					this.$xnsort.append(xncolumn);
				}
				xncolumn.setAttribute("name", name);
				xncolumn.setAttribute("ascending", bAsc ? "true" : "false");
			}
			if (rows.length == 0 && !$isNull(this.$xnsort)) {
				this.$xnsort.remove();
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