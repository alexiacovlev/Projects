<%@ Control Language="C#" %>
<style>
	div#_menu a { padding:4px;margin-top:1px;color:#1a3da0; }
	div#_menu img { margin-right:5px; }
</style>
<div style="background-color: #eaeaea">
	<div style="position: absolute; top:0;bottom:32px;width:240px;border:solid 1px #a59d9b">
		<div class="fm-toolbar" style="position:absolute;width:100%;height:24px;">
			<div id="_toolbar" class="fm-menu" style="margin-left:2px;">
			<%= AX.FM.Common.UI.Button.RenderMenuItem("add", "Add item", "Menu/16_plus.png")%>
			<%= AX.FM.Common.UI.Button.RenderMenuItem("up", "", "../../Explorer/Images/16_up.png", "Move Up")%>
			<%= AX.FM.Common.UI.Button.RenderMenuItem("down", "", "../../Explorer/Images/16_down.png", "Move Down")%>
			<%= AX.FM.Common.UI.Button.RenderMenuItem("delete", "Delete", "Menu/16_delete.png")%>
			</div>
		</div>
		<div style="position:absolute;width:100%;top:24px;bottom:0;">
			<div id="_menu" class="fm_list" style="height: 100%;overflow-y:auto;border:0;">
				
			</div>
		</div>
	</div>
	<div style="position:absolute;top:0;left:243px;right:0px;bottom:32px;border:solid 1px #a59d9b">
		<div class="fmNavHeader fm-toolbar" style="width: 100%; height: 24px;">
			<label style="font-size:9pt;position:relative;font-weight:normal;font-style:italic">Menu Item Properties</label>
		</div>
		<div style="width:100%;background-color:#FFF;position:absolute;top:24px;bottom:0;" class="fm-dlg">
			<table id="_itemProperties" style="width: 100%; table-layout: fixed;" cellspacing="5" cellspacing="3">
				<colgroup>
					<col width="125" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<td class="n">
							Title:
						</td>
						<td>
							<input id="itemTitle" class="fm" />
						</td>
					</tr>
					<tr>
						<td class="n">
							Icon:
						</td>
						<td>
							<div style="position:relative;">
								<span id="itemImage"></span>
								<input id="itemImage_tb" class="fm" style="width:130px;position:absolute;right:0;" />
							</div>
						</td>
						
					</tr>
					<tr>
						<td class="n">
							Command:
						</td>
						<td>
							<select id="itemCommand" class="fm">
								<option value="EDIT">OPEN (dbl-click action)</option>
								<option value="CREATE">CREATE (Form)</option>
								<option value="FORM">FORM (Form)</option>
								<option value="WORKFLOW">WORKFLOW</option>
								<option value="PROFILE">PROFILE</option>
								<option value="NAVIGATOR">NAVIGATOR</option>
								<option value="STATEPROCESS">STATEPROCESS</option>
								<option value="PROCESS">PROCESS</option>
								<option value="URL">Open URL</option>
								<option value="PRINT">Print Record Form</option>
								<option value="SET">SET (Modify record(s) with preset)</option>
								<option value="SERVERCONTROL">Custom Server Control</option>
								<option value="CLIENTCONTROL">JScript Control</option>
								<option value="SL">Silverlight Control</option>
								<option value="">MENU SEPARATOR</option>
							</select>
						</td>
						
					</tr>
					<tr>
						<td class="n">
							Value:
						</td>
						<td>
							<input id="itemValue" class="fm" />
						</td>
						
					</tr>
					<tr>
						<td class="n">
							Parameters:
						</td>
						<td>
							<input id="itemAttributes" class="fm" />
						</td>
						
					</tr>
					<tr>
						<td class="n">
							Window Size:
						</td>
						<td>
							<div id="itemWindow"></div>
						</td>
						
					</tr>
					<tr>
						<td class="n">
							Visibility:
						</td>
						<td>
							<label class="fm-chk"><input type="checkbox" id="item_Toolbar" />Show in the horizontal toolbar</label>&nbsp;&nbsp;
							<label class="fm-chk"><input type="checkbox" id="item_Toolbar_Text" />Show button label</label>
							<br />
							<label class="fm-chk"><input type="checkbox" id="item_MoreActions" />Show in the 'More Actions' drop down menu</label>
						</td>
						
					</tr>
					
				</tbody>
			</table>
		</div>
	</div>
	<div id="_bottomButtons" style="position:absolute;bottom:4px;right:3px;">
		<label id="lblMenuInfo" style="font-weight:bold;color:#463474;margin-right:10px;display:none;"></label>
		<%= AX.FM.Common.UI.Button.Render("saveX", "margin-left:5px;", true) %>
		<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
	</div>

</div>