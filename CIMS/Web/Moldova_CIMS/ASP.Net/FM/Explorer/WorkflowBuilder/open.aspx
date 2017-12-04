<%@ Page Language="C#"%>
<% 
	var w= Request.QueryString.Count > 0 ? Request.QueryString[0] : "";
	Response.Redirect("../#WorkflowBuilder/w="+w); 
%>