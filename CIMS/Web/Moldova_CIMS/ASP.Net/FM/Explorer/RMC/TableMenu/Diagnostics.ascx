<%@ Control Language="C#" Inherits="AX.Kernel.UI.HtmlModuleUserControl" ScriptClientType="RMC.DiagnosticsDialog" %>
<script type="text/javascript">
$registerNamespace("RMC");
RMC.Path= "<%= AX.FM.Explorer.Utils.Path %>";
RMC.DiagnosticsDialog= function($panel, input, ticket, wnd) {
	wnd.setHeader("Records Diagnostic Tools");
	wnd.loadURL(RMC.Path + "Diagnostics/main.aspx", null, true);
}
</script>