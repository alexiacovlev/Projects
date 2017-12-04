<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin.ascx.cs" Inherits="AX.FM.Explorer.ProfileBuilder.ProfileAdminControl" ScriptClientType="FM.ProfileBuilderAdmin"%>

<style type="text/css">
	ul.ProfileAdmin li {
		display: block;
		margin:5px;
		cursor:pointer;
		padding:5px;
		border:solid 1px #FFF;
		border-radius:2px;
	}
	ul.ProfileAdmin li:hover {
		background-color:#fdda72;
		border-color:#d5e1ff;
	}
</style>

<script type="text/javascript">
	var profileName= "<%= ProfileName %>";

	FM.ProfileBuilderAdmin= function($panel, input, ticket, wnd) {
		this._window= wnd;
		this.$p= $panel;
		
		$("ul.ProfileAdmin li", this.$p).click(function() {
			var $li= $(this);
			var r= $li.attr('role');
			if (r[0]!='*') { /*AX.Window.alert('Profile Builder', 'The Profile is using the configuration<br/> for the role Members.');*/ }
			else r= r.substr(1);
			wnd.close();
			var refresh_callback= null;
			FM.ShowAdminWindow("ProfileBuilder", 950, 650, "p=" + profileName + "/r=" + r + "/f=Root/sr="+r, refresh_callback);
		});

		$("#buttons A", this.$p).click(function() {
			
			wnd.close();
			
		});
	}
</script>

<div style="font-weight:bold;font-size:14px;padding:5px;"><%= ProfileName %></div>
<div style="color:gray;font-style:italic;padding-left:20px">
	To configure, select role from the list.
</div>
<div style="position:absolute;top:45px;bottom:32px;left:0;right:0;overflow-y:auto;padding:10px;background-color:white;border:solid 1px #d5e1ff;border-radius:2px;">
	<ul class="ProfileAdmin">
		<%= sb.ToString() %>
	</ul>
</div>

<div style="position:absolute;bottom:4px;right:5px;" id="buttons">
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>