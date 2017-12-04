<%@ Page Language="C#" AutoEventWireup="true" Inherits="AX.FM.Explorer.DbTablesDiagnostics" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>Records Management Diagnostics</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<style>
		html, body, div, p, h1, h2, h3, h4, h5, h6, blockquote, td, form, fieldset, a, img, button {
			margin: 0;
			border: 0;
		}
		body {
			font-family: Tahoma, Verdana, Arial;
			font-size: 11px;
			background-color: #FFF;
			cursor: default;
		}
		b {
			font-weight: normal;
		}
		
		A:link, A:visited {
			color: blue;
		}
		A:hover {
			color: brown;
			cursor: pointer;
			text-decoration: underline;
		}
		
		td {
			font-size: 10pt;
			padding: 3px 0 3px 10px;
			vertical-align: top;
		}
		
		td.h {
			padding:3px;
			font-size: 10pt;
			font-weight:bold;
		}
		td.s {
			font-size: 11pt;
			font-weight:bold;
			border-bottom: 1px solid black;
		}
		h3 {
			font-size:11pt;
			font-family:Tahoma;
			color:#3366cc;
		}
	</style>
</head>
<body style="background-color: #fffbff;">
	<table id="TraceTable" width="80%" align="center" cellpadding="0" cellspacing="0" style="table-layout: fixed; margin-top: 20px; margin-bottom: 10px;">
		<colgroup>
			<col width="35%" />
			<col />
		</colgroup>
		<tr>
			<td colspan="2" style="padding: 5px;">
				<h3>
					Database Usage Statistics (Rows > 1000 or Size > 1 MB)</h3>
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<%= sbList1.ToString() %>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding:20px 0 0 0;">
				<div style="border-top:solid 1px #e5e5e5;border-bottom:solid 1px #7f7f7f;"></div>
			</td>

		</tr>
		<tr>
			<td colspan="2" style="padding:10px 5px 5px 5px;">
				<h3>Last Modified Tables</h3>
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<%= sbList2.ToString() %>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:right;font-size:8pt;">
				Server Time: <%= DateTime.Now %>
			</td>
		</tr>
	</table>
	<br />
</body>
</html>
