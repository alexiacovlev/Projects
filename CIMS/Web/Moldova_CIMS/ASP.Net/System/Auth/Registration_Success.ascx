<%@ Control Language="C#" Inherits="AX.Kernel.UI.UserControl" ResourceName="UserManagement" %>
<table style="width:100%;">
	<tr>
		<td style="padding:40px 0 0 30px;font-size:12pt;font-family:Verdana;color:#3c8ff7;font-weight:bold;">
			<%= Translate("Reg_Success_Header", "Congratulation!")%>
		</td>
	</tr>
	<tr>
		<td style="padding:20px 0 0 50px;font-size:10pt">
			<%= Translate("Reg_Success", "Your account has been successefuly created.<br/>The email with the registration data has been sent on<br/>your mail box.<br/><br/>Thank you for using our portal.")%>
		</td>
	</tr>
	<tr>
		<td style="padding:40px 0 0 0;text-align:center">
			<button style="width:140px" onclick="App_Reload();"><%= Translate("Continue")%></button>
		</td>
	</tr>
</table>