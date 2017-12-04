<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg" style="position:absolute;top:0px;left:0px;right:0px;bottom:33px;border: solid 1px #a59d9b;background-color:#fffbff;">
<fieldset>
	<legend class="sec">General Properties</legend>
	<table style="width: 100%; table-layout: fixed;" cellspacing="3">
		<colgroup><col width="140"/><col width="200"/><col /></colgroup>
		<tbody>
			<tr>
				<td class="n">Title:</td>
				<td><input id="tb_title" class="fm" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="n">Display Mode:</td>
				<td><label class="fm-chk"><input type="checkbox" class="fm-chk" id="cb_navigator" />Render top levels as buttons (Outlook style)</label></td>
			</tr>
			<tr>
				<td class="n">Startup Folder:</td>
				<td><dialogs:ProfileFolderControl id="lookup_folder" runat="server" /></td>
				<td style="padding-left:5px;">
					
				</td>
			</tr>
			<tr>
				<td class="n">Expand to level:</td>
				<td>
					<select id="list_level" class="fm">
						<option value="0">- 0 -</option>
						<option value="1">- 1 -</option>
						<option value="2">- 2 - (default)</option>
						<option value="3">- 3 -</option>
						<option value="4">- 4 -</option>
						<option value="5">- 5 -</option>
						<option value="6">- 6 -</option>
						<option value="7">- 7 -</option>
						<option value="10">max</option>
					</select> 
				</td>
			</tr>
			<tr>
				<td class="n">Tree Width:</td>
				<td>
					<select id="list_width" class="fm">
						<option value="100">100px</option>
						<option value="120">120px</option>
						<option value="140">140px</option>
						<option value="160">160px</option>
						<option value="180">180px</option>
						<option value="200">200px</option>
						<option value="210">210px</option>
						<option value="220">220px</option>
						<option value="230">230px</option>
						<option value="240">240px</option>
						<option value="0">250px (default)</option>
						<option value="270">270px</option>
						<option value="280">280px</option>
						<option value="290">290px</option>
						<option value="300">300px</option>
						<option value="310">310px</option>
						<option value="300">320px</option>
						<option value="330">330px</option>
						<option value="350">350px</option>
						<option value="370">370px</option>
						<option value="380">380px</option>
						<option value="400">400px</option>
						<option value="450">450px</option>
						<option value="500">500px</option>
					</select> 
				</td>
			</tr>
		</tbody>
	</table>
</fieldset>

<fieldset>
	<legend class="sec">Window Mask</legend>
	<table style="width: 100%; table-layout: fixed;" cellspacing="3">
		<colgroup><col width="140"/><col width="200"/><col /></colgroup>
		<tbody>
			<tr>
				<td colspan="3">
					<label class="comment">Use window mask template to generate window title with record data.</label>
				</td>
			</tr>
			<tr>
				<td class="n">
					Template:
				</td>
				<td>
					<input id="tb_mask" class="fm" />
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td colspan="2"><label class="comment">Example: Case #CaseNumber#, #JudjeName#</label></td>
			</tr>
			<tr>
				<td></td>
				<td>Source table name:</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><dialogs:TableLookupControl id="lookup_maskTable" runat="server" /></td>
				<td></td>
			</tr>

		</tbody>
	</table>
</fieldset>

<fieldset>
	<legend class="sec">Folder Counting</legend>
	<table style="width: 100%; table-layout: fixed;" cellspacing="3">
		<colgroup><col width="140"/><col width="200"/><col /></colgroup>
		<tbody>
			<tr>
				<td class="n">Auto refresh:</td>
				<td style="padding-left:5px;">
					<select id="list_refreshSec" class="fm">
						<option value="0" selected="selected">On load (default)</option>
						<option value="30">Each 30 seconds</option>
						<option value="60">Each 1 minute</option>
						<option value="120">Each 2 minutes</option>
						<option value="180">Each 3 minutes</option>
						<option value="300">Each 5 minutes</option>
						<option value="600">Each 10 minutes</option>
					</select>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2">
					<label class="comment">
					Note: Counting is refreshing after grid content changes.</label>
					<!--label class="fm-chk"><input type="checkbox" class="fm-chk" id="cb_refreshOnChange" />Refresh when grid content is reloading</label-->
				</td>
			</tr>
			
		</tbody>
	</table>
</fieldset>
</div>
<div id="_bottomButtons" style="position:absolute;bottom:4px;right:3px;">
	<%= AX.FM.Common.UI.Button.Render("saveX", "margin-left:5px;width:120px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;width:50px;", false)%>
</div>
<script type="text/javascript">
	RMC.ProfileFolderHandler= function() {
		this._window= AX.Window.createPopupWindow("Profile Folder Dialog", 350, 450, /*transp*/false, /*destroyOnclose*/true);
		this._window.setBackground("#FFF");
		this._window.show();
		var $tree= this.designer.$tree.clone();
		$tree.find("A.sel").removeClass('sel');
		this._window.$content.html($tree);

		var control= this;
		$tree.find("A").click(function() { control.setValue(this.getAttribute('n')); control._window.close(); });
	}

	RMC.ProfileProperties = function(designer, wnd) {
		this.designer= designer;
		this._window= wnd;

		var $p= this._window.$content;
		this.lookup_folder= new FM.LookupTextControl($("#lookup_folder", $p), null, RMC.ProfileFolderHandler);
		this.lookup_folder.designer= designer;
		this.lookup_maskTable= new FM.LookupTextControl($("#lookup_maskTable", $p));

		$("#_bottomButtons", $p).addHandler('click', this.btn_click, this);
	}
	RMC.ProfileProperties.prototype = {
		loadState: function() {
			var data = "{\"profileName\":\"" + this.designer.profileName + "\",\"groupName\":\"" + this.designer.groupName + "\"}";
			ExecuteService(data, FM.Path + "Explorer/ProfileBuilder/SupportService.asmx/LoadTreeProperties", $.proxy(this.loadState_complete, this));
		},
		loadState_complete: function(result) {
			var res = result.d;
			if (res.Error) { alert(res.Error); this._window.close(); return; }
			this.propObject = res;
			var $p = this._window.$content;
			$("#tb_title", $p).val(res.title).focus();
			$("#cb_navigator", $p).attr('checked', res.navigator);
			this.lookup_folder.setValue(res.folder);
			$("#list_level", $p).val(res.level);
			$("#list_width", $p).val(res.width);

			$("#tb_mask", $p).val(res.mask);
			this.lookup_maskTable.setValue(res.maskTable);

			$("#list_refreshSec", $p).val(res.refreshSec);
			//$("#cb_refreshOnChange", $p).attr('checked', res.refreshOnChange);
		},

		saveState: function() {
			var $p = this._window.$content;
			var o = this.propObject;
			var ps0 = JSON.stringify(o);
			o.title= $("#tb_title", $p).val().trim();
			o.navigator= $("#cb_navigator", $p).is(":checked");
			o.folder= this.lookup_folder.getValue();
			o.level= parseInt($("#list_level", $p).val());
			o.width= parseInt($("#list_width", $p).val().trim());

			o.mask= $("#tb_mask", $p).val().trim();
			o.maskTable= this.lookup_maskTable.getValue();

			o.refreshSec= parseInt($("#list_refreshSec", $p).val());
			//o.refreshOnChange= $("#cb_refreshOnChange", $p).is(":checked");

			var ps = JSON.stringify(o);
			if (ps != ps0) {// no changes
				var data = "{\"profileName\":\"" + this.designer.profileName + "\",\"groupName\":\"" + this.designer.groupName + "\",\"p\":" + ps + "}";
				ExecuteService(data, FM.Path + "Explorer/ProfileBuilder/SupportService.asmx/SaveTreeProperties", $.proxy(this.saveState_complete, this));
			} else {
				this._window.close();
			}
		},

		saveState_complete: function(result) {
			var res = result.d;
			if (res != "") alert(res);
			else this._window.close();
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "saveX": this.saveState(); break;
				case "X": this._window.close(); break;
			}
		}
	}
</script>