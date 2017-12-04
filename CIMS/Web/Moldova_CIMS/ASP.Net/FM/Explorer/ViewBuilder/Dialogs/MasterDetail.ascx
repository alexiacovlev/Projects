<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;top:0;">
	<div class="tab" style="display:block">
		
		<fieldset style="margin-top:12px;padding:12px">
			<legend>Related Grid</legend>
			<div class="comment">Specify Related Grid Settings (table name and view name)</div>
			<table style="width:90%;margin-top:5px;" cellpadding="3" cellspacing="3">
				<colgroup><col width="140" /><col /></colgroup>
				<tr>
					<td class="n">Table Name:</td><td style="padding-right:0"><dialogs:TableLookupControl id="tbTableName" runat="server" /></td>
				</tr>
				<tr>
					<td class="n">View Name:</td><td style="padding-right:0"><dialogs:ViewLookupControl id="tbViewName" runat="server" /></td>
				</tr>
				<tr>
					<td class="n">Parent Key Field:</td><td style="padding-right:0"><dialogs:FieldLookupControl id="tbField" runat="server" /></td>
				</tr>
			</table>
		</fieldset>

		<fieldset style="margin-top:12px;padding:12px">
			<legend>On Click action</legend>
			<div class="comment">Specify the handler for OnClick action</div>
			<table style="width:90%;margin-top:5px;" cellpadding="3" cellspacing="3">
				<colgroup><col width="140" /><col /></colgroup>
				<tr>
					<td class="n">Handler:</td><td><input id="tbHandler" class="fm" /></td>
				</tr>
				<tr>
					<td class="n">Window Size:</td><td><input id="tbWindow" class="fm" /></td>
				</tr>
			</table>
		</fieldset>

		<fieldset style="margin-top:12px;padding:12px">
			<legend></legend>
			<table style="width:90%;margin-top:5px;" cellpadding="3" cellspacing="3">
				<colgroup><col width="140" /><col /></colgroup>
				<tr>
					<td class="n">Header Text:</td><td><input id="tbTitle" class="fm" /></td>
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
	RMC.VB_MasterDetail= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}
	RMC.VB_MasterDetail.prototype = {
		
		initialize: function() {
			var $p= this.$p;
			
			this.tbTableName= new FM.LookupTextControl($("#tbTableName", this.$p));
			this.tbViewName= new FM.LookupTextControl($("#tbViewName", this.$p), this.tbTableName);
			this.tbField= new FM.LookupTextControl($("#tbField", this.$p), this.tbTableName);

			this.$tbTitle= $("#tbTitle", this.$p);
			this.$tbHandler= $("#tbHandler", this.$p);
			this.$tbWindow= $("#tbWindow", this.$p);


			$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
		},

		LoadState: function(designer) {
			this._window.show();
			
			this.designer= designer;
			var $xnview= this.designer.$xnview;
			var $md= $xnview.find('masterdetail');

			if ($md.attr('field')) this.applyFix($md);
			
			this.tbTableName.setValue($md.attr('table')||"");
			this.tbViewName.setValue($md.attr('view')||"");
			this.tbField.setValue($md.attr('parentKey')||"");

			this.$tbTitle.val($md.attr('title')||"");
			this.$tbHandler.val($md.attr('handler')||"");
			this.$tbWindow.val($md.attr('window')||"");
		},

		applyFix: function($md) {
			$md.removeAttr('field');
			$md.attr('table', '');
			$md.attr('view', $md.attr('detailView')||''); $md.removeAttr('detailView');
			$md.attr('handler', $md.attr('detailForm')||''); $md.removeAttr('detailForm');
			var w= $md.attr('detailFormParams')||'';
			if (w) w= w.replace(/,true/g, '').replace(/,false/g, '');
			$md.attr('window', w); $md.removeAttr('detailFormParams');
		},

		SaveState: function() {
			var $xnview= this.designer.$xnview;
			var $md= $xnview.find('masterdetail');
			var exists= !$isNull($md);
			if (!exists) $md= $(xml_createNode(this.designer.xmlDoc, 'masterdetail'));
			
			var t= this.tbTableName.getValue();
			var v= this.tbViewName.getValue();
			var f= this.tbField.getValue();
			if (!t || !v || !f) { AX.Window.alert("You must configure the settings for Related Grid."); return false; }
			
			$md.attr('table', t);
			$md.attr('view', v);
			$md.attr('parentKey', f);
			
			$md.attr('title', this.$tbTitle.val().trim());
			$md.attr('handler', this.$tbHandler.val().trim());
			var w= this.$tbWindow.val().trim();
			if (w.indexOf(',') == -1) w= "";
			$md.attr('window', w);

			if (!exists) $xnview.append($md);

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