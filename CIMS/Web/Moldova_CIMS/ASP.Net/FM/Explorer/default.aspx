<%@ Page Language="C#" Inherits="AX.FM.Explorer.AdminPage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Records Management Console</title>
<%= base.RegisterHeader() %>
<script type="text/javascript">
RMC = {};
RMC.Path= FM.Path + "Explorer/";
RMC.close_callback= null;

function RMC_LoadModule() {
	var href= document.location.href;
	
	if (!RMC._initialized) { 
		RMC._initialized= true;
		RMC.$content= $("#mainContent:first");
		RMC.window= (window.frameElement) ? window.frameElement._window : null;
		if (RMC.window) RMC.window.onclose = function(res) { if (res && RMC.close_callback) RMC.close_callback(); document.location.href= RMC.Path + "#"; }
	}

	var i = href.indexOf('#');
	if (i == -1 || i == href.length-1) { RMC.$content.empty(); return; }

	var data = href.substr(i + 1).split('/');
	var type= data[0];
	var input= [];
	for (var i = 1; i < data.length; i++) {
		var mas= data[i].split('=');
		input[mas[0]]= mas[1];
	}


	RMC.close_callback= RMC.window ? RMC.window.refresh_callback : null;

	var oncreate = function(_typeReference) {
		RMC.$content.empty();
		RMC.component = new _typeReference(RMC.$content, input, RMC.window);
	};
	
	window.Runtime_Library.loadObjectType("RMC."+type, type, null, oncreate);
}


function RMC_loadASCX($p, rel_path, callback) {
	$p.load("/ASP.Net/System/Component.aspx?path=" + rel_path, callback);
}

window.Runtime_Library.Add("TableBuilder",	["/ASP.Net/FM/Explorer/TableBuilder/TableBuilder.css","/ASP.Net/FM/Explorer/TableBuilder/TableBuilder.js"]);
window.Runtime_Library.Add("ViewBuilder",		["/ASP.Net/FM/Explorer/ViewBuilder/ViewBuilder.css","/ASP.Net/FM/Explorer/ViewBuilder/ViewBuilder.js"]);
window.Runtime_Library.Add("PreviewBuilder",["/ASP.Net/FM/Explorer/PreviewBuilder/PreviewBuilder.css","/ASP.Net/FM/Explorer/PreviewBuilder/PreviewBuilder.js"]);
window.Runtime_Library.Add("FormBuilder",		["/ASP.Net/FM/Explorer/FormBuilder/FormBuilder.css","/ASP.Net/FM/Explorer/FormBuilder/FormBuilder.js"]);
window.Runtime_Library.Add("ProfileBuilder",["/ASP.Net/FM/DataViewer/Profile/JS/fm.nav.css","/ASP.Net/FM/Explorer/ProfileBuilder/ProfileBuilder.js"]);
window.Runtime_Library.Add("WorkflowBuilder",["/ASP.Net/FM/Explorer/WorkflowBuilder/WorkflowBuilder.css","/ASP.Net/FM/Explorer/WorkflowBuilder/WorkflowBuilder.js"]);
		
$(document).ready(function () {
	$(window).on('hashchange', RMC_LoadModule);
	$(document.body).preventSelection();
	RMC_LoadModule();
});
		
</script>
</head>
<body style="background-color:#FFF;"><div id="mainContent" style="width:100%;height:100%"></div></body>
</html>
