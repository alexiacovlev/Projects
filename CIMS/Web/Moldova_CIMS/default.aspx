<%@ Page Language="C#" Inherits="AX.PortalShell.AppPage" %>

<!DOCTYPE html>

<html>
<head>

	<title><%= Page_Title %></title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta property="og:title" content="<%= Page_Title %>" />
	<meta property="og:type" content="website" />
	<meta property="og:url" content="<%= Page_Url %>" />
	<meta property="og:image" content="<%= Page_Url %>/images/thumb1.jpg" />
	<meta property="og:description" content="<%= Page_Description %>" />

	<%= Page_CSS %>
	<%= Page_SCRIPTS %>

</head>

<body>

	<header>
		<div id="header">
			<span id="appLogo"></span>
			<label id="appTitle"><%= Page_Title %></label>
      <label id="appDesc"><%= Page_Description %></label>
		</div>
		<nav>
			<div id="appMenu"><%= BuildMenuItemsHtml(true) %></div>
			<div id="appLinks"><%= BuildLinksItemsHtml() %></div>
		</nav>
		<div id="appLang"><%= BuildLangItemsHtml(false) %></div>
	</header>

	<div id="content"></div>

	<footer>
		<div id="footer">
			<%= AdminBtnHtml %>
			<label id="copyright">2017 © AlfaSoft Web Software Company, LLC. All Rights Reserved. <%= Version %></label>
			<span id="userInfo"><%= UserInfoHtml %></span>
			<span id="loginMenu"><%= LoginButtonHtml %></span>
		</div>
	</footer>

  <%= Page_PreLoaderHtml %>

</body>

</html>



