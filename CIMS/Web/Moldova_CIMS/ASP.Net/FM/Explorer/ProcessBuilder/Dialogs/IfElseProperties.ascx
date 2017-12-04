<%@ Control Language="C#" %>
<div class="fm-dlg fm-dlg-content" style="top:0;border:0;">
	<fieldset class="fm-dlg-sec-bg" style="padding:4px;margin-top:5px;">
		<table cellpadding="3" cellspacing="3" width="100%">
			<colgroup><col width="70"/><col width="80" /><col /></colgroup>	
			<tr>
				<td rowspan="3" valign="top"><img src="Images/48/field_editor.png" width="48" height="48" /></td>
				<td class="n">Title:</td>
				<td><input id="tbTitle" class="fm" maxlength="100" style="font-size:10pt;height:22px;"/></td>
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

	<fieldset class="fm-dlg-sec" style="margin-top:15px;padding:10px;">
		<legend>Main branch connection</legend>
		<div class="comment" style="margin-bottom:5px;">When conditions below are TRUE, go to this state</div>
		<select id="listConnections" class="fm" style="display:block;width:200px;margin-left:10px;"><option value="0">State1</option><option value="1">State2</option></select>
	</fieldset>

	<fieldset class="fm-dlg-sec" style="margin-top:15px;">
		<legend>Conditions</legend>
		<div id="panelConditions" style="overflow-y:auto;height:100px;margin-top:2px;">
			<div style='margin:3px 0px 5px 10px;'><label style='width:160px;font-weight:bold;display:inline-block;color:#0464d0;'></label><select class="fm" style="width:95px"><option value='eq'>equal</option><option value='ne'>not equal</option></select><input class='fm' style='width:170px;margin-left:10px'/><img cmd='select' style='vertical-align:bottom;margin-left:2px;cursor:pointer' src='/ASP.Net/FM/Common/Images/btn_lookup_off.gif' /><img cmd="delete" style='vertical-align:bottom;margin-left:20px;cursor:pointer' src='/ASP.Net/FM/Common/Images/16_delete.gif' /></div>
		</div>
	</fieldset>

</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
FMS.IfElseProperties= function(wnd) {
	wnd.setSize(550, 420);
	FMS.Properties_BaseInit(this, wnd);

	this.assign= new FMS.AssignPanel($("#panelConditions", this.$p), true);
	this.assign.saveFieldXml= this.saveFieldXml;
	this.assign.emptyMessage= "No conditions";

	this.$listConnections= $("select#listConnections", this.$p)
}

FMS.IfElseProperties.prototype= {

	LoadState: function(xd, item, lane) {
		this.xmlDoc= xd;
		this.assign.xmlDoc= xd;
		FMS.Properties_BaseLoad(this, item);
		
		var $xn= $(this.xn);
		this.assign.clear();
		var $xn_conditions= $("conditions:first", $xn);
		var $xn_group= $("group:first", $xn_conditions);

		// TRUE branch
		//
		var groupSink= $xn_group.attr('sink');
		this.$listConnections.empty();
		var connections= item.connectionsOut;
		if (connections.length == 0) this.$listConnections.append("<option value=''>Not connected yet</option>");
		for (var i= 0; i < connections.length; i++) {
			var c= connections[i];
			var name= c.targetItem.box.name;
			var title= c.targetItem.box.text||name;
			var selected= (groupSink == name) ? " selected='selected'" : "";
			this.$listConnections.append("<option value='"+name+"'"+selected+">"+title+"</option>");
		}

		// conditions
		//
		var xn_fields= $xn_group.children();
		for (var i= 0; i < xn_fields.length; i++) {
			var xnf= xn_fields[i];
			var name= xnf.getAttribute('attribute');
			var value= xnf.getAttribute('value');
			var text= xnf.getAttribute('displayValue');
			var op= xnf.getAttribute('operator');
			
			var tb= this.assign.appendHtmlField(xnf, name, value, text);
			tb.prevValue= null; // skip value checking on save
			$(tb.previousSibling).val(op);
		}
		this.assign.showEmptyMessage();
	},

	SaveState: function() {
		if (!FMS.Properties_BaseSave(this)) return false;
		var $xn= $(this.xn);
		var $xn_conditions= $("conditions:first", $xn);
		if ($xn_conditions.length == 0) $xn_conditions= xml_appendNode(this.xmlDoc, $(this.xn), "conditions");
		var $xn_group= $("group:first", $xn_conditions);
		if ($xn_group.length == 0) $xn_group= xml_appendNode(this.xmlDoc, $xn_conditions, "group");

		// TRUE branch
		//
		var prevSink= $xn_group.attr('sink');
		var newSink= this.$listConnections.val();
		if (newSink != prevSink) {
			this.item.changed= true;
			this._window.returnValue= true;
			$xn_group.attr('sink', newSink);
			// set TRUE label
			var connections= this.item.connectionsOut;
			if (connections.length > 0) {
				var i= this.$listConnections[0].selectedIndex;
				var c_true= connections[i];
				if (!c_true.title) c_true.title= '[TRUE]';
				if (connections.length == 2) {
					var c_false= connections[i==0?1:0];
					if (c_false.title == '[TRUE]') c_false.title= '';
				}
			}
		}

		// conditions
		//
		this.assign.SaveState(this.xmlDoc, null, true, $xn_group);

		return true;
	},
	
	saveFieldXml: function($xn_assign, xnf, tb, value, text) {
		var fieldName= tb.fieldName;
		var op= tb.previousSibling.value;

		if (xnf == null) {
			xnf= xml_appendNode(this.xmlDoc, $xn_assign, 'field')[0];
			xnf.setAttribute('attribute', fieldName);
		}
		xnf.setAttribute('operator', op);
		xnf.setAttribute('value', value);
		xml_updateAttribute(xnf, 'displayValue', text);
	}
	
}
</script>