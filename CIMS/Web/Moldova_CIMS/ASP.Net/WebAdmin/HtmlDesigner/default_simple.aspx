<%@ Page Language="C#" Inherits="AX.PortalAdmin.HtmlDesigner._default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%= base.RegisterHeader() %>

	<style type="text/css">
		div.dialog_wnd {
			box-shadow: 0px 2px 10px #383838;
			-webkit-box-shadow: 0px 2px 10px #383838;
			-moz-box-shadow: 0px 2px 10px #383838;
			border-color: #555555;
			position: absolute;
			top: 10px;
			left: 10px;
			right: 10px;
			bottom: 10px;
			background-color: #f1f1f1;
		}

		div#menu {
			background-color: #FFF;
			padding: 2px 4px 0 0;
			cursor: default;
		}

			div#menu a {
				font-weight: bold;
				text-decoration: none;
				display: inline-block;
				border: solid 1px #FFF;
				padding: 0 4px 2px 4px;
			}

				div#menu a:hover {
					border-color: #a0a0a0;
					box-shadow: 0px 2px 10px #383838;
					-webkit-box-shadow: 0px 2px 10px #383838;
					-moz-box-shadow: 0px 2px 10px #383838;
				}
	</style>
	<script type="text/javascript">
		var pageID = "<%= pageID %>";
		var lcid = "<%= lcid %>";
		var bClose = false;
		var bChanged = false;
		var mode = "HTML";
		var $tbSource, $panelDesign;

		function LoadHtml() {
			$.get("LoadHtml.aspx?id=" + pageID + "&lcid=" + lcid
							, null
							, function (s) {
								$tbSource.val(s);
								if (mode == "HTML") {
									if (!TryLoadDesignHtml(s)) ChangeMode("TEXT");
								}
							}
							, "html");
		}

		function TryLoadDesignHtml(s) {
			try {
				$panelDesign.html(s);
				return true;
			} catch (e) {
				alert("Sorry, the HTML text you've typed contains syntax errors.\n\nPlease, check Text Source syntax.");
				$("#rbModeText").attr('checked', 'checked');
				return false;
			}
		}

		function SaveHtml() {
			if (!bChanged) {
				if (bClose) Close();
				return;
			}

			var html;
			if (mode == "TEXT") {
				html = $tbSource.val();
				if (!TryLoadDesignHtml(html)) return; // validate
			} else if (mode == "HTML") {
				html = $panelDesign.html();
				$tbSource.val(html); // sync text with source panel
			}

			html = _HtmlEncode(html);

			$("#btnSave").attr('disabled', 'disabled');
			$.post("SaveHtml.aspx?id=" + pageID + "&lcid=" + lcid
							, html
							, function (result) {
								$("#btnSave").removeAttr('disabled');
								if (result != "") {
									alert(result);
								} else if (!bClose) {
									bChanged = false;
									$("#lblInfo").show().fadeOut(2000);
								} else {
									Close();
								}
								bClose = false;
							}
							, "html"
			);
		}

		function mode_onclick() {
			var new_mode = ($("#rbModeHTML").is(":checked")) ? "HTML" : "TEXT";
			if (new_mode != mode) ChangeMode(new_mode);
		}



		function ChangeMode(new_mode) {
			if (new_mode == "HTML") {
				if (!TryLoadDesignHtml($tbSource.val())) return;// if HTML not parsed prevent toggle mode.
				$tbSource.hide();
				$panelDesign.parent().parent().show();
				$panelDesign.focus();
			} else {
				if (bChanged) $tbSource.val($panelDesign.html());// if loaded with errors then allow toggle mode to TEXT with original Text
				$panelDesign.parent().parent().hide();
				$tbSource.show();
				$tbSource.focus();
			}
			mode = new_mode;
		}

		function Close() {
			window.parent.location.reload();
		}

		function _HtmlEncode(s) {
			return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
		}

		$(document).ready(function () {
			$tbSource = $("#tbSource");
			$panelDesign = $("#panelDesign");

			$panelDesign.keydown(function () { bChanged = true; });
			$tbSource.keydown(function () { bChanged = true; });

			// menu
			$('div#menu a').click(function (e) {
				var cmd = e.currentTarget.getAttribute('cmd');
				if (!cmd) return;
				bChanged = true;
				document.execCommand(cmd, false, null);
				$panelDesign.focus();
				return false;
			});
			//

			$("#btnSave").click(SaveHtml);
			$("#btnSaveAndClose").click(function () { bClose = true; SaveHtml(); });
			$("#btnClose").click(Close);

			$("#rbModeText").click(mode_onclick);
			$("#rbModeHTML").click(mode_onclick);

			$("#ddlLanguage").change(function () { lcid = $(this).val(); LoadHtml(); });
			LoadHtml();
		});
	</script>
</head>
<body style="background-color: #999999">
	<div class="dialog_wnd">
		<div style="height: 50px; border-bottom: solid 1px #a0a0a0; background-color: #FFF">
			<lable style="position: absolute; top: 8px; left: 10px; font-weight: bold; font-size: 9pt;">Html Text Editor</lable>
			<lable style="position: absolute; top: 27px; left: 20px; font-size: 8pt;">You can add custom HTML text for each language presented in the portal.</lable>
			<select id="ddlLanguage" style="position: absolute; top: 10px; right: 5px; width: 200px;" class="fm"><%= ddlLanguage_Options%></select>
		</div>
		<div style="border-top: solid 1px #FFF"></div>

		<div style="position: absolute; top: 60px; bottom: 40px; width: 100%;">
			<textarea id="tbSource" class="fm" style="margin-left: 10px; width: 98%; height: 99%; font-family: Verdana; font-size: 9pt; display: none;"></textarea>
			<div style="position: relative; margin-left: auto; margin-right: auto; width: 98%; height: 99%; border: solid 1px #616161; background-color: #FFF;">
				<div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; border: solid 1px #c9c9c9; padding: 3px;">
					<div id="panelDesign" contenteditable="true" style="width: 100%; height: 100%; overflow-y: auto; outline: 0;"></div>
					<div id="menu" style="position: absolute; top: 0px; right: 0px;">
						<a cmd="bold" title="Bold" href="#" style="font-weight: bold">B</a>
						<a cmd="italic" title="Italic" href="#" style="font-style: italic">I</a>
						<a cmd="underline" title="Underline" href="#" style="text-decoration: underline">U</a>
						<a cmd="strikethrough" title="Line-Through" href="#" style="text-decoration: line-through">S</a>
					</div>
				</div>
			</div>
		</div>

		<div style="position: absolute; bottom: 14px; left: 12px;">
			<label style="margin-right: 10px; font-weight: bold;">
				<input type="radio" class="fm-chk" name="Mode" id="rbModeHTML" checked="checked" />Design</label>
			<label style="font-weight: bold;">
				<input type="radio" class="fm-chk" name="Mode" id="rbModeText" />Text Source</label>
		</div>

		<div style="position: absolute; bottom: 10px; right: 10px;">
			<a class="fm-btn" id="btnSave" style="width: 60px; margin-right: 8px;">Save</a>
			<a class="fm-btn" id="btnSaveAndClose" style="width: 100px; margin-right: 8px; font-weight: bold;">Save and Close</a>
			<a class="fm-btn" id="btnClose" style="width: 60px">Close</a>
		</div>
		<div id="lblInfo" style="position: absolute; bottom: 15px; right: 360px; font-weight: bold; color: #0961cc; display: none;">Html Text Saved</div>
	</div>
</body>

</html>
