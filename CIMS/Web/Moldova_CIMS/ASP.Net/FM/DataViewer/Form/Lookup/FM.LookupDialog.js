FM.LookupDialog=function(g,f,a,b,c,e){this.formID=g;this.data_name=f;this.dtype=a;this.filter=c;this.selected_items=b;this.onSelect=e;var d=new AX.Window(true);this._window=d;this.$p=d.$content;d.setHeader("...");if(a=="multi"){d.setSize(800,570)}else{if(a=="tree"){d.setSize(560,550)}else{d.setSize(670,540)}}d.show();fmExecuteDataService("LookupDialog_Generate",'{"formID":"'+g+'","name":"'+f+'","dtype":"'+a+'"}',$.proxy(this._onGenerate,this))};FM.LookupDialog.prototype={dispose:function(){if(this.innerGrid){this.innerGrid.dispose();this.innerGrid=null}},_onGenerate:function(b){var d=b.d;this.$p.html(d.Html);if(d.HasError){return}var e=this.$p.children();this.$hdr=$(e[0]);this.$content=$(e[1]);this.$buttons=$(e[2]);this.isMultiTyped=(e[0].className=="fm-ldlg-mthdr");var g=this.$hdr.children();var c=this.$content.children();if(this.dtype=="multi"){this.isMany2Many=true;this.$multiPanel=$(c[1]);this.$gridPanel=$(c[0])}else{this.isMany2Many=false;this.$gridPanel=this.$content}this.innerGrid=null;this.lookupType="";if(this.isMultiTyped){this.$typeSelector=$(g[1]).find("select:first");this.$typeSelector.change($.proxy(this.type_onchange,this))}else{this.gridID=g[1].getAttribute("gridID")}this.$buttons.click($.proxy(this.btn_click,this));if(this.isMany2Many){this.$ml_add=$(c[2]);this.$ml_add.click($.proxy(this.grid_dblclick,this));this.$ml_remove=$(c[3]);this.$ml_remove.click($.proxy(this.multi_remove,this));this.$multiPanel.addHandlers({click:this.multi_click,dblclick:this.multi_remove},this)}this.loadState();if(App.User.IsAdmin){var f=$("<img src='/ASP.Net/FM/Common/Images/menu_grid.png' class='fm-ico' style='position:absolute;top:2px;right:3px;' title='Edit View'/>").addHandler("click",this.admin_click,this);this.$p.append(f)}this.search_nodes=this.$hdr.children()[2].childNodes;var a=$(this.search_nodes[2].firstChild);a.one("focus",$createDelegate(this.search_attach,this))},loadState:function(){if(this.isMultiTyped){this.type_onchange()}else{this.loadDataGrid()}if(this.isMany2Many){this.$multiPanel.html("");for(var a=0;a<this.selected_items.length;a++){this.$multiPanel.append($(this.selected_items[a].buildHtml()))}}},btn_click:function(b){var c=b.target;if(c.tagName!="A"){c=$(c).parent()[0]}if(c.tagName!="A"||c.disabled){return}var a=$(c).attr("cmd");switch(a){case"EDIT":this.OpenProperties();break;case"NEW":this.OpenNew();break;case"NULL":this.ReturnNone();break;case"OK":this.ReturnSelected();break;case"X":this.Close();break}},ReturnNone:function(){this.selected_items=new Array();this.ReturnItemsAndClose()},ReturnSelected:function(){if(!this.isMany2Many){this.selected_items=this.grid_getSelectedItems()}this.ReturnItemsAndClose()},ReturnItemsAndClose:function(){this.Close();if(this.onSelect){this.onSelect(this.selected_items)}},OpenProperties:function(){var b=this.grid_getSelectedItems();if(b.length==0){return AX.window.alert("Please, select the record.")}var a=b[0];var c=$createDelegate(function(d){if(d){this.loadData()}},this.innerGrid);window.fmOpenHandler("DIALOG/EDIT",this.formID,this.data_name+"|"+a.Type,"id="+a.Value,null,c)},OpenNew:function(){var b=$createDelegate(function(c){if(c){this.loadData()}},this.innerGrid);var a=this.filter?("_data="+this.filter):"";window.fmOpenHandler("DIALOG/NEW",this.formID,this.data_name+"|"+this.lookupType,a,null,b)},loadDataGrid:function(){var a='{"gridID":"'+this.gridID+'","filter":"'+this.filter+'"}';_fmLoadScriptModule("LookupDialog_Grid",a,this.$gridPanel,null,"",$.proxy(this.onGridCreated,this))},onGridCreated:function(j){this.innerGrid=j;var l=j.settings("title");var b=j.settings("dlg_title");if(!b){b=l}if(this._window){this._window.setHeader(b)}var o=j.settings("dlg_desc");if(o){$($(this.$hdr.children()[0]).children()[1]).html(o)}j.allowMultiSelect=this.isMany2Many;j.row_dblclick=$.proxy(this.grid_dblclick,this);var e=j.settings("lookup_btn1");var d=j.settings("lookup_btn2");if(e||d||this.isMultiTyped){var f=this.$buttons.children();var m=f[0];var k=f[1];if(e){$(m).text(e).show()}else{$(m).hide()}if(d){$(k).text(d).show()}else{$(k).hide()}}var a=j.settings("s_names").split(";");var h=j.settings("s_titles").split(";");var n=$(this.search_nodes[1]);var p="";for(var g=0;g<a.length;g++){p+=("<option value='"+a[g]+"'>"+h[g]+"</option>")}n.empty().html(p);n.attr("size",1);if(this.search){this.search.grid=this.innerGrid}},search_attach:function(f){if(this.s_attached){return}this.s_attached=true;var c=this;var b=this.innerGrid;var g=$(this.search_nodes[1]);var a=$(this.search_nodes[2].firstChild);var d=$(this.search_nodes[3]);if(typeof(FM.GridSearch)=="function"){(c.search=new FM.GridSearch(b,g,a,d))}else{Runtime_ResourceLoader.LoadResources([FM.Path+"DataViewer/Grid/JS/fm.grid.search.js"],function(){c.search=new FM.GridSearch(b,g,a,d)})}},type_onchange:function(){var a=this.$typeSelector.val().split("|");this.gridID=a[0];this.lookupType=a[1];this.loadDataGrid()},grid_dblclick:function(b){var a=this.grid_getSelectedItems();if(this.isMany2Many){this.multi_addLookupItems(a,true)}else{this.selected_items=a;this.ReturnItemsAndClose()}},grid_getSelectedItems:function(){var c=this.innerGrid.selectedRows;var a=new Array();for(var b=0;b<c.length;b++){a.push(this.grid_buildItemByRow(c[b]))}return a},grid_buildItemByRow:function(d){var a=d.getAttribute("rid");if(a==null){a=d.getAttribute("oid")}var b="";var e=d.cells[0];if(e.firstChild){if(e.firstChild.tagName=="B"&&e.firstChild.getAttribute("h")){e=e.nextSibling}if(e.firstChild.tagName=="IMG"){b=e.firstChild.src;e=e.nextSibling}}var c=$(e).text();return new FM.LookupItem(a,this.lookupType,null,c,b)},multi_addLookupItems:function(b,a){if(b!=null&&b.length>0){var d;for(var c=0;c<b.length;c++){d=b[c];if(!a||!this.multi_isExists(d)){this.$multiPanel.append($(d.buildHtml()));this.selected_items.push(d)}}}},multi_isExists:function(a){var b=this.selected_items;for(var c=0;c<b.length;c++){if(b[c].Value==a.Value&&b[c].Type==a.Type){return true}}return false},multi_getItem:function(a){var b=a.target;if(b.tagName=="IMG"){b=b.parentNode}return(b.tagName=="A")?$(b):null},multi_remove:function(b){if(!this.$multi_sel){return}var a=this.$multi_sel.index();if(a!=-1){this.selected_items.splice(a,1);this.$multi_sel.remove();this.$multi_sel=null}},multi_click:function(b){if(this.$multi_sel){this.$multi_sel.removeClass("fm-l-a-sel");this.$multi_sel=null}var a=this.multi_getItem(b);if(a){a.addClass("fm-l-a-sel");this.$multi_sel=a}},admin_click:function(){var c=this.innerGrid;if(!c){return}var b=$createDelegate(function(){this.loadDataGrid()},this);var a=c.widths;c.widths="";FM.ShowAdminWindow("ViewBuilder",860,540,"t="+c.settings("t")+"/v="+c.settings("v")+"/mode=LOOKUP/w="+a,b)},Close:function(){if(this._window){this._window.close()}}};