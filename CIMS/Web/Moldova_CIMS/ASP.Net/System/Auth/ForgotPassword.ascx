<%@ Control Language="C#" Inherits="AX.Kernel.UI.UserControl" ResourceName="UserManagement" %>
<div id="ForgotForm" class="axdlg" style="margin: 100px auto 0 auto; width: 500px;">
	<div class="axdlg-header"><%= Translate("Recovery_Hdr", "Request to reset the password") %></div>
	<div class="axdlg-desc" id="message" style="height:2em"><%= Translate("Recovery_Desc", "Please, define the email attached to your account.<br />We will send you further instructions.") %></div>
	<div class="axdlg-body" style="padding:10px">
		<table style="table-layout:fixed;width:100%;" cellpadding="8">
			<colgroup>
				<col width="100" />
				<col />
			</colgroup>
			<tr style="height:40px">
				<td align="right" style="padding:10px;"><%= Translate("info_Email", "Email") %></td>
				<td style="padding:10px;"><input type="text" id="Email" class="fm"/></td>
			</tr>
			<tr style="height:40px;vertical-align:bottom">
				<td>
					<a style="font-size: 0.8em; cursor: pointer; color: #1872f8;" id="backLink"><%= Translate("info_BackToLogin", "Back to Login") %></a>
				</td>
				<td style="text-align:right">
					<button id="sendOK" class="ax-btn" style="min-width:80px"><%= Translate("info_Send", "Send") %></button>&nbsp;&nbsp;
					<button id="sendClose" class="ax-btn" style="min-width:80px"><%= Translate("btnClose", "Close") %></button>
				</td>
			</tr>
		</table>
	</div>
</div>
<script type="text/javascript">
	$(function () {
		var $form = $('#ForgotForm');
		var $wnd = $form.parent().parent();
		$('#Email', $form).focus();

		$('#sendOK', $form).click(function () {
			var email = $('#Email', $form).val().trim();
			if (email == "") return;
			$('#Email', $form).attr('disabled', 'disabled');
			$('#sendOK', $form).attr('disabled', 'disabled');
			$("#message", $form).text('<%= Translate("Recovery_processing", "Processing your request") %> ...');
			alert('sending');
			return;
			var onready = function (result) {
				var res = result.d;
				if (res.indexOf("ERROR:") == 0) {
					$("#message", $form).text(res.substr(6)).css({ 'background-color': '#844242', 'color': '#FFF' });
					$('#Email', $form).attr('disabled', '');
					$('#sendOK', $form).attr('disabled', '');
				} else {
					$("#message", $form).text(res).css({ 'background-color': '#3c8ff7', 'color': '#FFF' });
				}
			}
			ExecuteService("{\"email\":\"" + email + "\"}", App.SystemPath + "Auth/Service.asmx/PasswordRecovery", onready);
		});

		$('#sendClose', $form).click(function () {
			$wnd.css({ display: 'none' });
		});

		$('#backLink', $form).click(function () {
			//$wnd.load(App.SystemPath+"Component.aspx?path=Auth/LoginWindow.ascx");
			App_Login(true);
		});
	});

</script>



