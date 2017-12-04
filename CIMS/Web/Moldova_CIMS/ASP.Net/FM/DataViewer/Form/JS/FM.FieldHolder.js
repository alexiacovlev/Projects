// FM.BaseField Client Script Library
// Alfa-XP, Michael Isipciuc, 2012.
//
FM.FieldHolder=function(o,frm){this.input=o;this.hostForm=frm;this.Name=o.getAttribute("field");this.Type=o.getAttribute("ctype");this.Title=o.getAttribute("title");this.IsRequired=o.getAttribute("req")=="1";this.Readonly=this._ro=o.getAttribute("ro")=="1";var b=o.getAttribute("bindings");this.bindings=(b)?eval(b):null;this.onchange_script=o.getAttribute("onchange_script");this._onchange=null;this.watermark=o.getAttribute("wm");this.value=this.initialValue=o.value;this.useControlWriter=false;this.needEncode=false};FM.FieldHolder.prototype={initialize:function(){this._ui=this.input.nextSibling;this.$ui=$(this._ui);var a=null;switch(this.Type){case"Text":a=new FM.TextBoxControl();break;case"DateTime":a=new FM.DateTimeControl();break;case"Lookup":a=new FM.LookupControl();break;case"Integer":case"Float":case"Money":a=new FM.NumberControl(this.Type);break;case"Picklist":a=new FM.PicklistControl();break;case"RadioGroup":a=new FM.RadioGroupControl();break;case"Boolean":a=new FM.BooleanControl();break;case"Image":a=new FM.ImageFileControl();break;case"EditableGrid":a=new FM.EditableGridControl();break;default:if(this.Type=="_Control"){a=new FM.HtmlControlHolder()}else{if(this.Type=="EditableGrid/RO"){a=new FM.ReadonlyEGridControl()}else{a=new FM.ReadonlyControl()}}break}a.base=this;a._ui=this._ui;a.$ui=this.$ui;this._control=a;this._control.init()},reg_disposable:function(){if(!this.hostForm._disposables){this.hostForm._disposables=[]}this.hostForm._disposables.push(this._control)},get:function(a){return this.input.getAttribute(a)},getValue:function(){if(this.useControlWriter){return this._control.getValue()}else{return this.value}},getText:function(){if(this._control.getText){return this._control.getText()}else{return this.getValue()}},WriteXmlData:function(b,a,c){if(this.useControlWriter){return this._control.WriteXmlData(b,a,c)}else{if(this.value===""&&this.IsRequired){if(b){this.NotifyRequired()}return null}if(c){this.initialValue=""}if(this.value===this.initialValue){return""}return"<"+this.Name+">"+(this.needEncode?xmlEncode(this.value):this.value)+"</"+this.Name+">"}},WriteFilterData:function(){if(this.useControlWriter){return this._control.WriteFilterData()}else{var a=this.value;if(a==""){return""}var b=this.Name+":"+this.Type;return"["+b+"]"+(this.needEncode?urlEncodeURI(a):a)+"[/"+b+"]"}},_getTabElement:function(){var b=this._ui;if(this.hostForm._egrid){b=this.hostForm._egrid.base._ui}var a=0;while(b&&a++<15){b=b.parentNode;if(b&&b.tagName=="DIV"&&b.className=="fm-tab"){return b}}return null},NotifyRequired:function(b){if(!b){b=fmres("Form__YouMustProvide","Please, enter value for")+" "+this.Title+"."}var a=this._getTabElement();if(a){this.hostForm.showTab($(a).index())}if(this.hostForm.usePopup){AX.Window.alert("",b,this.focus,this);return}this.showTooltip(b);this.focus()},focus:function(){if(this.Readonly){return}if(this.$tb){this.$tb.focus()}else{this._control.focus()}},controller_changed:function(){this.resolveBindings();this._control._loaded=false;this._control.setValue("");this.event_change_fire()},resolveBindings:function(){if(!this.bindings){return""}var e="";var a,g,f;var d=this._ro;for(var c=0;c<this.bindings.length;c++){a=this.bindings[c];g=this.hostForm.getField(a.From);f=(g)?g.getValue():"";if(f==""){d=true;continue}if(e!=""){e+=";"}e+=a.To+":"+f}this.set_readonly(d);return e},initInputBox:function(a,b){this.$tb=a;this.tb=b;a.focus($createDelegate(this.tb_onfocus,this));a.blur($createDelegate(this.tb_onblur,this));this.tb_watermark_apply()},tb_setValue:function(b,a){this.value=b;this.tb.value=a;if(this.watermark_on&&b!=""){this.tb_watermark_clear()}else{this.tb_watermark_apply()}},tb_onfocus:function(a){if(this.watermark_on){this.tb.value="";this.tb_watermark_clear()}this.prevValue=this.tb.value},tb_onblur:function(c){var b=this.tb.value.trim();if(this.prevValue!=b){var a=this._control.parseTextValue(b);if(a!=null){this.value=a;this.event_change_fire()}else{c.stopPropagation();c.preventDefault()}}this.tb_watermark_apply()},tb_watermark_clear:function(){this.watermark_on=false;this.$tb.css("background-color","").css("color","")},tb_watermark_apply:function(){if(this.watermark!=null&&this.value==""){this.watermark_on=true;this.tb.value=this.watermark;this.$tb.css("background-color","#E1E7F7").css("color","#666666")}},event_change_add:function(a){if(!this._onchange){this._onchange=[];if(this.useControlEvent){this._control.event_change_add($createDelegate(this.event_change_fire,this))}}this._onchange.push(a)},event_change_fire:function(){if(this._onchange){for(var i=0;i<this._onchange.length;i++){this._onchange[i](this)}}if(this.onchange_script){this.hostForm.eval(this.onchange_script,this.Name)}},set_readonly:function(a){if(this.Readonly!=a){this.Readonly=a;if(this.$tb){if(a){this.$tb.attr("disabled","disabled")}else{this.$tb.removeAttr("disabled")}}else{this._control.set_readonly(a)}}},showTooltip:function(a){if(!this._tooltip){this._tooltip=new FM.Tooltip(this.$ui.parent(),5,-25)}this._tooltip.Show(a,true)},getInfo:function(){return this.Name}};FM.ReadonlyControl=function(){};FM.ReadonlyControl.prototype={init:function(){this.base.useControlWriter=true;var a=this.base.input;this.islookup=a.getAttribute("ctype")=="Lookup/RO";if(this.islookup){this.$ui.addHandler("click",this._onclick,this)}},_onclick:function(b){var c=b.target;if(c.tagName=="A"&&c.parentNode.className.indexOf("fm-off")==-1){var a=this.base.get("pn")+this.base.Name;window.fmOpenHandler("FORM/LOOKUP_RO",this.base.hostForm.ticket,a+"|"+c.getAttribute("otype"),"id="+c.getAttribute("oid"),null)}},getValue:function(){var a=this.base.value;var b=this.base._ui.firstChild;if(this.islookup){b=b.firstChild;a=(b!=null)?b.getAttribute("oid"):""}else{if(a==""&&b){a=b.getAttribute("value");if(a==null){a=$(b).text()}}}return a},getText:function(){return this.$ui.text()},setValue:function(a){},set_readonly:function(a){},focus:function(){},WriteXmlData:function(){return""},WriteFilterData:function(){return""},event_change_add:function(){}};FM.TextBoxControl=function(){};FM.TextBoxControl.prototype={init:function(){this.base.needEncode=true;this.base.value=this.base.initialValue=this._ui.value;this.base.initInputBox(this.$ui,this._ui);this.exp=this._ui.getAttribute("exp");if(this.base.get("ac")=="1"){this.$ui.one("focus",$createDelegate(this.ac_attach,this))}},parseTextValue:function(a){if(this.exp!=null){try{if(!(new RegExp(this.exp)).test(a)){throw"error"}}catch(b){this.base.NotifyRequired(this._ui.getAttribute("message"))}}return a},setValue:function(a){this.base.tb_setValue(a.toString(),a)},ac_attach:function(){if(this.ac){return}var a=$createDelegate(function(b){this.ac=new b("text-field",this)},this);window.Runtime_Library.loadObjectType("FM.AutoComplete",null,["/ASP.Net/FM/DataViewer/Form/JS/FM.AutoComplete.js"],a)},};FM.BooleanControl=function(){};FM.BooleanControl.prototype={init:function(){var b=this._ui.firstChild;var c=b.firstChild;this.isRadio=(c.type=="radio");var d=$createDelegate(this.onclick,this);this.$box0=$(c);this.$box0.click(d);if(this.isRadio){var a=b.nextSibling;this.$box1=$(a.firstChild);this.$box1.click(d)}},onclick:function(b){var a=this.isRadio?b.target.value:b.target.checked.toString();if(!this.isRadio){this.setCheckText(a)}if(this.base.value!=a){this.base.value=a;this.base.event_change_fire()}},setCheckText:function(a){if(a=="true"){l=this.$box0.attr("lbl1")}else{l=this.$box0.attr("lbl0")}$(this.$box0[0].nextSibling).text(l)},setValue:function(a){if(this.isRadio){this.base.value=a;if(a==this.$box1.val()){this.$box1.attr("checked","checked")}else{if(a==this.$box0.val()){this.$box0.attr("checked","checked")}else{this.$box0.removeAttr("checked");this.$box1.removeAttr("checked")}}}else{if(!a){a="false"}this.base.value=a;this.$box0.prop("checked",a=="true");this.setCheckText(a)}},set_readonly:function(a){if(a){this.$box0.attr("disabled","disabled")}else{this.$box0.removeAttr("disabled")}if(this.isRadio){if(a){this.$box1.attr("disabled","disabled")}else{this.$box1.removeAttr("disabled")}}},focus:function(){this.$box0.focus()},event_change_add:function(){}};FM.HtmlControlHolder=function(){};FM.HtmlControlHolder.prototype={dispose:function(){if(this.ctrl!=null&&typeof(this.ctrl.dispose)=="function"){this.ctrl.dispose();this.ctrl=null}},init:function(){this.base.reg_disposable();var b="";var a=this.base.get("typeName");if(a=="FM.CustomControl"){$(this._ui.firstChild).addHandler("click",this.custom_click,this)}else{if(a!=""){window.Runtime_Library.loadObjectType(a,this.base.get("library"),this.base.get("resources").split(","),$createDelegate(this.oncreated,this))}}},oncreated:function(a){var b=this.base.get("ticket");this.ctrl=new a(this.$ui,"",b,null,this.base.hostForm);this.ctrl.hostForm=this.base.hostForm},custom_click:function(){var $o=$(this._ui.firstChild);var value=$o.attr("Value");var cmd=$o.attr("Command");if(cmd=="URL"){var w=800;var h=500;var wndParam=$o.attr("WindowParameters");if(wndParam){w=parseInt(wndParam.split(",")[0]);h=parseInt(wndParam.split(",")[1])}var url=value+"?"+$o.attr("Attributes").replace(/,/g,"&");AX.Window.createFrameWindow(url,$o.attr("WindowTitle"),w,h)}else{if(cmd=="SCRIPT"){var frm=this.base.hostForm.getScriptForm();var $element=$o;try{eval(value)}catch(e){alert(e.description)}}else{if(cmd=="HND"){var oninvoke=$o.attr("OnInvoke");var close_hnd=$createDelegate(function(res){if(this._window&&res){this._window.returnValue=res;this._window.close()}},this.base.hostForm);var callback=null;if(oninvoke=="CloseParentAfterSave"){callback=close_hnd}else{if(oninvoke=="RefreshParentAfterClose"){callback=$createDelegate(function(res){this.Refresh()},this.base.hostForm)}else{if(oninvoke=="SaveParentAfterClose"){callback=$createDelegate(function(res){this.btn_click(null,"save")()},this.base.hostForm)}}}window.fmOpenHandler("CUSTOM/FORMBUTTON",this.base.hostForm.ticket,$o.attr("cid"),$o.attr("Attributes").replace(/,/g,"&"),$o.attr("WindowParameters"),callback);if(oninvoke=="CloseParent"){close_hnd()}}}}},focus:function(){this.$ui.focus()}};FM.ImageFileControl=function(){};FM.ImageFileControl.prototype={init:function(){this.$info=$(this._ui.nextSibling);$("a:first",this.$info).addHandler("click",this.openDialog,this);this.mode=this.base.get("mode");if(this.mode=="2"){this.$ui.addHandler("click",this.showImage,this)}},openDialog:function(){var c=this.base.get("ext");var b=this.base.get("url");if(this.mode=="2"&&!c){c="jpg,jpeg,gif,png"}this.extensions=c?c.split(","):null;var d=new AX.Window(true);d.setHeader("");d.extensions=this.extensions;var a=!($.browser.msie);d.setSize(550,a?300:200);d.onUpload=$createDelegate(this.onupload,this);d.show();d.loadURL(b?b:"/ASP.Net/System/Upload/default.aspx")},onupload:function(d,a,b){a=a.replace(/&/g,"&amp;");var c=a.substr(a.lastIndexOf(".")+1).toLowerCase();if(this.extensions&&$.inArray(c,this.extensions)==-1){AX.Window.alert("You cannot upload this file.");return}this.base.value=d+","+a;$("label:first",this.$info).text(a+". "+fmres("Form__File","The file is received")+". ");if(this.mode=="2"){this._ui.firstChild.setAttribute("src","/Temp/_Upload/"+d)}},showImage:function(){var b=this._ui.firstChild.getAttribute("src");if(b.indexOf("noimage")>0){this.openDialog();return}var a=$("<img src='"+b+"' style='min-width:400px;min-height:400px;'/>");a.ready(function(){var c=new AX.WindowPanel("",a,true);a.parent().css("margin","8px");c.show();c.$wnd.click(function(){c.close()})})},focus:function(){this.$ui.focus()}};FM.ValidateEmail=function(b){var a=/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;return a.test(b)};