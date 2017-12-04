<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg fm-dlg-tabs" style="top:0;bottom:30px;padding:5px 5px">
	
	<fieldset class="fm" style="padding:10px;">
		<legend>Folder attributes</legend>
		<table style="width:90%;table-layout:fixed">
			<colgroup><col width="120" /><col /></colgroup>
			<tr>
				<td colspan="2" id="pnlGridOnly">
					<label class="fm-chk" style="display:block;margin:5px;"><input id="cbAllowAutoCount" class="fm-chk" type="checkbox"/>Show record's count</label>
					<label class="fm-chk" style="display:block;margin:5px 0 5px 20px;"><input disabled="disabled" id="cbAllowAutoCount2" class="fm-chk" type="checkbox">track changes</label>
					<label class="fm-chk" style="display:block;margin:5px 0 5px 20px;"><input id="cbAllowPlaySound" class="fm-chk" type="checkbox">notify with sound</label>
				</td>
			</tr>
			<tr><td colspan="2" style="padding-top:10px;"><div class="desc">If the profile is showed for child record, you can define availability for the folder content.</div></td></tr>
			<tr>
				<td colspan="2">
					<label class="fm-chk"><input id="cbIsDependOnParentKey" class="fm-chk" type="checkbox"/>Folder is available only if record exists</label>
				</td>
			</tr>
		</table>
	</fieldset>

	<fieldset class="fm" style="padding:10px;margin-top:20px;">
		<legend>Dynamic sub-tree</legend>

		<a id="btnSubTree" class="fm" style="display:block;margin:5px;">add</a>

		<table id="pnlSubTree" style="width:90%;table-layout:fixed;display:none">
			<colgroup><col width="120" /><col /></colgroup>
			
			<tr><td colspan="2"><div class="desc">Specify the lookup evidence for dynamic folders</div></td></tr>
			<tr><td style="padding-left:20px">Lookup Table:</td><td><dialogs:TableLookupControl id="tbTableName" runat="server" /></td></tr>
			<tr><td style="padding-left:20px">View:</td><td><dialogs:ViewLookupControl id="tbViewName" runat="server" /></td></tr>
		
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td colspan="2"><div class="desc">If the pfofile tree is rendered for specified record,<br />you can add filter by the field.</div></td></tr>
			<tr><td style="padding-left:20px">Filter Field Name:</td><td><dialogs:FieldLookupControl id="tbField" runat="server" /></td></tr>

			<tr><td colspan="2">&nbsp;</td></tr>
			<tr><td colspan="2"><div class="desc">You can specify render or not the current folder <br />(root for the sub-folders)</div></td></tr>
			<tr><td style="padding-left:20px" colspan="2"><label class="fm-chk"><input id="cbRoot" class="fm-chk" type="checkbox" />Render root folder</label></td></tr>
		</table>
	</fieldset>

</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.ProfileFolderProperties= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}
	RMC.ProfileFolderProperties.prototype = {
		
		initialize: function() {
			this.tbTableName= new FM.LookupTextControl($("#tbTableName", this.$p));
			this.tbViewName= new FM.LookupTextControl($("#tbViewName", this.$p), this.tbTableName);

			this.tbField= new FM.LookupTextControl($("#tbField", this.$p), this.tbTableName);

			this.$pnlGridOnly= $("#pnlGridOnly", this.$p);

			this.$cbAllowAutoCount= $("#cbAllowAutoCount", this.$p);
			this.$cbAllowAutoCount2= $("#cbAllowAutoCount2", this.$p);
			this.$cbAllowPlaySound= $("#cbAllowPlaySound", this.$p);
			this.$cbIsDependOnParentKey= $("#cbIsDependOnParentKey", this.$p);

			this.$cbRoot= $("#cbRoot", this.$p);
			this.$btnSubTree= $("#btnSubTree", this.$p);
			this.$btnSubTree.addHandler('click', function(){this.hasSubTree= true;this.togglePanels();}, this);
			this.$pnlSubTree= $("#pnlSubTree", this.$p);
			
			$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
		},

		LoadState: function(designer) {
			this.designer= designer;
			var d= this.designer.nodeData.split(',');
			this.IsGrid= (this.designer.mapNode != null && this.designer.mapNode.attr('type') == "GRID")
			this.$pnlGridOnly.toggle(this.IsGrid);

			// attributes
			this.$cbAllowAutoCount.prop("checked", (d[0] == '' || d[0] == 'true'));
			this.$cbAllowAutoCount2.prop("checked", (d[0] == '' || d[0] == 'true'));
			this.$cbAllowPlaySound.prop("checked", d[1] == 'true');
			this.$cbIsDependOnParentKey.prop("checked", d[2] == 'true');


			// sub-tree
			this.hasSubTree= (d[3] != "");
			var info= (this.hasSubTree) ? d[3].split('/') : ["", "", "", ""];
			this.tbTableName.setValue(info[0]);
			this.tbViewName.setValue(info[1]);
			this.tbField.setValue(info[2]);
			this.$cbRoot.prop('checked', info[3]=='true');

			this.togglePanels();
			this._window.show();
		},
		togglePanels: function() {
			this.$pnlSubTree.toggle(this.hasSubTree);
			this.$btnSubTree.toggle(!this.hasSubTree);
			this._window.setSize(400, (this.hasSubTree?430:250) + (this.IsGrid?60:0));
			this._window.setCenter();
		},

		SaveState: function() {
			
			var d= this.designer.nodeData.split(',');
			//d[0]= this.$cbAllowAutoCount.is(":checked")?'':'false';
			//if (this.$cbAllowAutoCount.is(":checked") && this.$cbAllowAutoCount2.is(":checked")) d[0]= 'true';
			d[0]= this.$cbAllowAutoCount.is(":checked")?'true':'false'
			d[1]= this.$cbAllowPlaySound.is(":checked")?'true':'false';
			d[2]= this.$cbIsDependOnParentKey.is(":checked")?'true':'false';
			
			var tableName= this.tbTableName.getValue();
			if (tableName != "") {
				d[3]= tableName+'/'+this.tbViewName.getValue() + '/' + this.tbField.getValue() + '/' + this.$cbRoot.prop('checked');
				this.designer.setNodeData(d.join(','));
			} else {
				d[3]= "";
			}

			this.designer.setNodeData(d.join(','));
			this.designer.$cbAllowAutoCount.attr("checked", d[0] != 'false');
			return true;
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": if (this.SaveState()) this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}
	}
</script>