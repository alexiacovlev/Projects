<%@ Control Language="C#" Inherits="AX.PortalAdmin.UserManagement.BaseHtmlUserControl" ScriptClientType="AX.UM_CreateUserDialog" %>
<style type="text/css">
	#NewUserForm div.section_hdr {font-family:Verdana;font-size:9pt;color:#3c8ff7;border-bottom:solid 1px gray;padding:3px;margin-bottom:3px;}
	#NewUserForm #ErrorMessage {color:Red;padding-left:5px;padding-top:5px;text-align:center;font-size:9pt;}
	#NewUserForm td {padding:2px;}
	#NewUserForm td.lbl_r {font-weight:bold;text-align:left;padding-left:18px;}
	#NewUserForm td.lbl {text-align:left;padding-left:18px;}
	#NewUserForm td input {width:100%;}
</style>
<div id="NewUserForm">
	<table style="width:100%;height:100%;table-layout:fixed;">
		<colgroup>
			<col width="130px"/>
			<col />
		</colgroup>
		<tr>
			<td colspan="2" style="margin-top:0px;margin-bottom:4px;font-size:10pt;font-family:Verdana;font-weight:bold;"><%= Translate("Reg_Header", "Create a New Account")%></td>
		</tr>
		<tr style="height:30px">
			<td colspan="2" style="padding:2px 10px 2px 20px" id="message"><%= Translate("Reg_Description", "Please, complete all required (bolded) fields to create a new account") %></td>
		</tr>
	</table>
	<div>
		<br />
		<table style="table-layout:fixed;width:98%;" align="center">
			<colgroup>
				<col width="170px" />
				<col width="270px" />
				<col />
			</colgroup>
			<tr>
				<td colspan="3">
					<div class="section_hdr"><%= Translate("Reg_Section1", "General Info")%></div>
				</td>
			</tr>
			<tr>
				<td class="lbl_r"><%= Translate("Reg_UserName", "User name (login)")%></td>
				<td><input id="UserName" /></td>
				<td></td>
			</tr>
			<tr>
				<td class="lbl"><%= Translate("Reg_FirstName", "First Name")%></td>
				<td><input id="FirstName" /></td>
				<td></td>
			</tr>

			<tr>
				<td class="lbl"><%= Translate("Reg_LastName", "Last Name")%></td>
				<td><input id="LastName" /></td>
				<td></td>
			</tr>			
			<tr>
				<td class="lbl_r"><%= Translate("Reg_Email", "E-mail")%></td>
				<td><input id="Email" /></td>
				<td></td>
			</tr>

			<% if (!AX.PortalAdmin.UserManagement.Handler.WebConfig_AllowSimplePassword) { %>
			<tr>
				<td></td>
				<td colspan="2" style="padding:5px 0 0 0;font-style:italic;color:#5d5d5d;font-size:8pt;"><%= String.Format(Translate("Req_PasswordCommentMask", "The password must be at least {0} characters in length<br />and must contain at least one special character e.g. @ or #."), Membership.MinRequiredPasswordLength) %></td>
			</tr>
			<% } %>
			<tr>
				<td class="lbl_r"><%= Translate("Reg_Password", "Password")%></td>
				<td><input type="text" id="Password" /></td>
				<td></td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
			</tr>

			<tr>
				<td colspan="3">
					<div class="section_hdr"><%= Translate("Reg_Section2", "Account Properties")%></div>
				</td>
			</tr>

			<tr>
				<td class="lbl"><%= Translate("Reg_PortalRole", "Portal Role")%>:</td>
				<td>
					<select id="RoleName" style="width:252px;height:20px;font-size:9pt;"><%= GeneratePortalRolesList() %></select>
				</td>
				<td></td>
			</tr>

			<tr>
				<td colspan="3" style="height:40px;"><div id="ErrorMessage"></div></td>
			</tr>
		</table>

		
	</div>
	<div style="position:absolute;bottom:8px;right:8px;">
		<a class="fm-btn" id="btnCreate" style="min-width:100px;font-weight:bold"><%= Translate("btnRegister", "Register")%></a>
		<a class="fm-btn" id="btnClose" style="min-width:60px;margin-left:5px"><%= Translate("btnClose", "Close")%></a>
	</div>
</div>
<script language="javascript">
	AX.UM_CreateUserDialog= function ($panel, input, ticket, wnd) {
		wnd.setHeader("");
		var username_min= 4;
		var password_min= <%= (AX.PortalAdmin.UserManagement.Handler.WebConfig_AllowSimplePassword) ? 1 : Membership.MinRequiredPasswordLength %>;
		var msg_Required= "<%= Translate("Reg_msg_Required", "The field is required. Please, type value for it.")%>";
		var msg_UserName_Length= "<%= Translate("Reg_msg_UserNameLength", "The User name must contain more characters.")%>";
		var msg_WrongEmail= "<%= Translate("Reg_msg_WrongEmail", "You've typed wrong email, please correct it.")%>";
		var msg_Password_Length= "<%= Translate("Reg_msg_PasswordLength", "The Password must contain more characters.")%>";

		var $p= $panel;
		var IsValid= false;

		$('#UserName', $p).focus();
				
		$('#btnCreate', $p).click(function () {
			var data= new Object();
			data.UserName= ValidateAndGetValue("UserName", true);if (!IsValid) return;
			ValidateUserName();if (!IsValid) return;
			data.Email= ValidateAndGetValue("Email", true);if (!IsValid) return;
			ValidateEmail();if (!IsValid) return;
			data.FirstName= ValidateAndGetValue("FirstName", false);
			data.LastName= ValidateAndGetValue("LastName", false);
			data.Password= ValidateAndGetValue("Password", true);if (!IsValid) return;
			ValidatePassword();if (!IsValid) return;
			data.RoleName= ValidateAndGetValue("RoleName", false);
			ExecuteService("{\"data\":"+JSON.stringify(data)+"}", "/ASP.Net/WebAdmin/UserManagement/Service.asmx/CreateUser", Service_OnRegister);
		});

		$('#btnClose', $p).click(function () {
			wnd.close();
		});

		function Service_OnRegister(result) {
			var res= result.d
			if (res != "") {
				$("#ErrorMessage", $p).text(res);
			} else {
				wnd.loadHTML("<h2>Done.</h2>");
				wnd.setSize(300, 200);
				wnd.returnValue= true;
				wnd.close();
			}
		}
		
		function ValidateAndGetValue(id, req) {
			IsValid= true;
			var $o= $("#"+id, $p);
			var v= $o.val();
			var msg= null;
			if (req && v == "") { 
				msg= msg_Required;
				IsValid= false;
				Notify($o, msg, false);
			}
			return v;
		}

		function Notify($o, msg, reset) {
			if (!$o[0].tt) $o[0].tt= new FM.Tooltip($o.parent(), 3, -26);
			$o[0].tt.Show(msg, true);
			if (reset) $o.val("");
		}

		function ValidateEmail() {
			var $o= $("#Email", $p);
			var email= $o.val();
			var emailPattern= /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;  
			if (!emailPattern.test(email)) { IsValid=false; Notify($o, msg_WrongEmail); }
		}

		function ValidatePassword() {
			var $o= $("#Password", $p);
			var password= $o.val();
			if (password.length < password_min) { IsValid=false; Notify($o, msg_Password_Length); }
		}

		function ValidateUserName() {
			IsValid= true;
			var $o= $('#UserName', $p);
			var v= $o.val();
			if (v.length < username_min) { IsValid= false; Notify($o, msg_UserName_Length); }
		}
		
}
</script>