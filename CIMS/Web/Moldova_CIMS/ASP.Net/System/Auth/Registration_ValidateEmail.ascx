<%@ Control Language="C#" Inherits="AX.Kernel.UI.UserControl" %>

<div id="ValidateUserEmail" class="dialogWithDropShadow" style="position:relative;padding:5px;width:450px;height:240px;margin:50px auto 0 auto;">
	<table style="width:90%;table-layout:fixed;margin-top:10px;" align="center">
		<colgroup>
			<col width="140px"/>
			<col />
		</colgroup>
		<tr>
			<td colspan="2" style="margin-top:0px;margin-bottom:4px;font-size:12pt;font-family:Verdana;color:#3c8ff7;font-weight:bold;"><%= Translate("Reg_Verification_Header", "Registration. Email Verification.")%></td>
		</tr>
		<tr style="height:30px">
			<td colspan="2" style="padding-top:10px;padding-left:10px;"><%= Translate("Reg_Verification_Description", "We sent the email with verification code to your email.<br/> Please, enter the code from your email and click the button to complete registration.") %></td>
		</tr>

		<tr style='height:50px;'>
			<td align="right">
				<label for="VerificationTicket" style="font-family:Verdana;font-weight:bold;font-size:8pt;padding-right:8px;"><%= Translate("Reg_Verification_Ticket", "Verification Code") %></label>
			</td>
			<td>
				<input type="text" name="VerificationTicket" id="VerificationTicket" class="text" style="width:99%;font-size:10pt;padding-bottom:2px;" />
			</td>
		</tr>
		<tr>
			<td id="message" style="height:30px;text-align:center;font-size:10pt;vertical-align:top" colspan="2">
					
			</td>
		</tr>
		<tr>
			<td style="text-align:right;" colspan="2">
				<button id="btnSubmit" style="width:100px"><%= Translate("Submit")%></button>
			</td>
		</tr>

	</table>

	<table style="width:100%;display:none">
		<tr>
			<td style="padding:20px 0 0 30px;font-size:12pt;font-family:Verdana;color:#3c8ff7;font-weight:bold;">
				<%= Translate("Reg_Success_Header", "Congratulation!")%>
			</td>
		</tr>
		<tr>
			<td style="padding:20px 0 0 50px;font-size:10pt">
				<%= Translate("Reg_Verification_Success", "Your account has been successefuly created<br/> and approved.<br/><br/>Thank you for using our portal.")%>
			</td>
		</tr>
		<tr>
			<td style="padding:40px 0 0 0;text-align:center">
				<button id="btnReload" style="width:140px"><%= Translate("Continue")%></button>
			</td>
		</tr>
	</table>
</div>
<script type="text/javascript">
$(function () {

	var qs= location.search;
	var $panel= $("div#ValidateUserEmail");
	var $panel1= $($panel.children()[0]);
	var $panel2= $($panel.children()[1]);
	
	var $ticket= $("input#VerificationTicket", $panel1);
	$ticket.val(qs.length > 1 ? qs.substring(1) : "");
	$ticket.focus();

	var $btnSubmit= $("#btnSubmit", $panel1);
	var $message= $("#message", $panel1);
	
	var completeRegistration= function() {
		var code= $ticket.val().trim();
		if (!code) return;
		$btnSubmit.attr('disabled', 'disabled');
		$message.text('checking the code...').css('color', '#000000');

		ExecuteService("{\"code\":\""+jsonEncode(code)+"\"}", App.SystemPath + "Auth/Service.asmx/CompleteRegistration", function(result) {
			var res= result.d;
			$message.text(res);
			if (res == "") {
				$panel1.hide();
				$panel2.fadeIn(300);
			} else {
				$message.css('color', 'red');
				$btnSubmit.removeAttr('disabled');
			}
		});
	}
	
	$btnSubmit.click(completeRegistration);
	$("#btnReload", $panel2).click(function() {window.location.href="/";});

	completeRegistration();
		
});
</script>