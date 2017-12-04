<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginWindow.ascx.cs" Inherits="AX.PortalShell.Auth.LoginWindow" %>
<div id="LoginWindow" class="axdlg">
<div class="axdlg-header"><%= Translate("login_Header", "Welcome!") %></div>
<div class="axdlg-body">
	<table id="LoginForm" style="width:100%;table-layout:fixed;" cellpadding="8">
		<colgroup>
			<col width="32%"/>
			<col />
		</colgroup>
		<tr>
			<td colspan="2" style="text-align:right;"><label id="status" style="color:gray;" /><label id="msg" style="color:red;" />&nbsp;</td>
		</tr>

		<tr>
			<td style="text-align:right;white-space:nowrap;">
				<label for="UserName" style="font-weight:bold;padding-right:10px;"><%= Translate("login_UserName", "User name") %></label>
			</td>
			<td>
				<input type="text" name="UserName" id="UserName" class="fm" />
			</td>
		</tr>
		<tr>
			<td style="text-align:right;white-space:nowrap;">
				<label for="Password" style="font-weight:bold;padding-right:10px;"><%= Translate("login_Password", "Password") %></label>
			</td>
			<td>
				<input type="password" name="Password" id="Password" class="fm" />
			</td>
		</tr>
		<tr>
			<td style="text-align:right;white-space:nowrap;"><label for="Persistance" style="font-size:0.8em;vertical-align:middle;cursor:pointer;margin-right:5px;"><%= Translate("login_Keep", "Keep me signed in") %></label></td>
			<td>
				<input type="checkbox" id="Persistance" name="Persistance" class="fm-chk" />
				<a style="float:right;font-size:0.8em;cursor:pointer;color:#1872f8;" id="forgotLink"><%= Translate("login_Forgot", "Forgot password?") %></a>
			</td>
		</tr>
		<tr>
			<td style="padding:30px 0 5px 15px;vertical-align:bottom" colspan="2">
				<div style="float:left">
					<label style="font-size:0.8em;font-weight:bold"><%= Translate("login_NotRegistered", "Not registered?") %></label><br />
					<a style="font-size:0.8em;cursor:pointer;color:#1872f8;" id="registerLink"><%= Translate("login_Register", "Register Now") %></a>
				</div>
				<div style="float:right;margin-top:20px;">
					<button id="loginOK" class="ax-btn" style="min-width:100px"><%= Translate("login_OK", "Log In") %></button>
					<button id="loginClose" class="ax-btn" style="min-width:70px;margin-left:10px;display:none"><%= Translate("Cancel") %></button>
				</div>
			</td>
		</tr>
	</table>
</div>
</div>
<script type="text/javascript">
	$(function() {
		var $wnd= $('#LoginWindow').parent();
		var $form= $('#LoginForm', $wnd);
		var is_busy= false;
		var $UserName= $('#UserName', $form);
		var $Password= $('#Password', $form);
		$UserName.focus();
		$Password.keyup(function(e){if (e.keyCode==13)$('#loginOK', $form).click();});
		$('#Persistance', $form).keyup(function(e){if (e.keyCode==13)$('#loginOK', $form).click();});

		$('#loginOK', $form).click(function () {
			if (is_busy) return;
			var l= $UserName.val();
			var p= $Password.val();
			if (l.indexOf('\'') != -1 || l.indexOf('\\') != -1 || p.indexOf('\'') != -1 || p.indexOf('\\') != -1) { $('#msg', $form).html("<%= Translate("login_badparameters", "The name or password contains wrong characters") %>"); return; }
			var ps= $('#Persistance', $form).is(':checked');

			if (l == "") {
				$('#msg', $form).html("<%= Translate("login_UserName_required", "Please, enter User name") %>");
				$UserName.focus();
			} else if (p == "") {
				$('#msg', $form).html("<%= Translate("login_Password_required", "Please, enter Password") %>");
				$Password.focus();
			} else {
				$('#msg', $form).html("");
				$('#status', $form).html("<%= Translate("login_logging", "logging in") %> ...");
				is_busy= true;
				App_SignIn(l, p, ps, function (msg) { $('#status', $form).html(""); $('#msg', $form).html(msg); is_busy= false; });
			}

		});

		$('#loginClose', $form).click(function () {
			$wnd.css({display:'none'});
		});

		$('#registerLink', $form).click(function () {
			<% if (AX.PortalShell.Auth.Registration.IsCustom) { %>
			if (window.location.href.indexOf("#Registration") == -1) window.location.href= "#Registration"; else App_LoadTabContent();
			<% } else { %>
			App.UI.Content.empty();
			var w= $("<div></div>");
			App.UI.Content.append(w);
			w.hide().load(App.SystemPath + "Component.aspx?path=Auth/Registration.ascx").fadeIn(300);
			<% } %>
		});

		$('#forgotLink', $form).click(function () {
			App.UI.Content.empty();
			var w= $("<div></div>");
			App.UI.Content.append(w);
			w.hide().load(App.SystemPath + "Component.aspx?path=Auth/ForgotPassword.ascx").fadeIn(300);
			//var $lwnd= $form.parent();
			//var load= function() {$lwnd.empty();$lwnd.load(App.SystemPath+"Component.aspx?path=Auth/ForgotPassword.ascx").fadeIn();}
			//$lwnd.fadeOut(300, load);
		});
	});

</script>