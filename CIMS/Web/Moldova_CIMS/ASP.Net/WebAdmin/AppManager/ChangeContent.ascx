<%@ Control Language="C#" Inherits="AX.PortalAdmin.AppManager.ChangeContentDialog" %>
<div style="width:500px;height:250px">
	<div id="panelMain" app_prefix="<%= app_prefix %>">
		<table width="95%" cellpadding="5" cellspacing="5" style="margin:10px 20px 0 20px">
			<tr>
				<td class="fm-n">What control type do you want to place in this tab?</td>
			</tr>
			<tr>
				<td>
					<select id="listTypes" class="fm-select">
						<option value="">None</option>
						<option value="HTML">Html Content</option>
						<option value="PROFILE">Data Navigator (Profile)</option>
						<option value="WORKFLOW">Step-by-step Workflow</option>
						<option value="SERVERCONTROL">Custom ASCX Component</option>
					</select>
				</td>
			</tr>
		</table>
	</div>
	<div id="panelList">
		<div id="panelNone" style="display:none"></div>

		<table id="panelHtml" cellpadding="5" cellspacing="5" style="margin:10px 20px 0 20px;width:95%;display:none;">
			<tr>
				<td class="fm-n" colspan="3">Please, define the name for HTML page:</td>
			</tr>
			<tr>
					<td style="width:140px;padding-left:15px;">HTML Page name: </td>
					<td style="width:250px;"><input class="fm" id="tbHtml" /></td>
					<td></td>
				</tr>
			<tr>
				<td class="fm-comment" colspan="3" style="padding-left:15px;">
					Note: By default will be used the same name as the name for the tab it contains.
				</td>
			</tr>
		</table>

		<table id="panelProfile" cellpadding="5" cellspacing="5" style="margin:10px 20px 0 20px;width:95%;display:none;table-layout:fixed">
			<colgroup><col width="35%" /><col /></colgroup>
			<tr>
				<td class="fm-n" colspan="2">Please, define the name for the profile:</td>
			</tr>
			<tr>
				<td style="padding-left:15px;" class="fm-n">Profile Name: </td>
				<td><input class="fm" id="tbProfileName" /></td>
			</tr>
			<tr>
				<td style="padding-left:15px;" class="fm-n"></td>
				<td><select class="fm-select" id="listProfiles" /></td>
			</tr>
		</table>

		<table id="panelWorkflow" cellpadding="5" cellspacing="5" style="margin:10px 20px 0 20px;width:95%;display:none;table-layout:fixed">
			<colgroup><col width="35%" /><col /></colgroup>
			<tr>
				<td class="fm-n" colspan="2">Please, define the name for the workflow:</td>
			</tr>
			<tr>
				<td style="padding-left:15px;" class="fm-n">Workflow Name: </td>
				<td><input class="fm" id="tbWorkflowName" /></td>
			</tr>
			<tr>
				<td style="padding-left:15px;" class="fm-n"></td>
				<td><select class="fm-select" id="listWorkflows" /></td>
			</tr>
			
		</table>

		<table id="panelControl" width="95%" cellpadding="5" cellspacing="5" style="margin:10px 20px 0 20px;width:95%;display:none;">
			<tr>
				<td class="fm-n" colspan="2">Please, define ASCX relative path or control type settings:</td>
			</tr>
			<tr>
				<td colspan="2"><input class="fm" id="tbControl" /></td>
			</tr>
			<tr>
				<td class="fm-comment" colspan="2" style="padding-left:15px;">
					Note: Control must be inherited from AX.Kernel.UI.IHtmlModuleControl.<br />
					You can use server control compiled into assembly, in this case define control assembly and full type.
				</td>
			</tr>
		</table>
		
	</div>

</div>