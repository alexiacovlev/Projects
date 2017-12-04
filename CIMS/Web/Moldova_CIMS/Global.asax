<%@ Application Language="C#" %>
<script RunAt="server">

	void Application_Start(object sender, EventArgs e) {
		AX.PortalShell.Application.Start();
	}

	void Application_End(object sender, EventArgs e) {
		AX.PortalShell.Application.End();
	}

	void Application_Error(object sender, EventArgs e) {
		AX.PortalShell.Application.Error(sender, e);
	}

	void Session_Start(object sender, EventArgs e) {
		AX.PortalShell.Application.Session_Start(sender, e);
	}

	void Application_PreRequestHandlerExecute(object sender, EventArgs e) {
		AX.PortalShell.Application.HandleRequest(Request);
	}

</script>






















