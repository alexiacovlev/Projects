<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;top:0;">
	<div class="tab" style="display:block">
		<table cellpadding="4" cellspacing="4" style="width:100%;table-layout:fixed">
			<colgroup><col width="80" /><col /></colgroup>	
			<tr>
				<td class="n">URL:
						<!--img id="imgFavorites" src="../../Common/Images/ico/Faforites.gif" style="position:absolute;left:55px;cursor:pointer;display:none;" title="Add to Favorites Web Services" height="16px" width="16px" onclick="OpenAddToGallery()" /-->
				</td>
				<td valign="top">
					<input class="fm" id="tbUrl" style="font-size:10pt;"/>
				</td>
			</tr>
			<tr>
				<td class="n" valign="top" style="padding-top:4px;">Methods:</td>
				<td>
					<select id="ddlMethods" multiple="multiple" style="height:100px;font-size:9pt;" class="fm">
					</select>
				</td>
			</tr>
			<tr>
				<td class="n" valign="top" style="padding-top:4px;">Namespace:</td>
				<td valign="top" id="tdNamespace" style="min-height:18px;"></td>
			</tr>
		</table>

		<fieldset class="fm-dlg-sec-bg" style="margin:10px 5px;">
			<legend>Input:</legend>
			<div id="tdInput" style="height:120px;overflow-y:scroll;padding:5px"></div>
		</fieldset>

		<fieldset class="fm-dlg-sec-bg" style="margin:10px 5px;">
			<legend>Output:</legend>
			<div id="tdOutput" style="padding:5px;overflow-y:scroll;height:120px"></div>
		</fieldset>
		
	</div>
</div>
<div style="position:absolute;left:3px;bottom:3px;">
	<a id="btnTest" class="fm-btn" style="width:60px;">Run</a>
</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.WB_WebServiceDialog= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}
	RMC.WB_WebServiceDialog.prototype = {
		
		initialize: function() {
			var $p= this.$p;
			
			this.$tbUrl= $("input#tbUrl", this.$p);
			this.$tbUrl.addHandler('change', this.url_change, this);

			this.$ddlMethods= $("#ddlMethods", this.$p);
			this.$ddlMethods.addHandler('change', this.methods_click, this);

			this.$tdInput= $("#tdInput", this.$p);
			this.$tdOutput= $("#tdOutput", this.$p);

			$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
			$("a#btnTest", this.$p).addHandler('click', this.btn_test_click, this);
		},

		url_change: function() {
			this.url= this.$tbUrl.val().trim();
			this.$ddlMethods.empty();
			if (this.url != "") {
				this.$ddlMethods.append($("<option />").val("").text("loading ..."));
				var data= "{\"url\":\"" + this.url + "\"}";
				ExecuteService(data, RMC.Path + "WorkflowBuilder/Dialogs/WebServiceDialog.asmx/GetMethods", $createDelegate(this.getmethods_loaded, this), _fm_onHandlerError);
			}
		},
		getmethods_loaded: function(result) {
			var res= result.d;
			this.ns= res[0];
			$("#tdNamespace", this.$p).text(this.ns);
			var $ddl= this.$ddlMethods;
			$ddl.empty();
			for (var i= 1; i < res.length; i++) {
				$ddl.append($("<option />").val(res[i]).text(res[i]));
			};

			this.$tdInput.empty();
			this.$tdOutput.empty();
			
		},
		methods_click: function() {
			this.method= ""+this.$ddlMethods.val();
			if (this.url && this.method) {
				var data= "{\"url\":\"" + this.url + "\", \"method\":\"" + this.method + "\"}";
				ExecuteService(data, RMC.Path + "WorkflowBuilder/Dialogs/WebServiceDialog.asmx/GetMethodInfo", $createDelegate(this.method_loaded, this), _fm_onHandlerError);
			}
		},

		method_loaded: function(result) {
			var res= result.d;
			this.input= res.length>0?res[0]:"";
			this.output= res.length>1?res[1]:"";

			this.$tdInput.html(this.generateForm(this.input));
			this.$tdOutput.html(this.output);
		},
		generateForm: function(s) {
			this.inputLength= 0;
			if (!s) return s;
			var m= s.split(';');
			this.inputLength= m.length;
			var s= "";

			for (var i= 0; i < this.inputLength; i++) {
				var m1= m[i].split('|');
				var name= m1[0]; var type= m1[1];
				s+= ("<div style='margin-bottom:2px;'><label style='display:inline-block;width:140px'>&#8226; "+name+" ("+type+")</label><input n='"+name+"' value='' class='fm' style='font-size:8pt;width:150px'/></div>");
			}
			return s;
		},
		parseVars: function(s) {
			var mas= [];
			if (!s) return mas;
			var m= s.split(';');
			var s= "";
			for (var i= 0; i < m.length; i++) {
				var m1= m[i].split('|');
				mas.push(m1[0]);
			}
			return mas;
		},

		LoadState: function(ref) {
			this.ref= ref;
			this._url= this.url= this.ref.$ExecuteRequest_Url.val().trim();

			
			this.$tbUrl.val(this.url);
			this._window.show();
			
			this.$tbUrl.trigger('change');
		},

		SaveState: function() {
			if (!this.method) return;

			var $xn= this.ref.$xn;
			var $xn_s= $xn.find("Settings");
			var settings_method= $xn_s.attr('method');

			if (this.method != settings_method) {
				$xn.attr('url', this.url);
				$xn_s.attr('method', this.method);
				$xn_s.attr('namespace', this.ns);

				this.ref.$ExecuteRequest_Method.val(this.method);
				this.ref.$ExecuteRequest_Url.val(this.url);
				this.ref.panelAssign.clearPanel();

				var mas1= this.parseVars(this.input);
				for (var i= 0; i < mas1.length; i++) {
					this.ref.panelAssign.addField(mas1[i], "");
				}
			}

			return true;
		},

		runService: function() {
			var names= [];
			var values= [];
			var $inputs= this.$tdInput.find('INPUT');
			if ($inputs.length != this.inputLength) { alert('Input fields not found'); return; }
			for (var i= 0; i < $inputs.length; i++) {
				names.push($inputs[i].getAttribute('n'));
				values.push($inputs[i].value.trim());
			}

			var data= {
				url:this.url, 
				method:this.method,
				ns:this.ns,
				inputNames: names,
				inputValues: values
			};
			this.$tdOutput.empty().text('processing ...');
			ExecuteService(JSON.stringify(data), RMC.Path + "WorkflowBuilder/Dialogs/WebServiceDialog.asmx/Run", $createDelegate(this.run_loaded, this), _fm_onHandlerError);
		},

		btn_test_click: function() {
			AX.Window.confirm("Run Web Service", "Are you sure you want to send live request to this web service?", this.runService, this);
		},

		run_loaded: function(result) {
			var res= result.d;
			if (res) this.$tdOutput.html(res);
			else this.$tdOutput.text("no value");
		},

		
		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": if (this.SaveState()) this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}
	}
</script>