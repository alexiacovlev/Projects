<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImageDialog.aspx.cs" Inherits="AX.PortalAdmin.HtmlDesigner.dialogs.ImageDialog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" class="redImageManager">
<head>
	<title></title>
	<%= base.RegisterHeader() %>
	<style type="text/css">

	 
html.redImageManager body {
	width: 820px;
	height: 502px;
}
		div.d {
			margin: 3px 0 3px 20px;
		}

		div.d-text {
			font-weight: bold;
			margin: 4px 0;
			color: white;
		}

		div.d-items {
			margin: 3px 10px;
		}

		span.f {
			display: inline-block;
			margin: 10px 10px;
			width: 120px;
			height: 130px;
			padding: 2px;
		}

			span.f label {
				display: block;
				width: 120px;
				overflow: hidden;
				white-space: nowrap;
				margin-top: 10px;
			}

			span.f img {
				display: block;
				border-radius: 2px;
				box-shadow: 0px 2px 10px #383838;
				-webkit-box-shadow: 0px 2px 10px #383838;
				-moz-box-shadow: 0px 2px 10px #383838;
				border: solid 1px #555555;
				width: 100px;
				height: 100px;
				cursor: pointer;
			}

			span.f:hover img {
				box-shadow: 0px 1px 10px #35a9f7;
				-webkit-box-shadow: 0px 1px 10px #35a9f7;
				-moz-box-shadow: 0px 1px 10px #35a9f7;
				border-color: #35a9f7;
				margin: 2px 0 2px 0;
			}

			span.f:hover label {
				margin-top: 8px;
			}
	</style>

	<script type="text/javascript">
		function GetRadWindow() {
			var oWindow = null;
			if (window.radWindow) oWindow = window.radWindow;
			else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
			return oWindow;
		}
		function GetRadEditor() {
			return window.parent.editor;
		}
		function closeWindow() {
			GetRadWindow().close();
		}

		$(document).ready(function () {
			$("#explorer").click(function (e) {
				var o = e.target;
				if (o.tagName != "IMG") return;
				var editor = GetRadEditor();
				editor.pasteHtml('<img src="' + o.getAttribute('rel_src') + '" />');
				GetRadWindow().close();
			});
		});

	</script>
</head>
<body style="background-color: #999999">
	<div id="explorer" style="width: 100%; height: 502px; overflow-y: scroll;">
		<%= sb.ToString() %>
	</div>
	<div style="position: absolute; bottom: 15px; right: 30px;">
		<button id="btnClose" style="width: 100px; height: 24px; margin-left: 5px;" onclick="closeWindow()">Close</button>
	</div>

</body>
</html>
