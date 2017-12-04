<%@ Control Language="C#" Inherits="AX.Kernel.UI.HtmlModuleUserControl" ScriptClientType="AX.Auth_ChangePasswordByEmailDialog" ResourceName="UserManagement" %>

<style type="text/css">
	#User div.section_hdr {font-family:Verdana;font-size:9pt;color:#3c8ff7;border-bottom:solid 1px gray;padding:3px;margin-bottom:3px;}
	#User #ErrorMessage {color:Red;padding-left:5px;padding-top:5px;text-align:center;font-size:9pt;}
	#User td {padding:2px;}
	#User td.lbl_r {font-weight:bold;padding-left:8px;}
	#User td.lbl {padding-left:8px;}
	div.statusMessage {background-color:#3c8ff7;color:#FFF;padding:10px;}
	div.errorMessage {background-color:#844242;color:#FFF;padding:15px;}
</style>
<div class='dialogWithDropShadow' style='position:relative;padding:20px;width:450px;height:200px;margin:100px auto 0 auto;'>
		<div style="font-weight:bold;font-size:10pt;margin-bottom:10px;"><%= Translate("info_ChangePassword_Header", "Change account password")%></div>
		<div id="User" style="display:none">
		<table id="pwd_form" style="width:100%;table-layout: fixed;" cellspacing="12">
			<colgroup><col width="170"><col /></colgroup>
			<tbody>
			<tr>
				<td colspan="2" style="font-style:italic;color:#5d5d5d;font-size:8pt;padding-left:70px;"><%= String.Format(Translate("info_PasswordCommentMask", "The password must be at least {0} characters in length<br />and must contain at least one special character e.g. @ or #."), Membership.MinRequiredPasswordLength) %></td>
			</tr>
			<tr>
				<td class="lbl_r"><%= Translate("info_NewPassword", "New password")%>:</td>
				<td><input type="password" tabindex="2" class="fm" id="pwd1" /></td>
			</tr>

			<tr>
				<td class="lbl_r"><%= Translate("info_ConfirmPassword", "Confirm password")%>:</td>
				<td><input type="password" tabindex="3" class="fm" id="pwd2" /></td>
			</tr>

			</tbody>
		</table>

	<div style='float:right;margin:10px;'>
		<a id="btn1" class='fm-btn' tabindex="4" style='padding-top:1px;padding-bottom:2px;margin-right:4px;width:70px;'><%= Translate("btnApply", "Apply")%></a>
	</div>
</div>

<div id="message" style='margin:15px 5px'>
</div>

<a id="btn2" style='width:70px;display:none;float:right;' href="<%= AX.Kernel.Settings.WorkspaceUrl %>"><%= Translate("btnContinue", "Continue")%></a>

</div>
<script type="text/javascript">

AX.Auth_ChangePasswordByEmailDialog= function($panel, input, ticket, wnd) {

	var qs= window.location.search;
	var ticket= qs.substr(1, qs.length-1);

	var $pwd1= $("#pwd1", $panel);
	var $pwd2= $("#pwd2", $panel);


	$("#btn1", $panel).click($createDelegate(function() {
		var s1= $pwd1.val().trim();
		var s2= $pwd2.val().trim();
		if (s1 == "" || s2 == "") {AX.Window.alert("<%= Translate("Alert")%>", "<%= Translate("info_msg_CompleteAll", "Please, complete all required fields.")%>");return;}
		if (s1 != s2) {AX.Window.alert("<%= Translate("Alert")%>", "<%= Translate("info_msg_PasswordConfirmFailed", "The 'Confirm password' does not match with the 'New password',<br/>please re-type it.")%>");return;}
		var url= App.SystemPath + "Auth/Service.asmx/PasswordRecovery_ChangePassword";
		ExecuteService("{\"ticket\":\""+ticket+"\",\"newPassword\":\""+jsonEncode(s1)+"\"}", url,
			function(result) {
				var res= result.d;
				if (res != "") AX.Window.alert(res);
				else {
					$("#pwd_form", $panel).hide();
					$("#btn1", $panel).hide();
					$("#message").html("<%= Translate("info_msg_PasswordChanged", "Password has been changed.")%>").addClass('statusMessage');
					$("#btn2", $panel).show();
				}
			}
		);
	}, this));

	// init
	//
	ExecuteService("{'ticket':'"+ticket+"'}", App.SystemPath + "Auth/Service.asmx/PasswordRecovery_CheckTicket",
		function(result) {
			if (result.d) {
				$("#User", $panel).show();
				$pwd1.focus();
			} else {
				$("#message", $panel).html("<%= Translate("info_msg_TicketNotValid", "Ticket is not valid or expired.")%>").addClass('errorMessage');
				$("#btn2", $panel).show();
			}
		}
	);

}
</script>

