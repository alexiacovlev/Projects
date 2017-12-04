<%@ Page Language="C#" %>
<%
	string url= Request.QueryString["url"];
	if (url == null) url= "/url_not_defined/";
	string name= Request.QueryString["name"];
	url= AX.Kernel.Settings.WorkspaceUrl + url + ((url.IndexOf('?')!=-1?'&':'?') + Request.QueryString["id"]);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Document Download Form</title>
	<style type="text/css">
		body {
			font-family: Verdana, Arial;
			font-size: 9pt;
			margin: 2px;
			border: 2px;
			cursor: default;
		}
		
		td {font-size: 8pt;line-height:1.5;}

	</style>

	<script type="text/javascript">
		function redirect() {
			var tb= document.getElementById('tbUrl');
			tb.focus();
			tb.select();
			//window.document.location.href= "<%= url %>";
		}
		function closeOnTimeOut() {
			window.setTimeout('closedialog()', 1500);
		}
		function closedialog() {
			if (window.frameElement) window.frameElement._window.close();
		}
	</script>
</head>
<body onload="redirect()" scroll="no">
	<div style="position:absolute;top:5px;left:5px;right:5px">
		<input id="tbUrl" type="text" value="<%= url %>" style="width:99%;font-size:11px;font-family:Verdana" />
	</div>
	<table style="width:99%;margin-top:20px;" cellpadding="5" cellspacing="5" align="center">
		<tr>
			<td width="110px">
				<img alt="" src="download.png" />
			</td>
			<td>
				<table style="width:350px;">
					<tr>
						<td colspan="2" style="font-weight: bold">Download document notes:</td>
					</tr>

					<tr>
						<td>
							<div style="font-weight:bold;margin:5px;"><%= name %></div>
							Click the <b>Download</b> button on this page to start the download
							<br />
							To save the document to your computer for opening<br />
							at a later time, click <b>Save</b>.
							<br />
							To cancel the downloading, click Cancel.
							<br />
							This document is available for public access, you can copy the link and share it.
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td colspan="2" style="text-align:center;padding-top:10px;">
				<a style="height:23px;width:300px; font-weight: bold" href="<%= url %>" onclick="closeOnTimeOut()">Download</a>
			</td>
		</tr>
		

		<div style="position:absolute;bottom:3px;right:3px;">
			<button onclick="closedialog()" style="width:90px;height:25px;">Close</button>
		</div>
	</table>
</body>
</html>
