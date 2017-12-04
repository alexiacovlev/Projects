RMC.FieldPropertiesDialog=function(b){this._window=b;var a=b.$content;$("#_bottomButtons",a).addHandler("click",this.btn_click,this);this.$btnChangeType=$("#btnChangeType",a);this.$tb_title=$("#tb_title",a);this.$tb_name=$("#tb_name",a);this.$tb_type=$("#tb_type",a);this.$tb_description=$("#tb_description",a);this.$cb_required=$("#cb_required",a);this.$cb_readonly=$("#cb_readonly",a);this.$panelText=$("#panelText",a);this.$panelNumber=$("#panelNumber",a);this.$panelPicklist=$("#panelPicklist",a);this.$panelExtract=$("#panelExtract",a);this.$panelRelation=$("#panelRelation",a);this.$panelDateTime=$("#panelDateTime",a);this.$panelBoolean=$("#panelBoolean",a);this.$panelFile=$("#panelFile",a);this.$panelEditableGrid=$("#panelEditableGrid",a);this.$panelDbType=$("#panelDbType",a);this.$listDbType=$("select#listDbType",this.$panelDbType);this.new_mode=false;this.$tb_name.addHandler("keyup",function(c){this.$tb_title.val(this.$tb_name.val())},this);this.xmlParser=xml_createParser()};RMC.FieldPropertiesDialog.prototype={openState:function(b,c,d,a){this.designer=d;this.OnChanged=a;var e='{"tableName":"'+b+'", "name":"'+c+'"}';ExecuteService(e,RMC.Path+"TableBuilder/SupportService.asmx/LoadFieldXml",$.proxy(this.onLoadFieldState,this))},onLoadFieldState:function(a){var b=a.d;if(b.Error!=null){AX.Window.alert("Field Properties",b.Error);return}this.xmlDoc=xml_loadXML(this.xmlParser,b.Data);this.$xn=$("field:first",this.xmlDoc)},loadNewState:function(c,g,d,b){this.designer=d;this.OnChanged=b;var f=g.split("/");var e=f[0];var a=f[1];var h=f[2]},loadXmlNode:function(d){var d=this.$xn;var g=this.$xn[0];var b=g.getAttribute("name");var k=g.getAttribute("type");var o=g.getAttribute("dbtype");this.togglePanels(k,o,isNew);var m=g.getAttribute("format");this.$tb_title.val(g.getAttribute("title"));this.$tb_name.val(g.getAttribute("name"));this.$tb_description.val(g.getAttribute("description"));this.$tb_type.val(k);this.$cb_required.prop("checked",g.getAttribute("required")=="true");this.$cb_readonly.prop("checked",g.getAttribute("readonly")=="true");var n=480;var j=450;var s=null;switch(k){case"Text":if(o!="Guid"){$("#tb_text_length",this.$panelText).val(g.getAttribute("size"));$("#cb_text_max",this.$panelText).prop("checked",g.getAttribute("size")=="");$("#cb_text_unicode",this.$panelText).prop("checked",o=="StringUnicode")}s=["String","Guid","Int32","Decimal","Double","Boolean","DateTime"];break;case"Float":case"Money":if(!this.$ddl_precision){this.$ddl_precision=$("#ddl_precision",this.$panelNumber)}if(!this.$tb_sign){this.$tb_sign=$("#tb_sign",this.$panelNumber)}if(!this.panel_FloatFormat){this.panel_FloatFormat=new FM.RadioGroup($("#panel_FloatFormat",this.$panelNumber))}this.panel_FloatFormat.setValue(k);this.$ddl_precision.val(g.getAttribute("size")||"");s=["Decimal","Double"];break;case"Picklist":if(!this.rb_picklist_mode){this.rb_picklist_mode=new FM.RadioGroup($("#rb_picklist_mode",this.$panelPicklist));this.$listPicklistSource=$("select#listPicklistSource",this.$panelPicklist);this.$listPicklistSource.change($createDelegate(function(){var h=this.$listPicklistSource.val()=="DB";$("tr#tr_picklist_1",this.$panelPicklist).toggle(!h);$("tr#tr_picklist_2",this.$panelPicklist).toggle(h)},this));$("a#linkOptions",this.$panelPicklist).addHandler("click",this.openStaticOptions,this);this.$lookup_extract_table2=new FM.LookupTextControl($("#lookup_extract_table2",this.$panelPicklist));this.$tb_extract_view2=$("#tb_extract_view2",this.$panelPicklist)}var l=d.find("extract");var a=!$isNull(l);this.$listPicklistSource.val(a?"DB":"");this.rb_picklist_mode.setValue(m);this.$lookup_extract_table2.setValue(a?(l.attr("table")||""):"");this.$tb_extract_view2.val(a?(l.attr("view")||""):"");this.$listPicklistSource.change();s=["Int32","Guid","String"];break;case"Lookup":this.loadExtract(d.find("extract"));var r=d.find("relation");if(!$isNull(r)||m=="multi"){this.loadRelation(d,r,k,m);j=545}s=["Int32","Guid","String"];break;case"Checkboxlist":this.loadExtract(d.find("extract"));var r=d.find("relation");this.loadRelation(d,r,k,m);break;case"DateTime":if(!this.$rb_datetime_mode){this.$rb_datetime_mode=new FM.RadioGroup($("#rb_datetime_mode",this.$panelDateTime))}this.$rb_datetime_mode.setValue(m);break;case"Boolean":if(!this.$rb_boolean_mode){this.$rb_boolean_mode=new FM.RadioGroup($("#rb_boolean_mode",this.$panelBoolean))}this.$rb_boolean_mode.setValue(m);break;case"Image":if(!this.$rb_image_mode){this.$rb_image_mode=new FM.RadioGroup($("#rb_image_mode",this.$panelFile))}if(!this.$tb_file){this.$tb_file=$("#tb_file",this.$panelFile)}if(m!=""&&m.indexOf("attachment:")==0){this.$tb_file.val(m.substring(m.indexOf(":")+1));this.$rb_image_mode.setValue("attachment")}else{this.$tb_file.val("");this.$rb_image_mode.setValue("photo")}break;case"EditableGrid":if(!this.lookup_slavegrid_table){this.lookup_slavegrid_table=new FM.LookupTextControl($("#lookup_slavegrid_table",this.$panelEditableGrid));this.$tb_slavegrid_view=$("#tb_slavegrid_view",this.$panelEditableGrid);this.$tb_slavegrid_parentkey=$("input#tb_slavegrid_parentkey",this.$panelEditableGrid);this.$panel_eg_list=$("#panel_eg_list",this.$panelEditableGrid)}var q=xml_getOrCreate(this.designer.xmlDoc,d,"slavegrid");this.lookup_slavegrid_table.setValue(q.attr("table")||"");this.$tb_slavegrid_view.val(q.attr("grid")||"");var e="";this.$panel_eg_list.empty();var c=q.children();for(var f=0;f<c.length;f++){var p=c[f];var b=p.getAttribute("name");var k=p.getAttribute("type");if(k=="parentkey"){e=b}else{this.$panel_eg_list.append('<div><input class="fm" style="width:150px;margin-left:5px;" disabled="disabled" value="'+b+'"/><input class="fm" style="width:100px;margin-left:5px;" disabled="disabled" value="'+p.getAttribute("value")+'"/></div>')}}this.$tb_slavegrid_parentkey.val(e);j=500;break}if(isNew){this.new_mode=true;this.$tb_name[0].className="fm";this.$tb_name.removeAttr("readonly");this.$btnChangeType.hide();if(o!=""){if(s==null){s=[];s.push(o)}this.$listDbType.empty();for(var f=0;f<s.length;f++){this.$listDbType.append("<option value='"+s[f]+"'>"+s[f]+"</option>")}this.$listDbType.val(o);this.$panelDbType.show();j+=20}else{this.$panelDbType.hide()}}else{if(this.new_mode){this.new_mode=false;this.$tb_name[0].className="fm ro";this.$tb_name.attr("readonly","true");this.$btnChangeType.show();this.$panelDbType.hide()}}this._window.setSize(n,j);this._window.setHeader(k+" - Field Properties");this._window.show();this._window.$content.fadeIn(100);if(isNew){this.$tb_name.focus()}else{this.$tb_title.focus()}},saveState:function(){var n=this.xmlNode;var h=this.$xmlNode;var B=n.getAttribute("name");var z=(!B);var b=n.getAttribute("type");var y=n.getAttribute("dbtype");if(z){if($("input#cbVirtual").prop("checked")){n.setAttribute("dbtype",y="")}B=this.$tb_name.val().trim();var f=this.$tb_name;if(B==""){return FM.Validators.notify(f,"","Please, provide the field's name",-25,-3)}if(!FM.Validators.checkName(B)){return FM.Validators.notify(f,"","The field name must begin with an english letter",-25,-3)}if(this.fieldExists(B)){return AX.Window.alert("Field Registration","The field with the name <b>"+B+"</b> already exists.<br/><br/>Please, define another name.",function(){f.focus()})}}var e=y!="";var m=(z&&e);n.setAttribute("title",this.$tb_title.val().trim());n.setAttribute("description",this.$tb_description.val().trim());var k=this.$cb_required.is(":checked")?"true":"false";if(k!=n.getAttribute("required")){n.setAttribute("required",k);m=true}n.setAttribute("readonly",this.$cb_readonly.is(":checked")?"true":"false");switch(b){case"Text":var p=$("#tb_text_length",this.$panelText).val().trim();if($("#cb_text_max",this.$panelText).is(":checked")){p=""}if(p!=n.getAttribute("size")){n.setAttribute("size",p);m=true}if(e){var d="String";if(z){d=this.$listDbType.val()}if($("#cb_text_unicode",this.$panelText).is(":checked")){d="StringUnicode"}if(y!=d){n.setAttribute("dbtype",d);m=true}}break;case"Float":case"Money":var p=this.$ddl_precision.val();n.setAttribute("size",p);var g=this.panel_FloatFormat.getValue();if(g!=b){n.setAttribute("type",b=g);if(z&&e){n.setAttribute("dbtype",y=(g=="Money")?"Decimal":"Double")}}n.setAttribute("format",this.$tb_sign.val().trim());break;case"Picklist":n.setAttribute("format",this.rb_picklist_mode.getValue());var C=this.$listPicklistSource.val()=="DB";var q=h.find("extract");if(C){if($isNull(q)){q=xml_appendNode(this.designer.xmlDoc,h,"extract")}q.attr("table",this.$lookup_extract_table2.getValue());q.attr("view",this.$tb_extract_view2.val())}else{if(!$isNull(q)){q.remove()}}break;case"Lookup":var j=h.find("relation");var A=!$isNull(j);var q=this.saveExtract(h,A);if($isNull(q)){return}if(A){if(!j.attr("table")){AX.Window.alert("Field Registration","Please, configure <b>Relation Db Table</b> for the field.");return}n.setAttribute("format",this.$rb_lookup_mode.getValue())}break;case"Checkboxlist":var q=this.saveExtract(h,false);if($isNull(q)){return}var j=h.find("relation");if(!j.attr("table")){AX.Window.alert("Field Registration","Please, configure <b>Relation Db Table</b> for the field.");return}break;case"DateTime":n.setAttribute("format",this.$rb_datetime_mode.getValue());break;case"Boolean":n.setAttribute("format",this.$rb_boolean_mode.getValue());break;case"Image":var w="";if(this.$rb_image_mode.getValue()=="attachment"){w="attachment:"+this.$tb_file.val().trim()}n.setAttribute("format",w);break;case"EditableGrid":var c=h.find("slavegrid");var o=this.lookup_slavegrid_table.getValue().trim();var l=this.$tb_slavegrid_view.val().trim()||"default";var x=this.$tb_slavegrid_parentkey.val().trim();if(!o){return AX.Window.alert("Field Registration","To complete the registration, you should specify the <b>Table Name</b>.")}if(!x){return AX.Window.alert("Field Registration","To complete the registration, you should specify the <b>Primary Key</b>.")}c.attr("table",o).attr("grid",l);var a=c.children();var u=null;for(var s=0;s<a.length;s++){var r=a[s];if(r.getAttribute("type")=="parentkey"){u=$(r)}}if(u==null){u=xml_appendNode(this.designer.xmlDoc,c,"column")}u.attr("name",x).attr("type","parentkey");break}if(z){n.setAttribute("name",B)}this._window.close();this.OnChanged(n,z,(m&&e))},loadExtract:function(b){var c=b.attr("table");var a=b.attr("view");if(!this.$lookup_extract_table){this.$lookup_extract_table=new FM.LookupTextControl($("#lookup_extract_table",this.$panelExtract))}this.$lookup_extract_table.setValue(c||"");if(!this.$tb_extract_view){this.$tb_extract_view=$("#tb_extract_view",this.$panelExtract)}this.$tb_extract_view.val(a||"");var e=b.attr("dialog");if(!this.$tb_extract_dialog){this.$tb_extract_dialog=$("#tb_extract_dialog",this.$panelRelation);this.$cb_extract_dialog=$("#cb_extract_dialog",this.$panelRelation);this.$cb_extract_dialog.change($createDelegate(function(){this.$tb_extract_dialog.toggle(this.$cb_extract_dialog.is(":checked"))},this))}this.$cb_extract_dialog.prop("checked",e!=null&&e!="").change();this.$tb_extract_dialog.val(e||"")},saveExtract:function(f,a){var e=this.$lookup_extract_table.getValue();var c=this.$tb_extract_view.val().trim();var g=this.$tb_extract_dialog.val().trim();if(!this.$cb_extract_dialog.is(":checked")){g=""}if(a){if(!e&&!g){AX.Window.alert("Field Registration","To complete the registration, you should specify<br/><b>lookup table</b> or <b>multi-typed dialog</b> with the collection<br/>of lookup views.");return}}else{if(!e){AX.Window.alert("Field Registration","To complete the registration, you should specify the <b>lookup table</b>.");return}}var b=xml_getOrCreate(this.designer.xmlDoc,f,"extract");b.attr("table",e);b.attr("view",c);if(a){xml_updateAttr(b,"dialog",g)}return b},loadRelation:function(c,b,a,d){if(!this.$panelRelationLookup){this.$panelRelationLookup=$("#panelRelationLookup",this.$panelRelation)}this.$panelRelationLookup.toggle(a=="Lookup");if($isNull(b)){b=xml_appendNode(this.designer.xmlDoc,c,"relation")}if(!this.$rb_lookup_mode){this.$rb_lookup_mode=new FM.RadioGroup($("#rb_lookup_mode",this.$panelRelation));this.$labelRelationTable=$("#labelRelationTable",this.$panelExtract_relation);$("a#linkRelation",this.$panelRelation).addHandler("click",this.openRelation,this)}this.$labelRelationTable.text(b.attr("table")||"not configured");this.$rb_lookup_mode.setValue(d);this.$panelRelation[0].style.display=""},openRelation:function(){var e=this.$xmlNode;var a=this.$tb_name.val().trim();var b=this.designer;var d=$createDelegate(function(f){this.$labelRelationTable.text(f.attr("table")||"not configured")},this);var c=AX.Window.createPopupWindow("Field Relation Settings",550,350,false,true);c.loadASCX(RMC.Path+"TableBuilder/Dialogs/dlg_Relation.ascx",null,function(){new RMC.LookupRelationEditor(c,b,e,a,d)});c.show()},openStaticOptions:function(){var b=this.$tb_name.val();if(!b){AX.Window.alert("Please, enter the name for the field, before filling-up the list.");return}var a=this.designer.tableName;var c=AX.Window.createPopupWindow("Static Options",440,440,false,true);c.loadASCX(RMC.Path+"TableBuilder/Dialogs/dlg_StaticOptions.ascx",null,function(){new RMC.StaticOptionsEditor(c,a,b)});c.show()},togglePanels:function(c,b,a){this.$panelText[0].style.display=(c=="Text"&&b!="Guid")?"":"none";this.$panelNumber[0].style.display=(c=="Float"||c=="Money")?"":"none";this.$panelPicklist[0].style.display=(c=="Picklist")?"":"none";this.$panelExtract[0].style.display=(c=="Lookup"||c=="Checkboxlist")?"":"none";this.$panelDateTime[0].style.display=(c=="DateTime")?"":"none";this.$panelBoolean[0].style.display=(c=="Boolean")?"":"none";this.$panelFile[0].style.display=(c=="Image")?"":"none";this.$panelEditableGrid[0].style.display=(c=="EditableGrid")?"":"none";this.$panelRelation[0].style.display="none";var d=(a&&b!="")},fieldExists:function(a){var c=this.designer.$xnfields.children();a=a.toLowerCase();for(var b=0;b<c.length;b++){if(c[b].getAttribute("name").toLowerCase()==a){return true}}return false},btn_click:function(a){switch(_fm_getCommand(a)){case"OK":this.saveState();break;case"X":this._window.close();break}}};