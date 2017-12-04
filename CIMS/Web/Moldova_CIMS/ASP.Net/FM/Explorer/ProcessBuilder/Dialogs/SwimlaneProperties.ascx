<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div style="background-color: #eaeaea">
	<div style="position: absolute; top:0;bottom:32px;width:270px;border:solid 1px #a59d9b">
		<div class="fm-toolbar" style="position:absolute;width:100%;height:24px;">
			<div id="_toolbar" class="fm-menu" style="margin-left:2px;">
			<%= AX.FM.Common.UI.Button.RenderMenuItem("add", "Add Panel", "Menu/16_plus.png")%>
			<%= AX.FM.Common.UI.Button.RenderMenuItem("up", "", "../../Explorer/Images/16_up.png", "Move Up")%>
			<%= AX.FM.Common.UI.Button.RenderMenuItem("down", "", "../../Explorer/Images/16_down.png", "Move Down")%>
			<%= AX.FM.Common.UI.Button.RenderMenuItem("delete", "Delete", "Menu/16_delete.png")%>
			</div>
		</div>
		<div style="position:absolute;width:100%;top:24px;bottom:0;">
			<div id="listPanels" class="fm_list" style="height: 100%;overflow-y:auto;border:0;font-size:10pt;">
			</div>
		</div>
	</div>

	<div class="fm-dlg fm-dlg-tabs" style="position:absolute;top:0;left:273px;right:0px;bottom:32px;">

		<fieldset class="fm-dlg-sec-bg" style="padding:8px">
		<legend>Swimlane Properties</legend>
			<div class="comment">Specify the title for the swimlane</div>
			<table id="_itemProperties" style="width: 100%; table-layout: fixed;" cellspacing="5" cellspacing="3">
				<colgroup><col width="90" /><col /></colgroup>
				<tbody>
					<tr>
						<td class="n">Title:</td>
						<td><input id="tbTitle" class="fm" /></td>
					</tr>
					<tr>
						<td class="n">Description:</td>
						<td><textarea id="tbDescription" class="fm" rows="2"></textarea></td>
					</tr>
					<tr id="rowTaskRole">
						<td class="n">Task Role:</td>
						<td><input id="tbRoleName" class="fm" /></td>
					</tr>
				</tbody>
			</table>
		</fieldset>
		<fieldset class="fm-dlg-sec" style="padding:8px;margin-top:20px;">
			<legend>Assign state fields</legend>
			<div class="comment">Swimlines can be used to assign data to the states belong to corresponding panel.</div>
			<div id="panelFields">
				<div style='padding:5px'><label style='width:110px;font-weight:bold;display:inline-block;color:#0464d0;'></label><label>= </label><input class='fm' style='width:185px'/><img cmd="select" style='vertical-align:bottom;margin-left:2px;cursor:pointer' src='/ASP.Net/FM/Common/Images/btn_lookup_off.gif' /><img cmd="delete" style='vertical-align:bottom;margin-left:15px;cursor:pointer' src='/ASP.Net/FM/Common/Images/16_delete.gif' /></div>
			</div>
		</fieldset>
	</div>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
FMS.SwimplaneProperties= function(wnd) {
	this._window= wnd;
	var $p= this.$p= wnd.$content;
	this.$tbTitle= $("#tbTitle", $p);
	this.$tbDescription= $("#tbDescription", $p);
	this.$tbRoleName= $("#tbRoleName", $p);
	this.$rowTaskRole= $("#rowTaskRole", $p);
	$("div.fm-dlg-buttons", $p).addHandler('click', this.btn_click, this);
	this.$listPanels= $("#listPanels", $p);
	this.$listPanels.mousedown(function(e) { e.preventDefault(); });
	this.$listPanels.click($createDelegate(this.panels_click, this));

	$("#_toolbar", $p).click($createDelegate(this.toolbar_click, this));
	this.assignPanel= new FMS.AssignPanel($("div#panelFields", $p), true);
	this.selectedIndex= -1;
}
FMS.SwimplaneProperties.prototype = {
		
	LoadState: function(xd, $xnpanels, index) {
		this.selectedIndex= -1;
		this.xmlDoc= xd;
		this.$xnpanels= $xnpanels;
		var xnlpanels= this.$xnpanels.children();
		this.$listPanels.empty();
		for (var i= 0; i < xnlpanels.length; i++) {
			var xn= xnlpanels[i];
			this.$listPanels.append("<a style='padding:5px;margin-top:1px;color:#1a3da0;'>" + xn.getAttribute('title') + "</a>");
		}

		this.isTaskMode= (xd.documentElement.getAttribute('assignTasks') == 'true');
		this.$rowTaskRole.toggle(this.isTaskMode);
				
		this._window.show();
		if (index != -1) this.selectPanel(index);

		this.assignPanel.tableName= $(xd.documentElement).find("settings").attr('table');
	},

	selectPanel: function(index) {
		var htmlitems= this.$listPanels.children();
		var xnitems= this.$xnpanels.children();

		if (this.selectedIndex != -1) {
			this.applyChanges(xnitems[this.selectedIndex], htmlitems[this.selectedIndex]);
			htmlitems[this.selectedIndex].className= '';
		}

		this.selectedIndex= index;
		var item= htmlitems[index];
		item.className= 'sel';

		var xn= xnitems[index];
		this.$tbTitle.val(xn.getAttribute('title'));
		this.$tbTitle.focus();
		this.$tbDescription.val(xn.getAttribute('description')||'');
		if (this.isTaskMode) this.$tbRoleName.val(xn.getAttribute('role')||'');

		this.assignPanel.LoadState(this.xmlDoc, $(xn));
	},

	applyChanges: function(xn, item) {
		var new_title= this.$tbTitle.val().trim();
		var title= xn.getAttribute('title');
		if (new_title != title) {
			xn.setAttribute('title', new_title);
			if (item) $(item).html(new_title);
			this._window.returnValue= true;
		}
		xml_updateAttribute(xn, 'description', this.$tbDescription.val().trim());
		if (this.isTaskMode) xml_updateAttribute(xn, 'role', this.$tbRoleName.val().trim());

		this.assignPanel.SaveState(this.xmlDoc, $(xn));
	},

	panels_click: function(e) {
		var o= e.target;
		if (o.tagName == "A") this.selectPanel($(o).index());
	},
	toolbar_click: function(e) {
		switch (_fm_getCommand(e)) {
			case "add": this.addNode(); break;
			case "delete": this.deleteNode(true); break;
			case "up": this.moveNode('up'); break;
			case "down": this.moveNode('down'); break;
		}
	},
	addNode: function() {
		var xn_panels= this.$xnpanels.children();
		var $xn_assign= xn_panels.length > 0 ? $("assign", xn_panels[0]) : [];
		var title= "New Panel";
		var $xn= xml_appendNode(this.xmlDoc, this.$xnpanels, 'panel');
		$xn.attr('title', title).attr('height', '100');
		if ($xn_assign.length == 1) {
			$xn_assign= $xn_assign.clone();
			var xn_fields= $xn_assign.children();
			for (var i= 0; i < xn_fields.length; i++) xn_fields[i].setAttribute('value', '');
			$xn.append($xn_assign);
		}
		this.$listPanels.append("<a style='padding:4px;margin-top:1px;color:#1a3da0;'>" + title + "</a>");
		FM.DialogUtils.scrollBottom(this.$listPanels);
		this.selectPanel(this.$xnpanels.children().length-1);
		this._window.returnValue= true;
	},
	deleteNode: function(confirm) {
		if (this.selectedIndex == -1) return;
		if (confirm) {
			AX.Window.confirm("Delete Confirmation", "Are you sure you want to delete this swimlane?", function() { this.deleteNode(false); }, this);
		} else {
			var htmlitems= this.$listPanels.children();
			var xnitems= this.$xnpanels.children();

			$(htmlitems[this.selectedIndex]).remove();
			$(xnitems[this.selectedIndex]).remove();
			this.selectedIndex= -1;
			this._window.returnValue= true;
		}
	},
	moveNode: function(dir) {
		if (this.selectedIndex == -1) return;

		var htmlitems= this.$listPanels.children();
		var xnitems= this.$xnpanels.children();

		var $item= $(htmlitems[this.selectedIndex]);
		var $xn= $(xnitems[this.selectedIndex]);

		if (dir == 'up') {
			if (this.selectedIndex == 0) return;
			$item.insertBefore($item.prev());
			$xn.insertBefore($xn.prev());
			this.selectedIndex-= 1;
		} else if (dir == 'down') {
			if (this.selectedIndex == xnitems.length-1) return;
			$item.insertAfter($item.next());
			$xn.insertAfter($xn.next());
			this.selectedIndex+= 1;
		}

		this._window.returnValue= true;
	},

	SaveState: function() {
		if (this.selectedIndex != -1) {
			var xnitems= this.$xnpanels.children();
			this.applyChanges(xnitems[this.selectedIndex]);
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