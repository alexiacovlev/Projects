<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Document Download Form</title>
	<style type="text/css">
		body {
			font-family: Verdana, Arial;
			font-size: 8pt;
			margin: 0px;
			border: 0px;
			cursor: default;
		}
		
		td {font-size: 8pt;line-height:1.5;}

	</style>
	<script type="text/javascript">
		function redirect() {
			window.document.location.href= "<%= Request.QueryString["url"] %>";
		}
		function closeOnTimeOut() {
			window.setTimeout('closedialog()', 1500);
		}
		function closedialog() {
			if (window.frameElement) window.frameElement._window.close();
			else window.close();
		}
	</script>
</head>
<body onload="redirect()" scroll="no">
	<table style="width:99%;" cellpadding="5" cellspacing="5" align="center">
		<tr>
			<td width="110px">
				<img alt="" src="download.png" />
			</td>
			<td>
				<table style="width:350px;">
					<tr>
						<td colspan="2" style="font-weight: bold">Download document details:</td>
					</tr>
					<tr>
						<td>
							<div style="font-weight:bold;margin:5px;"><%= Request.QueryString["name"] %></div>
							Click the <b>Download</b> button on this page to start the download
							<br />
							To save the document to your computer for opening<br />
							at a later time, click <b>Save</b>.
							<br />
							To cancel the downloading, click Cancel.
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				
				<br />
				<a style="height:23px;width:300px; font-weight: bold" href="<%= Request.QueryString["url"] %>" onclick="closeOnTimeOut()">Download</a>
			</td>
		</tr>
		<div style="position:absolute;bottom:3px;right:3px;">
			<button onclick="closedialog()" style="width:90px;">Close</button>
		</div>
	</table>
</body>
</html>
