<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Registration.ascx.cs" Inherits="AX.PortalShell.Auth.Registration" %>
<style type="text/css">
	#Reg div.section_hdr {color:#3c8ff7;border-bottom:solid 1px gray;padding:3px;margin-bottom:3px;}
	#Reg #ErrorMessage {color:Red;padding-left:5px;padding-top:5px;text-align:center;font-size:9pt;}
	#Reg td {padding:4px;}
	#Reg td.lbl_r {font-weight:bold;text-align:right;padding-right:8px;}
	#Reg td.lbl {text-align:right;padding-right:8px;}
	#Reg td input {width:100%;}
	#Reg td.comment {font-style:italic;color:#5d5d5d;font-size:0.8em;padding-left:163px;}
</style>
<div id="Reg" class="axdlg" style="margin:50px auto 0 auto;width:600px;">
	<div class="axdlg-header"><%= Translate("Header", "Create a New Account")%></div>
	<div class="axdlg-desc" id="message"><%= Translate("Description", "Please, complete all required (bolded) fields to create a new account") %></div>
	<div class="axdlg-body" style="padding:10px;">
	<table style="table-layout:fixed;width:100%">
		<colgroup>
			<col width="180" />
			<col width="250" />
			<col />
		</colgroup>
		<tr>
			<td class="lbl_r"><%= Translate("User name (login)")%></td>
			<td><input id="UserName" class="fm" /></td>
			<td></td>
		</tr>
		<tr>
			<td class="lbl"><%= Translate("First Name")%></td>
			<td><input id="FirstName" class="fm" /></td>
			<td></td>
		</tr>

		<tr>
			<td class="lbl"><%= Translate("Last Name")%></td>
			<td><input id="LastName" class="fm" /></td>
			<td></td>
		</tr>
		<tr>
			<td class="lbl_r"><%= Translate("E-mail")%></td>
			<td><input id="Email" class="fm" /></td>
			<td></td>
		</tr>

		<tr>
			<td colspan="3" class="comment">The password must be at least <%= Membership.MinRequiredPasswordLength %> characters in length<br /><%= (Membership.MinRequiredNonAlphanumericCharacters > 0) ? "and must contain at least one special character e.g. @ or #." : "" %></td>
		</tr>
		<tr>
			<td class="lbl_r"><%= Translate("Password")%></td>
			<td><input type="password" class="fm" id="Password" /></td>
			<td id="PasswordHint" style="padding-left:7px;font-weight:bold"></td>
		</tr>

		<tr>
			<td class="lbl_r"><%= Translate("Confirm password")%></td>
			<td><input type="password" class="fm" id="ConfirmPassword" /></td>
			<td></td>
		</tr>

		<% if (Membership.RequiresQuestionAndAnswer) { %>
		<tr>
			<td colspan="3" class="comment">The security question can help recover your password,<br />in case you forgot it.</td>
		</tr>
		<tr>
			<td class="lbl_r"><%= Translate("Security question")%></td>
			<td>
				<select id="Question" style="width:252px;height:21px">
					<%= DropDownTextOption("Question_1", "What is your favorite pet's name?")%>
					<%= DropDownTextOption("Question_2", "What is the name of your favorite childhood friend?")%>
					<%= DropDownTextOption("Question_3", "What was your childhood nickname?")%>
					<%= DropDownTextOption("Question_4", "What was the color of your first car?")%>
					<%= DropDownTextOption("Question_5", "In what city or town was your first job?")%>
					<%= DropDownTextOption("Question_6", "Where did you vacation last year?")%>
					<%= DropDownTextOption("Question_7", "What is your mother's maiden name?")%>
				</select>
			</td>
			<td></td>
		</tr>

		<tr>
			<td class="lbl_r"><%= Translate("Your answer")%>:</td>
			<td><input id="Answer" /></td>
			<td></td>
		</tr>
		<% } %>

		<tr>
			<td>
				<div id="ErrorMessage"></div>
			</td>
		</tr>
		<tr>
			<td>
				<a style="font-size: 0.8em;cursor:pointer;color:#1872f8;" id="backLink">Back to Login</a>
			</td>
			<td colspan="2" style="text-align:right">
				<button id="btnCreate" class="ax-btn" style="width:140px">Register</button>
			</td>
		</tr>
	</table>

	</div>
</div>
<script type="text/javascript">
	$(function () {
		var requireEmailValidation= <%= this.RequireEmailValidation().ToString().ToLower() %>;
		var password_min= <%= Membership.MinRequiredPasswordLength %>;
		var password_special_require= <%= (Membership.MinRequiredNonAlphanumericCharacters > 0).ToString().ToLower() %>;
		var requiresQuestionAndAnswer= <%= Membership.RequiresQuestionAndAnswer.ToString().ToLower() %>;
		var password_min_strength_level= password_special_require ? 3 : 1;

		var username_min= 4;
		var msg_Required= "Please, fill up this field";
		var msg_PasswordStrongLevel= "Please, enforce your password with upper case letters or numbers.";
		var msg_PasswordStrongLevel_special= "Please, enforce your password with numbers and special characters.";
		var msg_UserName_Length= "The User name(login) must be " + username_min + " characters in length.";
		var msg_UserName_Dublicated= "Sorry, this User name is busy. Please, type another one.";
		var msg_WrongEmail= "You've typed wrong email, please correct it.";
		var msg_ConfirmPasssword= "The Confirm password does not match with the Password, please re-type it.";
		
		var $p= $('#Reg');
		var $wnd = $p.parent();
		$('#UserName', $p).focus();
		var IsAdminMode= false;
		var IsValid= false;

		$('#backLink', $p).click(function () {
			App_Login(true);
		});

		$('#btnCreate', $p).click(function () {
			var data= new Object();
			data.UserName= ValidateAndGetValue("UserName", true);if (!IsValid) return;
			ValidateUserName();if (!IsValid) return;
			data.Email= ValidateAndGetValue("Email", true);if (!IsValid) return;
			ValidateEmail();if (!IsValid) return;
			data.FirstName= ValidateAndGetValue("FirstName", false);
			data.LastName= ValidateAndGetValue("LastName", false);
			data.Password= ValidateAndGetValue("Password", true);if (!IsValid) return;
			if (strength < password_min_strength_level) {//must be Good
				Notify($("#Password", $p), (password_special_require&&!strength_special?msg_PasswordStrongLevel_special:msg_PasswordStrongLevel), true);
				return;
			}
			var pwd2= ValidateAndGetValue("ConfirmPassword", true);if (!IsValid) return;
			if (data.Password != pwd2) { Notify($("#ConfirmPassword", $p), msg_ConfirmPasssword, true); return; }

			if (requiresQuestionAndAnswer) {
				data.Question= $("Question", $p).val();
				data.Answer= ValidateAndGetValue("Answer", true);if (!IsValid) return;
			}

			$("#ErrorMessage", $p).html("<label style='color:#5d5d5d'>registering ...</label>");
			$('#btnCreate', $p).attr('disabled', 'disabled');
			ExecuteService("{\"data\":"+JSON.stringify(data)+"}", App.SystemPath + "Auth/Service.asmx/Registration", Service_OnRegister);
		});

		function Service_OnRegister(result) {
			var res= result.d;
			$('#btnCreate', $p).removeAttr('disabled');
			$("#ErrorMessage", $p).empty();

			if (res != "") {
				$("#ErrorMessage", $p).text(res);
			} else {
				var w= $("<div class='dialogWithDropShadow' style='position:relative;padding:5px;width:470px;height:260px;margin:100px auto 0 auto;'></div>");
				App.UI.Content.empty().append(w);
				if (requireEmailValidation) window.location.href= "#/USER-REG-ENTER";
				else w.load(App.SystemPath + "Component.aspx?path=Auth/Registration_Success.ascx").fadeIn(300);
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
			$o[0].tt.Show(msg, false);
			if (reset) $o.val("");
			$o.focus().one('keypress',function() { this.tt.Hide(); });
		}

		function ValidateEmail() {
			var $o= $("#Email", $p);
			var email= $o.val();
			var emailPattern= /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
			if (!emailPattern.test(email)) { IsValid=false; Notify($o, msg_WrongEmail); }
		}

		function ValidateUserName() {
			IsValid= true;
			var $o= $('#UserName', $p);
			var v= $o.val();
			if (v.length < username_min) { IsValid= false; Notify($o, msg_UserName_Length); }
		}

		$('#UserName', $p).change(function() {
			var $o= $(this);
			var v= $o.val();
			if (v != "") {
				ValidateUserName();if (!IsValid) return;
				ExecuteService("{\"username\":\""+jsonEncode(v)+"\"}", App.SystemPath + "Auth/Service.asmx/CheckName", Service_OnCheckName);
			}
		});

		$('#ConfirmPassword', $p).change(function() {
			var $o= $(this);
			if ($o.val() != "" && $o.val() != $('#Password', $p).val()) Notify($o, msg_ConfirmPasssword);
		});

		var strength= 0;
		var strength_special= false;

		$('#Password', $p).keyup(function() {
			var $o= $(this);
			var password= $o.val().trim();
			var s= "";
			strength= 0;
			strength_special= false;
			var $h= $("#PasswordHint", $p);
			if (password.length > 0) {
		    if (password.length < 6) {
					strength= 0;
				} else {
					if (password.match(/([a-z])/)) strength+= 1;
					if (password.match(/([A-Z])/)) strength+= 1;
					if (password.match(/([0-9])/)) strength+= 1;
					strength_special= password.match(/(^.*[^a-zA-Z0-9].*$)/);
					if (strength_special) strength+= 2;
					else if (strength == 3 && password_special_require) strength-= 1;
				}

				switch (strength) {
					case 0: $h.text("too short").css('color', '#FF0000'); break;
					case 1: $h.text("weak").css('color', '#e66c2c'); break;
					case 2: $h.text("weak").css('color', '#34495e'); break;
					case 3: $h.text("Good").css('color', '#2d98f3'); break;
					case 4: $h.text("Strong").css('color', '#006400'); break;
					case 5: $h.text("High security").css('color', '#2d98f3'); break;
				}
			} else {
				$h.text("");
			}
		});

		function Service_OnCheckName(result) {
			var res= result.d
			if (res) Notify($('#UserName', $p), msg_UserName_Dublicated, false);
		}

		$('#Email', $p).change(function() {
			if ($(this).val() != "") ValidateEmail();
		});

	});

</script>