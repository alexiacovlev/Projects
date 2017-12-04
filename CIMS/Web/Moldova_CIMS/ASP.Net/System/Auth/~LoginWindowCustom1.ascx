<%@ Control Language="C#" Inherits="AX.Kernel.UI.UserControl" %>
<div id="LoginWindow" class="dialogWithDropShadow" style="position:relative;padding:5px;width:420px;height:210px;margin:80px auto 0 auto;">
<table id="LoginForm" style="width:100%;height:100%;table-layout:fixed;">
	<colgroup>
		<col width="140px"/>
		<col />
	</colgroup>
	<tr style="height:18px">
		<td colspan="2" align="right" style="padding-right:10px"><label id="status" style="color:gray;" /><label id="msg" style="color:red;font-size:9pt;" /></td>
	</tr>

	<tr style='height:30px;'>
		<td align="right">
			<label for="UserName" style="font-family:Verdana;font-weight:bold;font-size:8pt;padding-right:8px;"><%= Translate("login_UserName", "User name") %></label>
		</td>
		<td>
			<input type="text" name="UserName" id="UserName" class="text" style="width:95%;font-size:10pt;padding-bottom:2px;" />
		</td>
	</tr>
	<tr style='height:30px;'>
		<td align="right">
			<label for="Password" style="font-family:Verdana;font-weight:bold;font-size:8pt;padding-right:10px;"><%= Translate("login_Password", "Password") %></label>
		</td>
		<td>
			<input type="password" name="Password" id="Password" class="text" style="width:95%;font-size:10pt;padding-bottom:2px;" />
			<div style="position:absolute;right:12px;top:94px">
				<a style="font-family:Verdana;font-size:8pt;cursor:pointer;color:#1872f8;" id="forgotLink"><%= Translate("login_Forgot", "Forgot password?") %></a>
			</div>
		</td>
	</tr>
	<tr>
		<td align="right"><label for="Persistance" style="font-family:Verdana;font-size:8pt;vertical-align:text-top;cursor:pointer;margin-right:5px;"><%= Translate("login_Keep", "Keep me signed in") %></label></td>
		<td><input type="checkbox" id="Persistance" name="Persistance" style="cursor:pointer" /></td>
	</tr>
	<tr>
		<td colspan="2" style="position:relative;">
			<div style="position:relative;left:5px">
				<label style="position:relative;font-family:Verdana;font-size:8pt;font-weight:bold"><%= Translate("login_NotRegistered", "Not registered?") %></label><br />
				<a style="position:relative;top:3px;font-family:Verdana;font-size:8pt;cursor:pointer;color:#1872f8;" id="registerLink"><%= Translate("login_Register", "Register Now") %></a>
			</div>
			<div style="position:absolute;right:2px;bottom:2px;">
				<button id="loginOK" style="width:80px;font-weight:bold;height:24px">OK</button>&nbsp;&nbsp;
				<button id="loginClose" style="width:80px;height:24px"><%= Translate("Cancel") %></button>
			</div>

		</td>
	</tr>
</table>
<% if (AX.PortalShell.Auth.AuthService.PINRequired) { %>
<table id="PINForm" style="width:100%;height:100%;table-layout:fixed;display:none">
	<colgroup>
		<col width="140px"/>
		<col />
	</colgroup>
	<tr style='height:20px;'>
		<td colspan="2" style="padding:10px;font-weight:bold">
			PIN VALIDATION
		</td>
	</tr>
	<tr style='height:30px;'>
		<td colspan="2" style="padding:0px 20px;line-height:12pt;">
			<label>To continue authentification, </label><br /><label>please check your email </label><label id="pinEmail"></label><br /><label>and type in PIN code below.</label>
		</td>
	</tr>
	<tr style='height:20px;'>
		<td colspan="2" align="right" style="padding-right:10px;">
			<label id="pin_status" style="color:gray;" /><label id="pin_msg" style="color:red;font-size:9pt;" />
		</td>
	</tr>
	<tr style='height:30px;'>
		<td align="right">
			<label for="PIN" style="font-family:Verdana;font-weight:bold;font-size:8pt;padding-right:8px;"><%= Translate("login_PIN", "PIN") %></label>
		</td>
		<td>
			<input type="text" name="PIN" id="PIN" class="text" style="width:95%;font-size:10pt;padding-bottom:2px;" maxlength="4" />
		</td>
	</tr>
	
	<tr>
		<td colspan="2" style="position:relative;">
			<div style="position:absolute;right:2px;bottom:2px;">
				<button id="btnOK" style="width:80px;font-weight:bold;height:24px">OK</button>&nbsp;&nbsp;
				<button id="btnCancel" style="width:80px;height:24px"><%= Translate("Cancel") %></button>
			</div>
		</td>
	</tr>
</table>
</div>
<% } %>
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

		var $pinform= $('#PINForm', $wnd);
		var $pin= $('#PIN', $pinform);
		var l, p, ps;

		$('#loginOK', $form).click(function () {
			if (is_busy) return;
			l= $UserName.val();
			p= $Password.val();
			if (l.indexOf('\'') != -1 || l.indexOf('\\') != -1 || p.indexOf('\'') != -1 || p.indexOf('\\') != -1) { $('#msg', $form).html("<%= Translate("login_badparameters", "The name or password contains wrong characters") %>"); return; }
			ps= $('#Persistance', $form).is(':checked');

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

				<% if (AX.PortalShell.Auth.AuthService.PINRequired) { %>
				ExecuteService("{userName:'" + l + "', password:'" + p + "', persistent: '" + ps + "'}", App.SystemPath + "Auth/PinService.asmx/PreAuthenticate", 
					function (res) { 
						is_busy= false; 
						$('#status', $form).html("");
						var email= res.d;
						$('#pinEmail', $pinform).text(email);
						$form.hide();
						$pinform.fadeIn(300);
						
						$pin.val("").focus();
					}, 
					function (msg) { 
						$('#status', $form).html(""); $('#msg', $form).html(msg); is_busy= false; 
					});
				<% } else { %>
				App_SignIn(l, p, ps, function (msg) { $('#status', $form).html(""); $('#msg', $form).html(msg); is_busy= false; });
				<% } %>
			}

		});

		$('#loginClose', $form).click(function () {
			$wnd.css({display:'none'});
		});

		$('#registerLink', $form).click(function () {
			<% if (AX.PortalShell.Auth.Registration.IsCustom) { %>
			if (window.location.href.indexOf("#Registration") == -1) window.location.href= "#Registration"; else App_LoadTabContent();
			<% } else { %>
			App.Content.empty();
			var w= $("<div class='dialogWithDropShadow' style='position:relative;padding:5px;width:580px;height:450px;margin:50px auto 0 auto;'></div>");
			App.Content.append(w);
			w.hide();
			w.load(App.SystemPath + "Component.aspx?path=Auth/Registration.ascx");
			w.fadeIn(300);
			<% } %>
		});

		$('#forgotLink', $form).click(function () {
			var $lwnd= $form.parent();
			var load= function() {$lwnd.empty();$lwnd.load(App.SystemPath+"Component.aspx?path=Auth/ForgotPassword.ascx").fadeIn();}
			$lwnd.fadeOut(300, load);
		});



		<% if (AX.PortalShell.Auth.AuthService.PINRequired) { %>
			
			$('#btnOK', $pinform).click(function () {
				if (is_busy) return;
				var pin= $pin.val();
				if (pin.length == 0 || pin.indexOf('\'') != -1 || pin.indexOf('\\') != -1) return;

				$('#pin_msg', $pinform).html("");
				$('#pin_status', $pinform).html("<%= Translate("login_logging", "logging in") %> ...");

				ExecuteService("{pin:'" + pin + "', userName:'" + l + "', password:'" + p + "', persistent: '" + ps + "'}", App.SystemPath + "Auth/PinService.asmx/AuthenticateWithPIN", 
					App_Reload,
					function (msg) { is_busy= false; $('#pin_status', $pinform).html(""); $('#pin_msg', $pinform).html(msg);  }
				);
			});
			$('#btnCancel', $pinform).click(function () {
				$Password.val("");
				$pinform.hide();
				$form.fadeIn(300);
			});
		<% } %>



	});

</script>