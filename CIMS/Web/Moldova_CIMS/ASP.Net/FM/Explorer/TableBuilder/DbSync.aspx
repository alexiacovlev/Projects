<%@ Page language="c#" AutoEventWireup="false" Inherits="AX.FM.Explorer.TableBuilder.DbSyncPage" EnableViewState="False"%>
<HTML>
	<HEAD>
		<title>Database Syncronization</title>
		<meta http-equiv="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<link href="/ASP.Net/FM/Common/CSS/fm.common.css" rel="stylesheet" type="text/css" />
		<style type="text/css">
			div, td, button { font-size:9pt; font-family:Verdana; }
			td.f { font-size:10pt }
			label.h { font-size:10pt; font-weight:bold;padding-left:5px; }
		</style>

		<script type="text/javascript">
			var _window= window.frameElement ? window.frameElement._window : window;
			_window.returnValue= <%= bSave?"true":"false" %>;
			
			function OK_Click() {
				_window.close();
			}
		</script>
	</HEAD>
	<body>
		<form id="frm" runat="server">
		<div style="font-weight:bold;margin:5px;"><%= HeaderDesc%></div>
		<div style="height:100%;overflow-y:auto;padding-left:5px;padding-top:5px;">
			<asp:Label ID="lblInfo" runat="server"></asp:Label>
			<asp:Label ID="lblInfo2" runat="server"></asp:Label>
			<asp:Repeater ID="rptAppend" runat="server">
				<HeaderTemplate>
				<br/><br/><label class='h'>The next fields has been <font color="red">appended</font> to the table settings:</label>
				<table style="margin-left:10px;">
				</HeaderTemplate>
				<ItemTemplate><tr><td class='f'><%# Container.DataItem%></td></tr></ItemTemplate>
				<FooterTemplate>
				</table>
				</FooterTemplate>
			</asp:Repeater>
			<asp:Repeater ID="rptRemoved" runat="server">
				<HeaderTemplate>
				<br/><br/><label class='h'>Below listed the fields not presented in the current database:</label>
				<table style="margin-left:10px;">
				</HeaderTemplate>
				<ItemTemplate><tr><td class='f'><li /><%# Container.DataItem%></td></tr></ItemTemplate>
				<FooterTemplate>
				</table>
				</FooterTemplate>
			</asp:Repeater>
			<asp:Repeater ID="rptUpdated" runat="server">
				<HeaderTemplate>
				<br/><br/><label class='h'>Some attributes have been <font color="red">updated</font> for next fields:</label>
				<table style="margin-left:10px;">
				</HeaderTemplate>
				<ItemTemplate><tr><td class='f'><%# Container.DataItem%></td></tr></ItemTemplate>
				<FooterTemplate>
				</table>
				</FooterTemplate>
			</asp:Repeater>
		</div>

		<div style="position:absolute;bottom:8px;right:8px;">
			<a class="fm-btn" id="btnSelect" onclick="OK_Click()" style="WIDTH:60px;font-weight:bold;">OK</a>
			<a class="fm-btn" id="btnClose" onclick="OK_Click()" style="WIDTH:60px;margin-left:10px;">Close</a>
		</div>
					
		</form>
	</body>
</HTML>