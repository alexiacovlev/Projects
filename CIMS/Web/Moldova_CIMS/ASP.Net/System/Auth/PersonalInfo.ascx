<%@ Control Language="C#" Inherits="AX.Kernel.UI.HtmlModuleUserControl" ScriptClientType="AX.Auth_PersonalInfoDialog" ResourceName="UserManagement" %>
<div style="width:500px;margin:20px auto 0 auto;padding:10px;" class="fm-dlg-form">
	<div id="sec_info" class="fm-sec">
		<label class="fm-sec-lbl"><%= Translate("Personal Info")%></label>
		<table id="info_form" style="width: 100%; table-layout: fixed;margin-top:5px;" cellspacing="10">
			<colgroup><col width="170"/><col /></colgroup>
			<tbody>
			<tr>
				<td class="fm-n"><%= Translate("info_FirstName", "First Name")%>:</td>
				<td><input id="FirstName" tabindex="1" class="fm" /></td>
			</tr>
			<tr>
				<td class="fm-n"><%= Translate("info_LastName", "Last Name")%>:</td>
				<td><input id="LastName" tabindex="2" class="fm" /></td>
			</tr>
			<tr>
				<td class="fm-req"><%= Translate("info_Email", "Email")%>:</td>
				<td><input id="Email" tabindex="2" class="fm" /></td>
			</tr>

			<!--tr>
				<td colspan="2" style="font-style:italic;color:#5d5d5d;font-size:8pt;padding-left:100px;">Email is important</td>
			</tr-->
				
			<tr>
				<td></td>
				<td style="text-align:right">
					<a id='btn1' class="fm-btn fm-btn-saveclose" tabindex="4"><%= Translate("btnApply", "Apply")%></a>
				</td>
			</tr>
			</tbody>
		</table>
		<div id="message"></div>
	</div>
</div>

<script type="text/javascript">
AX.Auth_PersonalInfoDialog= function($panel, input, ticket, wnd) {
	var userID= input.split('=')[1];
	var data= null;

	var onchanged= function(result) {
		$("#info_form", $panel).hide();
		$("#btn1", $panel).hide();
		$("#message").html("<h3 style='text-align:center;color:#2d98f3;padding:10px;'><%= Translate("info_msg_InfoChanged", "Your Personal Info has been changed.")%></h3><div style='text-align:center;'><%= Translate("info_msg_InfoChangedComment", "Please, refresh your browser window to reflect the changes.")%></div>");
	}
	
	var onload= function(result) {
		data= result.d;
		$("#FirstName", $panel).val(data.FirstName).focus();
		$("#LastName", $panel).val(data.LastName);
		$("#Email", $panel).val(data.Email);
	};
	var onfailed= function(msg) {
		AX.Window.alert(msg);
	}
	
	$("#btn1", $panel).click(function() {
		data.FirstName= $("#FirstName", $panel).val().trim();
		data.LastName= $("#LastName", $panel).val().trim();
		data.Email= $("#Email", $panel).val().trim();
		if (data.Email == "") {AX.Window.alert("<%= Translate("Alert")%>", "<%= Translate("info_msg_CompleteAll", "Please, complete all required fields.")%>");return;}
		ExecuteService("{\"data\":"+JSON.stringify(data)+"}", App.SystemPath + "Auth/Service.asmx/UpdatePersonalInfo", onchanged, onfailed);
	});


	ExecuteService("", App.SystemPath + "Auth/Service.asmx/GetPersonalInfo", onload);

}
</script>
