<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SchedulerJob.ascx.cs" Inherits="AX.FM.Explorer.UI.SchedulerJobControl" ScriptClientType="FM.SchedulerJobControl"%>

<style type="text/css">

</style>

<script type="text/javascript">
	
	FM.SchedulerJobControl= function($panel, input, ticket, wnd) {
		this._window= wnd;
		this.$p= $panel;
		
		

		$("#buttons A", this.$p).click(function() {
			
			wnd.close();
			
		});
	}
</script>

<table style="width:100%">
	<tr>
		<td></td>
	</tr>
</table>

<fieldset>
	<legend class="sec">Scheduler Job Properties</legend>
	<table style="width: 100%; table-layout: fixed;" cellspacing="3">
		<colgroup>
			<col width="140"/>
			<col width="200"/>
			<col />
		</colgroup>
		<tbody>
			<tr>
				<td class="n">
					Title:
				</td>
				<td>
					<input type="text" class="fm" />
				</td>
				<td style="padding-left:5px;">
					<label class="comment">Define title</label>
				</td>
			</tr>
			
		</tbody>
	</table>
</fieldset>

<fieldset>
	<legend class="sec">Condition</legend>
	<div>Modification allows on the server side only</div>
</fieldset>

<fieldset>
	<legend class="sec">Action</legend>
	<div>Modification allows on the server side only</div>
</fieldset>

<fieldset>
	<legend class="sec"></legend>
	<table style="width: 100%; table-layout: fixed;" cellspacing="3">
		<colgroup>
			<col width="140"/>
			<col />
		</colgroup>
		<tbody>
			<tr>
				
			</tr>
		</tbody>
	</table>
</fieldset>

<div style="position:absolute;bottom:4px;right:5px;" id="buttons">
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>