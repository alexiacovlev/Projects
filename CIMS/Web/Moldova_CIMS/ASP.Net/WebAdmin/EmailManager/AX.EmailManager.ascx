<%@ Control Language="C#" Inherits="AX.PortalAdmin.Modules.EmailManagerControl" %>
<div style="position:relative;height:100%;">
	<div class="em-bg" style="height:60px;position:absolute;width:100%;">
		<div style="font-size:10pt;color:#37377c;font-weight:bold;margin:10px;text-decoration:underline">Email Templates Manager</div>
		<div style="margin:10px 0 10px 20px;" class="fm-comment">Email tempaltes are using to notify portal's users about important events by email.</div>
		<img src="/ASP.Net/System/Images/48_alert.png" style="display:none"/>
	</div>`
	<div class="em-tree" style="position:absolute;top:61px;left:0;right:0;bottom:0px;overflow-y:scroll" id="listItems">
		<%= sbRows %>
	</div>
	
</div>