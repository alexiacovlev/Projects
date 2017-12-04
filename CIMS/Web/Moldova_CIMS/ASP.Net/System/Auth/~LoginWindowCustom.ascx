<%@ Control Language="C#" Inherits="AX.Kernel.UI.UserControl" %>
<style type="text/css">
ul.features {
    list-style: none;
    line-height: 17px;
    overflow: hidden;
    margin: 2em 0 0;
}
ul.features li {
    margin: 3px 0 2em;
}
ul.features img {
    float: left;
    margin: -3px 0 0;
}
ul.features p {
    margin: 0 0 0 68px;
		line-height:17px;
}

ul.features .title {
    font-size: 16px;
    margin-bottom: 0.3em;
}



#LoginForm {
font-family: arial, helvetica;
font-size:9pt;
}

#LoginForm input {
	height:25px;font-size:12pt;
	border-radius:4px;
}


</style>
<div id="LoginWindow" style="border-top:solid 1px #e5e5e5; background-color:#FFF;padding:10px 80px;height:100%;">
<table style="width:100%;height:100%">
	<tr>
		<td style="font-family: arial, helvetica, sans-serif;color: rgb(111, 111, 111);font-size:12px;">

<div class="product-info mail" id="left_content" name="left_content">
<div class="product-headers">
  <h1 style="color:#dd4b39;font-weight: 400;font-size:25px;">Construction Permit Management Information System</h1>
  <h2>Reviewers Login Area.</h2>
</div>
  <p style="line-height:17px;">
  This part of the system can only be accessed by registered reviewers. If you want more information, please contact the System Administrator. Registered reviewers can:
</p>
<ul class="features">
  <li>
  <img alt="" src="/images/logincustom/users_2.png">
  <p class="title">Activate/De-Activate Client Accounts</p>
  <p>
  New client accounts require activation before they can submit applications.
  </p>
  </li>

  <li>
  <img alt="" src="/images/logincustom/documents.png">
  <p class="title">Assess Submitted Applications</p>
  <p>
  Access applications submitted by clients and submit your comments.
  </p>
  </li>

   <li>
  <img alt="" src="/images/logincustom/graph.png">
  <p class="title">Monitor Progress Of Applications</p>
  <p>
  Using various reports you can monitor the progress of applications in various stages of approval.
  </p>
  </li>

  <li>
  <img alt="" src="/images/logincustom/tick.png">
  <p class="title">Issue Permits</p>
  <p>
  Issue permits to approved applications. Permits are received online and can be printed out.
  </p>
  </li>

</ul>
<ul class="mail-links">
  <li><a href="#">
  About MasterPMIS</a></li>
  <li><a href="#">Contact System Administrator </a></li>
</ul>
<p>&nbsp;</p>
  </div>


		</td>




		<td>
<div style="width:350px;background-color:#f1f1f1;border:solid 1px #e5e5e5;padding-left:10px;padding-bottom:10px;">
<table id="LoginForm" cellspacing="4" cellpadding="4" style="width:100%;">
	<tr>
		<td style="font-size:14pt;padding-top:10px;">Sign in</td>
	</tr>


	<tr>
		<td>
			<label for="UserName" style="font-family:Verdana;font-weight:bold;padding-right:8px;"><%= Translate("login_UserName", "User name") %></label>
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" name="UserName" id="UserName" class="text" style="width:95%;padding-bottom:2px;" />
		</td>
	</tr>
	<tr>
		<td>
			<label for="Password" style="font-family:Verdana;font-weight:bold;padding-right:10px;"><%= Translate("login_Password", "Password") %></label>
		</td>
	</tr>
  <tr>
		<td style="position:relative;">
			<input type="password" name="Password" id="Password" class="text" style="width:95%;padding-bottom:2px;" />
			<div style="right:12px;top:94px">
				<a style="font-family:Verdana;cursor:pointer;color:#1872f8;" id="forgotLink"><%= Translate("login_Forgot", "Forgot password?") %></a>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<label for="Persistance" style="font-family:Verdana;cursor:pointer;margin-right:5px;"><%= Translate("login_Keep", "Keep me signed in") %><input type="checkbox" id="Persistance" name="Persistance" style="cursor:pointer;vertical-align:middle;" /></label>
		</td>
	</tr>
	<tr>
		<td style="position:relative;">
				<label style="font-family:Verdana;font-weight:bold"><%= Translate("login_NotRegistered", "Not registered?") %></label>
				<a style="font-family:Verdana;cursor:pointer;color:#1872f8;" id="registerLink"><%= Translate("login_Register", "Register Now") %></a>
		</td>
	</tr>
	<tr>
		<td align="right" style="padding-right:10px;height:18px;"><label id="status" style="color:gray;" /><label id="msg" style="color:red;font-size:9pt;" /></td>
	</tr>
	<tr>
		<td align="right">
				<button id="loginOK" style="width:90px;font-weight:bold;font-size:10pt;height:28px">OK</button>&nbsp;&nbsp;
				<button id="loginClose" style="width:90px;font-size:10pt;height:28px"><%= Translate("Cancel") %></button>

		</td>
	</tr>
</table>
		</td>

	</tr>
</table>
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
			var w= $("<div class='dialogWithDropShadow' style='position:relative;padding:5px;width:580px;height:450px;margin:50px auto 0 auto;'></div>");
			App.UI.Content.append(w);
			w.hide();
			w.load(App.SystemPath + "Component.aspx?path=Auth/Registration.ascx");
			w.fadeIn(300);
			<% } %>
		});

		$('#forgotLink', $form).click(function () {
			var $lwnd= $form.parent();
			var load= function() {$lwnd.empty().load(App.SystemPath+"Component.aspx?path=Auth/ForgotPassword.ascx").fadeIn();}
			$lwnd.fadeOut(300, load);
		});
	});

</script>










