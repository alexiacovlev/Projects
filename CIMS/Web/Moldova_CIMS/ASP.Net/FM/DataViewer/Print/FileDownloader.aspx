<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Document Download Form</title>
<style type="text/css">
body {
  font-family: Tahoma, Verdana, Arial;
  font-size: 11px;
  margin:        0px;
  border: 0px;
  cursor: default;
}
td { 
	font-size: 11px; 
}

.xpbutton, button {
  filter:        progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#cecfde);
  cursor:        pointer;
  font-size: 11px;
  padding-left: 5px;
  padding-right: 5px;
  border:        1px solid #7b9ebd;
}
.header {
  border-bottom: solid 1px #D4D0C8;
  border-top: solid 1px #D4D0C8;
  background-color:#EBEADB;
  height:20px;
 }
</style>
<script runat="server">
protected string GetDownloadUrl() {
	string url= Request.QueryString["url"];
  return !String.IsNullOrEmpty(url) ? url : ("WordReport.aspx?"+Request.QueryString);
}
</script>
<script type="text/javascript">
	function redirect() {
		document.location.href= "<%= GetDownloadUrl() %>";
		window.setTimeout('closedialog()', 30*1000);
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
<form id="form1" runat="server">
	<table style="width: 470px;" cellpadding="5" cellspacing="5" align="center">
		<tr>
			<td width="100px">
				<img alt="" src="FileDownload.png" />
			</td>
			<td>
				<table style="width: 340px;">
					<tr>
						<td  colspan="2">
							<font style="font-weight: bold">Download document details:</font>
						</td>
					</tr>
					<tr>
						<td>
						 <br />
							Click the <b>Download</b> button on this page to start the download <br />
							To save the document to your computer for opening at a later time, <br /> click <b>Save</b>. <br />
							To cancel the downloading, click Cancel.
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<br /><br />
				<a style="height:23px;width:300px;font-weight:bold" href="<%= GetDownloadUrl() %>" onclick="closeOnTimeOut()">Download</a>
			</td>
		</tr>
	</table>
</form>
</body>
</html>