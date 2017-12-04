<%@ Control Language="C#" Inherits="AX.Kernel.UI.HtmlModuleUserControl" %>
<div class="fm-dlg-form" style="height:100%;">
	<table id="panelProperties" cellpadding="0" cellspacing="0" style="table-layout:fixed;width:100%;">
		<colgroup>
			<col width="180" />
			<col width="400" />
			<col />
		</colgroup>
		<tr>
			<td colspan="3">
				<div class="fm-dlg-sec">Properties</div>
			</td>
		</tr>
		<tr>
			<td class="fm-n" style="padding:1em 2em">Title:</td>
			<td style="padding:1em"><input class="fm" id="tbTitle" maxlength="30" /></td>
			<td style="text-align:right;padding-right:1em;"></td>
		</tr>
		<tr>
			<td class="fm-n" style="padding:0em 2em;">Type:</td>
			<td style="padding:0 1em">
				<select id="listType" class="fm-select" style="width:200px">

					<optgroup label="Bar charts">
						<option value="bar">Vertical Bar</option>
						<option value="horizontalBar">Horizontal Bar</option>
					</optgroup>

					<optgroup label="Line charts">
						<option value="line">Basic line</option>
						<option value="line:dashed">Dashed line</option>
						<option value="line:filled">Filled line</option>
						<option value="radar">Radar</option>
					</optgroup>

					<optgroup label="Pie charts">
						<option value="pie">Pie</option>
						<option value="doughnut">Doughnut</option>
						<option value="halfdoughnut">Half Doughnut</option>
					</optgroup>

					<optgroup label="Custom">
						<option value="custom:list">List of counters</option>
						<option value="custom:panel">Counter panels</option>
					</optgroup>
					
				</select>
			</td>
			<td></td>
		</tr>

		<!--tr>
			<td colspan="3" style="padding-top:1em;">
				<div class="fm-dlg-sec">Availability</div>
			</td>
		</tr>
		
		<tr>
			<td colspan="3" style="padding-top:1em;">
				<div class="fm-dlg-sec">Content</div>
			</td>
		</tr>
		<tr>
			<td class="fm-n" style="padding:1em 2em;">Type:</td>
			<td style="padding:1em; overflow: hidden;"><a id="linkType" cmd="content" class="ax-dlg-link" title="Change Content"></a></td>
			<td style="text-align:right;padding-right:1em;">
				
			</td>
		</tr>


		<tr>
			<td colspan="3">
				<div id="panelSetters" style="max-height:15em; overflow-y: auto;"></div>
			</td>
		</tr-->

	</table>
		

	<div style="position:absolute;bottom:8px;left:7px;">
		<a tabindex="9" class="fm-btn" cmd="appsettigns">Dashboard settings</a>
	</div>
	<div id="buttons" style="position:absolute;bottom:8px;right:7px;">
		<a tabindex="10" class="fm-btn fm-btn-saveclose" cmd="saveX" style="width:80px">OK</a>&nbsp;
		<a tabindex="11" class="fm-btn" cmd="close">Close</a>
	</div>

</div>