<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form.aspx.cs" Inherits="AX.FM.DataViewer.Print.PrintForm" %>
<%@ Register TagPrefix="fmctrl" Namespace="AX.FM.DataViewer.UI" Assembly="AX.FM.DataViewer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Print Form - <%= PageTitle %></title>
	<link href="print_form.css" type="text/css" rel="stylesheet" />
	<style type="text/css" media="print">
	 div.print_toolbar { display:none; }
	 div.print_content { 
		margin-top:0; 
		width:100%;
		padding:0px;
		border:0;
		box-shadow:none;-webkit-box-shadow:none;-moz-box-shadow:none;
	 }
	</style>
</head>
<body>
	<div class="print_toolbar"><a href="javascript:window.print();">Print Page</a></div>
	<div class="print_content">
		<fmctrl:PrintFormControl id="pfc" runat="server"></fmctrl:PrintFormControl>
	</div>
</body>
</html>
