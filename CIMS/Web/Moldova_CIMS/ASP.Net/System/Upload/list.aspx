<%@ Page Language="C#" AutoEventWireup="true" Inherits="AX.PortalShell.Controls.UploadPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Multiple file(s) upload</title>
	<link rel="stylesheet" href="<%= AX.Kernel.Settings.JQuery_UI_CSS %>" id="theme" />
	<link rel="stylesheet" href="JS/style.css" />
	<script src="<%= AX.Kernel.Settings.JQuery_JS %>" type="text/javascript"></script>
	<script src="JS/jquery.fileupload.js" type="text/javascript"></script>
	<script src="JS/jquery.fileupload-ui.js" type="text/javascript"></script>
</head>
<body>
	<form id="file_upload" name="file_upload" method="post" action="/file.upload" runat="server">
		<div id="filediv">
			<input type="file" name="file"/><!-- accept="image/*"-->
			<button></button>
			<label><%= AX.Kernel.Translation.TranslateUI("upload_button", "Choose a file from the disk") %> ...</label>
		</div>
		<div id="dropLabel"><%= AX.Kernel.Translation.TranslateUI("upload_drag_text", "Or just drag and drop your file here,<br />it will be automatically uploaded") %> ...</div>
	</form>
	<table id="files" style="position:absolute;top:50px;left:20px;width:95%;table-layout:fixed;">
		<colgroup>
			<col />
			<col width="150" />
			<col width="40" />
		</colgroup>
	</table>
	<button id="btnClose" style="position: absolute; right: 5px; bottom: 5px; width:85px;">Close</button>
	
	<script type="text/javascript">
		/*global $ */
		$(function() {
			var allowDrop= $.browser.webkit || ($.browser.mozilla && $.browser.version != "11.0");
			var $form= $('#file_upload', this.$p);
			var $dropLabel= $('#dropLabel', this.$p);
			var $results= $('#files', this.$p);
			var rowIndex= 0;
			var wnd= null;
			if (window.frameElement) wnd= window.frameElement._window;
			if (wnd) wnd.setHeader("Upload File(s)");

			$("#btnClose", this.$p).click(function() { if (wnd) wnd.close(); });
			if (!allowDrop) $dropLabel.hide();

			function onupload(file, index) {
				$dropLabel.hide();

				$.ajax({ type: "POST", url: "/ASP.Net/FM/DataViewer/Modules/UploadService.asmx/Register", contentType: "application/json; charset=utf-8", dataType: "json",
					data: JSON.stringify({file_id:file.id,file_name:file.name,attributes:window.location.search.substr(1)}),
					success: function(res) {
						var $row= $("tr#row_"+index, $results);
						$($row.children()[1]).text(' - success.');
						if (wnd) wnd.returnValue= true;
					},
					error: function(xhr, status, thrownError) {
						var er= xhr.responseText;if (er.indexOf('{') == 0) er= (window.eval("(" + er + ")")).Message;
						alert(er);
						var $row= $("tr#row_"+index, $results);
						$($row.children()[1]).text(' - failed.');
					}
				});
			}

			$form.fileUploadUI({
				url: '/file.upload',
				method: 'POST',
				dragDropSupport: allowDrop,
				uploadTable: $results,
				downloadTable: $results,
				onError: function(res) {
					var s= res.toString();
					if (s.indexOf("Syntax") == 0) s='File size exceeds the max limit (20MB).'; alert('Sorry, error occured on uploading your file.\n\n'+s);
				},
				buildUploadRow: function(files, index) {
				 return $('<tr><td>' + files[index].name + '<\/td>' +
									'<td class="file_upload_progress"><div><\/div><\/td>' +
									'<td class="file_upload_cancel">' +
									'<button class="ui-state-default ui-corner-all" title="Cancel">' +
									'<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
									'<\/button><\/td><\/tr>');
				},
				buildDownloadRow: function(file) {
					rowIndex+= 1;
					onupload(file, rowIndex);
					return $('<tr id="row_'+rowIndex+'"><td>' + file.name + '<\/td><td> - registering ...</td><td></td><\/tr>');
				}
			});

		});
	</script>
</body>
</html>

