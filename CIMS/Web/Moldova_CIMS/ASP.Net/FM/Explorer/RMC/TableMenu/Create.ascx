<%@ Control Language="C#" Inherits="AX.Kernel.UI.HtmlModuleUserControl" ScriptClientType="RMC.CreateTableDialog" %>
<div class="fm-dlg-panel fm-dlg">
	<table style="margin:30px 0px 10px 50px; border-spacing: 5px;">
		<tr>
			<td style="font-size:9pt;" class="req">Table Name:</td>
			<td style="width:230px" colspan="2"><input id="tbTableName" class="fm" maxlength="50" value="<%= AX.FM.Explorer.AdminPage.AppDbPrefix %>" /></td>
		</tr>
		
		<tr>
			<td style="font-size:9pt;"></td>
			<td colspan="2">
				<select id="listTemplate" class="fm">
					<option value="" selected="selected">Empty Table</option>
					<option value="default">Empty (with Tracking fields)</option>
					<option value="textdata">Data Entry (with Tracking fields)</option>
					<option value="dictionary">Dictionary Table</option>
				</select>
			</td>
		</tr>
	</table>
	
	<div id="message" style="font-size:9pt;color:#a40000;text-align:center;"></div>
</div>
<a id="linkDB" style="position:absolute;bottom:19px;left:15px;" class="fm">Register from Database</a>
<div class="fm-dlg-buttons" style="position:absolute;bottom:15px;right:15px;">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
$registerNamespace("RMC");
RMC.Path= "<%= AX.FM.Explorer.Utils.Path %>";

RMC.CreateTableDialog= function(wnd) {
	this._window= wnd;
	this.$p= wnd.$content;
	this.$tb= $("#tbTableName", this.$p);
	this.$message= $("#message", this.$p);

	this.btn_click= function(e) {
		switch (_fm_getCommand(e)) {
			case "OK":
				var t= this.$tb.val().trim();
				var template= $("#listTemplate", this.$p).val();
				this.$message.text('');
				if (t == "") { this.$message.text("Please, enter the table name"); return; }
				if (t.length<5) { this.$message.text("The Table Name length must be greater 5 characters."); return; }
				this.toggleUI(false);

				var data= "{\"table_name\":\"" + t + "\",\"template\":\"" + template + "\"}";
				ExecuteService(data, RMC.Path + "TableBuilder/SupportService.asmx/RegisterNewTable", $createDelegate(this.onRegister, this), $createDelegate(this.onError, this));
				break;
			case "X": 
				this._window.close(); 
				break;
		}
	}

	this.toggleUI= function(b) {
		$('div.fm-dlg-buttons a', this.$p).toggle(b);
	},

	this.onRegister= function(result) {
		var table_name= result.d;
		this._window.close();
		window.RMC_OpenTableSettings(table_name);
	}
	this.onError= function(msg) {
		this.$message.text(msg);
		this.toggleUI(true);
		if (msg.indexOf('SQL:') == 0) AX.Window.confirm("Confirmation", msg + '<br/><br/>Do you want to generate configuration from the database?', $createDelegate(this.registerFromDatabase, this));
	}

	this.registerFromDatabase= function() {
		var t= this.$tb.val().trim();
		if (t) {
			this._window.loadHTML("");
			this._window.setSize(700, 550);this._window.setCenter();
			this._window.loadURL(FM.Path + "Explorer/TableBuilder/_generator.aspx?sourceName="+t);
		}
	}

	this.addFromDB= function() {
		var control= this;
		control.get= function(n) {
			switch (n) {
				case "type": return "DBLIST";
				case "image": return "/ASP.Net/FM/Images/Explorer/ico_table.png";
				case "filter": return "LIST";
				case "wndTitle": return "Database Table List";
				case "wndSize": return "450,480";
				default: return "";
			}
		}
		var onselect= $createDelegate(function(n) { this.$tb.val(n); this.registerFromDatabase(); }, this);
		var onready= function() { var dlg= new FM.LookupAdminDialog(control, onselect); dlg.Show(""); }
		Runtime_ResourceLoader.LoadResources([FM.Path + "Explorer/Dialogs/FM.LookupAdminDialog.js", FM.Path + "Explorer/Dialogs/dialogs_utils.js"], onready);
	}


	this.$tb.focus();
			
	$('div.fm-dlg-buttons a', this.$p).addHandler('click', this.btn_click, this);
	$('a#linkDB', this.$p).addHandler('click', this.addFromDB, this);

}
</script>