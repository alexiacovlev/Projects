<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form.aspx.cs" Inherits="AX.FM.DataViewer.Modules.PostIncidentForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<link href="/ASP.Net/System/Themes/gray/portal.css" rel="stylesheet" type="text/css" />
	<link href="/ASP.Net/FM/Common/CSS/fm.common.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		body {user-select: none;-webkit-user-select: none;-moz-user-select: none;}
		span.c {
			display: inline-block;width: 15px;height: 15px;margin:1px 1px 1px 2px;cursor:pointer;border:solid 1px white;border-radius:2px;
			box-shadow:2px 2px 1px #525252;-webkit-box-shadow:2px 2px 1px #525252;-moz-box-shadow:2px 2px 4px #525252;
		}
		span.c:hover, span.selected {
			height: 20px;
		}
		div#msg {
			position:absolute;top:3px;left:3px;padding:20px 15px;background-color:#ffff80;border:solid 1px #b1b1b1;border-radius:3px;
			font-size:10pt;
			-webkit-box-shadow:2px 2px 3px #000;
		}
		div#txtPanel {
			position:absolute;width:250px;
			padding:20px;background-color:#ffff80;border:solid 1px #b1b1b1;border-radius:3px;
			-webkit-box-shadow:2px 2px 3px #000;
			padding:10px;
		}
		td.req { font-weight:bold; color:#990000; }
	</style>
	<script type="text/javascript" src="Form.js"></script>
</head>
<body onload="init()">
	<form id="frm" name="frm" method="post" action="Form.aspx">
		<input id="screenshot_data" name="screenshot_data" type="hidden" />
		<div>
				<table style="width: 100%; table-layout: fixed" cellpadding="2" cellspacing="2">
					<colgroup>
						<col width="100" />
						<col />
						<col width="80" />
						<col width="150" />
					</colgroup>
					<tr>
						<td class="req"><%= AX.FM.DataViewer.Utils.TranslateLabel("Subject")%></td>
						<td>
							<input id="Subject" name="Subject" class="fm" /></td>
						<td class="n"><%= AX.FM.DataViewer.Utils.TranslateLabel("Type")%></td>
						<td>
							<select id="Type" name="Type" class="fm">
								<%= AX.FM.DataViewer.Modules.IncidentService.RenderIncidentTypeOptions() %>
							</select>
						</td>
					</tr>
					<tr>
						<td class="n" rowspan="2"><%= AX.FM.DataViewer.Utils.TranslateLabel("Description")%></td>
						<td rowspan="2">
							<textarea id="Description" name="Description" class="fm" style="height:45px"></textarea></td>
						<td class="n"><%= AX.FM.DataViewer.Utils.TranslateLabel("Priority")%></td>
						<td>
							<select id="Priority" name="Priority" class="fm">
								<%= AX.FM.DataViewer.Modules.IncidentService.RenderPriorityOptions() %>
							</select>
						</td>
					</tr>
					<tr>
						<td class="n"><%= AX.FM.DataViewer.Utils.TranslateLabel("Category")%></td>
						<td>
							<select id="Category" name="Category" class="fm">
								<%= AX.FM.DataViewer.Modules.IncidentService.RenderCategoryOptions() %>
							</select>
						</td>
					</tr>
					
				</table>
			<div id="msg" style="display:none;"></div>
		</div>
		<div id="canPanel" style="position:absolute;top:80px;left:2px;right:2px;bottom:35px;overflow:scroll;border:solid 1px #353535;-webkit-box-shadow:0px 0px 3px #000;">
			<canvas id="can" width="1200" height="900" style="cursor:default;background-color:#FFF"></canvas>
		</div>
		<div id="txtPanel" style="display:none;"><textarea id="txtBox" class="fm" rows="3" style="font-size:10pt"></textarea><div style="text-align:right"><a id="btnAddText" class="fm-btn" style="margin-right:5px;">OK</a><a id="btnCancelText" class="fm-btn">Cancel</a></div></div>
		<div style="position:absolute;bottom:5px;left:8px;cursor:default;" title="Set Pencil Color">
			<span class="c selected" style="background: red;" id="red" onclick="color(this)"></span>
			<span class="c" style="background: #00f000;" id="green" onclick="color(this)"></span>
			<span class="c" style="background: #06c1ff;" id="blue" onclick="color(this)"></span>
			<span class="c" style="background: #804040;" id="brown" onclick="color(this)"></span>
			<span class="c" style="background: black;" id="black" onclick="color(this)"></span>
			<span class="c" style="background: #fff;margin-left:10px;border-color:gray" id="white" onclick="color(this)" title="Eraser"></span>
		</div>
		<div style="position:absolute;bottom:10px;left:190px;font-style:italic">Note: You can underline the area you want to inform about</div>
		<div id="labels"
			hdr="<%= AX.FM.OM.Data.ResourceLabel.Translate("incident_hdr", "Post Incident")%>"
			subject_msg="<%= AX.FM.OM.Data.ResourceLabel.Translate("incident_message_2", "The Subject field is required for the incident")%>."
		/>

		<div style="position: absolute; bottom: 4px; right: 4px;">
			<a id="btnOK" style="min-width: 60px; font-weight: bold; margin-left: 5px;" class="fm-btn" cmd="OK">
				<img src="/ASP.Net/FM/Common/Images/ok.png"><%= AX.FM.DataViewer.Utils.Translate("OK", "OK")%></a>
			<a id="btnClose" style="min-width: 60px; margin-left: 5px;" class="fm-btn" cmd="X">
				<img src="/ASP.Net/FM/Common/Images/16_close.png"><%= AX.FM.DataViewer.Utils.Translate("Wnd__Close", "Close")%></a>
		</div>
	</form>
</body>
</html>
