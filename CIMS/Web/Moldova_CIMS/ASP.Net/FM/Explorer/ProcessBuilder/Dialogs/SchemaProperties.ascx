<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>

<div class="fm-dlg-tabbar">
	<span class="tab tabOn">General</span><span class="tab">State Fields</span><span class="tab">Tasks</span><span class="tab">Additional</span>
</div>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;">
	<div class="tab" style="display:block;padding:5px;">

		<table cellpadding="2" cellspacing="2" width="90%">
			<colgroup><col width="75"/><col width="100" /><col /></colgroup>	
			<tr>
				<td rowspan="8" valign="top"><img src="Images/48/64_process.png" width="64" height="64" /></td>
				<td colspan="2">
					<div class="comment" style="height:18px">Specify the name and the title for the process schema</div>
				</td>
			</tr>
			<tr>
				<td class="req">Name:</td>
				<td><input id="tbName" disabled="disabled" class="fm"/></td>
			</tr>
			<tr>
				<td class="n">Title:</td>
				<td><input id="tbTitle" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td class="n" valign="top">Description:</td>
				<td><textarea id="tbDescription" class="fm" style="height:60px" rows="4"></textarea></td>
			</tr>
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr>
				<td colspan="2">
					<div class="comment">Specify process handled record parameters</div>
				</td>
			</tr>
			<tr>
				<td class="req">Table Name:</td>
				<td><dialogs:TableLookupControl id="lookupTableName" runat="server" /></td>
			</tr>
			<tr>
				<td class="n">Record Key:</td>
				<td><input id="tbFieldName" class="fm" disabled="disabled" maxlength="100"/></td>
			</tr>

		</table>
	</div>

	<div class="tab" style="padding:10px;">
		<div class="comment">You can assign record state data for each RecordState activity.<br />
			To configure custom data for the state use Properties->Assign State tab.<br />
		</div>
		<div id="panelFields" style="padding:10px;overflow-y:auto;height:263px;">
			<div style='padding:5px;'><label style='width:120px;font-weight:bold;display:inline-block;color:#0464d0;'></label><label>= </label><input class='fm' style='width:250px'/><img cmd="select" style='display:none;vertical-align:bottom;margin-left:2px;cursor:pointer' src='/ASP.Net/FM/Common/Images/btn_lookup_off.gif' /><img cmd="delete" style='vertical-align:bottom;margin-left:20px;cursor:pointer' src='/ASP.Net/FM/Common/Images/16_delete.gif' /></div>
		</div>
	</div>

	<div class="tab" style="padding:10px;">
		<div class="comment" style="margin-bottom:10px;">You can activate Tasks Assignment for the process.</div>
		<div style="margin-top:10px;">
			<label class="fm-chk" style="display:block;font-size:9pt;margin:0px 25px 5px 25px;"><input id="cbAssignTasks" type="checkbox" class="fm-chk" />Assign State Tasks</label>
			<label class="fm-chk" style="display:block;font-size:9pt;margin-left:45px;">Custom Regarding Type <input id="tbRegardingType" type="text" class="fm" style="width:30px;" /></label>
		</div>
		<br />
		<div class="comment" style="margin-bottom:10px;">You can assign common data for all Task during the process.<br />
			And also you can configure custom data for each task.<br />
		</div>
		<div id="panelTaskFields" style="padding:10px;overflow-y:auto;height:200px;display:none">
			<div style='padding:5px;'><label style='width:120px;font-weight:bold;display:inline-block;color:#0464d0;'></label><label>= </label><input class='fm' style='width:250px'/><img cmd="select" style='display:none;vertical-align:bottom;margin-left:2px;cursor:pointer' src='/ASP.Net/FM/Common/Images/btn_lookup_off.gif' /><img cmd="delete" style='vertical-align:bottom;margin-left:20px;cursor:pointer' src='/ASP.Net/FM/Common/Images/16_delete.gif' /></div>
		</div>
	</div>

	<div class="tab">
		<label class="fm-chk" style="display:block;font-size:9pt;margin:25px;"><input id="cbAllowBack" type="checkbox" class="fm-chk" />Allow BACK button</label>
		<label class="fm-chk" style="display:block;font-size:9pt;margin:25px;"><input id="cbHideDescription" type="checkbox" class="fm-chk" />Hide state description</label>
		<label class="fm-chk" style="display:block;font-size:9pt;margin:25px;"><input id="cbAllowHistory" type="checkbox" class="fm-chk" />Save Activity State History</label>
	</div>

</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
FMS.SchemaProperties= function(wnd) {
	this._window= wnd;
	var $p= this.$p= wnd.$content;
	
	this.tabBar= new FM.Tabbar($("div.fm-dlg-tabbar", $p));
	this.$tbTitle= $("#tbTitle", $p);
	this.$tbName= $("#tbName", $p);
	this.$tbDescription= $("#tbDescription", $p);

	this.lookupTableName= new FM.LookupTextControl($("#lookupTableName", $p));
	this.lookupTableName.onselect= $createDelegate(this.ontablechanged, this);
	this.$tbFieldName= $("#tbFieldName", $p);

	this.$cbAllowBack= $("#cbAllowBack", $p);
	this.$cbHideDescription= $("#cbHideDescription", $p);
	this.$cbAllowHistory= $("#cbAllowHistory", $p);
	this.$cbAssignTasks= $("#cbAssignTasks", $p);
	this.$tbRegardingType= $("#tbRegardingType", $p);

	this.$panelTaskFields= $("div#panelTaskFields", $p);
	this.$cbAssignTasks.addHandler('change', function(e){this.$panelTaskFields.toggle(this.$cbAssignTasks.is(':checked'));}, this);

	this.assignPanel= new FMS.AssignPanel($("div#panelFields", $p), true);
	this.assignPanel2= new FMS.AssignPanel(this.$panelTaskFields, false);

	$("div.fm-dlg-buttons", $p).addHandler('click', this.btn_click, this);
}
FMS.SchemaProperties.prototype = {
		
	LoadState: function() {
		this._window.show();

		this.isNew= !FMS.designer.schemaName;
		this.$tbName.val(FMS.designer.schemaName||'');
		this.xmlDoc= FMS.designer.xmlDoc;
		var $xn= this.$xn= $(this.xmlDoc.documentElement);

		this.tableChanged= false;

		var $settings= $xn.find("settings");
		
		this.$tbTitle.val($xn.attr('title'));
		this.$tbDescription.val($xn.attr('description'));
		this.lookupTableName.setValue($settings.attr('table')||'');
		this.$tbFieldName.val($settings.attr('keyName'));

		this.assignPanel.LoadState(this.xmlDoc, $settings);

		this.$cbAllowBack.prop('checked', ($xn.attr('allowBack')=='true'));
		this.$cbHideDescription.prop('checked', ($xn.attr('hideDesc')=='true'));
		this.$cbAllowHistory.prop('checked', ($xn.attr('allowHistory')=='true'));

		this.allowTasks= ($xn.attr('assignTasks')=='true');
		this.$cbAssignTasks.prop('checked', this.allowTasks);
		this.$tbRegardingType.val($xn.attr('regardingType'));
		this.$panelTaskFields.toggle(this.allowTasks);
		if (this.allowTasks) this.assignPanel2.LoadState(this.xmlDoc, $xn.find("tasks"));

		if (this.isNew) {
			this.$tbName[0].disabled= false;
			this.$tbName.focus();
		} else {
			this.$tbTitle.focus();
		}
	},

	SaveState: function() {
		if (this.isNew) {
			var name= this.$tbName.val().trim();
			if (!name) {AX.Window.alert("Please, define the Process Name."); return false;}
			this.$tbName[0].disabled= true;
			FMS.designer.schemaName= name;
			this._window.returnValue= true;
		}

		this.$xn.attr('title', this.$tbTitle.val().trim());
		this.$xn.attr('description', this.$tbDescription.val().trim());
			
		var $settings= this.$xn.find("settings");
		if (this.tableChanged) {
			FMS.designer.tableName= this.lookupTableName.getValue();
			$settings.attr('table', FMS.designer.tableName);
			$settings.attr('keyName', this.$tbFieldName.val());
		}

		this.assignPanel.SaveState(this.xmlDoc, $settings);

		xml_updateAttr(this.$xn, 'allowBack', this.$cbAllowBack.prop('checked'));
		xml_updateAttr(this.$xn, 'hideDesc', this.$cbHideDescription.prop('checked'));
		xml_updateAttr(this.$xn, 'allowHistory', this.$cbAllowHistory.prop('checked'));

		xml_updateAttr(this.$xn, 'assignTasks', this.$cbAssignTasks.prop('checked'));
		xml_updateAttr(this.$xn, 'regardingType', this.$tbRegardingType.val());
		this.allowTasks= this.$cbAssignTasks.is(':checked');
		var $tasks= this.$xn.find("tasks");
		if (this.allowTasks) {
			if ($isNull($tasks)) { $tasks= xml_createNode(this.xmlDoc, "tasks"); $tasks.insertAfter($settings); }
			this.assignPanel2.SaveState(this.xmlDoc, $tasks);
		} else if (!$isNull($tasks)) {
			$tasks.remove();
		}
		
		return true;
	},
	
	ontablechanged: function(name) {
		this.tableChanged= true;
		var tb= this.$tbFieldName[0];
		FMS.ExecuteService(JSON.stringify({name:name}), "Dialogs_GetTablePrimaryKey", function(res) {tb.value= res.d.Value;});
		FMS.designer.tableName= name;
	},

	btn_click: function(e) {
		switch (_fm_getCommand(e)) {
			case "OK": if (this.SaveState()) this._window.close(); break;
			case "X": this._window.close(); break;
		}
	}
}
</script>