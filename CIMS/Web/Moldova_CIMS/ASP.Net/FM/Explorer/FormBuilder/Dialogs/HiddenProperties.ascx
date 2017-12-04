<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;top:0;">
	<div class="tab" style="display:block">
		
		<fieldset style="margin-top:12px;padding:12px">
			<legend>Value Binding</legend>
			<div class="comment">Specify the value that will be applied for this field on creating<br />new record and on record update. You can assign dynamic run-time variable value or type the constant value for the field.</div>
			<table style="width:90%;margin-top:5px;" cellpadding="3" cellspacing="3">
				<colgroup><col width="140" /><col /></colgroup>
				<tr>
					<td class="n">OnCreateValue:</td><td style="padding-right:0"><dialogs:AdminPickTextControl id="tbOnCreateValue" runat="server" DialogType="VARIABLES" /></td>
				</tr>
				<tr>
					<td class="n">OnUpdateValue:</td><td style="padding-right:0"><dialogs:AdminPickTextControl id="tbOnUpdateValue" runat="server" DialogType="VARIABLES" /></td>
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
	RMC.FB_HiddenProperties= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}
	RMC.FB_HiddenProperties.prototype = {
		
		initialize: function() {
			var $p= this.$p;
			
			this.tbOnCreateValue= new FM.LookupTextControl($("#tbOnCreateValue", $p));
			this.tbOnUpdateValue= new FM.LookupTextControl($("#tbOnUpdateValue", $p));


			$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
			
		},

		LoadState: function(designer, $xn, $xn_s) {
			this._window.show();
			this.$xn= $xn;
			this.designer= designer;

			this._window.show();

			var $p= this.$p;
			var name= $xn_s.attr('name');
			var type= $xn_s.attr('type');
			var $xn_prop= this.$xn.children('properties:first');
			
			// Value Binding
			this.tbOnCreateValue.setValue($xn_prop.attr('oncreatevalue')||'');this.tbOnCreateValue.parentValue= type;
			this.tbOnUpdateValue.setValue($xn_prop.attr('onupdatevalue')||'');this.tbOnUpdateValue.parentValue= type;

			this.tbOnCreateValue.$input.focus();
		},

		SaveState: function() {
			var $xn= this.$xn;
			
			var $xn_prop= this.$xn.children('properties:first');
			var prop_exists= !$isNull($xn_prop);
			if (!prop_exists) $xn_prop= xml_createNode(this.designer.xmlDoc, 'properties');

			// Value Binding
			xml_updateAttr($xn_prop, 'oncreatevalue', this.tbOnCreateValue.getValue());
			xml_updateAttr($xn_prop, 'onupdatevalue', this.tbOnUpdateValue.getValue());

			// add or remove <properties> node
			var prop_has_data= $xn_prop[0].attributes.length>0;
			if (prop_has_data) {
				if (!prop_exists) $xn.append($xn_prop);
			} else {
				if (prop_exists) $xn_prop.remove();
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