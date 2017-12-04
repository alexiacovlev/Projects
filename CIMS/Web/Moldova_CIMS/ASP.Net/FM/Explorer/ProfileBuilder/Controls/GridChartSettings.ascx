<%@ Control Language="C#"%>
<%@ Register TagPrefix="dialogs" Namespace="AX.FM.Explorer.Dialogs" Assembly="AX.FM.Explorer" %>
<div class="fm-dlg fm-dlg-tabs" style="top:0;bottom:30px;padding:5px 5px">
	
	<table style="width:100%;table-layout:fixed" cellpadding="5" cellspacing="5">
		<colgroup><col width="120" /><col width="200" /><col /></colgroup>
		
		<tr>
			<td class="n">Group BY</td>			
			<td>
				<dialogs:FieldLookupControl id="tbGroupBy" runat="server" DialogType="FIELD/CHART" WindowTitle="Grouping Available Fields" />
			</td>
			<td></td>
		</tr>
	
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="n">Chart Type</td>			
			<td colspan="2">
				<div id="panelChartType">
						<label class="fm-chk"><input class="fm-chk" type="radio" name="ChartType" value="BAR" /><img src="Images/chart/bar.jpg" width="90" height="64" /></label>
						<label class="fm-chk"><input class="fm-chk" type="radio" name="ChartType" value="PIE" /><img src="Images/chart/pie.jpg" width="90" height="64" /></label>
						<label class="fm-chk"><input class="fm-chk" type="radio" name="ChartType" value="LINE" /><img src="Images/chart/line.jpg" width="90" height="64" /></label>
					</div>
			</td>
		</tr>
		

		<!--tr>
			<td class="n">Initial State</td>			
			<td>
				<select id="listChartState" class="fm">
					<option value="">Default</option>
					<option value="min">Collapsed</option>
					<option value="max">Full Screen</option>
				</select>
			</td>
			<td></td>
		</tr-->
	

	</table>

</div>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:50px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
</div>

<script type="text/javascript">
	RMC.GridChartSettings= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		this.tbGroupBy= new FM.LookupTextControl($("#tbGroupBy", this.$p));
		this.panelChartType= new FM.RadioGroup($("div#panelChartType", this.$p));
		//this.listChartState= $("#listChartState", this.$p);

		$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
	}
	RMC.GridChartSettings.prototype = {
		
		LoadState: function(link, tableName) {
			this.link= link;
			this.tbGroupBy.parentValue= tableName;
			var settings= this.link.attr('settings');
			if (settings != '') {
				var mas= settings.split('|');
				this.tbGroupBy.setValue(mas[1]);
				this.panelChartType.setValue(mas[2]);
				//this.listChartState.val(mas[3]);
			} else {
				this.tbGroupBy.setValue('');
				this.panelChartType.setValue('BAR');
				//this.listChartState.val('');
			}
			this._window.show();
		},
		
		SaveState: function() {
			var settings= "";
			var groupby= this.tbGroupBy.getValue();
			if (groupby != '') {
				settings+= '|'+groupby;
				settings+= '|'+this.panelChartType.getValue();
				settings+= '|'/*+this.listChartState.val()*/;
			}
			this.link.attr('settings', settings);
			return true;
		},

		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": if (this.SaveState()) this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}
	}
</script>