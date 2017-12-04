<%@ Control Language="C#" Inherits="AX.FM.Explorer.RMC.TableListControl" %>
<div style="position:relative;height:100%;">
	<div class="rmc-bg" style="height:60px;position:absolute;width:100%;">
		<div style="color:#37377c;text-decoration:underline;font-weight:bold;margin:10px;">Records Management Console</div>
		<div style="margin:10px 0 10px 20px;" class="fm-comment">The tables are grouped by preffix, click on the group name to show the tables.</div>
		<div style="position:absolute;right:20px;top:20px;">
			<table>
				<tr>
					<td><input class="fm" id="filter" style="width:10em" placeholder="search by name" tabindex="100" /></td>
					<td><a class="fm-btn-flat" style="width:25px;" tabindex="100">&gt;&gt;</a></td>
				</tr>
			</table>
		</div>
	</div>
	<div style="position:absolute;top:60px;width:100%;">
		<div id="_toolbar" class="fm-dg-toolbar rmc-toolbar">
			<div class="rmc-menu">
				<a class="rmc-menu-a" cmd="add"><img class="rmc-menu-img" src="/ASP.Net/Images/ico/create_record.png">Create New Table&nbsp;</a>&nbsp;<i class="V"></i>&nbsp;
				<a class="rmc-menu-a" cmd="edit"><img class="rmc-menu-img" src="/ASP.Net/Images/ico/ico_18_1089.png">Table Settings&nbsp;</a>
				<a class="rmc-menu-a" cmd="forms"><img class="rmc-menu-img" src="/ASP.Net/Images/ico/ico_18_1.png">Forms/Views/Lookups&nbsp;</a>
			</div>
			<div class="rmc-menu" style="right:0;">
			<i class="rmc-menu-V"></i>&nbsp;
			<a class="rmc-menu-a" cmd="db_stat"><img class="rmc-menu-img" src="/ASP.Net/FM/Explorer/Images/db_stat.png">Db Usage&nbsp;</a>
			<a class="rmc-menu-a" cmd="diag"><img class="rmc-menu-img" src="/ASP.Net/Images/ico/bug.png">Diagnostic Tool&nbsp;</a>
			</div>
		</div>
		<table class="rmc-dg-header" cellspacing="0" cellpadding="0" style="height:28px">
			<colgroup><col width="24" /><col width="200" /><col /><col width="150"/><col width="250"/><col width="100"/><col width="130" /></colgroup>
			<tr>
				<td class="rmc-dg-hdr">&nbsp;</td><td class="rmc-dg-hdr">Name</td><td class="rmc-dg-hdr">Description</td><td class="rmc-dg-hdr">Title</td><td class="rmc-dg-hdr">Database</td><td class="rmc-dg-hdr">CreatedOn</td><td class="rmc-dg-hdr">ModifiedOn</td>
			</tr>
		</table>
	</div>
	<div style="position:absolute;top:118px;left:0;right:0;bottom:0px;" class="rmc-grid-panel" id="listTables">
	</div>
</div>