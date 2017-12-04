// Records Management Console Client Script Library
// Alfa-XP, Michael Isipciuc, 2013.
//
AX.ResxManager=function(e,a,d,c){this.folderPath="/ASP.Net/WebAdmin/ResxManager/";var b=e;this.$listTables=$("#listTables",b);this.$listFilter=$("#listFilter",b);this.resx=this.$listTables.attr("resx");this.system=this.$listTables.attr("system");this.$listTables.addHandler("click",this.onclick,this);this.$toolbar=$("#_toolbar",b);this.$toolbar.addHandler("click",this.toolbar_click,this);this.selected_row=null;this.$tbSearch=$("input#tbSearch",this.$toolbar);this.$searchMsg=$("#searchMsg",this.$toolbar);this.$tbSearch.addHandler("keypress",function(f){if(f.keyCode==13){this.findItem()}},this);this._searchIndex=0;this._searchCell=null;this._searchText=null;this.hdrCells=$("#rowHdr",b)[0].cells;this.$panelAdd=$("#panelAdd",b);this.load();this.$lblCount=$("#lblCount",b);this.$panelInfo=$("#panelInfo",b);this.$panelMenu=$("#panelMenu",b);if(this.$panelInfo[0].style.display!="none"){this.$panelMenu.show()}};AX.ResxManager.prototype={init:function(){this._table=this.$listTables[0].firstChild;this._rows=this._table.rows;this.$lblCount.text("("+this._rows.length+")")},load:function(){this.$listTables.load(this.folderPath+"table_rows.ashx?"+this.resx,$createDelegate(this.init,this))},onChangeFilter:function(){this.selected_row=null},getSelectedName:function(){if(!this.selected_row){AX.Window.alert("","Please, select the table from the list.")}return this.selected_row?this.selected_row.getAttribute("n"):""},onclick:function(a){var b=a.target;if(b.tagName=="TD"){this.editItem(b)}},editItem:function(b){this.clearSelection();this._selectedRow=b.parentNode;this._selectedRow.className="sel";this._selectedIndex=b.cellIndex;this._selectedKey=$(this._selectedRow.cells[0]).text();var d="# "+this._selectedKey;var a=$("<input class='fm' style='font-size:10pt;' />");if(this._selectedIndex==0&&this.system=="true"){a.attr("disabled","disabled")}var c=$("<div></div>");c.append(a);c.append("<div style='font-weight:normal;font-size:8pt;text-align:right;margin-top:3px;'>"+$(this.hdrCells[this._selectedIndex]).text()+"</div>");this.editDialog=AX.Window.dialog(d,c,this.editItem_onclose,this);this.editDialog.show();this.editDialog.value=$(b).text();this.editDialog.$tb=a;a.val(this.editDialog.value);a.focus().select()},editItem_onclose:function(){var e=this.editDialog.$tb.val().trim();if(this.editDialog.value!=e){if(this._selectedIndex==0&&e==""){$(this._selectedRow).remove()}else{if(this._selectedIndex==0){if(!this.checkDublicate(e,this._selectedRow.rowIndex)){return}e=this.prepareText(e)}var b=this._selectedRow.cells;var a=b[this._selectedIndex];$(a).text(e);this.toggleState(true);for(var c=0;c<b.length;c++){b[c].className="modified"}}var d={resx:this.resx,key:this._selectedKey,value:e,index:(this._selectedIndex-1)};ExecuteService(JSON.stringify(d),this.folderPath+"Service.asmx/Update",this.service_callback)}this.editDialog.close()},service_callback:function(a){var b=a.d;if(b!=""){AX.Window.alert("Error",b)}},checkDublicate:function(d,a){d=d.toLowerCase();for(var c=0;c<this._rows.length;c++){if(c==a){continue}var e=this._rows[c];var b=$(e.cells[0]).text().toLowerCase();if(b==d){AX.Window.alert("","Translation for this Key already exists");return false}}return true},addItem:function(b){this.clearSelection();this.$panelAdd.find("#Msg").hide();this.$panelAdd.remove().show();var c=this.$panelAdd.find("input");for(var d=0;d<c.length;d++){c[d].value=""}var a=$("");this.addDialog=AX.Window.dialog("Add",this.$panelAdd,this.addItem_onclose,this);this.addDialog.show();this.$panelAdd.find("input:first").focus()},prepareText:function(a){return a.replace(/"/g,"")},addItem_onclose:function(){var a=this.$panelAdd.find("input");var e=this.prepareText(a[0].value.trim());if(e==""){this.$panelAdd.find("#Msg").show();a[0].focus();return}if(!this.checkDublicate(e,-1)){return}this.addDialog.close();var b=[];var f=$("<tr></tr>");for(var d=0;d<a.length;d++){var h=$("<td class='modified'></td>");f.append(h);if(d==0){h.text(e)}else{h.text(a[d].value.trim());b.push(a[d].value.trim())}}var c=$(this._table);c.append(f);this._rows=this._table.rows;this.$listTables.animate({scrollTop:c.height()},500);this.toggleState(true);var g={resx:this.resx,key:e,values:b};ExecuteService(JSON.stringify(g),this.folderPath+"Service.asmx/Add",this.service_callback)},clearSelection:function(){if(this._selectedRow){this._selectedRow.className=null}this._selectedRow=null},findItem:function(){this.find($("input#tbSearch",this.$toolbar).val())},find:function(f){this.$searchMsg.hide();if(!f||!this._rows||this._rows.length==0){return}this.clearSelection();f=f.toLowerCase();var g=this._rows[0].cells.length;var e=$(this._rows[0]).height();var a;if(this._searchText&&this._searchText!=f){this._searchIndex=0}this._searchText=f;for(var c=this._searchIndex;c<this._rows.length;c++){var k=this._rows[c];for(var b=0;b<g;b++){a=k.cells[b];ts=a.innerHTML.toLowerCase();if(ts.indexOf(f)!=-1){if(this._searchCell){this._searchCell.className=null}a.className="found";this._searchIndex=c+1;this._searchCell=a;var d=c*e;this.$listTables.animate({scrollTop:d},500);return}}}this._searchIndex=0;if(this._searchCell){this._searchCell.className=null}this.$searchMsg.show()},toggleState:function(a){this.$panelInfo.toggle(a);this.$panelMenu.toggle(a)},publish:function(){this.toggleState(false);FM.ProgressBar.Show("Publishing is in progress");var a={resx:this.resx};var b=function(c){FM.ProgressBar.Hide();var d=c.d;if(d!=""){AX.Window.alert("Error",d);this.toggleState(true);return}this.load();AX.Window.alert("Done.")};ExecuteService(JSON.stringify(a),this.folderPath+"Service.asmx/Publish",$createDelegate(b,this))},toolbar_click:function(a){switch(_fm_getCommand(a)){case"add":this.addItem();break;case"find":this.findItem();break;case"publish":this.publish();break}},};