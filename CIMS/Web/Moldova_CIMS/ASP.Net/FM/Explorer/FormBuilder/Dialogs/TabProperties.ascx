<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg fm-dlg-tabs" style="top:0;bottom:30px;">
	<fieldset class="fm-dlg-sec-bg" style="padding:8px">
		<legend>Label</legend>
		<table cellpadding="0" cellspacing="0" width="100%">
			<colgroup><col width="70"/><col /></colgroup>	
			<tr>
				<td rowspan="2"><img src="Images/48/field_editor.png" width="48" height="48" /></td>
				<td>
					<div class="comment">Specify the title for the tab</div>
					<dialogs:AdminResTitleControl ID="tbTitle" runat="server" />
				</td>
			</tr>
			
		</table>
	</fieldset>

	<div id="panelCommands" style="position:absolute;bottom:8px;left:8px;">
		<a class="fm" style="" cmd="moveleft">move left</a>
		<a class="fm" style="margin-left:3px;" cmd="moveright">move right</a>
		<a class="fm" style="margin-left:10px;" cmd="delete">delete tab</a>
	</div>

</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.FB_TabProperties= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}
	RMC.FB_TabProperties.prototype = {
		
		initialize: function() {
			this.$tbTitle= $("#tbTitle", this.$p);
			this.resTitle= new FM.ResTitle(this.$tbTitle);
			this.$panelCommands= $("div#panelCommands", this.$p);
			
			$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
			this.$panelCommands.addHandler('click', this.commands_click, this);
		},

		LoadState: function(designer, $xntab, tabHeader, index) {
			this._window.show();
			this.$xntab= $xntab;
			this.designer= designer;
			this.tabHeader= tabHeader;
			this.index= index;
			this.$panelCommands.toggle($xntab.parent().children().length > 1);

			this._window.show();

			this.$tbTitle.val($xntab.attr('title')).focus();
			this.resTitle.setResValue($xntab.attr('restitle'));

			this.$tab= $(designer.$tabBar.children()[index]);
			this.$panel= $(designer.$tabPanel.children()[index]);
		},

		SaveState: function() {
			var title= this.$tbTitle.val().trim();
			this.$xntab.attr('title', title);
			xml_updateAttr(this.$xntab, 'restitle', this.resTitle.getResValue());

			$(this.tabHeader).text(title);
			return true;
		},

		deleteTab: function() {
			this.$tab.remove();
			this.$panel.remove();

			this.$xntab.remove();
			this._window.close();

			this.designer.tabBar._index= -1;
			this.designer.tabBar.select(0);
		},

		move: function(dir) {
			var $tab= this.$tab;
			var $panel= this.$panel;

			if (dir == 'left') {
				if (this.$xntab.prev().length == 0) return;
				this.$xntab.insertBefore(this.$xntab.prev());

				var $tab2= this.$tab.prev();
				$tab.insertBefore($tab2); 
				$panel.insertBefore($panel.prev());
			} else if (dir == 'right') {
				if (this.$xntab.next().length == 0) return;
				this.$xntab.insertAfter(this.$xntab.next());
				
				var $tab2= $tab.next();
				$tab.insertAfter($tab2);
				$panel.insertAfter($panel.next());
			}
		},

		commands_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "delete": AX.Window.confirm("Delete Tab", "Are you sure you want to delete the tab from the form?", this.deleteTab, this); break;
				case "moveleft": this.move('left'); break;
				case "moveright": this.move('right'); break;
			}
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": if (this.SaveState()) this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}
	}
</script>