<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;top:0;">
	<div class="tab" style="display:block">
		
		<fieldset id="panelHierarchy">
			<legend>Self-Referencing Hierarchy</legend>
			<div class="desc">
				This mode is applicable only if the table has self-hierarchy model and <br />require ParentID field.
				<br />Allows render records in the hierarchy view mode.<br />
				To apply hierarchy view, just choose parent field name from the registered field list.
			</div>
			<table cellpadding="5" cellspacing="5" style="table-layout:fixed;">
			<colgroup><col width="150"/><col width="180" /></colgroup>
			<tr>
				<td>Hierarchy Parent Field:</td>
				<td><dialogs:FieldLookupControl id="tb_parentFieldName" runat="server" DialogType="FIELD/HIERARCHY" /></td>
			</tr>
		</table>
		</fieldset>

	</div>
</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.VB_Hierarchy= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}
	RMC.VB_Hierarchy.prototype = {
		
		initialize: function() {
			var $p= this.$p;
		
			this.tb_parentFieldName= new FM.LookupTextControl($("#tb_parentFieldName", this.$p));
			
			$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
		},

		LoadState: function(designer) {
			this._window.show();
			this.designer= designer;
			var $xnview= this.designer.$xnview;

			this.tb_parentFieldName.parentValue= this.designer.tableName;
			this.tb_parentFieldName.setValue($xnview.find('parentFieldName').text());
		},

		SaveState: function() {
			var $xnview= this.designer.$xnview;
			var xd= this.designer.xmlDoc;

			var h_pn= this.tb_parentFieldName.getValue();
			var $xn_parentFieldName= $xnview.find('parentFieldName');
			if (h_pn != "") {
				if ($isNull($xn_parentFieldName)) $xn_parentFieldName= xml_appendNode(xd, $xnview, "parentFieldName");
				$xn_parentFieldName.text(h_pn);
			} else if (!$isNull($xn_parentFieldName)) {
				$xn_parentFieldName.remove();
			}

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