<%@ Page Language="C#" AutoEventWireup="true" Inherits="AX.FM.Explorer.Diagnostics" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>Records Management Diagnostics</title>
	<%= base.RegisterCompactHeader() %>
	<style type="text/css">
b { font-weight:normal;}
A:link, A:visited { color: blue; }
A:hover { color: brown;  cursor:pointer; text-decoration:underline; }
td {font-size:11pt;padding:5px;vertical-align:top;}
	</style>
	<script type="text/javascript">
var $oTraceTable, $progressInfo, selectMode;
var tableIndex= 0;
var processed_count= 0;
var error_count= 0;
var root= "<%= AX.Kernel.Settings.WorkspaceRoot %>";
var mode= "<%= Mode %>";
<%= TablesClientArrayDeclaration %>

			function openStdWin(sPath, sName, iX, iY, scroll, full) {
				if (!iX) iX= 750;if (!iY) iY= 510;
				var top, left;
				try {
					if (full) { iX= screen.width - 5; iY= screen.availHeight - 60; top= 0; left= 0;
					} else { left= (screen.width - iX) / 2; top= (screen.availHeight - iY) / 2 - 30; }
					var params= "width=" + iX + ",height=" + iY + ",top=" + top + ",left=" + left + ",status=1,resizable=1,scrollbars=" + ((scroll) ? "1" : "0");
					window.open(sPath, sName, params);
				} catch(e) {}
			}

			function Start() {

				tableIndex= 0;
				$oTraceTable= $("#TraceTable");
				$progressInfo= $("#progressInfo");
				selectMode= document.getElementById("selectMode");

				if (mode == "") {
	        $("#panelInfo").css("visibility", "hidden");
					$("#msg").html(" <- <b>To Start Diagnostic, select the mode</b>");
				  return;
				}

				$progressInfo.text("" + tableIndex + "/" + tables.length);

				selectMode.selectedIndex= getIndexByValue(selectMode, mode);
				//if (selectMode.selectedIndex != -1)
					LoadNextPage();
				//else {
				//	document.getElementById("panelInfo").style.visibility= "hidden";
				//	document.getElementById("msg").innerHTML= " <- <b>To Start Diagnostic, select the mode</b>";
				//}
			}

			function getIndexByValue(o, v) {
				var index= 0;
				for (var i= 0; i < o.options.length; i++) {
					if (o.options[i].value == v) { index= i; break; }
				}
				return index;
			}

			var $oRow;

			function check(t) {
				openStdWin("check.aspx?t=" + t + "&mode="+mode+"&details=1", "check", 800, 600);
			}

			function LoadNextPage() {
				if (tableIndex >= tables.length) { Done(); return; }
				var t= tables[tableIndex];
				var url= "check.aspx?t="+t+"&mode="+mode;
				$progressInfo.text("" + tableIndex + "/" + tables.length);
				tableIndex+= 1;
				var style= (tableIndex % 2 != 0) ? " style='background-color:#ebebe9'":"";
				$oRow= $("<tr"+style+"><td>&nbsp;&nbsp;<a href=\"javascript:void(0)\" onclick=\"check('"+t+"')\">" + t + "</a></td><td>checking ...</td></tr>");
				$oTraceTable.append($oRow);
				$.get(url, null, callBack);
			}

			function callBack(data) {
				processed_count+= 1;
				$($oRow.children()[1]).html(checkContent(data));
				//if (oFHttp.status == 200) cell1.innerHTML= checkContent(oFHttp.responseText);
				//else cell1.innerHTML= formatError("Status: " + oFHttp.status);
				LoadNextPage();
			}

			function checkContent(content) {
				if (content.length > 0) {
					error_count+= 1;
					return "<label style='color:red'>"+content+"</label>";
				} else {
					return "OK";
				}
			}

			function formatError(s) {
				error_count+= 1;
				return "<font color='#990000'>" + s + "</font>";
			}

			function Done() {
				var s= "Processed: " + processed_count + ", " + ((error_count > 0) ? ("<font color='red'>Errors= " + error_count + "</font>") : " <font color='green'>All Right!</font>");

				$("#panelInfo").html(s);
				window.scrollTo(0,0);
			}
			function Mode_Changed() {
				var i= selectMode.selectedIndex;
				if (i == -1) return;
				var v= selectMode.options[i].value;
				if (v == "") return;
				tableIndex= tables.length; // to stop iteration

				if (v == "resx") window.location.href= "resx_generator.aspx?language=";
				else window.location.href= "main.aspx?mode=" + v;
			}
</script>

	</head>
	<body onload="Start()" style="overflow-y:scroll">
		<table id="TraceTable" width="80%" align="center" cellpadding="0" cellspacing="0" border="0" style="table-layout:fixed;margin-top:20px;margin-bottom:10px;background-color: #fffbff;border-top:solid 1px #f0f0f0;border-left:solid 1px #f0f0f0;border-right:solid 1px #a0a0a0;border-bottom:solid 1px #a0a0a0;">
		<colgroup>
			<col width="35%" />
			<col />
		</colgroup>
		<tr>
			<td colspan="2" style="padding:5px;">
				<h3 style="color:#606050">Records Management Diagnostics Page</h3>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="left" style="padding-left:10px;font-size:11px;"><%= GetInfo() %></td>
		</tr>
		<tr style="height:40px">
			<td colspan="2" valign="middle"><div id="panelInfo" style="margin:5px;font-size:12pt"><img align="middle" alt="loading" src="<%= AX.FM.Common.Utils.Path %>Images/ico_progress.gif" width="20" height="20" />&nbsp;<font color='#004080'>Processing <span id="progressInfo" style="width:50px;"></span> ... </font></div></td>
		</tr>
		<tr>
			<td colspan="2">

				<select id="selectMode" onchange="Mode_Changed()" style="font-size:14px;width:260px;font-style:italic">
					<option value="">Choose target subsystem to check</option>
					<option value="">  </option>
					<option value="profile"> - Records Profiles - </option>
					<option value="table"> - Data Tables, Forms, Views, ... - </option>
					<option value="workflow"> - Human Workflows - </option>
					<option value="process_workflow"> - Process Internal Workflows - </option>
					<option value="">  </option>
					<option value="">  </option>
					<option value="">  </option>
					<option value="">  </option>
					<option value="resx"> - Generate Resource File - </option>
				</select>
				<span id="msg" style="color:Blue"></span>
			</td>
		</tr>
		
		</table>
		<br />
	</body>
</html>






