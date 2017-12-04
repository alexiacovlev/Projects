<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg fm-dlg-content" style="top:0;border:0;">
	<fieldset class="fm-dlg-sec-bg" style="padding:4px;margin:0px;">
		<table cellpadding="3" cellspacing="3" width="100%">
			<colgroup><col width="70"/><col width="80" /><col /></colgroup>	
			<tr>
				<td rowspan="3" valign="top"><img src="Images/48/field_editor.png" width="48" height="48" /></td>
				<td class="n">Title:</td>
				<td><input id="tbTitle" class="fm" maxlength="150" style="font-size:10pt;height:22px;"/></td>
			</tr>
			<tr>
				<td class="n">Name:</td>
				<td><input id="tbName" class="fm" disabled="disabled" /></td>
			</tr>				
			<tr>
				<td valign="top" style="padding-top:4px;">Description:</td>
				<td><textarea id="tbDescription" class="fm" rows="4"></textarea></td>
			</tr>	
		</table>
	</fieldset>

	<div class="fm-dlg-tabbar" style="position:absolute;top:140px;">
		<span class="tab tabOn" style="width:100px">Presentation</span><span class="tab" style="width:100px">Assign State</span><span id="tabTask" class="tab" style="width:50px;display:none">Task</span><span class="tab" style="width:70px">Timeout</span><span class="tab">Dialog Messages</span>
	</div>
	<div class="fm-dlg-tabs fm-dlg" style="top:164px;bottom:0px;padding:0;">
		<div class="tab" style="padding:15px;display:block">
			<div class="comment" style="margin-bottom:10px;">
				The state in the process can be represented by FORM with handled record data or by forms sequence.
				You can customize the appearance for each state of the process.<br />
				Please, define the handler type from the list below:
			</div>
			<table cellpadding="2" cellspacing="2" width="100%">
				<colgroup><col width="130" /><col /></colgroup>	
				<tr>
					<td class="n">Handler Type:</td>
					<td>
						<select id="ddlHandlerType" class="fm" style="width:200px">
							<option value="">Nothing</option>
							<option value="WORKFLOW">Human Workflow</option>
							<option value="FORM">Data Form (for handled record)</option>
							<option value="PROFILE">Data Profile</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="n" align="right"></td>
					<td><input id="tbHandlerValue" class="fm" style="width:200px" /></td>
				</tr>
			</table>
		</div>

		<div class="tab" style="overflow-y:scroll;height:255px;">
			<fieldset class="fm-dlg-sec-bg" style="margin-top:15px;padding:10px 5px 9px 12px;">
				<legend>Current Assignment</legend>
				<div id="panelAssignState"></div>
			</fieldset>
			<fieldset style="margin-top:12px;padding:10px 5px 9px 12px;">
				<legend>Global Schema Assignment</legend>
				<div id="panelGlobalState"></div><!-- style="font-weight:bold;padding:8px 5px;color: #0464d0;"-->
			</fieldset>
			<fieldset style="margin-top:12px;padding:10px 5px 9px 12px;">
				<legend>Panel Assignment</legend>
				<div id="panelSwimlane"></div>
			</fieldset>
		</div>

		<div class="tab" style="overflow-y:scroll;height:255px;">
			<fieldset class="fm-dlg-sec-bg" style="margin-top:15px;padding:10px 5px 9px 12px;">
				<legend>Current Assignment</legend>
				<div id="panelAssignTask"></div>
				<div style="margin:4px 5px;text-align:right">
					<label>Estimated Time: </label><input id="tbTaskDays" class="fm" style="width:30px;" min="0" max="100" type="number" /><label> days, </label><input id="tbTaskHours" class="fm" style="width:30px;" min="0" max="23" type="number" /><label> hours</label>
				</div>
			</fieldset>
			<fieldset style="margin-top:12px;padding:10px 5px 9px 12px;">
				<legend>Global Schema Assignment</legend>
				<div id="panelGlobalTask"></div>
			</fieldset>
			<fieldset style="margin-top:12px;padding:10px 5px 9px 12px;">
				<legend>Panel Assignment</legend>
				<div id="panelSwimlaneTask" style="margin: 5px;">
					<label style="width: 120px; display: inline-block;">Assign to Role</label><label>= </label><input id="tbTaskRole" disabled="disabled" class="fm" style="width:273px;" />
				</div>
			</fieldset>
			
		</div>

		<div class="tab" style="padding:15px">

			<table id="panelTimeout" cellpadding="4" cellspacing="4" style="width:90%">
				<tr>
					<td class="n" style="width:120px">Use transition:</td>
					<td id="panelConnections"></td>
				</tr>
				<tr>
					<td class="n" style="width:120px">Raise after:</td>
					<td id="panelInterval"></td>
				</tr>
			</table>
			<a class="fm" id="btnTimeout" style="display:block;margin:5px;">Click to configure</a>
			
		</div>

		<div class="tab" style="padding:15px">
			<table cellpadding="4" cellspacing="4" width="100%">
				<colgroup><col width="120" /><col /></colgroup>	
				<tr>
					<td class="n">Final Title:</td>
					<td><input id="ftitle" class="fm" /></td>
				</tr>
				<tr>
					<td class="n" valign="top">Final Description:</td>
					<td><textarea id="fdesc" class="fm" rows="4"></textarea></td>
				</tr>
				
			</table>
		</div>
	</div>
</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
FMS.StateProperties= function(wnd) {
	wnd.setHeader("State Properties");
	FMS.Properties_BaseInit(this, wnd);

	// Presentation
	this.$ddlHandlerType= $("#ddlHandlerType", this.$p); 
	this.$tbHandlerValue= $("#tbHandlerValue", this.$p); 
	this.$ddlHandlerType.change($createDelegate(this.ddlHandlerType_onchange, this));

	// Assign State
	this.assign= new FMS.StateAssignContainer(this.$p, "panelAssignState", "panelGlobalState", "panelSwimlane", true);

	// Task
	this.$tabTask= $("#tabTask", this.$p); 
	this.assign2= new FMS.StateAssignContainer(this.$p, "panelAssignTask", "panelGlobalTask", "panelSwimlaneTask", false);
	this.$tbTaskRole= $("#tbTaskRole", this.$p);
	this.$tbTaskDays= $("#tbTaskDays", this.$p);
	this.$tbTaskHours= $("#tbTaskHours", this.$p);

	// Timeout
	this.$panelConnections= $("#panelConnections", this.$p)
	this.$panelInterval= $("#panelInterval", this.$p)
	this.$btnTimeout= $("a#btnTimeout", this.$p);
	this.$btnTimeout.addHandler('click', this.editTimeout, this);
	
	// Dialog Messages
	this.$ftitle= $("#ftitle", this.$p); 
	this.$fdesc= $("#fdesc", this.$p);
}

FMS.StateProperties.prototype= {

	LoadState: function(xd, item, lane) {
		this.xmlDoc= xd;
		FMS.Properties_BaseLoad(this, item);

		var $xn= $(this.xn);
		// Presentation
		var ui= this._ui= this.xn.getAttribute("ui")||'';
		var ui_type= '', ui_val= ''
		if (ui && ui.indexOf(':') != -1) { ui_type= ui.substr(0, ui.indexOf(':')); ui_val= ui.substr(ui.indexOf(':')+1); }
		this.$ddlHandlerType.val(ui_type); this.$tbHandlerValue.val(ui_val); 
		this.$tbHandlerValue.toggle(ui != '');

		// Assign State
		this.assign.LoadState(xd, $xn, "assign", $("settings", xd), lane);

		// Task
		this.allowTasks= (xd.documentElement.getAttribute('assignTasks')=='true');
		this.$tabTask.toggle(this.allowTasks);
		if (this.allowTasks) {
			this.assign2.LoadState(xd, $xn, "task", $("tasks", xd), -1);
			if (lane != -1) {
				var $xn_panels= $("panels", xd.documentElement);
				this.$tbTaskRole.val("'"+$xn_panels.children()[lane].getAttribute('role')+"'");
			}
			var d= 1; h= 0;
			var dd= $xn.attr("duedate");
			if (dd) { var duedate= parseInt(dd); h= duedate%24; d= (duedate-h)/24; }
			this.$tbTaskDays.val(d.toString()); this.$tbTaskHours.val(h.toString());
		}

		// Timeout
		this.$listConnections= null;
		this.$btnTimeout.show();
		this.$panelConnections.empty();
		this.$panelInterval.empty();
		this.duration= $xn.find("timeout").attr('duration');
		var info= "";
		var cinfo= "";
		if (this.duration) {
			var connections= item.connectionsOut;
			for (var i= 0; i < connections.length; i++) {
				var c= connections[i];
				if (c.type == 'timeout') {
					cinfo= c.targetItem.box.text||c.targetItem.box.name;
					if (c.title) cinfo+= " ("+c.title+")";
					break;
				}
			}
			info= this.durationToString();
		} else {
			cinfo= "Not set";
		}
		this.$panelConnections.html("<input disabled='disabled' class='fm' value='"+cinfo+"'/>");
		this.$panelInterval.html("<input disabled='disabled' class='fm' value='"+info+"'/>");
		
		// Dialog Messages
		this.$ftitle.val(xml_getAttribute(this.xn, 'ftitle')); 
		this.$fdesc.val(xml_getAttribute(this.xn, 'fdesc')); 
	},

	ddlHandlerType_onchange: function() {
		var h= this.$ddlHandlerType.val();
		var v= this.$tbHandlerValue.val();
		var name= this.item.box.name;
		if (h=='WORKFLOW') {
			this.$tbHandlerValue.val(name);
		} else if (h=='FORM') {
			this.$tbHandlerValue.val('default');
		} else {
			this.$tbHandlerValue.val('');
		}
		this.$tbHandlerValue.toggle(h != "");
	},

	durationToString: function () {
		var s= "";
		var d= this.duration;
		if (d.indexOf('.') != -1) { s= this.ToOneNumber(d.substr(0, d.indexOf('.'))) + " days"; d= d.substr(d.indexOf('.')+1); }
		var mas= d.split(':');
		if (mas[0] != '00') s+= (s?" and ":"") + this.ToOneNumber(mas[0]) + " hours";
		if (mas[1] != '00') s+= (s?" and ":"") + this.ToOneNumber(mas[1]) + " minutes";
		if (mas[2] != '00') s+= (s?" and ":"") + this.ToOneNumber(mas[2]) + " seconds";
		return s;
	},

	editTimeout: function() {
		this.$btnTimeout.hide();
		this.$listConnections= $("<select class='fm'></select>");
		var connections= this.item.connectionsOut;
		if (connections.length == 0) this.$listConnections.append("<option value=''>Not connected yet</option>");
		else {
			this.$listConnections.append("<option value=''>Not set</option>");
			for (var i= 0; i < connections.length; i++) {
				var c= connections[i];
				var name= c.targetItem.box.name;
				var title= c.targetItem.box.text||name;
				if (c.title) title+= " ("+c.title+")";
				var selected= (c.type == 'timeout') ? " selected='selected'" : "";
				this.$listConnections.append("<option value='"+name+"'"+selected+">"+title+"</option>");
			}
		}
		this.timeoutIndex= this.$listConnections[0].selectedIndex;
		this.$panelConnections.empty().append(this.$listConnections);

		var d= this.duration;
		if (!d) d= "00:00:00";
		var days= "00";
		if (d.indexOf('.') != -1) { days= d.substr(0, d.indexOf('.')); d= d.substr(d.indexOf('.')+1); }
		var mas= d.split(':');
		this.$panelInterval.empty();
		this.$tbDays= $("<input class='fm' style='width:24px' maxlength='3' type='number' value='"+this.ToOneNumber(days)+"'/>");
		this.$panelInterval.append(this.$tbDays).append("<label> days, </label>");
		this.$tbHours= $("<input class='fm' style='width:24px' maxlength='2' type='number' value='"+this.ToOneNumber(mas[0])+"'/>");
		this.$panelInterval.append(this.$tbHours).append("<label> hours, </label>");
		this.$tbMinutes= $("<input class='fm' style='width:24px' maxlength='2' type='number' value='"+this.ToOneNumber(mas[1])+"'/>");
		this.$panelInterval.append(this.$tbMinutes).append("<label> minutes, </label>");
		this.$tbSeconds= $("<input class='fm' style='width:24px' maxlength='2' type='number' value='"+this.ToOneNumber(mas[2])+"'/>");
		this.$panelInterval.append(this.$tbSeconds).append("<label> seconds </label>");
	},

	ToOneNumber: function(s) { return (s[0]=='0')?s[1]:s; },

	SaveState: function() {
		if (!FMS.Properties_BaseSave(this)) return false;
		var $xn= $(this.xn);

		// Presentation
		var ui_type= this.$ddlHandlerType.val();
		var ui_val= this.$tbHandlerValue.val().trim();
		var ui= (ui_type != '') ? (ui_type + ':' + ui_val) : '';
		if (this._ui != ui) {
			this.xn.setAttribute('ui', ui);
			this.item.box.handler= ui;
			this.item.box.ui_ico= ui_type.length;
			this._window.returnValue= true;
		}

		// Assign
		this.assign.SaveState(this.xmlDoc, $xn, "assign");

		// Task
		if (this.allowTasks) {
			this.assign2.SaveState(this.xmlDoc, $xn, "task");
			var dd= $xn.attr("duedate");
			var d= parseInt(this.$tbTaskDays.val());var h= parseInt(this.$tbTaskHours.val());
			var dd= (24*d+h);
			xml_updateAttribute(this.xn, "duedate", dd != 24 ? dd.toString() : "");
		}

		// Timeout
		if (this.$listConnections != null) {
			var newIndex= this.$listConnections[0].selectedIndex;
			var duration= null;
			if (newIndex > 0) {
				var pad= function(s) { 
					s= s.trim();
					if (!s) return '00';
					var n= parseInt(s)||0;
					return (n < 10 ? '0':'')+n.toString();
				}
				var days= pad(this.$tbDays.val());
				duration= pad(this.$tbHours.val())+':'+pad(this.$tbMinutes.val())+':'+pad(this.$tbSeconds.val());
				if (days != '00') duration= days+'.'+duration;
				if (duration == '00.00:00:00' || duration == '00:00:00') { duration= null; AX.Window.alert('Please, define Timeout interval.'); this.$tbHours.focus(); return false; }
			}
			var connections= this.item.connectionsOut;
			if (this.timeoutIndex > 0 && this.timeoutIndex != newIndex) { var c0= connections[this.timeoutIndex-1]; c0.type= null; c0.istimeout= false; c0.setTitle(''); }
			if (duration && newIndex > 0) {
				xml_getOrCreate(this.xmlDoc, $xn, 'timeout').attr('duration', duration);
				var c1= connections[newIndex-1]; c1.type= 'timeout'; c1.istimeout= true;
				this.duration= duration;
				if (!c1.title) c1.setTitle("after " + this.durationToString());
			} else if (this.duration) {
				$xn.find("timeout").remove();
			}
			this.item.changed= true;
			this._window.returnValue= true;
		}
		
		// Dialog Messages
		xml_updateAttribute(this.xn, "ftitle", this.$ftitle.val().trim());
		xml_updateAttribute(this.xn, "fdesc", this.$fdesc.val().trim());
		
		return true;
	}

}


</script>
