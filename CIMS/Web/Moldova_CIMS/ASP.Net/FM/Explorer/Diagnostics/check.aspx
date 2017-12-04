<%@ Page Language="C#" AutoEventWireup="true" Inherits="AX.FM.Explorer.CheckTable" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
body {
	font-family: Tahoma, Verdana, Arial;font-size: 11px;
	background-color:#FFF;
	cursor: default;
}
td {
	font-size:11pt;
	border: 0;
}
</style>
<script type="text/javascript">
	function openStdWin(sPath, sName, iX, iY, scroll, full) {
		if (!iX) iX= 750;if (!iY) iY= 510;
		var top, left;
		try {
			if (full) { iX= screen.width - 5; iY= screen.availHeight - 60; top= 0; left= 0;
			} else { left= (screen.width - iX) / 2; top= (screen.availHeight - iY) / 2 - 30; }
			var params= "width=" + iX + ",height=" + iY + ",top=" + top + ",left=" + left + ",status=1,resizable=1,scrollbars=" + ((scroll) ? "1" : "0");
			window.open(sPath, sName, params);
		} catch(e) {}
	}
	function edit() {
		<% if (Mode == "0") { %>
		openStdWin("../TableBuilder/Designer.aspx?t=<%= ObjectName %>", "TableBuilder", 800, 510);
		<% } else if (Mode == "1") { %>
		openStdWin("../HumanWorkflow/workflow.aspx?w=<%= ObjectName %>", "HWorkflowEditor", 940, 720);
		<% } %>
	}
</script>
</head>
<body>
<h3 style="color:#606050;padding-top:10px;padding-left:100px;">Detailed Diagnostics Page For <%= ObjectName%></h3>
<table width="80%" align="center" cellpadding="0" cellspacing="0" border="1" style="table-layout:fixed;margin-top:20px;margin-bottom:10px;background-color: #fffbff;">
<tr>
	<td>
    <div style="overflow-y:auto;width:100%;height:450px;padding:20px;">
			<%= Message %>
		</div>
	</td>
</tr>
<tr>
	<td align="right" style="padding-right:10px;padding-bottom:3px;">
	<!--<a href="javascript:edit()">Settings</a>&nbsp;&nbsp; -->
	<a href="javascript:window.close()">Close</a>
	</td>
</tr>
</table>
<br />
</body>
</html>
