<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Word Document Download Form</title>
<style>
body
{
      font-family: Verdana, Arial;
      font-size: 8pt;
      margin:        0px;
      border: 0px;
      cursor: default;
}

td {
      font-family: Verdana, Arial;
      font-size: 8pt;
     }

.header
{
      border-bottom: solid 1px #D4D0C8;
      border-top: solid 1px #D4D0C8;
      background-color:#EBEADB;
      height:20px;
      }
button {
			background-color:#f3f3f7;
			filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#cecfde);
			cursor: pointer;
			font-size: 11px;
			padding-left: 5px;
			padding-right: 5px;
			width:80px;
			height:22px;
			border: 1px solid #7b9ebd;
		}
</style>
<script type="text/javascript">
	function redirect() {
		document.location.href= "WordReport.aspx?<%= Request.QueryString %>";
	}
	function closeOnTimeOut() {
		window.setTimeout(closedialog, 1500);
	}
	function closedialog() {
		if (window.frameElement) window.frameElement._window.close();
	}
</script>
</head>
<body onload="redirect()" scroll="no">
<form id="form1" runat="server">
	<table cellpadding="4" cellspacing="4">
		<tr>
			<td>
        <img alt="" src="FileDownload.png" width="100" height="100" />
			</td>
			<td>
				<table style="width:384px;">
					<tr>
						<td colspan="2">
							<font style="font-weight: bold">Download document instruction:</font>
						</td>
					</tr>
					<tr>
						<td>
						 <br />

If your download does not start automatically after 20 seconds,
<br/>please click the <b>Download</b> button on this page.<br />

 <br />To save the document to your computer for opening at a later time, click <b>Save</b>. <br />

To cancel the downloading, click Cancel.
						</td>
					</tr>

				</table>
			</td>
		</tr>

		<tr>
			<td colspan="2" align="center">
			<br />
				<!--button class="xpbutton" style="height:23;width:300px" onclick="redirect();closeOnTimeOut();">Download</button><br /-->
				<a style="height:23px;width:300px;font-weight:bold" href="WordReport.aspx?<%= Request.QueryString %>" onclick="closeOnTimeOut()">Download</a>
			</td>
		</tr>
	</table>
	<button style='position:absolute;right:5px;bottom:5px;' onclick='closedialog()'>Close</button>
</form>
</body>
</html>




