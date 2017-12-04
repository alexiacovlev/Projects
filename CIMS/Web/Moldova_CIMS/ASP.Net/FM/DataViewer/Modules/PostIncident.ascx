<%@ Control Language="C#" %>
<div class="fmForm" style="position:absolute;top:0;bottom:32px;width:100%;">
<div class="sec" style="padding-top:0;">
	<table style="width: 100%;table-layout:fixed" cellpadding="4" cellspacing="4">
		<colgroup><col width="100"/><col /><col width="80" /><col width="150" /></colgroup>
		<tr>
			<td class="req"><%= AX.FM.DataViewer.Utils.TranslateLabel("Subject")%></td><td><input id="tbSubject" class="fm" /></td>
			<td class="n"><%= AX.FM.DataViewer.Utils.TranslateLabel("Type")%></td>
			<td>
				<select id="ddlType" class="fm">
					<%= AX.FM.DataViewer.Modules.IncidentService.RenderIncidentTypeOptions() %>
				</select>
			</td>
		</tr>
		<tr>
			<td class="n" rowspan="2"><%= AX.FM.DataViewer.Utils.TranslateLabel("Description")%></td>
			<td rowspan="2"><textarea id="tbDescription" class="fm" style="height:60px"></textarea></td>
			<td class="n"><%= AX.FM.DataViewer.Utils.TranslateLabel("Priority")%></td>
			<td>
				<select id="ddlPriority" class="fm">
					<%= AX.FM.DataViewer.Modules.IncidentService.RenderPriorityOptions() %>
				</select>
			</td>
		</tr>
		<tr>
			<td class="n"><%= AX.FM.DataViewer.Utils.TranslateLabel("Category")%></td>
			<td>
				<select id="ddlCategory" class="fm">
					<%= AX.FM.DataViewer.Modules.IncidentService.RenderCategoryOptions() %>
				</select>
			</td>
		</tr>
		<tr>
			<td class="n" valign="top"><%= AX.FM.DataViewer.Utils.TranslateLabel("Screenshot")%></td>
			<td colspan="3">
				<div style="border: 1px solid rgb(128, 128, 128); height: 240px; text-align: center; overflow: auto;padding-bottom:10px;padding-top:2px;">
					<img id="img" style="max-width:100%;" src="/ASP.Net/FM/Common/Images/noimage.gif"/>
				</div>
				<span style="margin-left: 10px;"><label id="label"></label><a class="fm" id="btnAttach"><%= AX.FM.DataViewer.Utils.TranslateLabel("Attach a File")%></a></span>
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="3"><div style="font-size:9pt;font-style:italic;"><%= AX.FM.OM.Data.ResourceLabel.Translate("incident_comment", "Please make a screenshot file with the incident and attach it.")%></div></td>
		</tr>
	</table>
</div>
</div>
<div id="labels" 
	hdr="<%= AX.FM.OM.Data.ResourceLabel.Translate("incident_hdr", "Post Incident")%>"
	hdr_file="<%= AX.FM.DataViewer.Utils.TranslateLabel("Upload File")%>"
	msg1="<%= AX.FM.OM.Data.ResourceLabel.Translate("incident_message_1", "Only image files are allowed")%>."
	msg2="<%= AX.FM.OM.Data.ResourceLabel.Translate("incident_message_2", "The Subject field is required for the incident")%>."
	n_hdr="<%= AX.FM.OM.Data.ResourceLabel.Translate("incident_message_hdr", "Thank you for posting the incident")%>."
	n_text="<%= AX.FM.OM.Data.ResourceLabel.Translate("incident_message_text", "Our responsible team will resolve your request<br/> as soon as possible")%>."
/>
<div style='position:absolute;bottom:8px;left:5px;'>Note: You can add <a id="linkPlugin" style="cursor:pointer">Incident Screenshot Maker Plugin</a> to your Chrome browser</div>

<div style="position:absolute;bottom:4px;right:4px;">
	<a id="btnOK" style="min-width:60px;font-weight: bold; margin-left: 5px;" class="fm-btn" cmd="OK"><img src="/ASP.Net/FM/Common/Images/ok.png"><%= AX.FM.DataViewer.Utils.Translate("OK", "OK")%></a>
	<a id="btnClose" style="min-width:60px;margin-left: 5px;" class="fm-btn" cmd="X"><img src="/ASP.Net/FM/Common/Images/16_close.png"><%= AX.FM.DataViewer.Utils.Translate("Wnd__Close", "Close")%></a>
</div>