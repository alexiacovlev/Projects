<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImportCSVDataControl.ascx.cs" Inherits="AX.FM.DataViewer.Modules.ImportCSVDataControl"
	ScriptClientType="FM.UploadCSVData" 
%>
<div class="fmForm" style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; background-color:#fffbff">
	<div id="lblHeader" style="font-weight:bold;font-size:12pt;margin:10px 0 10px 30px;"><%= TitleMessage %></div>
	<div style="margin:10px 20px 5px 20px;">
		<div style="padding-left: 10px;">
			<% if (ErrorMesasge == null) { %>
			<div style="margin-top: 10px; font-size: 9pt; font-style: italic; line-height: 12pt;">
				<div><%= FileMaskMessage %></div>
				<div>
					Click <b>Browse</b> and select corresponding dataset file from your local computer. <br />
					After file selected, it will be uploaded automatically to the server.
				</div>
			</div>
			<form id="import_uploadFrm" name="import_uploadFrm" enctype="multipart/form-data" method="post" action="/ASP.Net/FM/DataViewer/Modules/ImportCSVData.aspx" target="import_uploadFrame">
				<input type="hidden" name="TableName" value="<%= TableName %>" />
				<input type="hidden" name="Mapping" value="<%= Mapping %>" />
				<div style="margin-top: 15px;">
					<input type="file" name="file" id="file" style="height: 24px; width: 350px" accept="<%= FileExtentions %>" filemask="<%= JSFileMask%>" />
					<label id="lblMessage" style="font-size:9pt;color:#950000;font-weight:bold;margin-left:10px;"></label>
				</div>
				<button id="btnUpload" type="submit" style="display: none; margin-top: 20px; width: 210px; height: 24px; background-color: #34495e; background-image: none; color: #FFF; border-radius: 3px;" class="fm">Upload Records Data File</button>
			</form>
			<% } else { %>
			<div style="font-size:10pt; margin-top: 15px;color:red;font-weight:bold;color:red"><%= ErrorMesasge %></div>
			<% } %>

		</div>
		<iframe id="import_uploadFrame" name="import_uploadFrame" style="margin-left:2px;background-color:#fffbff;margin-top:8px;width:100%;height:280px;" frameborder="0" scrolling="no"></iframe>
	</div>

	<div style="right: 3px; bottom: 4px; position: absolute;<%= (IsWorkflowContext?"display:none":"") %>">
		<a class="fm-btn" id="btnClose" style="margin-left: 8px; min-width: 65px;" cmd="X"><img src="/ASP.Net/FM/Common/Images/16_close.png">Close</a>
	</div>

</div>
<script type="text/javascript">

	FM.UploadCSVData= function ($panel, input, ticket, wnd) {
		var header= $("#lblHeader", $panel).text();
		wnd.setHeader(header||"Dataset Upload");
		$("#btnClose", $panel).click(function () { wnd.close(); });
		var $lbl= $("label#lblMessage", $panel);
		var $file= $("input#file", $panel);
		var messageActive= false;

		$("#file", $panel).change(function () {
			var fileName= $file.val();
			var fileMask= $file.attr('filemask');

			if (messageActive) $lbl.empty(); messageActive= false;
			if (fileMask) {
				var r= new RegExp(fileMask);
				if (!r.test(fileName)) { $lbl.text("  file does not correspond required file mask."); messageActive= true; return; }
			}
			FM.ProgressBar.Show("Uploading", true);
			$("#import_uploadFrm", $panel).submit();
			wnd.returnValue= true;
		});


		$("#import_uploadFrame", $panel).load(function () {
			FM.ProgressBar.Hide();
		});

	}

</script>
