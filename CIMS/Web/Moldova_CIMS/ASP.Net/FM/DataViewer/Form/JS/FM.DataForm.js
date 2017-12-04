// DataForm Client Script Library
// Alfa-XP, M i c h a e l	I s i p c i u c, 2012.
//
FM.DataForm=function(d,c,b){this.ticket=c;this._window=b;this.root=d[0];this.$p=d;this._controls=new Array();this._controlList=new Array();this._disposables=null;var a=this.$p.children();if(a.length==1){this.Readonly=true;return}this.$form=$(a[0]);this._tabs=this.$form.children();this.$tabBar=$(a[1]);this._scriptStorage=a[2];this.keyValue=this.$form.attr("keyValue");this.Readonly=this.$form.attr("ro")=="1";this.initialize()};FM.DataForm.prototype={initialize:function(){this.initTabs();var inputs=this.root.getElementsByTagName("INPUT");var f;var observers=new Array();for(var i=0;i<inputs.length;i++){if(inputs[i].getAttribute("context")!="form"){continue}f=new FM.FieldHolder(inputs[i],this);this.registerControl(f.Name,f);if(f.bindings!=null){observers.push(f)}}if(!this.Readonly){FM.DataForm.RegisterObservers(this,observers);this.focus()}if(this.Readonly&&this._scriptStorage.getAttribute("enablereadonly")!="true"){return}var code=this._scriptStorage.getAttribute("code");if(code){try{window.eval(code)}catch(e){alert(e.description)}}var scriptUrl=this._scriptStorage.getAttribute("scriptUrl");var loadScript=this._scriptStorage.getAttribute("loadscript");if(scriptUrl&&!window.Runtime_ResourceLoader.IsLoaded(scriptUrl)){var callback=(loadScript)?$createDelegate(function(){this.eval(loadScript,"OnLoad Event")},this):null;window.Runtime_ResourceLoader.LoadScript(scriptUrl,callback)}else{if(loadScript){this.eval(loadScript,"OnLoad Event")}}},registerControl:function(a,b){this._controls[a]=b;this._controlList.push(b);b.initialize()},eval:function(script,s){frm=this.getScriptForm();try{eval(script)}catch(e){alert(s+"\n"+e.description)}},getField:function(a){return this._controls[a]},buildXmlData:function(b){var a=(this.keyValue=="");var d="",f,e;for(var c=0;c<this._controlList.length;c++){f=this._controlList[c];e=f.WriteXmlData(b,a,false);if(e==null){return null}if(e.length>0){d+=e}}return d},buildXml:function(needValidation){if(FM.Tooltip._active){FM.Tooltip._active.Hide()}if(needValidation==null){needValidation=true}var xml=this.buildXmlData(needValidation);var script=this._scriptStorage.getAttribute("savescript");if(script&&needValidation&&xml!=null){frm=this.getScriptForm();frm._changed=false;frm.IsValid=true;try{eval(script)}catch(e){alert("OnBeforeSave\n"+e.description);return null}if(!frm.IsValid){return null}if(frm._changed){frm._changed=false;xml=this.buildXmlData(needValidation)}}return xml},dispose:function(){if(this._disposables!=null){for(var a=0;a<this._disposables.length;a++){this._disposables[a].dispose()}this._disposables=null}if(this._tabBar!=null){this._tabBar.dispose();this._tabBar=null}},focus:function(){if(this._controlList.length>0){this._controlList[0].focus()}},focusElement:function(){this.root.focus()},Reset:function(){for(var a=0;a<this._controlList.length;a++){this._controlList[a]._control.setValue("")}},Refresh:function(){this.btn_click(null,"reload")},showInfo:function(a){alert("Name: "+a.Name+"\n\n\ninitialValue:"+a.initialValue+"\nValue:"+a.getValue()+"\nIsRequired:"+a.IsRequired)},initTabs:function(){this.tabIndex=0;this.$tabBar.addHandler("click",this.tabs_click,this)},tabs_click:function(a){a.preventDefault();var b=a.target;if(b.tagName=="SPAN"){this.showTab($(b).index())}},showTab:function(b){if(this.tabIndex==b){return}this.tabIndex=b;var a=this.$tabBar.children()[b];this.$tabBar.children().each(function(){this.className="fm-tab-lbl"});a.className="fm-tab-lbl fm-tab-on";this._tabs.each(function(){this.style.display="none"});this._tabs[b].style.display="block"},getScriptForm:function(){if(!this.scriptForm){this.scriptForm=new FM.FormScriptObject(this)}return this.scriptForm},addEditBtn:function(a,c){this._refresh_container_callback=$createDelegate(c.Redraw,c);var b=$("<b class='fm-b fm-ico-frm'/>").addHandler("click",this.openDesigner,this);this.$p.append(b)},openDesigner:function(){var d=this.$form;if(this.$p[0].tagName=="LABEL"){d=this.$p}var a=d.attr("t");var c=d.attr("f");var b=FM.FormBuilderDialog;if(!b){b=FM.FormBuilderDialog=new window.parent.AX.Window(false);b.setSize(1000,650)}b.refresh_callback=this._refresh_container_callback;b.loadURL(FM.Path+"Explorer/#FormBuilder/t="+a+"/f="+c);b.show()}};FM.DataForm.RegisterObservers=function(f,g){if(g.length==0){return}for(var e=0;e<g.length;e++){var c=g[e];var a=c.bindings;for(var d=0;d<a.length;d++){var b=f.getField(a[d].From);if(b){b.event_change_add($.proxy(c.controller_changed,c));if(b.initialValue==""){c.set_readonly(true)}}else{c.set_readonly(true)}}}};FM.FormScriptObject=function(a){this.host=a;this.Readonly=a.Readonly};FM.FormScriptObject.prototype={getKeyValue:function(){return this.host.keyValue},getValue:function(a){var b=this.host._controls[a];return(b)?b.getValue():""},getText:function(a){var b=this.host._controls[a];return(b)?b.getText():""},getNumber:function(a){var b=this.host._controls[a];return(b)?b._control.getNumber():0},getDate:function(a){var b=this.host._controls[a];return(b)?b._control.getDate():null},getLookupItems:function(a){var b=this.host._controls[a];return(b)?b._control.getLookupItems():[]},setValue:function(a,c){var b=this.host._controls[a];if(b){b._control.setValue(c||"")}this._changed=true},resetValue:function(a){this.setValue(a,"")},focusField:function(a){var b=this.host._controls[a];if(b){b.focus()}},notifyField:function(a,b){var c=this.host._controls[a];if(c){c.NotifyRequired(b)}},alert:function(b,a){AX.Window.alert(b,a)},setRequired:function(c,a){var d=this.host._controls[c];if(d){d.IsRequired=a}},setReadonly:function(c,a){var d=this.host._controls[c];if(d){d.set_readonly(a)}},toggleSection:function(c,a){this.getElement(c).toggle(a)},RaiseOnChange:function(a){var b=this.host._controls[a];if(b){b.event_change_fire()}},usePopupForRequired:function(){this.host.usePopup=true},clickButton:function(a){this.host.btn_click(null,a)},invoke:function(a,c){var b=this.host._controls[a];if(!b){return null}if(c=="RECALCULATE"){return b._control.Recalculate()}else{return null}},getLookupInfo:function(b,d){var f=this.host._controls[b];if(!f){return[]}b=f.get("pn")+b;var e;if(f.Type=="Lookup"){var a=f._control.getLookupItems();e=a.length>0?a[0].getValue():""}else{e=f.getValue()}var c=Server_ReceiveData(FM.Path+"DataViewer/Form/Lookup/Resolver.aspx?ticket="+this.host.ticket+"&name="+b+"&columns="+d+"&val="+e);if(c.indexOf("{")!=0){alert(c);return[]}return $.parseJSON(c)},loadInfo:function(c,a,d){var b=FM.Path+"DataViewer/Form/Lookup/InfoService.aspx?ticket="+this.host.ticket+"&name="+c+"&input="+encodeURI(a);if(d){$.getJSON(b,d)}else{return JSON.parse($.ajax({type:"GET",url:b,dataType:"json",async:false}).responseText)}},getControl:function(b){var a=this.host._controls["CONTROL_"+b];return a?a._control.ctrl:null},getElement:function(a){return $("#"+a+":first",this.host.$p)}};