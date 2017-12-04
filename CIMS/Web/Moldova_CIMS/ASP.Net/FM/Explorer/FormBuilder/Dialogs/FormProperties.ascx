<%@ Control Language="C#"%>
<div class="fm-dlg-tabbar">
	<span class="tab tabOn">Display</span><span class="tab">Automatization</span><span class="tab">Triggers</span>
</div>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;">
	<div class="tab" style="display:block">

		<table cellpadding="2" cellspacing="2" width="100%">
			<colgroup><col width="70"/><col width="100" /><col /></colgroup>	
			<tr>
				<td rowspan="12" valign="top"><img src="Images/48/field_editor.png" width="48" height="48" /></td>
				<td colspan="2">
					<div class="comment" style="height:18px">Specify the name and the title for the form</div>
				</td>
			</tr>
			<tr>
				<td class="req">Name:</td>
				<td><input id="tbName" disabled="disabled" class="fm"/></td>
			</tr>
			<tr>
				<td>Title:</td>
				<td><input id="tbTitle" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td valign="top">Description:</td>
				<td><textarea id="tbDescription" class="fm" style="height:60px"></textarea></td>
			</tr>
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr>
				<td>Window Mask:</td>
				<td><input id="tbWindowMask" class="fm" maxlength="100"/></td>
			</tr>
			<tr>
				<td></td>
				<td>Example: <label style="color:blue;font-style:italic">Record Info: #Field1#, #Field2#</label></td>
			</tr>

			<tr><td colspan="2">&nbsp;</td></tr>
			<tr>
				<td colspan="2"><div class="comment" style="height:18px">Specify Form layout properties</div></td>
			</tr>
			<tr>
				<td>Padding:</td>
				<td>
					<select class="fm" id="listPadding" style="width:125px">
						<option value="small">Small Template</option>
						<option value="medium">Medium Template</option>
						<option value="">Normal Template</option>
						<option value="big">Big Template</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Label width:</td>
				<td>
					<select class="fm" id="listLabelWidth" style="width:125px">
						<option value="80">80 px</option>
						<option value="90">90 px</option>
						<option value="100">100 px</option>
						<option value="110">110 px</option>
						<option value="120">120 px</option>
						<option value="130">130 px</option>
						<option value="">140 px (default)</option>
						<option value="150">150 px</option>
						<option value="160">160 px</option>
						<option value="180">180 px</option>
						<option value="200">200 px</option>
						<option value="240">240 px</option>
						<option value="260">260 px</option>
					</select>
				</td>
			</tr>
		</table>
		
	</div>
	<div class="tab">
		<div class="comment">To automatizate form, use script language of ECMAScript standard<br />and Form Object Model.</div>
		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td class="n" style="width:150px">On Load:</td>
				<td style="text-align:right"><label class="fm-chk"><input id="cbEventOnLoad" type="checkbox" class="fm-chk" />Is enabled</label>&nbsp;<label class="fm-chk"><input id="cbROEventOnLoad" type="checkbox" class="fm-chk" />for readonly</label></td>
			</tr>
		</table>
		<textarea id="tbEventOnLoad" class="fm" style="height:140px"></textarea>

		<table width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td class="n" style="width:150px">On Before Save:</td>
				<td style="text-align:right"><label class="fm-chk"><input id="cbEventOnSave" type="checkbox" class="fm-chk" />Is enabled</label></td>
			</tr>
		</table>
		<textarea id="tbEventOnSave" class="fm" style="height:100px"></textarea>

		<div style="font-weight:bold;margin-top:4px;color:#4f4f4f">Examples:</div>
		<div style="color:blue;line-height:16px;margin-left:2px;">
			<label style="color:black"> On Load:</label> var s= frm.getValue("field1"); frm.alert('Value for field1 is: ' + s);<br/>
			<label style="color:black"> On Before Save:</label> var s= frm.getValue("field2"); <br />if (s != '1') { frm.IsValid= false; frm.alert('Validation failed'); }
		</div>

		
		<div style="margin-top:8px;">
			<a id="linkScriptEditor" class="fm-btn" cmd="script-editor" style="">Define form's common functions</a>
			<a id="linkScriptHelp" class="fm-btn" cmd="script-help" style="margin-left:10px;">Form Documentation</a>
		</div>
	
	</div>

	<div class="tab">
		<div class="comment">While processing data you can fire server trigger <br />and make some DB manipulations with the data on the server side.</div>
		
		<div style="margin:20px">
			<span style="display:inline-block;width:100px;font-weight:bold;">OnLoad</span><label class="fm-chk"><input id="cbTriggerOnLoad" type="checkbox" class="fm-chk" /> enabled</label>
		</div>
		<div style="margin:20px">
			<span style="display:inline-block;width:100px;font-weight:bold;">OnBeforeSave</span><label class="fm-chk"><input id="cbTriggerOnBeforeSave" type="checkbox" class="fm-chk" /> enabled</label>
		</div>
		<div style="margin:20px">
			<span style="display:inline-block;width:100px;font-weight:bold;">OnAfterSave</span><label class="fm-chk"><input id="cbTriggerOnAfterSave" type="checkbox" class="fm-chk" /> enabled</label>
		</div>
		
	</div>

</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>
<script type="text/javascript">
	RMC.FB_FormProperties= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}

	RMC.FB_FormProperties.prototype = {
		
		initialize: function() {
			var $p= this.$p;
			this.tabBar= new FM.Tabbar($("div.fm-dlg-tabbar", $p));
			this.$tbTitle= $("#tbTitle", $p);
			this.$tbName= $("#tbName", $p);
			this.$tbDescription= $("#tbDescription", $p);
			this.$tbWindowMask= $("#tbWindowMask", $p);
			this.$listPadding= $("#listPadding", $p);
			this.$listLabelWidth= $("#listLabelWidth", $p);
			
			this.$cbEventOnLoad= $("#cbEventOnLoad", $p); this.$cbEventOnLoad.addHandler('change', function() { this.$tbEventOnLoad.prop('disabled', !this.$cbEventOnLoad.prop('checked')); }, this);
			this.$cbEventOnSave= $("#cbEventOnSave", $p); this.$cbEventOnSave.addHandler('change', function() { this.$tbEventOnSave.prop('disabled', !this.$cbEventOnSave.prop('checked')); }, this);
			this.$tbEventOnLoad= $("#tbEventOnLoad", $p);
			this.$tbEventOnSave= $("#tbEventOnSave", $p);
			this.$cbROEventOnLoad= $("#cbROEventOnLoad", $p);

			this.$cbt1= $("#cbTriggerOnLoad", $p);
			this.$cbt2= $("#cbTriggerOnBeforeSave", $p);
			this.$cbt3= $("#cbTriggerOnAfterSave", $p);
			
			var btn_click= $createDelegate(this.btn_click, this);
			this.$linkScript= $("#linkScriptEditor", $p); this.$linkScript.click(btn_click);
			$("#linkScriptHelp", $p).click(btn_click);
			$("div.fm-dlg-buttons", $p).click(btn_click);
		},
		
		LoadState: function(designer, tabIndex) {
			this._window.show();
			this.designer= designer;
			this.$xnform= designer.$xnform;
			this.$xnheader= this.$xnform.children("header");
			this.$xndesc= this.$xnform.children("description");
			
			this.tabBar.select(tabIndex);
			
			//
			this.$tbTitle.val(this.$xnheader.attr('title'));
			this.$tbName.val(this.designer.formName);
			this.$tbDescription.val(this.$xndesc.attr('title'));
			this.$tbWindowMask.val(this.$xnform.children("windowMask").text());

			this.$listPadding.val(this.$xnform.attr('padding'));
			this.$listLabelWidth.val(this.$xnform.attr('labelwidth'));

			//
			this.scriptUrl= this.$xnform.find("handlers").attr("scriptUrl");
			this.$linkScript.text(this.scriptUrl?("Library: "+this.scriptUrl):"Define form's internal functions");

			var $xn_onloadscript= this.$xnform.find("handlers onloadscript");
			var $xn_onsavescript= this.$xnform.find("handlers onsavescript");
			this.$tbEventOnLoad.val($xn_onloadscript.text()); this.$cbEventOnLoad.prop('checked', $xn_onloadscript.attr('enabled') != "false");
			this.$tbEventOnSave.val($xn_onsavescript.text()); this.$cbEventOnSave.prop('checked', $xn_onsavescript.attr('enabled') != "false");
			this.$cbROEventOnLoad.prop('checked', $xn_onloadscript.attr('enablereadonly') == "true");
			//
			this.$cbEventOnLoad.change();
			this.$cbEventOnSave.change();

			//
			this.$xnt= this.$xnform.children("triggers");
			var cbt1= this.$xnt.attr('onload');var cbt2= this.$xnt.attr('onbeforesave');var cbt3= this.$xnt.attr('onaftersave');
			this.$cbt1.prop('checked', cbt1=='true');this.$cbt2.prop('checked', cbt2=='true');this.$cbt3.prop('checked', cbt3=='true');
			//

			this._window.show();
			if (tabIndex == 0) this.$tbTitle.focus();
		},

		SaveState: function() {
			//
			var xd= this.designer.xmlDoc;

			var title= this.$tbTitle.val().trim();
			(xml_getOrCreate(xd, this.$xnform, "header")).attr('title', title);
			
			var desc= this.$tbDescription.val().trim();
			(xml_getOrCreate(xd, this.$xnform, "description")).attr('title', desc);

			var mask= this.$tbWindowMask.val().trim();
			xml_updateNode(xd, this.$xnform, "windowMask", mask);
			
			xml_updateAttr(this.$xnform, 'padding', this.$listPadding.val());
			xml_updateAttr(this.$xnform, 'labelwidth', this.$listLabelWidth.val());

			//
			this.updateScript("onloadscript", this.$tbEventOnLoad, this.$cbEventOnLoad, this.$cbROEventOnLoad);
			this.updateScript("onsavescript", this.$tbEventOnSave, this.$cbEventOnSave);
			var $xnhandlers= this.$xnform.children("handlers");
			if (!$isNull($xnhandlers) && $xnhandlers.children().length == 0) $xnhandlers.remove();

			//
			this.$xnt= this.$xnform.children("triggers");
			var cbt1= this.$cbt1.is(':checked');var cbt2= this.$cbt2.is(':checked');var cbt3= this.$cbt3.is(':checked');
			if (cbt1 || cbt2 || cbt3) {
				if (this.$xnt.length == 0) this.$xnt= xml_appendNode(xd, this.$xnform, "triggers");
				this.$xnt.attr('onload', cbt1).attr('onbeforesave', cbt2).attr('onaftersave', cbt3);
			} else {
				if (this.$xnt.length == 1) this.$xnt.remove();
			}
			//
			
			return true;
		},

		updateScript: function(name, $tbEvent, $cbEvent, $cbROEvent) {
			var $xn_script= this.$xnform.find("handlers " + name);
			var s= $tbEvent.val().trim();
			var enabled= $cbEvent.prop('checked');

			if (s != "") {
				if ($isNull($xn_script)) $xn_script= xml_appendNode(this.designer.xmlDoc, xml_getOrCreate(this.designer.xmlDoc, this.$xnform, "handlers"), name);
				$xn_script.text(s);
				xml_updateAttr($xn_script, 'enabled', enabled?"":"false");
				if ($cbROEvent) xml_updateAttr($xn_script, 'enablereadonly', $cbEvent.prop('checked')?"true":"");
			} else if (!$isNull($xn_script)) {
				$xn_script.remove();
			}
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "script-editor": openStdWin(RMC.Path + "FormBuilder/Dialogs/ScriptEditor.aspx?t="+this.designer.tableName+"&f="+this.designer.formName+((this.scriptUrl)?("&scriptUrl="+this.scriptUrl):""), "ScriptEditor", 700, 610); break;
				case "script-help": window.open(RMC.Path + "FormBuilder/Dialogs/help.html", "ScriptEditor", "width=700,height=630,top=200,left=150,status=0,resizable=1,scrollbars=1"); break;
				case "OK": this.SaveState(); this._window.close(); break;
				case "X": this._window.close(); break;
			}
			
		}
	}
</script>