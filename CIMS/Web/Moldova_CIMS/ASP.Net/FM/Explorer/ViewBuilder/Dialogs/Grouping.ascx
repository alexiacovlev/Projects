<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;top:0;">
	<div class="tab" style="display:block">
	<fieldset>
		<legend>Grouping Properties</legend>
		<div class="desc">To group data grid, please specify field name. Also you can specify sorting and header mask for grouped items.</div>
		<table style="width:90%;" cellpadding="5" cellspacing="5">
			<colgroup><col width="140" /><col /></colgroup>
			<tr>
				<td>Group By Field:</td>
				<td><dialogs:FieldLookupControl id="tbGroupByName" runat="server" DialogType="FIELD/GROUPBY" WindowTitle="GroupBy Fields" /></td>
			</tr>
			<tr>
				<td>Sorting:</td>
				<td><div id="panelSorting"><label><input type='radio' class='fm-chk' name='gp_sorting' value="true"/>Ascending</label><label style='margin-left:10px;'><input type='radio' class='fm-chk' value="false" name='gp_sorting'/>Descending</label></div></td>
			</tr>
			<tr>
				<td>Title Mask:</td>
				<td><input id="tbGroupByTitle" type="text" class="fm" maxlength="100" placeholder="Field Name: {0} ({1})" /></td>
			</tr>
			<tr>
				<td>Mode:</td>
				<td><input id="tbGroupByMode" type="text" class="fm" title="For Date Fields: YEAR,MONTH; For Text Fields: ALPHABET"/></td>
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
	RMC.VB_Grouping= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}
	RMC.VB_Grouping.prototype = {
		
		initialize: function() {
			var $p= this.$p;
			
			this.tbGroupByName= new FM.LookupTextControl($("#tbGroupByName", this.$p));
			this.panelSorting= new FM.RadioGroup($("#panelSorting", this.$p));
			this.$tbGroupByTitle= $("#tbGroupByTitle", this.$p);
			this.$tbGroupByMode= $("#tbGroupByMode", this.$p);

			$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
		},

		LoadState: function(designer) {
			this._window.show();
			
			this.designer= designer;
			this.tbGroupByName.parentValue= this.designer.tableName;

			var $xnview= this.designer.$xnview;
			var $group= $xnview.find('fetch').find('groups').find('group:first');
			
			this.tbGroupByName.setValue($group.attr('name'));
			this.$tbGroupByTitle.val($group.attr('title'));
			this.$tbGroupByMode.val($group.attr('mode'));
			this.panelSorting.setValue($group.attr('ascending')||"false");
		},

		SaveState: function() {
			var $xnview= this.designer.$xnview;
			var xd= this.designer.xmlDoc;

			if (this.tbGroupByName.getValue().trim() == "") { AX.Window.alert('Please select the field name for grouping'); return false; }
			var title= this.$tbGroupByTitle.val().trim();
			if (title.length > 0 && (title.indexOf('{0}') == -1 || title.indexOf('{1}') == -1)) { AX.Window.alert('Title Mask must contains {0}-for grouped value and {1} - for sub-records count'); this.$tbGroupByTitle.val(""); return false; }

			var $fetch= xml_getOrCreate(xd, $xnview, 'fetch');
			var $groups= xml_getOrCreate(xd, $fetch, 'groups');
			var $group= xml_getOrCreate(xd, $groups, 'group');

			$group.attr('name', this.tbGroupByName.getValue());
			$group.attr('ascending', this.panelSorting.getValue());
			$group.attr('title', title);
			$group.attr('mode', this.$tbGroupByMode.val());
			
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