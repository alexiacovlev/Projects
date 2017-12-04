<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>

<div style="padding:5px;">
	<table cellpadding="4" cellspacing="4">
		<tr>
			<td class="n" style="width:120px">Raise after:</td>
			<td>
				<select id="listTimeout" class="fm" style="width:126px">
					<option value="00:00:30">30 seconds</option>
					<option value="00:01:00">1 minute</option>
					<option value="00:05:00">5 minutes</option>
					<option value="00:10:00">10 minutes</option>
					<option value="00:20:00">20 minutes</option>
					<option value="00:30:00">30 minutes</option>
					<option value="00:40:00">40 minutes</option>
					<option value="01:00:00">1 hour</option>
					<option value="02:00:00">2 hours</option>
					<option value="03:00:00">3 hours</option>
					<option value="05:00:00">5 hours</option>
					<option value="12:00:00">12 hours</option>
					<option value="24:00:00">1 day</option>
					<option value="2.00:00:00">2 days</option>
					<option value="3.00:00:00">3 days</option>
					<option value="7.00:00:00">7 days</option>
					<option value="30.00:00:00">30 days</option>
					<option value="0.00:00:00">[Custom Period]</option>
				</select>
				<input id="tbTimeout" class="fm" style="width:90px;display:none" title="d.HH:mm:ss" />
			</td>
		</tr>
		<tr>
			<td class="n" style="width:120px">Move to the state:</td>
			<td><select id="listConnections" class="fm" style="width:220px"></select></td>
		</tr>
		<tr>
			<td class="n" style="width:120px">with label:</td>
			<td><input id="tbTimeoutLabel" class="fm" style="width:220px" /></td>
		</tr>
	</table>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">

FMS.TimeoutProperties= function(wnd) {
	this._window= wnd;
	var $p= wnd.$content;
	this.$tbTitle= $("#tbTitle", $p);
	this.$tbPostAction= $("#tbPostAction", $p);
	$("div.fm-dlg-buttons", $p).click($createDelegate(FMS.Properties_BaseClick, this));
	$("img#btn1", $p).click($createDelegate(this.openDesigner, this));
}
FMS.TimeoutProperties.prototype= {
	LoadState: function(designer, conn) {
		this._window.returnValue= false;

		this.designer= designer;
		this.conn= conn;
		this.title= conn.title;
		this.action= conn.action;
		this.$tbTitle.val(this.title);
		var wf_name= ""; if (this.action) wf_name= this.action.substr(this.action.indexOf(':')+1);
		this.$tbPostAction.val(wf_name);

		this._window.returnValue= null;
		this._window.show();
		this.$tbTitle.focus();
	},
	SaveState: function() {
		var new_title= this.$tbTitle.val().trim();
		var wf_name= this.$tbPostAction.val().trim();
		var new_action= wf_name ? ("WORKFLOW:"+wf_name) : "";

		if (new_title != this.title || new_action != this.action) {
			this.conn.sourceItem.changed= true;
			this.conn.setTitle(new_title);
			this.conn.action= new_action; 
			this._window.returnValue= true;
		}
		return true;
	},
	openDesigner: function() {
		var wf_name= this.$tbPostAction.val().trim(); 
		if (!wf_name) return;
		this._window.close();
		this.designer.OpenHandlerDesigner("WORKFLOW", wf_name, null);
	}
}

</script>