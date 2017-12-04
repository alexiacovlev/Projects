<%@ Control Language="C#" %>
<div style="font-size: 1.3em; padding:18px 10px;color:#000; border-bottom: solid 1px #ebebe9;">Personal Tasks</div>
<% 
	System.Data.DataRowCollection TaskRows= AX.PortalShell.Controls.NotificationCenter.LoadTaskRows(5);
	foreach (System.Data.DataRow row in TaskRows) { 
%>
<a class="fm-o-a" style="padding: 8px; border-bottom: solid 1px #ebebe9;" oid="<%= row["ID"] %>">
	<div style="float:left;padding:5px 5px 0 0;color:#000;"><div style="background-color:<%= ((row["Status"].ToString() == "0") ? "#0187c3" : "#dfdfdf")%>;border-radius:15px;width:30px;height:30px;overflow:hidden"></div></div>
	<div style="display:inline-block;padding:2px;max-width:300px;word-wrap:break-word;">
		<div style="font-size:1.2em;padding-bottom:4px"><%= row["Title"] %></div>
		<div style="font-size:0.8em;padding:2px;"><%= row["MessageText"] %></div>
		<div style="font-size:0.8em;padding:2px;"><%= ((row["CreatedOn"] != DBNull.Value) ? (((DateTime)row["CreatedOn"]).ToShortDateString() +" "+((DateTime)row["CreatedOn"]).ToShortTimeString()) : "") %></div>
	</div>
</a>
<% }
	if (TaskRows.Count == 0) { %>
<div style="padding:20px 0 10px 20px;width:250px;">
	No active tasks
</div>		
<%	} %>

<a class="fm-o-a" style="padding:20px;margin-top:8px;border-top: solid 1px #ebebe9;">
	<div style="font-size:1em;padding-left:32px">Show all tasks ...</div>
</a>		