<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg fm-dlg-tabs" style="top:0;bottom:30px;">
	<fieldset class="fm-dlg-sec-bg" style="padding:8px">
		<legend>Title</legend>
		<table cellpadding="1" cellspacing="1" width="100%">
			<colgroup><col width="70"/><col /></colgroup>	
			<tr>
				<td rowspan="6" valign="top"><img src="Images/48/field_editor.png" width="48" height="48" /></td>
				<td>
					<div class="comment" style="height:18px">Specify the title for the section</div>
				</td>
			</tr>
			<tr>
				<td><dialogs:AdminResTitleControl ID="tbTitle" runat="server" /></td>
			</tr>
			<tr>
				<td style="text-align:right;padding-right:5px;">
					<input id="tbName" type="text" class="fm" maxlength="100" style="width:200px;display:none;"/>
					<a id="linkName" class="fm">...</a>
				</td>
			</tr>
			<tr>
				<td style="padding-top:12px">
					<div class="comment">Specify visibility state and decoration for the label</div>
				</td>
			</tr>
			<tr>
				<td>
					<label><input id="cbShowLabel" type="checkbox" class="fm-chk" /> Show the title for the section on the form</label>
				</td>
			</tr>
			<tr>
				<td id="panelDecoration" style="padding:2px 0 0 20px">
					<label class="fm-chk"><input class="fm-chk" type="radio" name="Decoration" value="" />None</label>
					<label class="fm-chk"><input class="fm-chk" type="radio" name="Decoration" value="line" />Underline section title</label>
					<label class="fm-chk"><input class="fm-chk" type="radio" name="Decoration" value="outline" />Outline section</label>
				</td>
			</tr>
		</table>
		
	</fieldset>

	<fieldset style="margin-top:12px;padding:8px 5px 5px 5px;">
		<legend>Layout</legend>
		<label class="comment">Select the number of columns</label>
		<table id="panelLayout" cellpadding="0" cellspacing="0" style="width:390px;margin:2px 0 5px 5px">
			<colgroup><col /><col /></colgroup>	
			<tr>
				<td style="text-align:center"><label><input type="radio" name="Columns" value="2" style="margin:5px 8px 0 0;" />Two column<br /><img src="Images/layout/section_columns_2.png" width="100" height="36" style="margin-left:20px;margin-top:2px;" /></label></td>
				<td style="text-align:center"><label><input type="radio" name="Columns" value="3" style="margin:5px 8px 0 0;" />Three columns<br /><img src="Images/layout/section_columns_3.png" width="100" height="36" style="margin-left:20px;margin-top:2px;" /></label></td>
			</tr>
		</table>

		<div style="margin-top:8px;">
			<label class="comment">Specify label width:</label>
			<select class="fm" id="listLabelWidth" style="width:70px;margin-right:20px">
				<option value="60">60 px</option>
				<option value="80">80 px</option>
				<option value="90">90 px</option>
				<option value="100">100 px</option>
				<option value="110">110 px</option>
				<option value="120">120 px</option>
				<option value="130">130 px</option>
				<option value="">inherit</option>
				<option value="150">150 px</option>
				<option value="160">160 px</option>
				<option value="180">180 px</option>
				<option value="200">200 px</option>
				<option value="240">240 px</option>
				<option value="260">260 px</option>
				<option value="300">300 px</option>
			</select>
		
			<label class="comment">and top intendation:</label>
			<select id="listMarginTop" class="fm" style="width:60px;">
				<option value="">0 px</option>
				<option value="5">5 px</option><option value="10">10 px</option><option value="20">20 px</option><option value="30">30 px</option><option value="40">40 px</option><option value="50">50 px</option><option value="100">100 px</option>
			</select>
		</div>

	</fieldset>

	<fieldset style="margin-top:12px;padding:8px 5px 5px 5px;">
		<legend>Visibility State</legend>
		<label class="comment">Specify the state for the section on form loading</label>
		<div id="panelVisibility" style="padding:8px 0 5px 20px">
			<label class="fm-chk"><input class="fm-chk" type="radio" name="Visibility" value="" />Visible</label>
			<label class="fm-chk" style="margin-left:10px;"><input class="fm-chk" type="radio" name="Visibility" value="false" />Hidden</label>
		</div>
		<label class="comment">Specify the position on the form</label>
		<div style="padding:8px 0 5px 20px">
			<select id="listTabs" class="fm" style="width:150px"><option>General</option></select>
		</div>
		<div id="panelCommands">
			<a class="fm" style="" cmd="moveup">move up</a>
			<a class="fm" style="margin-left:3px;" cmd="movedown">move down</a>
			<a class="fm" style="margin-left:10px;" cmd="delete">delete section</a>
		</div>
	</fieldset>

	<div style="position:absolute;bottom:8px;left:10px;" >
		
	</div>
	

</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>
<script type="text/javascript">
	RMC.FB_SectionProperties= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}
	RMC.FB_SectionProperties.prototype = {
		
		initialize: function() {
			var $p= this.$p;
			this.$tbTitle= $("#tbTitle", $p);
			this.resTitle= new FM.ResTitle(this.$tbTitle);
			this.$tbName= $("#tbName", $p);
			this.$linkName= $("#linkName", $p);
			
			this.$cbShowLabel= $("#cbShowLabel", $p);
			this.panelDecoration= new FM.RadioGroup($("#panelDecoration", $p));
			this.panelLayout= new FM.RadioGroup($("#panelLayout", $p));
			this.$listMarginTop= $("#listMarginTop", $p);
			this.$listLabelWidth= $("#listLabelWidth", $p);
			this.panelVisibility= new FM.RadioGroup($("#panelVisibility", $p));
			this.$listTabs= $("#listTabs", $p);
			
			$("div.fm-dlg-buttons", $p).addHandler('click', this.btn_click, this);
			$("div#panelCommands", $p).addHandler('click', this.commands_click, this);
		},

		LoadState: function(designer, $xnsec, section) {
			this._window.show();
			this.$xnsec= $xnsec;
			this.designer= designer;
			this.section= section;

			this._window.show();

			this.title0= this.$xnsec.attr('title');
			this.$tbTitle.val(this.title0).focus();
			this.resTitle.setResValue(this.$xnsec.attr('restitle'));
			
			this.name0= this.$xnsec.attr('name');
			this.$tbName.val(this.name0);
			this.$linkName.text(this.name0);
			
			this.showlabel0= $xnsec.attr('showlabel') != 'false';
			this.$cbShowLabel.prop('checked', this.showlabel0);

			this.decoration0= $xnsec.attr('decoration')||'';
			this.panelDecoration.setValue(this.decoration0);

			this.columns0= $xnsec.attr('columns')||'2';
			this.panelLayout.setValue(this.columns0);

			this.visible0= $xnsec.attr('visible')||'';
			this.panelVisibility.setValue(this.visible0);

			this.marginTop0= $xnsec.attr('marginTop')||'';
			this.$listMarginTop.val(this.marginTop0);

			this.$listLabelWidth.val($xnsec.attr('labelwidth')||'');
			
			this.loadTabPos();
		},

		SaveState: function() {
			var $xnsec= this.$xnsec;
			var redrawHeader= false;
			var redrawBody= false;

			var title= this.$tbTitle.val().trim();
			$xnsec.attr('title', title); if (title != this.title0) redrawHeader= true;
			xml_updateAttr($xnsec, 'restitle', this.resTitle.getResValue());

			var showlabel= this.$cbShowLabel.prop('checked');
			$xnsec.attr('showlabel', showlabel); if (showlabel != this.showlabel0) redrawHeader= true;

			var decoration= this.panelDecoration.getValue();
			$xnsec.attr('decoration', decoration); if (decoration != this.decoration0) redrawHeader= true;

			var visible= this.panelVisibility.getValue();
			xml_updateAttr($xnsec, 'visible', visible); if (visible != this.visible0) redrawHeader= true;

			var marginTop= this.$listMarginTop.val();
			xml_updateAttr($xnsec, 'marginTop', marginTop); if (marginTop != this.marginTop0) redrawBody= true;
			var labelWidth= this.$listLabelWidth.val();
			xml_updateAttr($xnsec, 'labelwidth', labelWidth);

			if (this.updateColumnsCount($xnsec)) redrawBody= true;

			
			var newIndex= this.$listTabs[0].selectedIndex;
			if (newIndex != this.tabIndex) {
				var $xn_sections= this.$xnsec.parent();
				var $xn_tab= $xn_sections.parent();
				var $xn_tabnew= $($xn_tab.parent().children()[newIndex]);
				this.$xnsec.remove();
				($xn_tabnew.children()[0]).appendChild(this.$xnsec[0]);

				var $sec= $(this.section);
				var $tab= $sec.parent();
				var $tabnew= $($tab.parent().children()[newIndex]);
				var tab_children= $tabnew.children();
				$sec.remove();
				$sec.insertBefore($(tab_children[tab_children.length-1]));
			}
			

			return {redrawHeader:redrawHeader, redrawBody:redrawBody};
		},

		updateColumnsCount: function ($xnsec) {
			var columns= this.panelLayout.getValue();
			if (columns != this.columns0) {
				var rows= $xnsec.find(":first").children();
				var rowCount= rows.length;
				// expand from 2 to 3 rows
				if (this.columns0 == '2' && columns == '3') {
					for (var i= 0; i < rowCount; i++) xml_appendNode(this.designer.xmlDoc, $(rows[i]), "cell");
					$xnsec.attr('columns', columns);
					return true;

				// collapse from 3 to 2 if possible
				} else if (this.columns0 == '3' && columns == '2') {
					// check if row has empty cell to remove it
					var processed= 0;
					for (var i= 0; i < rowCount; i++,processed++) {
						var cells= $(rows[i]).children();
						var hasempty= false;
						for (var c= 0; c < cells.length; c++) if (!cells[c].getAttribute('name'))  { hasempty= true; break; }
						if (!hasempty) break;
					}
					// remove last cell if possible
					if (processed == rowCount) {
						for (var i= 0; i < rowCount; i++,processed++) {
							var cells= $(rows[i]).children();
							for (var c= 0; c < cells.length; c++) if (!cells[c].getAttribute('name')) { $(cells[c]).remove(); break; }
						}

						$xnsec.attr('columns', columns);
						return true;
					}
				}

				AX.Window.alert('Section layout changing', 'Sorry, we cannot change the section layout.</br>Please, remove the fields from the third column and try again.');
			}

			return false;
		},

		loadTabPos: function() {
			var xn_tab= this.$xnsec.parent().parent();
			var xn_tabs= xn_tab.parent().children();
			this.$listTabs.empty();
			this.tabName= xn_tab[0].getAttribute('name');
			this.tabIndex= 0;
			for (var i= 0; i < xn_tabs.length; i++) {
				var xn= xn_tabs[i];
				var name= xn.getAttribute('name');
				var sel= "";
				if (this.tabName == name) { this.tabIndex= i; sel= " selected='selected'"}
				this.$listTabs.append("<option value='"+name+"'"+(this.tabName == name ? " selected='selected'":"")+">TAB: "+xn.getAttribute('title')+"</option>");
			}
		},
		move: function(dir) {
			var $sec= $(this.section);
			if (dir == 'up') {
				if (this.$xnsec.prev().length == 0) return;
				this.$xnsec.insertBefore(this.$xnsec.prev());
				$sec.insertBefore($sec.prev());
			} else if (dir == 'down') {
				if (this.$xnsec.next().length == 0) return;
				this.$xnsec.insertAfter(this.$xnsec.next());
				$sec.insertAfter($sec.next());
			}
		},

		commands_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "delete": AX.Window.confirm("Delete Section", "Are you sure you want to delete the section from the form?", this.deleteSection, this);break;
				case "moveup": this.move('up');break;
				case "movedown": this.move('down');break;
			}
		},

		deleteSection: function() {
			$(this.section).remove();

			this.$xnsec.remove();
			this._window.close();
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": this._window.returnValue= this.SaveState(); this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}
	}
</script>