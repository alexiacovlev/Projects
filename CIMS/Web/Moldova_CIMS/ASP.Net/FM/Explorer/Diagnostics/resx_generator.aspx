<%@ Page Language="C#" AutoEventWireup="true" Inherits="AX.FM.Explorer.resx_generator" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>Records Management Resource Generator</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<style>
html, body, div, p, h1, h2, h3, h4, h5, h6, blockquote, td, form, fieldset, a, img, button {
  margin: 0;
  border: 0;
}
body {
	font-family: Tahoma, Verdana, Arial;font-size: 11px;
	background-color:#FFF;
	cursor: default;
}
b { font-weight:normal;}

A:link, A:visited { color: blue; }
A:hover { color: brown;  cursor:pointer; text-decoration:underline; }

td {
	font-size:11pt;
	padding:5px;
	vertical-align:top;
}

	</style>
	<script language="javascript">

</script>
	</head>
	<body>
		<table id="TraceTable" width="80%" align="center" cellpadding="0" cellspacing="0" border="1" style="table-layout:fixed;margin-top:20px;margin-bottom:10px;background-color: #fffbff;">
		<tr>
			<td style="padding:5px;">
				<h3 style="color:#606050">Records Management Resource Generator</h3>
			</td>
		</tr>
		<tr style="height:40px">
			<td valign="middle"></td>
		</tr>
		<tr>
			<td>
				<div>
				<%= sb %>
				</div>
				<div style="color:red">
				<%= sbError %>
				</div>
			</td>
		</tr>
		</table>
		<br />
	</body>
</html>
