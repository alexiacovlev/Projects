<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>

<div id="pnl_Workflow" style="margin:16px;">
	<div style="font-weight:bold">WORKFLOW</div>
	<table style="margin:10px 10px;" cellpadding="5" cellspacing="5">
		<colgroup><col width="130" /><col width="250" /></colgroup>
		<tr>
			<td><label class="fm-lbl">Workflow Name:</label></td>
			<td><dialogs:WorkflowLookupControl id="tbWorkflowName" runat="server" /></td>
		</tr>
	</table>

	<div style="margin-top:5px;padding-left:30px;"><label class="comment"></label></div>
</div>

<div id="pnl_FORM" style="margin:16px;">
	<div style="font-weight:bold">FORM</div>
	<table style="margin:10px 10px;" cellpadding="5" cellspacing="5">
		<colgroup><col width="130" /><col width="250" /></colgroup>
		<tr>
			<td><label class="fm-lbl">Table Name:</label></td>
			<td><dialogs:TableLookupControl id="tbForm_TableName" runat="server" /></td>
		</tr>
		<tr>
			<td><label class="fm-lbl">Form Name:</label></td>
			<td><dialogs:FormLookupControl id="tbForm_Name" runat="server" /></td>
		</tr>
	</table>
	
	<div style="margin-top:5px;padding-left:30px;"><label class="comment"></label></div>
</div>

<div id="pnl_Control" style="margin:16px;">
	<div style="font-weight:bold">SERVER CONTROL</div>
	<div style="margin-top:15px;padding-left:0px;"><label class="comment">You can use Server Control from the assembly (define assembly name and full control type.)</label></div>
	<div style="white-space:nowrap;margin:5px 20px;">
		<label style="width:130px" class="fm-lbl">Assembly and Type:</label>
		<input id="tbControl_Assembly" class="fm" style="width:130px" />
		<label style="width:5px;padding:0;margin:0" class="fm-lbl">,</label>
		<input id="tbControl_FullName" class="fm" style="width:257px" />
	</div>

	<div style="margin-top:10px;padding-left:0px;"><label class="comment">Or ASCX Control (define relative url to the ascx control)</label></div>
	<div style="white-space:nowrap;margin:5px 20px;">
		<label style="width:130px" class="fm-lbl">ASCX Control Path:</label>
		<input id="tbControl_Ascx" class="fm" style="width:400px" />
	</div>

	<div style="margin-top:30px;padding-left:0px;"><label class="comment">Input Parameters:</label></div>	
	<div style="margin:10px 20px;">
		<table id="pnlControl_Properties" style="table-layout:fixed">
			<colgroup>
				<col width="130px" />
				<col width="400px" />
			</colgroup>
			<tr>
				<td><label class="fm-lbl">[Name]:</label></td>
				<td><input class="fm" /></td>
			</tr>
		</table>
	</div>
</div>


<div id="pnl_Custom" style="margin:16px;">
	<div style="font-weight:bold">UNKNOWN CONTENT</div>
	<div style="white-space:nowrap;margin:10px 20px;">
		<label style="width:130px" class="fm-lbl">Type:</label>
		<input id="tbCustom_Type" class="fm" style="width:400px" />
	</div>
	
	<div style="white-space:nowrap;margin:10px 20px;">
		<label style="width:130px" class="fm-lbl">Details:</label>
		<input id="tbCustom_Content" class="fm" style="width:400px" />
	</div>
</div>