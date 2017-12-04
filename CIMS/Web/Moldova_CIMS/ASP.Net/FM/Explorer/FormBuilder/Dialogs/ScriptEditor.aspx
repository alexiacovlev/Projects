<%@ Page language="C#" AutoEventWireup="false" Inherits="AX.FM.Explorer.FormBuilder.Dialogs.ScriptEditor" %>
<HTML>
<HEAD>
<title>Form Script Editor</title>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
<%= base.RegisterHeader() %>

<script language="javascript">
	
	var ScriptContent = null;
	function window_onload() {
		ScriptContent = document.getElementById("ScriptContent");
		ScriptContent.onkeydown = _onkeydown;

	}
	function _onkeydown(e) {
		if (event.keyCode == 9) {
			event.returnValue = false; event.cancelBubble = true;
			ScriptContent.selection = document.selection.createRange();
			ScriptContent.selection.text = String.fromCharCode(9);
			return false;
		}
	}
</script>
</HEAD>
<body bgcolor="#d7eaf7" onload="window_onload()">
<form name="frmDialog" action="ScriptEditor.aspx?<%= Request.QueryString %>" method="post">
<input name="bClose" type="hidden" value="0" />


<div class="fm-dlg-header">
	<h1 id="dlgTitle"><%= !String.IsNullOrEmpty(scriptUrl) ? (scriptUrl + " - GLOBAL Library Script Editor"):"Form Internal Script Editor" %></h1>
	<label>
		You can add/edit additional javascript functions for your form<br />
		<%= !String.IsNullOrEmpty(scriptUrl) ? "<b style='color:red'>Note: The changes will be applied to all the forms which reference to this library.</b>":"This functions will be attached to the form while rendering." %>
	</label>
</div>

<div style="position:absolute;top:75px;bottom:40px;left:5px;right:5px;">
	<textarea id="ScriptContent" name="ScriptContent" style="font-size:12px;font-family:Verdana;padding:5px;width:98%;height:98%;overflow-x:auto;overflow-y:scroll;" wrap="off"><%= ScriptContent %></textarea>
</div>

<div class="fm-dlg-footer">
	<div style="position:absolute;right:5px;bottom:5px;">
	<button id="btnDialogOk" onclick="frmDialog.submit()" style="width:100px">Save</button>&nbsp;
	<button id="btnDialogOk2" onclick="frmDialog.bClose.value='1';frmDialog.submit()" style="width:130px">Save and close</button>&nbsp;
	<button id="btnDialogCancel" onclick="window.close();" style="width:100px">Close</button>
	</div>
</div>

</form>
</body>
</HTML>
