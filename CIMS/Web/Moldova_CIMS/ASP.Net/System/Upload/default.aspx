<%@ Page Language="C#" AutoEventWireup="true" Inherits="AX.PortalShell.Controls.UploadPage" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Upload</title>
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
	<table id="files" style="position:absolute;top:80px;left:20px;">
	</table>
	<div id="message" style="margin-left:20px;"></div>
	<button id="btnClose" class="fm-btn" style="position: absolute; right: 3px; bottom: 3px; min-width: 60px;"><%= AX.Kernel.Translation.TranslateUI("Close") %></button>
	
	<script type="text/javascript">
		/*global $ */
		$(function() {
			var allowDrop= $.browser.webkit || ($.browser.mozilla && $.browser.version != "11.0");
			var $form = $('#file_upload', this.$p);
			var $dropLabel = $('#dropLabel', this.$p);
			var $results= $('#files', this.$p);
			var $message= $('#message', this.$p);
			var wnd= (window.frameElement && window.frameElement._window) ? window.frameElement._window : null;
			var extensions= wnd ? wnd.extensions : null;
			var notes= (extensions) ? ("<div style='font-style:italic;margin:2px;'><%= AX.Kernel.Translation.TranslateUI("upload_extension_text", "Note: We accept only files with extensions:") %>" + " " + extensions+"</div>") : "";
			var validationmessage= "<%= AX.Kernel.Translation.TranslateUI("upload_validation_text", "Sorry, you cannot upload this file.") %>";
			if (extensions) $message.html(notes);

			var CloseWindow= function(b) { 
				if (!wnd) return;
				if (b) wnd.returnValue= true;
				wnd.close();
			};
			$("#btnClose", this.$p).click(CloseWindow);
			if (!allowDrop) $dropLabel.hide();

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
					if (allowDrop) $dropLabel.hide();
					$results.empty();
					return $('<tr><td width="300">' + files[index].name + '<\/td>' +
                  '<td class="file_upload_progress"><div class="ui-progressbar-value"><\/div><\/td>' +
                  '<td class="file_upload_cancel">' +
                  '<button class="ui-state-default ui-corner-all" title="Cancel">' +
                  '<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
                  '<\/button><\/td><\/tr>');
				},
				buildDownloadRow: function(file) {
					if (allowDrop) $dropLabel.show();

					<% if (HandlerPage != null) { %>
					window.location.href= "<%= HandlerPage %>"+location.search+"&file_id="+file.id+"&file_name="+file.name;
					<% } else { %>
					if (!wnd) return $('<tr><td>done.<\/td><\/tr>');
							
					if (typeof(wnd.onUpload) == 'function') {
						wnd.onUpload(file.id, file.name, file.size);
						wnd.close();
					} else {
						OnUpload_ServerRegister(file);
					}
					<% } %>
				},

				// 2015-04-23
				validateFiles: function(files) {
					var allowUpload= true;
					if (extensions && files) {
						for (var i= 0; i < files.length; i++) {
							var ext= files[i].name.toLowerCase();
							if (ext.lastIndexOf('.') == -1) { allowUpload= false; break; }
							ext= ext.substr(ext.lastIndexOf('.')+1);
							if ($.inArray(ext, extensions)==-1) { allowUpload= false; break; }
            }
					}
					if (!allowUpload) {
						$message.html(notes+"<div style='color:red;font-weight:bold;margin-top:8px;font-family:Verdana;font-size:9pt;'>"+validationmessage+"</div>");
					} else {
						$message.html(notes);
					}
					return allowUpload;
				},
			});

			function OnUpload_ServerRegister(file) {
				$.ajax({ type: "POST", url: "/ASP.Net/FM/DataViewer/Modules/UploadService.asmx/Register", contentType: "application/json; charset=utf-8", dataType: "json",
					data: JSON.stringify({file_id:file.id,file_name:file.name,attributes:window.location.search.substr(1)}),
					success: function(result) {
						var res= result.d;
						if (res == "") {
							$message.html("File has been upploaded successefully.");
							window.setTimeout(function() { CloseWindow(true); }, 1000);
						} else $message.html("<div style='padding:10px;font-weight:bold'>"+res+"</div>");
					},
					error: function(xhr, status, thrownError) {
						alert(xhr.responseText);
						CloseWindow();
					}
				});
			}
		});

	</script>
</body>
</html>
