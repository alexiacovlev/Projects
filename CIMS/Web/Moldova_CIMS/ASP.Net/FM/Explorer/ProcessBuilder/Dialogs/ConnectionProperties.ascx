<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>

<div style="padding:5px;">
	<table cellpadding="5" cellspacing="5" width="100%">
		<colgroup><col width="140"/><col /><col width="30" /></colgroup>	
		<tr>
			<td colspan="3"><input id="tbTitle" class="fm" maxlength="100" style="font-size:10pt;height:22px;"/></td>
		</tr>
		<tr id="trRow1">
			<td colspan="3"><a id="btnAdd" class="fm">add post action workflow</a></td>
		</tr>
		<tr id="trRow2">
			<td>Post Action (workflow)</td>
			<td><input id="tbPostAction" class="fm" maxlength="100"/></td>
			<td><img id="btn1" src="images/schema/ico_16_hw.png" width="16" height="16" style="cursor:pointer" alt="Customize Post Action Workflow"/></td>
		</tr>
	</table>
	<select class="fm" id="ddlLevel" style="position:absolute;bottom:8px;left:14px;width:120px;">
		<option value="0">Default</option>
		<option value="1">Green</option>
		<option value="2">Blue</option>
		<option value="3">Brown</option>
		<option value="4">Red</option>
	</select>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">

FMS.ConnectionProperties= function(wnd) {
	this._window= wnd;
	var $p= wnd.$content;
	this.$tbTitle= $("#tbTitle", $p);
	this.$tbPostAction= $("#tbPostAction", $p);
	this.$ddlLevel= $("#ddlLevel", $p);
	this.$trRow1= $("#trRow1", $p);
	this.$trRow2= $("#trRow2", $p);
	$("div.fm-dlg-buttons", $p).click($createDelegate(FMS.Properties_BaseClick, this));
	$("img#btn1", $p).click($createDelegate(this.openDesigner, this));
	$("#btnAdd", $p).click($createDelegate(this.addPostAction, this));
}
FMS.ConnectionProperties.prototype= {
	LoadState: function(designer, conn) {
		this._window.returnValue= false;

		this.designer= designer;
		this.conn= conn;
		this.title= conn.title;
		this.action= conn.action;
		this.level= conn.level;
		this.$tbTitle.val(this.title);
		this.$ddlLevel.val(this.level);
		this.allowPostAction= (conn.sourceItem.box.type == "RecordState");
		if (this.allowPostAction) {
			var wf_name= ""; 
			if (this.action) wf_name= this.action.substr(this.action.indexOf(':')+1);
			this.$tbPostAction.val(wf_name);
			this.$trRow1.toggle(wf_name=="");
			this.$trRow2.toggle(wf_name!="");
		} else {
			this.$tbPostAction.val("");
			this.$trRow1.hide();
			this.$trRow2.hide();
		}

		this._window.returnValue= null;
		this._window.show();
		this.$tbTitle.focus();
	},
	SaveState: function() {
		var new_title= this.$tbTitle.val().trim();
		var new_level= parseInt(this.$ddlLevel.val()||'0');
		var new_action= "";
		if (this.allowPostAction) {
			var wf_name= this.$tbPostAction.val().trim();
			new_action= wf_name ? ("WORKFLOW:"+wf_name) : "";
		}

		if (new_title != this.title || new_action != this.action || new_level != this.level) {
			this.conn.sourceItem.changed= true;
			this.conn.setTitle(new_title);
			this.conn.level= new_level;
			if (this.allowPostAction) this.conn.action= new_action; 
			this._window.returnValue= true;
		}
		return true;
	},
	addPostAction: function() {
		this.$trRow2.show();
		this.$trRow1.hide();
		this.$tbPostAction.val(this.conn.sourceItem.box.name+"_transition");
	},
	openDesigner: function() {
		var wf_name= this.$tbPostAction.val().trim(); 
		if (!wf_name) return;
		this._window.close();
		this.designer.OpenHandlerDesigner("WORKFLOW", wf_name, null);
	}
}

</script>