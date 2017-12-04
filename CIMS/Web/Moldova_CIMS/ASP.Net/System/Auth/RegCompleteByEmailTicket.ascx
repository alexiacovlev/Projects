<%@ Control Language="C#" Inherits="AX.Kernel.UI.UserControl" %>

<div id="ValidateUserEmail" style="display: block;width:470px;margin:10px auto 0 auto;padding:10px;" class="fmForm">
	<div style="padding-bottom: 5px;" id="sec_info" class="sec">
		<label class="sec"><%= Translate("info_FinalReg_Header", "Welcome")%></label>
		
	</div>
	<div style='float:right;margin:10px;'>
		<a id='btn1' class='fm-btn' tabindex="4" style='padding-top:1px;padding-bottom:2px;margin-right:4px;width:70px;'><%= Translate("btnEnter", "Enter")%></a>
	</div>
	<div id="message" style='margin:10px;'></div>

</div>

<script type="text/javascript">
	ExecuteService("{\"ticket\":\""+jsonEncode(location.search.substring(1))+"\"}", App.SystemPath + "Auth/Service.asmx/CompleteRegistration", function(result) {
		var res= result.d;
		alert(res);
	});
</script>
