<%@ Page Language="C#" Inherits="AX.PortalAdmin.AdminPage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Portal Administration</title>
	<%= this.RegisterHeader() %>
	<script type="text/javascript">
		
		$(document).ready(function () {
			$(window).on('hashchange', Admin_ReloadModule);
			
			Admin_ReloadModule();
		});
		
	</script>
</head>
<body style="background-color:#FFF;">
</body>
</html>
