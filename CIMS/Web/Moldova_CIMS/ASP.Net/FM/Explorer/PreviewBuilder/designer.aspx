<%@ Page Language="C#"%>
<%@ Register TagPrefix="ui" Namespace="AX.FM.Common.UI" Assembly="AX.FM.Common" %>

<div class="fm-dlg-header">
	<h1 id="dlgTitle">Preview Builder</h1>
	<label>Move field cells from the right panel to the layout area.</label>
</div>

<div style="position:absolute;top:60px;bottom:40px;width:100%;">
	<table class="rmc-prw-table" style="table-layout:fixed;width:100%;height:100%" cellpadding="4" cellspacing="4">
		<colgroup><col /><col /></colgroup>
		<tr>
			<td></td>
			<td></td>
		</tr>
	</table>
</div>

<div class="fm-dlg-footer">
	<label id="lblInfo" style="font-weight:bold;color:#463474;position:absolute;bottom:10px;left:10px;display:none;"></label>
	<div style="position:absolute;bottom:5px;right:5px;">
		<%= AX.FM.Common.UI.Button.Render("save", "", false) %>
		<%= AX.FM.Common.UI.Button.Render("saveX", "margin-left:5px;", true) %>
		<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
	</div>
</div>