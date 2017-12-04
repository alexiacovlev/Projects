<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="monitor.aspx.cs" Inherits="AX.FM.Explorer.ProcessBuilder.MonitorPage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>

	<link href="../Scripts/page.css" rel="stylesheet" type="text/css" />
	<link href="../Scripts/ax.window.css" rel="stylesheet" type="text/css" />

	<link href="designer.css" rel="stylesheet" type="text/css" />

  <script src="../Scripts/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="../Scripts/ax.kernel.js" type="text/javascript"></script>
	<script src="../Scripts/fm.global.js" type="text/javascript"></script>
	<script src="../Scripts/ax.window.js" type="text/javascript"></script>

	<script src="/ASP.Net/FM/Explorer/admin_utils.js" type="text/javascript"></script>

	<script src="js/FMS.Monitor.js" type="text/javascript"></script>
	<script src="js/ax.schema.activities.js" type="text/javascript"></script>
	<script src="js/ax.schema.design.js" type="text/javascript"></script>

</head>
<body onload="FMS.Monitor_Load('<%= schemaName %>', '<%= instanceId %>', '<%= stateName %>')">
<div id="topmenu" style="position:absolute;top:0;left:0;right:0;height:25px;background-color:#b6d6fc;border-bottom:solid 1px #76b1ed;">
	<span cmd="Back" style="font-weight:bold;display:none">Back</span>	
</div>
<div id="schemaInfo" style="position:absolute;right:10px;top:6px;"></div>
<div id="canvasPanel" style="position:absolute;top:26px;bottom:0px;left:0;right:0;overflow:scroll;background-color:#f0f8ff">
	<iframe id="canvasFrame" src="canvas.html"></iframe>
</div>
<div id="zoomPanel" style="position:absolute;right:23px;bottom:21px;"><span title="zoom in" cmd="in">+</span><span title="fit to screen / restore" cmd="restore">100%</span><span title="zoom out" cmd="out">-</span></div>

</body>
</html>
