<%@ Control Language="C#" %>
<div class="fm-dlg-panel fm-dlg">
	<table style="width:100%;table-layout:fixed;" cellpadding="0" cellspacing="10">
		<colgroup><col /><col width="200" /></colgroup>
		<tr style="height:35px">
			<td>
				<b>Sql Relation Table:</b> Specify the name of the SQL table for 'many-to-many' relationship between the parent table and the child table.
			</td>
			<td>
				<input id="tbTableName" class="fm" />
			</td>
		</tr>
		<tr style="height:35px">
			<td>
				<b>Parent Key Name:</b> Specify the field which links to the parent table.
			</td>
			<td>
				<input id="tbParentKey" class="fm" />
			</td>
		</tr>
		<tr style="height:35px">
			<td>
				<b>Child Key Name:</b> Specify the field which links to the lookup table.
			</td>
			<td>
				<input id="tbChildKey" class="fm" />
			</td>
		</tr>
		<tr style="height:35px">
			<td>
				<b>Type Field Name:</b> (For multi-typed dialog) You can specify the field to store the type of the record from diffrent sources.
			</td>
			<td>
				<input id="tbTypeKey" class="fm" />
			</td>
		</tr>

		<tr>
			<td colspan="2" id="listOthers"></td>
		</tr>

	</table>

</div>
<div class="fm-dlg-buttons" style="position: absolute; bottom: 5px; right: 5px;">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.LookupRelationEditor= function(wnd, designer, $xn, name, lookup, onclose) {
		this._window= wnd;
		this.fieldName= name;
		this.lookupTable= lookup;
		this.designer= designer;
		this.$p= wnd.$content;
		this.$xn= $xn;
		
		this.btn_click= function(e) {
			switch (_fm_getCommand(e)) {
				case "OK":
					this.saveState();
					break;
				case "X": 
					this._window.close(); 
					break;

			}
		}

		this.onSave= function(result) {
			this._window.close();
		}

		this.loadState= function() {
			var $xn_relation= this.$xn.find("relation");
			var t= this.rel_table= $xn_relation.attr('table');
			
			$("input#tbTableName", this.$p).val(t);
			
			var $listOthers= $("#listOthers", this.$p);
			$listOthers.empty();
		
			var columns= $xn_relation.children();
			for (var i= 0; i < columns.length; i++) {
				var xc= columns[i];
				var name= xc.getAttribute('name');
				var type= xc.getAttribute('type');
				var value= xc.getAttribute('value');
			
				if (type == 'parentkey') $("input#tbParentKey", this.$p).val(name);
				else if (type == 'childkey') $("input#tbChildKey", this.$p).val(name);
				else if (type == 'typekey') $("input#tbTypeKey", this.$p).val(name);
				else $listOthers.append('<div><input class="fm" style="width:150px;margin-left:5px;" value="'+name+'"/><input class="fm" style="width:100px;margin-left:5px;" value="'+value+'"/></div>');
			}

			this.needCreateTable= (!t);
			if (this.needCreateTable && this.fieldName) {
				$("input#tbTableName", this.$p).val(this.designer.tableName + "__" + this.fieldName);
				$("input#tbParentKey", this.$p).val("ParentID");
				$("input#tbChildKey", this.$p).val("ObjectID");

				this.notifyControl($("input#tbTableName", this.$p), null, "The settings are generated automatically.");
			}
			
		}

		this.notifyControl= function($o, title, msg) {
			FM.Validators.notify($o, title, msg, -80, 8);
		}

		this.getNameAndValidate= function($o, title) {
			var s= $o.val();
			if (!s) { this.notifyControl($o, title, null); return ""; }
			return s;
		}

		this.saveState= function() {
			var tableName= this.getNameAndValidate($("input#tbTableName", this.$p), "Sql Table Name");if (!tableName) return;
			var parentKey= this.getNameAndValidate($("input#tbParentKey", this.$p), "Parent Key Name");if (!parentKey) return;
			var childKey= this.getNameAndValidate($("input#tbChildKey", this.$p), "Child Key Name");if (!childKey) return;
			var typeKey= $("input#tbTypeKey", this.$p).val().trim();

			var $xn_relation= xml_getOrCreate(this.designer.xmlDoc, this.$xn, "relation");
			$xn_relation.attr("table", tableName);

			var columns= $xn_relation.children();

			this.saveColumn($xn_relation, columns, parentKey, "parentkey", "");
			this.saveColumn($xn_relation, columns, childKey, "childkey", "");
			this.saveColumn($xn_relation, columns, typeKey, "typekey", "");

			var others= $("#listOthers", this.$p).children();
			for (var i= 0; i < others.length; i++) {
				var input_name= others[i].firstChild;
				var input_value= input_name.nextSibling;
				this.saveColumn($xn_relation, columns, input_name.value.trim(), "", input_value.value.trim());
			}
			
			
			if (this.needCreateTable || this.rel_table != tableName) {
				this.$xn_relation= $xn_relation;
				this.onclose= onclose;

				var xml= xml_convertToString($xn_relation[0]);
				FM.ProgressBar.Show('Creating relation table', true);
				ExecuteService("{\"tableName\":\""+this.designer.tableName+"\",\"lookupTable\":\""+this.lookupTable+"\",\"xmlData\":\"" + jsonEncode(xml) + "\"}", RMC.Path + "TableBuilder/SupportService.asmx/CreateRelation", $createDelegate(this.onAutoCreate, this));
			} else {
				this._window.close(); 
				onclose($xn_relation);
			}
		}

		this.onAutoCreate= function(result) {
			FM.ProgressBar.Hide();
			if (result.d) { AX.Window.alert(result.d); return; }

			AX.Window.alert("The related table '"+$("input#tbTableName", this.$p).val()+"' has been added to the database");
			this.needCreateTable= false;
			this._window.close();
			this.onclose(this.$xn_relation);
		}

		this.saveColumn= function($xn_relation, columns, name, type, value) {
			var xnc= null;
			for (var i= 0; i < columns.length; i++) {
				var xn= columns[i];
				if (type != '' && xn.getAttribute('type') == type) { xnc= xn; break; }
				if (name != '' && xn.getAttribute('name') == name) { xnc= xn; break; }
			}
			var $xnc;
			if (xnc == null) {
				if (name == '') return;
				$xnc= xml_appendNode(this.designer.xmlDoc, $xn_relation, "column");
			} else {
				$xnc= $(xnc);
			}
			if (name == '') { $xnc.remove(); return; } // remove base column if name is empty
			if (type == '' && value == '') { $xnc.remove(); return; } // remove extra column if value is empty
			
			if (name != '') $xnc.attr('name', name);
			if (type != '') $xnc.attr('type', type);
			if (value != '') $xnc.attr('value', value);
		}


		$('a', this.$p).addHandler('click', this.btn_click, this);

		this.loadState();

	}
</script>
