RMC.FB_CellProperties=function(a){this._window=a;this.$p=a.$content;this.initialize(this.$p)};RMC.FB_CellProperties.prototype={initialize:function(b){this.tabBar=new FM.Tabbar($("div.fm-dlg-tabbar",b));this.$tbTitle=$("#tbTitle",b);this.resTitle=new FM.ResTitle(this.$tbTitle);this.panelAlignment=new FM.RadioGroup($("#panelAlignment",b));this.$tbRowCount=$("#tbRowCount",b);this.panelTitlePos=new FM.RadioGroup($("#panelTitlePos",b));this.panelLayout=new FM.RadioGroup($("#panelLayout",b));this.$tdColumns3=$("#tdColumns3",b);this.panelRequiredLevel=new FM.RadioGroup($("#panelRequiredLevel",b));this.$lblRequired=$("#lblRequired",b);this.panelReadonly=new FM.RadioGroup($("#panelReadonly",b));this.$lblReadonly=$("#lblReadonly",b);this.$trWatermark=$("#trWatermark",b);this.$tbWatermark=$("#tbWatermark",b);this.tbOnCreateValue=new FM.LookupTextControl($("#tbOnCreateValue",b));this.tbOnUpdateValue=new FM.LookupTextControl($("#tbOnUpdateValue",b));this.$panelNumbers=$("#panelNumbers",b);this.$panelText=$("#panelText",b);this.$tbEvent=$("#tbEvent",b);this.$cbEventEnabled=$("#cbEventEnabled",b);this.$tbSchemaName=$("#tbSchemaName",b);this.$tbSchemaType=$("#tbSchemaType",b);this.$tbSchemaDbType=$("#tbSchemaDbType",b);this.$tbSchemaTitle=$("#tbSchemaTitle",b);this.$tbSchemaDesc=$("#tbSchemaDesc",b);this.$tbDescription=$("#tbDescription",b);this.$cbShowHelp=$("#cbShowHelp",b);this.$panelSuggestions=$("#panelSuggestions",b);this.$rowForText=$("#rowForText",b);this.$cbSuggestions=$("#cbSuggestions",b);this.$panelOnClick=$("#panelOnClick",b);var a=$createDelegate(this.btn_click,this);$("div.fm-dlg-buttons",b).click(a);$("#linkMetadata",b).click(a);this.$linkScript=$("#linkScriptEditor",b);this.$linkScript.click(a);$("#linkScriptHelp",b).click(a);this.isQuickEdit=false},LoadState:function(s,e,m,c){this.designer=s;this.$xn=e;this.$xn_s=m;var n=this.$p;var t=m.attr("name");var a=m.attr("type");var f=e[0].childNodes;this.xn_prop=null;this.xn_event=null;this.xn_content=null;for(var k=0;k<f.length;k++){switch(f[k].tagName){case"properties":this.xn_prop=f[k];break;case"event":this.xn_event=f[k];break;case"content":this.xn_content=f[k];break}}var l=m.attr("format");var p=xml_getAttribute(this.xn_prop,"behavior");var q=e.parent().parent().parent();var d=parseInt(q.attr("columns")||"1");this.resTitle.setValue(e.attr("title"));this.resTitle.setResValue(e.attr("restitle"));this.panelAlignment.setValue(e.attr("titlealign"));var r=(l=="textarea"||l=="multi"||(a=="Image"&&l=="")||a=="EditableGrid"||a=="Checkboxlist");this.$tbRowCount.parent().css("visibility",r?"visible":"hidden");this.$tbRowCount.val(e.attr("rowspan")||"1").prop("disabled",!r);this.panelTitlePos.setValue(e.attr("titlepos"));this.$tdColumns3.toggle(d==3);this.panelLayout.setValue(e.attr("colspan")||"1");this.isSystemRequired=m.attr("required")=="true";this.panelRequiredLevel.items.prop("disabled",this.isSystemRequired);if(!this.isSystemRequired){this.panelRequiredLevel.setValue(xml_getAttribute(this.xn_prop,"requiredlevel"));this.$lblRequired.text("Select the business requirement level.")}else{this.panelRequiredLevel.setValue("required");this.$lblRequired.text("The field is system required, you cannot override it.")}this.isSystemReadonly=m.attr("readonly")=="true";if(!this.isSystemReadonly){this.panelReadonly.setValue(xml_getAttribute(this.xn_prop,"readonly"));this.$lblReadonly.text("Select the editing level.")}else{this.panelReadonly.setValue("true");this.$lblReadonly.text("The field is disabled for all forms, you cannot override it.")}this.isNumber=(a=="Integer"||a=="Float"||a=="Money");this.allowWatermark=(a=="Text"||this.isNumber);this.$trWatermark.toggle(this.allowWatermark);if(this.allowWatermark){this.$tbWatermark.val(xml_getAttribute(this.xn_prop,"watermark"))}this.tbOnCreateValue.setValue(xml_getAttribute(this.xn_prop,"oncreatevalue"));this.tbOnCreateValue.parentValue=a;this.tbOnUpdateValue.setValue(xml_getAttribute(this.xn_prop,"onupdatevalue"));this.tbOnUpdateValue.parentValue=a;this.$panelNumbers.toggle(this.isNumber);if(this.isNumber){var g="";var j="";if(p&&p.indexOf("|")!=-1){g=p.split("|")[0];j=p.split("|")[1]}this.$panelNumbers.find("#tbNumMin").val(g);this.$panelNumbers.find("#tbNumMax").val(j)}this.$panelText.toggle(a=="Text");if(a=="Text"){this.$panelText.find("#ddlValidationType").val("");this.$panelText.find("#tbTextExp").val("");if(p!=null&&p!=""&&p.indexOf("lookup:")==-1){if(p=="email"||p=="phone"){this.$panelText.find("#ddlValidationType").val(p)}else{if(p.indexOf("regex:")==0){this.$panelText.find("#ddlValidationType").val("custom");this.$panelText.find("#tbTextExp").val(p.substr(6))}}}}var h=true;if(this.xn_event){this.$tbEvent.val($(this.xn_event).text());h=this.xn_event.getAttribute("enabled")!="false"}else{this.$tbEvent.val("")}this.$cbEventEnabled.prop("checked",h);this.scriptUrl=this.designer.$xnform.find("handlers").attr("scriptUrl");this.$linkScript.text(this.scriptUrl?("Library: "+this.scriptUrl):"Define form's internal functions");this.$tbSchemaName.val(t);this.$tbSchemaType.val(a);this.$tbSchemaDbType.val(m.attr("dbtype"));this.$tbSchemaTitle.val(m.attr("title"));this.$tbSchemaDesc.val(m.attr("description"));this.$cbShowHelp.prop("checked",e.attr("showhelp")=="true");this.$tbDescription.val(e.attr("description"));this.allowSuggestions=(a=="Lookup"||(a=="Text"&&l==""));this.$panelSuggestions.toggle(this.allowSuggestions);if(this.allowSuggestions){this.$rowForText.toggle(a=="Text");var o=false;if(a=="Lookup"){o=(p=="autocomplete")}else{if(a=="Text"){o=(p.indexOf("lookup:")==0);$("#tbTextBoxLookup",this.$p).val(o?(p.substr(7)):"")}}this.$cbSuggestions.prop("checked",o)}this.$panelOnClick.toggle(a=="Lookup");if(a=="Lookup"){$("#cbOnClick",this.$panelOnClick).prop("checked",xml_getAttribute(this.xn_prop,"handlermode")=="editable")}this._window.setHeader(t+" ("+a+") - Field Properties");this._window.show();this.tabBar.select(c);if(c==0){this.$tbTitle.focus()}},SaveState:function(){var h=this.$xn;var t=this.$tbTitle.val().trim();var g=h.attr("title");var d=this.$xn_s.attr("type");var m=h.attr("colspan")||"1";var c=this.panelLayout.getValue();var j=h.attr("rowspan")||"1";var r=this.$tbRowCount.val()||"1";if(isNaN(r)){AX.Window.alert("Please, enter correct rows count.");return false}if(parseInt(r)>20){AX.Window.alert("Rows count must be less 20.");return false}h.attr("title",t.trim());xml_updateAttr(h,"restitle",this.resTitle.getResValue());xml_updateAttr(h,"titlealign",this.panelAlignment.getValue());xml_updateAttr(h,"titlepos",this.panelTitlePos.getValue());var s=(this.xn_prop)?$(this.xn_prop):xml_createNode(this.designer.xmlDoc,"properties");if(!this.isSystemRequired){xml_updateAttr(s,"requiredlevel",this.panelRequiredLevel.getValue())}if(!this.isSystemReadonly){xml_updateAttr(s,"readonly",this.panelReadonly.getValue())}if(this.allowWatermark){xml_updateAttr(s,"watermark",this.$tbWatermark.val().trim())}xml_updateAttr(s,"oncreatevalue",this.tbOnCreateValue.getValue());xml_updateAttr(s,"onupdatevalue",this.tbOnUpdateValue.getValue());var e=this.$tbEvent.val();if(e!=""){var i=(this.xn_event)?$(this.xn_event):xml_appendNode(this.designer.xmlDoc,h,"event");xml_updateAttr(i,"enabled",this.$cbEventEnabled.prop("checked")?"":"false");i.text(e)}else{if(this.xn_event){$(this.xn_event).remove()}}xml_updateAttr(h,"showhelp",this.$cbShowHelp.prop("checked")?"true":"");xml_updateAttr(h,"description",this.$tbDescription.val());var p="";if(this.allowSuggestions){var o=this.$cbSuggestions.prop("checked");if(d=="Lookup"&&o){p="autocomplete"}else{if(d=="Text"&&o){var a=$("#tbTextBoxLookup",this.$p).val().trim();if(a&&a.indexOf("/")>0){p="lookup:"+a}}}xml_updateAttr(s,"behavior",p)}if(d=="Text"){if(p==""){p=this.$panelText.find("#ddlValidationType").val();if(p=="custom"){var f=this.$panelText.find("#tbTextExp").val().trim();p=(f!="")?("regex:"+f):""}xml_updateAttr(s,"behavior",p)}else{AX.Window.alert("Validation pattern will be ignored for field with auto-suggestions rules.")}}if(this.isNumber){var l=this.$panelNumbers.find("#tbNumMin").val().trim();var n=this.$panelNumbers.find("#tbNumMax").val().trim();p=(l!=""||n!="")?(l+"|"+n):"";xml_updateAttr(s,"behavior",p)}if(d=="Lookup"){var q=$("#cbOnClick",this.$panelOnClick).prop("checked");xml_updateAttr(s,"handlermode",q?"editable":"")}var k=s[0].attributes.length>0;if(k){if(this.xn_prop==null){h.append(s)}}else{if(this.xn_prop!=null){s.remove()}}this._window.returnValue={title:t,colspan:parseInt(c),rowspan:parseInt(r),layoutChanged:(c!=m||r!=j),titleChanged:(t!=g)};return true},showMetadata:function(){var b=this.$xn_s[0];var a={xmlDoc:this.designer.xdSettings,tableName:this.designer.tableName};RMC_OpenOrCreate("RMC.FieldPropertiesDialog","Field Properties",480,420,RMC.Path+"TableBuilder/Dialogs/properties.ascx",[RMC.Path+"Dialogs/dialogs_utils.js",RMC.Path+"TableBuilder/Dialogs/properties.js"],function(c){c.component=new RMC.FieldPropertiesDialog(c)},function(c){c.component.LoadState(b,a,null,true)},null)},btn_click:function(a){switch(_fm_getCommand(a)){case"metadata":this.showMetadata();break;case"script-editor":openStdWin(RMC.Path+"FormBuilder/Dialogs/ScriptEditor.aspx?t="+this.designer.tableName+"&f="+this.designer.formName+((this.scriptUrl)?("&scriptUrl="+this.scriptUrl):""),"ScriptEditor",700,630);break;case"script-help":window.open(RMC.Path+"FormBuilder/Dialogs/help.html","ScriptEditor","width=700,height=600,top=200,left=150,status=0,resizable=1,scrollbars=1");break;case"OK":if(this.SaveState()){this._window.close()}break;case"OK":if(this.SaveState()){this._window.close()}break;case"X":this._window.close();break}}};