<%@ Control Language="C#" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<style type="text/css">
	div.wf {
		box-shadow: 3px 3px 3px gray;
		background-color:#fff;
		margin:10px;
		padding:5px;
		border:solid 1px gray;
		border-radius:3px;
	}
	div.wf:hover {
		background-color:#ffffd7;
		box-shadow: 2px 2px 5px gray;
	}
</style>
<div class="fm-dlg" style="position:absolute;top:0px;left:0px;right:0px;bottom:33px;border: solid 1px #a59d9b;background-color:#fffbff;padding:4px;">
	<div id="panelList" style="overflow-y:auto;height:320px"></div>
	<div id="panelAdd" style="display:none">
		<table style="table-layout:fixed" cellpadding="5" cellspacing="5">
			<colgroup><col width="100" /><col width="120" /><col width="120" /></colgroup>
			<tr>
				<td>Event:</td>
				<td><label class="fm-chk"><input class="fm-chk" type="radio" name="eventType" id="eventType0" />On Create</label></td>
				<td><label class="fm-chk"><input class="fm-chk" type="radio" name="eventType" id="eventType1" checked="checked" />On Update</label></td>
			</tr>
			<tr>
				<td>Name:</td>
				<td colspan="2"><input id="eventName" class="fm" /></td>
			</tr>
		</table>
	</div>
</div>

<div style="position:absolute;bottom:4px;left:3px;">
	<a id="btnAdd" class="fm-btn" cmd="add"><img src="/ASP.Net/FM/Common/Images/Menu/16_plus.png"/>Add Event</a>
</div>

<div id="_bottomButtons" style="position:absolute;bottom:4px;right:3px;">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true)%>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;width:50px;", false)%>
</div>