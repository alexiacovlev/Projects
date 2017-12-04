<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-hdr">
	<label>Use this dialog to modify branch conditions for a workflow Switch element</label>
</div>
<div class="fm-dlg fm-dlg-content">
	<div style="padding:2px;margin:5px;font-size:9pt;height:270px;overflow-y:auto">
		<div style="font-weight:bold">When </div>
			<div id="panelBranches"></div>
			<div style="text-align:left;margin:10px;"><a class="fm-link" id="btnAdd">add conditional branch</a></div>
			<div style="font-weight:bold;">Otherwise </div>
			<div style="padding:8px 15px;" id="lblOtherwise">...</div>
		</div>
	</div>

</div>

<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
</div>