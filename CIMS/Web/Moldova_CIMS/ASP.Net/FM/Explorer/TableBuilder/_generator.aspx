<%@ Page language="c#" AutoEventWireup="false" Inherits="AX.FM.Explorer.TableBuilder.GeneratorForm" %>
<HTML>
<HEAD>
<title>Records Management Table Generator</title>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
<style>
html, body, form{margin:0; padding:0;font-family:Verdana;font-size:9pt;height:100%;}
td {margin:0; padding:0;font-family:Verdana;font-size:9pt;}
div.subtitle {font-size: 16px;font-weight: bold;padding-top: 2px;}
</style>
<script type="text/javascript">
	var expCurrentTableName= "<%= tableName %>";
	var fmExplorerPath= "<%= AX.FM.Explorer.Utils.Path%>";

	function wnd_close(t) {
		var w= window.frameElement._window;
		w.returnValue= true;
		if (t) window.parent.RMC_OpenTableSettings(t);
		w.close();
	}
</script>
</HEAD>
<body>
<form id="frm" runat="server" style="height:100%;margin:0;padding:0">
<table width="100%" height="100%" cellspacing="0" cellpadding="0" style="TABLE-LAYOUT:fixed;">
	<tr height="38">
		<td bgcolor="#ACC0E9" style="padding-left:4px;">
			<div class="subtitle"> Records Management Settings Generator.</div>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<% RenderContent(); %>
			<% if (!HasErrors) { %>
			<br /><br />
			<button onclick="wnd_close(expCurrentTableName)" style="position:absolute;bottom:5px;right:95px;width:170px;">OK, open table settings.</button>
			<button onclick="wnd_close(null)" style="position:absolute;bottom:5px;right:5px;width:80px;">Close</button>

			<% } %>
		</td>		
	</tr>
	</table>
</form>
</body>
</HTML>
