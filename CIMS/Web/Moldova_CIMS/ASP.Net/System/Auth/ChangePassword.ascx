<%@ Control Language="C#" Inherits="AX.Kernel.UI.HtmlModuleUserControl" ScriptClientType="AX.Auth_ChangePasswordDialog" ResourceName="UserManagement" %>
<div style="width:500px;margin:20px auto 0 auto;padding:10px;" class="fm-dlg-form">
	<div id="sec_info" class="fm-sec">
		<label class="fm-sec-lbl"><%= Translate("info_ChangePassword_Header", "Change account password")%></label>
		<table id="pwd_form" style="width: 100%; table-layout: fixed;margin-top:5px;" cellSpacing="10">
			<colgroup><col width="170"><col /></colgroup>
			<tbody>
			<tr>
				<td class="fm-req"><%= Translate("info_CurrentPassword", "Current password")%>:</td>
				<td><input id='pwd' tabindex="1" class="fm" type="password" /></td>
			</tr>

			<tr>
				<td colspan="2" style="font-style:italic;color:#5d5d5d;font-size:8pt;padding-left:100px;"><%= String.Format(Translate("info_PasswordCommentMask", "The password must be at least {0} characters in length<br />and must contain at least one special character e.g. @ or #."), Membership.MinRequiredPasswordLength) %></td>
			</tr>
			<tr>
				<td class="fm-req"><%= Translate("info_NewPassword", "New password")%>:</td>
				<td><input type="password" tabindex="2" class="fm" id="pwd1" /></td>
			</tr>

			<tr>
				<td class="fm-req"><%= Translate("info_ConfirmPassword", "Confirm password")%>:</td>
				<td><input type="password" tabindex="3" class="fm" id="pwd2" /></td>
			</tr>

			<tr>
				<td></td>
				<td style="text-align:right">
					<a id='btn1' class="fm-btn fm-btn-saveclose" tabindex="4"><%= Translate("btnApply", "Apply")%></a>
				</td>
			</tr>

			</tbody>
		</table>
	</div>
	<div id="message"></div>
</div>

<script type="text/javascript">
AX.Auth_ChangePasswordDialog= function($panel, input, ticket, wnd) {
	var userID= input.split('=')[1];
	var $pwd= $("#pwd", $panel);
	var $pwd1= $("#pwd1", $panel);
	var $pwd2= $("#pwd2", $panel);
	$pwd.focus();


	var onchanged= function(result) {
		var res= result.d;
		if (res != "") AX.Window.alert(res);
		else {
			$("#pwd_form", $panel).hide();
			$("#btn1", $panel).hide();
			$("#message").html("<h3 style='text-align:center;color:#2d98f3;padding:10px'><%= Translate("info_msg_PasswordChanged", "Password has been changed.")%></h3>");
		}
	}
	$("#btn1", $panel).click($createDelegate(function() {
		var s0= $pwd.val().trim();
		var s1= $pwd1.val().trim();
		var s2= $pwd2.val().trim();
		if (s0 == "" || s1 == "" || s2 == "") {AX.Window.alert("<%= Translate("Alert")%>", "<%= Translate("info_msg_CompleteAll", "Please, complete all required fields.")%>");return;}
		if (s1 != s2) {AX.Window.alert("<%= Translate("Alert")%>", "<%= Translate("info_msg_PasswordConfirmFailed", "The 'Confirm password' does not match with the 'New password',<br/>please re-type it.")%>");return;}
		var url= App.SystemPath + "Auth/Service.asmx/ChangePassword";
		ExecuteService("{\"oldPassword\":\""+jsonEncode(s0)+"\",\"newPassword\":\""+jsonEncode(s1)+"\"}", url, onchanged);
	}, this));
}
</script>

