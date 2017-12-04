<%@ Page Language="C#"%>
<%@ Register TagPrefix="ui" Namespace="AX.FM.Common.UI" Assembly="AX.FM.Common" %>
<div style="position:absolute;top:0;left:0;right:0;bottom:30px;outline:none;" tabindex="1">
	<div id="tabBar" class="rmc-fb-tabbar fm-dlg-tabbar" style="position:absolute;right:205px;left:2px;"></div>
	<div id="tabPanel" class="fm-dlg-tabs fm-dlg" style="position:absolute;bottom:6px;left:2px;right:205px;overflow-y:scroll;outline:0" tabIndex="0"></div>

	<div class="rmc-toolbar-hdr" style="top:0;right:0;width:200px;"><label style="cursor:pointer" id="linkSettings">Fields</label></div>
	<div id="toolbarFields" class="rmc-toolbar-body" style="top:24px;bottom:186px;right:0;width:200px;">
	</div>
	<div class="rmc-toolbar-hdr" style="bottom:157px;right:0;width:200px;border-top:solid 1px #94a6b5;"><label>Hidden fields</label></div>
	<div id="toolbarHidden" class="rmc-toolbar-body" style="bottom:6px;height:150px;right:0;width:200px;">
	</div>
	<div id="dragElement" class='rmc-fb-drag' style='position:absolute;z-index:1000;width:300px;display:none;'>
		<div class="text"></div>
		<div class="comment"></div>
	</div>
</div>

<div class="fm-dlg-footer">
	<label id="lblInfo" style="font-weight:bold;color:#463474;position:absolute;bottom:10px;right:330px;display:none;"></label>
	<div style="position:absolute;bottom:5px;left:5px;">
		<%= AX.FM.Common.UI.Button.Render("properties", "Form Properties", "Menu/16_edit.png", "width:135px", false) %>
		&nbsp;
		<img id="linkEvent" src="Images/event.png" width="16" height="16" class="fm-ico" title="The form has OnLoad or OnSave client event(s)" style="display:none;vertical-align:middle" />
		<img id="linkTriggers" src="Images/trigger.png" width="16" height="16" class="fm-ico" title="The form contains server trigger(s)" style="display:none;vertical-align:middle;margin-left:5px;margin-top:-2px" />
	</div>
	<div style="position:absolute;bottom:5px;right:5px;">
		<%= AX.FM.Common.UI.Button.Render("save", "", false) %>
		<%= AX.FM.Common.UI.Button.Render("saveX", "margin-left:5px;", true) %>
		<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
	</div>
</div>