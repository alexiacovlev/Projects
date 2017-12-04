<%@ Control Language="C#"%>
<div class="fm-dlg-tabs fm-dlg" style="bottom:30px;top:0;">
	<div class="tab" style="display:block">
		
		<fieldset class="fm-dlg-sec-bg" style="padding:8px">
			<legend>HTML Text or Script Control</legend>
			<textarea id="tbHtml" class="fm" style="width:100%;height:245px;line-height:16px;font-size:9pt"></textarea>
		</fieldset>

		<div style="padding-left:5px">
		<label class="comment">Select the number of columns the field occupies:</label>
		<table id="panelLayout" cellpadding="0" cellspacing="0" style="margin:0px 0 10px 38px">
			<colgroup><col /><col /><col /></colgroup>	
			<tr>
				<td style="text-align:center"><label><input type="radio" name="Columns" value="1" style="margin:5px 8px 0 0;" />One column</label></td>
				<td style="text-align:center"><label><input type="radio" name="Columns" value="2" style="margin:5px 8px 0 20px;" />Two columns</label></td>
				<td id="tdColumns3" style="text-align:center;display:none"><label><input type="radio" name="Columns" value="3" style="margin:5px 8px 0 20px;" />Three columns</label></td>
			</tr>
		</table>

		<label class="comment">Input the number of rows the field occupies:</label>
		<div style="padding:3px 0 10px 40px">
			<label>Rows:</label>
			<input id="tbRowCount" class="fm" style="width:30px;text-align:center;padding:0;" maxlength="2" />
		</div>

		<label class="comment">Additional text label:</label>
		<div id="panelTitlePos" style="padding:2px 0 0 32px">
			<label style="margin-right:2px;"><input type="radio" name="position" value="off" />No label (default)</label>
			<label style="margin-right:2px;"><input type="radio" name="position" value="" />Add label or empty area on the left</label>
			<label><input type="radio" name="position" value="top" />Add label on the top</label>
		</div>
		<div style="padding:3px 0 10px 44px">
			<label>Text: </label>
			<input class="fm" id="tbTitle" style="width:300px" />
		</div>
		</div>
	</div>

	<div class="tab">

	</div>

</div>
<a id="btnSnippet" class="fm-btn" style="position:absolute;left:0px;bottom:3px;width:120px" cmd="snippet">Add Control Snippet</a>
<div class="fm-dlg-buttons">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
	<%= AX.FM.Common.UI.Button.Render("X", "width:60px;margin-left:5px;", false) %>
</div>
<div style="display:none">
	<div id="panelSnippets" style="font-size:9pt;line-height:20px;">
		<a data="TEXT" class="fm">&bull; Html Label</a><br />
		<a data="GRID" class="fm">&bull; Embedded Data Grid</a><br />
		<a data="A" class="fm">&bull; JScript Invoker Link</a><br />
		<a data="BUTTON" class="fm">&bull; JScript Invoker Button</a><br />
		<a data="P-BUTTON" class="fm">&bull; Open Profile Button</a><br />
		<br />
		<a data="WORD-BUTTON" class="fm">&bull; Word Document Downloader Button</a><br />
	</div>
</div>


<script type="text/javascript">
	RMC.FB_CustomControlProperties= function(wnd) {
		this._window= wnd;
		this.$p= wnd.$content;
		
		this.initialize();
	}
	RMC.FB_CustomControlProperties.prototype = {
		
		initialize: function() {
			var $p= this.$p;
			this.$tbHtml= $("#tbHtml", $p);
			this.$tbTitle= $("#tbTitle", $p);
			this.$tbRowCount= $("#tbRowCount", $p);
			this.panelTitlePos= new FM.RadioGroup($("#panelTitlePos", $p));
			this.panelLayout= new FM.RadioGroup($("#panelLayout", $p));
			this.$tdColumns3= $("#tdColumns3", $p);
			
			$("div.fm-dlg-buttons", this.$p).addHandler('click', this.btn_click, this);
			$("a#btnSnippet", this.$p).addHandler('click', this.selectSnippet, this);
		},

		LoadState: function(designer, $xn) {
			this._window.show();
			this.$xn= $xn;
			this.designer= designer;

			this._window.show();

			this.$xn= $xn;
			var $p= this.$p;
			var name= $xn.attr('name');
			var $xn_content= $xn.children('content:first');
			this.$tbHtml.val($xn_content.text());
			//
			var $xnsec= $xn.parent().parent().parent();
			this.section_columns= $xnsec.attr('columns')||'1';
			
			this.$tbTitle.val($xn.attr('title'));
			var titlepos= $xn.attr('titlepos');
			if ($xn[0].getAttribute('title') == null) titlepos= "off";
			this.panelTitlePos.setValue(titlepos);
			
			this.$tbRowCount.val($xn.attr('rowspan')||'1');

			this.$tdColumns3.toggle(this.section_columns == '3');
			this.panelLayout.setValue($xn.attr('colspan')||'1');

			this.$tbHtml.focus();
		},

		SaveState: function() {
			var $xn= this.$xn;
			
			
			var $xn_content= xml_getOrCreate(this.designer.xmlDoc, $xn, "content");
			$xn_content.text(this.$tbHtml.val().trim());

			var title= this.$tbTitle.val().trim();
			var titlepos= this.panelTitlePos.getValue();
			if (titlepos == "") {
				$xn.attr('title', title);
			} else {
				xml_updateAttr($xn, 'title', title);// remove attr if empty
				if (titlepos == "off" && title == "") titlepos= "";
			}
			xml_updateAttr($xn, 'titlepos', titlepos);
			
			var colspan0= $xn.attr('colspan')||'1';
			var colspan= this.panelLayout.getValue();
			var rowspan0= $xn.attr('rowspan')||'1';
			var rowspan= this.$tbRowCount.val()||'1';

			if (colspan == this.section_columns && rowspan != '1') rowspan= '1';

			if (isNaN(rowspan)) { AX.Window.alert('Please, enter correct rows count.'); return false; }
			if (parseInt(rowspan) > 20) { AX.Window.alert('Rows count must be less 20.'); return false; }
			this._window.returnValue= {
				colspan: parseInt(colspan),
				rowspan: parseInt(rowspan),
				layoutChanged: (colspan != colspan0 || rowspan != rowspan0),
				titleChanged: false
			};

			return true;
		},

		selectSnippet: function(e) {
			var $p= $("div#panelSnippets", this.$p).clone();
			var dlg= new AX.WindowPanel("Select snippet from the list:", $p, true);
			var btnCancel= $("<a class=\"fm-btn\" style=\"width:60px;margin-left:8px;\">Cancel</a>").click(function() { dlg.close(); });
			dlg.init([btnCancel]); 
			dlg.show();
			var onselect= $createDelegate(this.addSnippet, this);
			$("A", $p).click(function(e) { dlg.close(); onselect(e.target.getAttribute('data')); });
		},

		addSnippet: function(type) {
			var code= "";
			switch (type) {
				case "GRID":
code+='<control type="GRID" height="190">\n'+
' <set name="TableName" value="MY_SmartContacts" ' +'/'+'>\n'+
' <set name="ViewName" value="default" ' +'/'+'>\n'+
' <set name="OpenForm" value="FORM:default" ' +'/'+'>\n'+
' <set name="CreateForm" value="FORM:default" ' +'/'+'>\n'+
' <set name="AllowCreate" value="true" ' +'/'+'>\n'+
' <set name="AllowDelete" value="true" ' +'/'+'>\n'+
' <set name="HandlerParameters" value="800,500" ' +'/'+'>\n'+
' <set name="ShowGridFilterPanel" value="false" ' +'/'+'>\n'+
' <set name="ShowActionsMenu" value="true" ' +'/'+'>\n'+
' <!--set name="InputFilterField" value="UserID=[KeyValue]" /-->\n'+
'</control>';
					break;
				case "TEXT":
					code= '<label class="fm-form-text">Your custom text label.</label>';
					break;
				case "A":
code+='<control type="A" style="font-weight:bold">\n'+
' <set name="Text" value="Toggle Section" ' +'/'+'>\n'+
' <set name="Command" value="SCRIPT" ' +'/'+'>\n'+
' <set name="Value" value="frm.toggleSection(\'sec3\');var b= frm.getElement(\'sec3\').is(\':visible\');$element.text(b?\'Close\':\'Open\');" ' +'/'+'>\n'+
'</control>';
						break;
					case "BUTTON":
code+='<control type="BUTTON" style="min-width:120px;">\n'+
' <set name="Text" value="Run Java Script" ' +'/'+'>\n'+
' <set name="Command" value="SCRIPT" ' +'/'+'>\n'+
' <set name="Value" value="var $o= frm.getElement(\'Form1_MyDiv1\'); $o.css(\'color\',\'blue\'); frm.alert(\'your script goes here\');" ' +'/'+'>\n'+
'</control>';
						break;
					case "P-BUTTON":
code+='<control type="BUTTON" style="min-width:120px;">\n'+
' <set name="Text" value="Open Record Profile" ' +'/'+'>\n'+
' <set name="Handler" value="PROFILE:MyProfile" ' +'/'+'>\n'+
' <set name="Attributes" value="id=[KeyValue]" ' +'/'+'>\n'+
' <set name="WindowParameters" value="900,500" ' +'/'+'>\n'+
'</control>';
					break;
				case "WORD-BUTTON":
code+='<control type="BUTTON">\n'+
' <set name="Text" value="Open word document" ' +'/'+'>\n'+
' <set name="Command" value="URL" ' +'/'+'>\n'+
' <set name="Attributes" value="t=MY_SmartUsers,template=UserReport2,id=[KeyValue]" ' +'/'+'>\n'+
' <set name="Value" value="/ASP.Net/FM/DataViewer/Print/WordReportDownloader.aspx" ' +'/'+'>\n'+
' <set name="WindowParameters" value="500,250" ' +'/'+'>\n'+
' <set name="WindowTitle" value="Download document dialog" ' +'/'+'>\n'+
'</control>';
					break;
			}
			this.$tbHtml.val(code);
		},
		btn_click: function(e) {
			switch (_fm_getCommand(e)) {
				case "OK": if (this.SaveState()) this._window.close(); break;
				case "X": this._window.close(); break;
			}
		}
	}
</script>