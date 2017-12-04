<%@ Control Language="C#" Inherits="AX.Kernel.UI.HtmlModuleUserControl" ScriptClientType="RMC.EntitiesDialog" %>
<style type="text/css">
	ul.fm-dlg-menulist { width: 100%; }
	ul.fm-dlg-menulist li { padding:4px; border:solid 1px transparent; margin:1px; cursor:pointer; }
	ul.fm-dlg-menulist label { margin-left:5px; display:inline-block; line-height:16px; }
	ul.fm-dlg-menulist img { vertical-align:bottom; }
	ul.fm-dlg-menulist li.sel { border-color:#feba3e; background-color:#fcdfaa; border-radius:3px; }
	ul.fm-dlg-menulist li:hover { border-color:#b1b1b1;color:#333;background-image: url(/ASP.Net/FM/Images/Nav/tab_bg.png);background-position:0px 28px; }

	ul.fm-dlg-list { width: 100%; }
	ul.fm-dlg-list li { padding:5px 4px 4px 4px; border-bottom:solid 1px #cdd4e3; cursor:default; }
	ul.fm-dlg-list span { margin-left:5px; display:inline-block;line-height:16px; }
	ul.fm-dlg-list img { vertical-align:bottom; }
	ul.fm-dlg-list li.sel { background-color:#fcdfaa; }
	ul.fm-dlg-list li:hover { color:#333;background-image: url(/ASP.Net/FM/Images/Nav/tab_bg.png);background-position:0px 28px; }
</style>
<div class="fm-dlg" style="position:absolute;left:0;top:0;width:200px;bottom:30px;background-color:#fefefe;border:solid 1px #787878;">
	<ul class="fm-dlg-menulist">
		<li i="0"><img width="16" height="16" src="/ASP.Net/FM/Images/Explorer/ico_table.png"/><label style="width:140px">Forms</label><span>(0)</span></li>
		<li i="1"><img width="16" height="16" src="/ASP.Net/FM/Images/Explorer/ico_table.png"/><label style="width:140px">Views</label><span>(0)</span></li>
		<li i="2"><img width="16" height="16" src="/ASP.Net/FM/Images/Explorer/ico_lookup.png"/><label style="width:140px">Lookups</label><span>(0)</span></li>
		<li i="3"><img width="16" height="16" src="/ASP.Net/FM/Images/Explorer/ico_table.png"/><label style="width:140px">Editable Grids</label><span>(0)</span></li>
	</ul>
</div>
<div class="fm-dlg-menu" style="position:absolute;left:204px;top:0;right:0;bottom:30px;background-color:#fffbff;border:solid 1px #787878;">
	<div style="height:54px;position:relative">
		<img style="position:absolute;bottom:0;left:2px;" src="/ASP.Net/FM/Images/Explorer/form_watermark.png" width="113" height="53"" />
		<label id="lblHeader" style="position:absolute;left:125px;top:9px;border-bottom:solid 1px #37377c;color:#37377c;font-size:10pt;font-weight:bold;"><span style="display:none">Customize Forms</span><span style="display:none">Customize Views</span><span style="display:none">Customize Lookup Views</span><span style="display:none">Customize Editable Grid Views</span></label>
		<label style="position:absolute;left:132px;top:32px;color:#666666">Use the buttons below to add or modify the items</label>
	</div>
	<div style="height:24px;border-top:solid 1px #9d9492;" class="fm-toolbar">
		<div class="fm-menu">
			<a cmd="add"><img src="/ASP.Net/Images/ico/create_record.png" width="16"/>New&nbsp;</a>
			<a cmd="edit"><img src="/ASP.Net/Images/ico/ico_18_1089.png" width="16"/>Modify&nbsp;</a>
		</div>
	</div>

	<div style="overflow-y:scroll;position:absolute;top:79px;left:0;right:0;bottom:0;border-top:solid 1px #9d9492;">
		<ul class="fm-dlg-list">
			<div style="text-align:center;padding-top:130px;color:#555555">loading ...</div>
		</ul>
	</div>
	
</div>

<div class="fm-dlg-buttons" style="position:absolute;bottom:3px;right:3px;">
	<%= AX.FM.Common.UI.Button.Render("OK", "width:60px;", true) %>
</div>

<script type="text/javascript">
$registerNamespace("RMC");
RMC.Path= "<%= AX.FM.Explorer.Utils.Path %>";

RMC.EntitiesDialog= function(wnd, t) {
	wnd.setHeader("Table Entities");
	this._window= wnd;
	this.tableName= t;
	this.$p= wnd.$content;
	this.headers_list= $("#lblHeader", this.$p).children();
	this.selectedModeIndex= -1;

	this.redraw= function() {
		var data= "{\"t\":\"" + this.tableName + "\"}";
		ExecuteService(data, RMC.Path + "RMC/SupportService.asmx/GetEntities", $.proxy(this.onLoadState, this), _fm_onHandlerError);
	}

	this.onLoadState= function(result) {
		this.entities= result.d;
		var menu_items= this.$menu.children();
		for (var i= 0; i < menu_items.length; i++) {
			$(menu_items[i].childNodes[2]).text('('+this.entities[i].length+')');
		}

		this.$menu.children()[0].className= 'sel';
		this.loadList(0);
	},

	this.loadList= function(index) {
		var list= this.entities[index];
		var s= "";
		this.selectedItem= null;
		if (list.length>0) {
			for (var i= 0; i < list.length; i++) s+= "<li n='"+list[i]+"'><img width='16' height='16' src='/ASP.Net/FM/Images/Explorer/ico_table.png'/><span>"+list[i]+"</span></li>";
		} else {
			s= "<div style='text-align:center;padding-top:130px;color:#555555'>No items</div>";
		}
		this.$list.html(s);

		this.headers_list.hide();
		this.headers_list[index].style.display='';
		this.selectedModeIndex= index;
	}

	this.addNew= function() {
		var wnd= AX.Window.createPopupWindow("Enter a Name", 400, 150, false, false);
		wnd.$content.append("<div><div style=\"white-space:nowrap;margin:30px 20px;\"><div style=\"white-space:nowrap;margin:10px 20px;\"><label style=\"width:90px;font-weight:bold;padding-right:10px;\">Name:</label><input class=\"fm\" style=\"width:230px;height:22px;\" /></div></div>");
		wnd.$content.append("<a class='fm-btn' style='position:absolute;bottom:5px;right:5px;width:60px;font-weight:bold;'><img src='/ASP.Net/FM/Common/Images/ok.png'>OK</a>");

		var $tb= $("input:first", wnd.$content);
		$("a:first", wnd.$content).addHandler('click', function() { var n= $tb.val().trim(); wnd.close(); this.openEditor(n) }, this);
		wnd.show();
		$tb.focus();
	}


	this.btn_click= function(e) {
		switch (_fm_getCommand(e)) {
			case "add": this.addNew(); break;
			case "edit": this.openEditor(); break;
			case "OK": this._window.close(); break;
		}
	}

	this.openEditor= function(n) {
		var name= n||this.selectedItem; if (!name) return;
		switch (this.selectedModeIndex) {
			case 0: FM.ShowAdminWindow("FormBuilder", 1000, 650, "t="+this.tableName+"/f="+name, null); break;
			case 1: FM.ShowAdminWindow("ViewBuilder", 950, 550, "t="+this.tableName+"/v="+name+"/mode=GRID", null); break;
			case 2: FM.ShowAdminWindow("ViewBuilder", 820, 500, "t="+this.tableName+"/v="+name+"/mode=LOOKUP", null); break;
			case 3: FM.ShowAdminWindow("ViewBuilder", 860, 500, "t="+this.tableName+"/v="+name+"/mode=EGRID", null); break;
		} 
	}

	this.menu_click= function(e) {
		var mas= this.$menu.children();
		for (var i= 0; i < mas.length; i++) mas[i].className= '';
		
		e.currentTarget.className= 'sel';
		this.loadList(parseInt(e.currentTarget.getAttribute('i')));
	}
	this.list_click= function(e) {
		var o= e.target;
		if (o.tagName == "IMG" || o.tagName == "SPAN") o= o.parentNode;
		if (o.tagName == "LI") {
			if (o.className == 'sel') { this.openEditor(); return; }
			var mas= this.$list.children();
			for (var i= 0; i < mas.length; i++) mas[i].className= '';
			o.className= 'sel';
			this.selectedItem= o.getAttribute('n');
		}
	}


	this.$menu= $("ul.fm-dlg-menulist", this.$p);
	this.$menu.children().addHandler('click', this.menu_click, this);

	this.$list= $("ul.fm-dlg-list", this.$p);
	this.$list.addHandler('click', this.list_click, this);

	$("div.fm-dlg-buttons a", this.$p).addHandler('click', this.btn_click, this);
	$("div.fm-menu a", this.$p).addHandler('click', this.btn_click, this);

	this.redraw();

}
</script>
