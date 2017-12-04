<%@ Control Language="C#" %>
<div class="fm-dlg fm-dlg-content" style="top:0;border:0;">
	<fieldset class="fm-dlg-sec-bg" style="padding:4px;margin:0px;">
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

	<div style="overflow-y:auto;height:100px;margin-top:2px;">

		<fieldset class="fm-dlg-sec-bg" style="margin-top:15px;padding:10px 5px 9px 12px;">
			<legend>Pair</legend>
			<div id="lblMessage" class="comment" style="margin-bottom:5px;">...</div>
			<select id="listLinks" class="fm" style="display:block;width:300px;margin-left:10px;"></select>
		</fieldset>
	</div>

</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
FMS.LinkProperties= function(wnd) {
	wnd.setSize(500, 300);
	FMS.Properties_BaseInit(this, wnd);

	this.$lblMessage= $("#lblMessage", this.$p);
	this.$listLinks= $("#listLinks", this.$p);
}

FMS.LinkProperties.prototype= {

	LoadState: function(xd, item, lane) {
		this.xmlDoc= xd;
		FMS.Properties_BaseLoad(this, item);
		var $xn= $(this.xn);
		this.currentName= this.xn.getAttribute('name');
		this.currentValue= this.xn.getAttribute('ui');
		this.$listLinks.empty();
		this.allowConnect= (item.connectionsOut.length == 0 && item.connectionsIn.length > 0);
		this.$listLinks.prop('disabled', !this.allowConnect);
		this.$listLinks.append("<option value='' style='font-style:italic'>not paired</option>");

		if (this.allowConnect) {
			this.$lblMessage.text(this.currentValue?'Paired LINK element:':'Please, select the target LINK element');
			this.loadLinks($(xd.documentElement));
		} else if (item.connectionsOut.length > 0) {
			this.$lblMessage.text('TARGET LINK: This element is using as a target LINK element');
			this.sourceLinks= "";
			this.findLinks($(xd.documentElement));
			if (this.sourceLinks != "") this.$listLinks.append("<option value='' selected='selected'>Paired with: "+this.sourceLinks+"</option>");
		} else {
			this.$lblMessage.text('Please, connect LINK element on the diagram with IN or OUT connections');
		}

	},

	loadLinks: function($xn) {
		var nodes= $xn.children("items").children();
		if (nodes.length == 0) return;
		for (var i= 0; i < nodes.length; i++) {
			var type= nodes[i].getAttribute("type");

			if (type == "Link") {

				var xnlink= nodes[i];
				var ui= xnlink.getAttribute('ui');
				var name= xnlink.getAttribute('name');
				if (ui || name == this.currentName) continue;
				var title= xnlink.getAttribute('title')||name;
				var value= "TO:"+name;
				var selected= (this.currentValue == value) ? " selected='selected'" : "";

				this.$listLinks.append("<option value='"+value+"'"+selected+">"+title+"</option>");

			} else if (type == "SubProcess") {

				this.loadLinks($(nodes[i]).children("inner_schema"));

			}
		}
	},

	findLinks: function($xn) {
		var nodes= $xn.children("items").children();
		if (nodes.length == 0) return;
		for (var i= 0; i < nodes.length; i++) {
			var type= nodes[i].getAttribute("type");

			if (type == "Link") {

				var xnlink= nodes[i];
				var ui= xnlink.getAttribute('ui');
				var name= xnlink.getAttribute('name');
				var targetName= (ui) ? ui.substr(3) : "";
				if (targetName && this.currentName == targetName) {
					if (this.sourceLinks != "") this.sourceLinks+= ", ";
					this.sourceLinks+= (xnlink.getAttribute('title')||name);
				}

			} else if (type == "SubProcess") {

				this.findLinks($(nodes[i]).children("inner_schema"));

			}
		}
	},

	SaveState: function() {
		if (!FMS.Properties_BaseSave(this)) return false;
		if (this.allowConnect) xml_updateAttribute(this.xn, 'ui', this.$listLinks.val());
		return true;
	}
}
</script>