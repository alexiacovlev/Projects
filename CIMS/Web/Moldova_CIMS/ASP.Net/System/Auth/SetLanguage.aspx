<%@ Page Language="C#" %>
<% int.Parse(Request.QueryString[0]); AX.Kernel.LocalizationUtils.SetLanguage(Request.QueryString[0]); Response.Redirect("/"); %>