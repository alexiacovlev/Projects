<%@ Control Language="C#" Inherits="AX.PortalAdmin.UserManagement.BaseHtmlUserControl" ScriptClientType="AX.UM_ChangePasswordDialog" %>
<div id="message" style="padding:10px;font-style:italic;color:#5d5d5d;font-size:8pt;">
	<%= (!AX.PortalAdmin.UserManagement.Handler.WebConfig_AllowSimplePassword) ? String.Format(Translate("Req_PasswordCommentMask", "The password must be at least {0} characters in length<br />and must contain at least one special character e.g. @ or #."), Membership.MinRequiredPasswordLength) : "" %>&nbsp;
</div>
<table id="table1" style='padding-left:10px'>
	<tr>
		<td style='width:130px;'><%= Translate("ChPwd_NewPassword", "New password") %>:</td>
		<td><input id='pwd' style='width:255px' /></td>
	</tr>
</table>
<div style='position:absolute;right:18px;bottom:15px;'>
	<a id='btn1' class='fm-btn' style='font-weight:bold;margin-right:8px;min-width:70px;'><%= Translate("btnSubmit", "Submit") %></a>
	<a id='btn2' class='fm-btn' style='min-width:70px;'><%= Translate("btnClose", "Close") %></a>
</div>

<script type="text/javascript">
AX.UM_ChangePasswordDialog= function($panel, input, ticket, wnd) {
	var userID= input.split('=')[1];
	this.wnd= wnd;
	wnd.setHeader("<%= Translate("ChPwd_Header", "Change user password") %>");

	var $pwd= $("#pwd", $panel);
	$pwd.focus();

	var onchanged= function(result) {
		var res= result.d;
		if (res != "") AX.Window.alert("Error", res);
		else {
			$("#table1", $panel).hide();
			$("#btn1", $panel).hide();
			$("#message").html("<h3 style='text-align:center;color:#2d98f3'><%= Translate("ChPwd_msg_changed", "Password has been changed.") %></h3>");
		}
	}
	$("#btn1", $panel).click($createDelegate(function() {
		var password= $pwd.val().trim();
		if (password == "") return;
		var url= "/ASP.Net/WebAdmin/UserManagement/Service.asmx/ChangePassword";
		ExecuteService("{\"id\":\""+userID+"\",\"password\":\""+jsonEncode(password)+"\"}", url, onchanged);
	}, this));
	$("#btn2", $panel).click(function() { wnd.close(); });
}
</script>
