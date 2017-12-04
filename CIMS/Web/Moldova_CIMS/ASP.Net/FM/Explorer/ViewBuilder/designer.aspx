<%@ Page Language="C#"%>
<%@ Register TagPrefix="ui" Namespace="AX.FM.Common.UI" Assembly="AX.FM.Common" %>

<div class="fm-dlg-header">
	<h1 id="dlgTitle">View Builder</h1>
	<label>Organize grid columns, configure sorting and filtering.</label>
	<img id="btnSettings" style="position:absolute;right:7px;top:7px;cursor:pointer" src="/ASP.Net/FM/Explorer/Images/edit.gif" title="Open Table Settings Dialog" />
</div>

<div style="position:absolute;top:20%;width:100%;">
<ui:Toolbar id="tb" runat="server" CssClass="fm-dlg-toolbar" ImagePath="/ASP.Net/FM/Explorer/ViewBuilder/Images/">
	<ui:MenuGroup CssClass="fm-dlg-menu">
		<ui:MenuItem Text="Move Left" ToolTip="Move the selected column left" Image="left.gif" Command="MOVE_LEFT" Enabled="false"/>
		<ui:MenuItem Text="Move Right" ToolTip="Move the selected column right" Image="right.gif" Command="MOVE_RIGHT" Enabled="false"/>
		<ui:MenuItem />
		<ui:MenuItem Text="Column Properties" ToolTip="Change the properties of the selected column" Image="colprops.gif" Command="COLUMN_PROPERTIES" Enabled="false"/>
		<ui:MenuItem />
		<ui:MenuItem Text="Add Columns" ToolTip="Add additional columns to this view" Image="coladd.gif" Command="ADD" />
		<ui:MenuItem Text="Remove" ToolTip="Remove the currently selected column from this view" Image="coldel.gif" Command="REMOVE" Enabled="false"/>
		<ui:MenuItem />
		<ui:MenuItem Text="View Properties" ToolTip="Change the properties of this view" Image="properties.gif" Command="VIEW_PROPERTIES" />
		<ui:MenuItem />
		<ui:MenuItem Text="Edit Filter Criteria" ToolTip="Edit the filter and search criteria this view uses" Image="gridfilter.gif" Command="FILTER" />
		<ui:MenuItem Text="Sorting" ToolTip="Configure the sort columns and direction for this view" Image="gridsort.gif" Command="SORT" />
	</ui:MenuGroup>
</ui:Toolbar>
<!--ui:MenuItem Text="Grouping" ToolTip="Configure the group columns for this view" Image="gridgroup.gif" Command="GROUP" />
		<ui:MenuItem />
		<ui:MenuItem Text="" ToolTip="Configure Record Actions" Image="actions.gif" Command="ACTIONS" /-->
<div class="rmc-vb-grid">
</div>

<div style="margin-top:20px;" class="rmc-vb-notes">
	<label>
		<img src="<%= AX.FM.Explorer.Utils.Path%>Images/16_info.gif"/>
		<b>Note:</b> When there are too many columns to fit on a page, the view will be 
		shortened and scrollbars will be added. 
		<br/>The right mouse click on the grid column allow quick edit the text.
	</label>
	<label id="panelFilter">
		<img src="<%= AX.FM.Explorer.Utils.Path%>Images/16_info.gif"/>
		<b>Filter defined for:</b><span id="FilterInfo" style="margin-left:10px;"></span>
	</label>
	<label>
		<img src="<%= AX.FM.Explorer.Utils.Path%>Images/16_info.gif"/>
		<b>Ordered By:</b><span id="SortInfo" style="margin-left:10px;"></span>
	</label>
</div>

</div>

<div class="fm-dlg-footer">
	<label id="lblInfo" style="font-weight:bold;color:#463474;position:absolute;bottom:10px;left:10px;display:none;"></label>
	<div style="position:absolute;bottom:5px;right:5px;">
		<%= AX.FM.Common.UI.Button.Render("save", "", false) %>
		<%= AX.FM.Common.UI.Button.Render("saveX", "margin-left:5px;", true) %>
		<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
	</div>
</div>