FM.LookupControl=function(){};FM.LookupControl.prototype={init:function(){this.base.useControlWriter=true;this._div=this._ui.firstChild;this.$lbox=$(this._div);this.$ui.click($.proxy(this.box_click,this));this.$btn=$(this._div.nextSibling);this.$btn.click($.proxy(this.btn_click,this));this.dtype=this.base.get("dtype");this.isac=(this.base.get("ac")=="1");if(this.isac){this.$ui.css("background-color","#fffff0");this.$ui.one("focus",$.proxy(this.ac_attach,this))}this._onchange=null},focus:function(){this.$ui.focus()},getValue:function(){var a=this.getLookupItems();return(a.length>0)?a[0].Value:""},setValue:function(b){var a=FM.LookupItem.Deserialize(b);this.setLookupItems((a!=null)?[a]:null)},setLookupItems:function(a){var c="";if(a!=null){for(var b=0;b<a.length;b++){c+=a[b].buildHtml()}}this.$lbox.html(c);this.valueIsChanged=true},getLookupItems:function(){var e=new Array();var d=this._div.getElementsByTagName("A");if(d.length==0){return e}var f,c,a;for(var b=0;b<d.length;b++){f=d[b];c=f.getAttribute("oid");a=f.getAttribute("otype");if(c){e.push(new FM.LookupItem(c,a,f.innerHTML))}}return e},WriteXmlData:function(f,a,g){var c=this.getLookupItems();var e=c.length;if(e==0&&this.base.IsRequired){if(f){this.base.NotifyRequired()}return null}if(g&&e!=0){this.valueIsChanged=true}if(!this.valueIsChanged){return""}var b="";if(e==1){b=c[0].getValue()}else{if(e>1){for(var d=0;d<e;d++){if(d>0){b+=","}b+=c[d].getValue()}}}return"<"+this.base.Name+"><items>"+b+"</items></"+this.base.Name+">"},WriteFilterData:function(){var b=this.getLookupItems();if(b.length==0){return""}var d="";for(var c=0;c<b.length;c++){if(c>0){d+=","}d+=b[c].getValue()}var a=this.base.Name+":"+this.base.Type;return"["+a+"]"+d+"[/"+a+"]"},dialog_OnSelected:function(a){this.setLookupItems(a);this.base.event_change_fire();this.focus()},box_click:function(b){var c=b.target;if(!this.base.Readonly&&c.tagName=="DIV"){if(!this.isac){this.btn_click(b)}}else{if(c.tagName=="A"&&c.parentNode.className.indexOf("fm-off")==-1){var a=this.base.get("pn")+this.base.Name;window.fmOpenHandler("FORM/LOOKUP",this.base.hostForm.ticket,a+"|"+c.getAttribute("otype"),"id="+c.getAttribute("oid"),null)}}},btn_click:function(g){if(this.base.Readonly||this._ui.disabled){return}var b=this.base.resolveBindings();var a=this.getLookupItems();var d=this.base.get("pn")+this.base.Name;var c=$createDelegate(this.dialog_OnSelected,this);var f=$createDelegate(function(e){new e(this.base.hostForm.ticket,d,this.dtype,a,b,c)},this);window.Runtime_Library.loadObjectType("FM.LookupDialog",null,["/ASP.Net/FM/DataViewer/Form/Lookup/FM.LookupDialog.js"],f)},set_readonly:function(a){var b="/ASP.Net/FM/Common/Images/";this._ui.disabled=a;if(a){this._ui.className="fm-l fm-dis";this.$btn[0].className="fm-b-dis fm-btn-l"}else{this._ui.className="fm-l";this.$btn[0].className="fm-b fm-btn-l"}},ac_attach:function(){if(this.ac){return}var a=$createDelegate(function(b){this.ac=new b("lookup-field",this)},this);window.Runtime_Library.loadObjectType("FM.AutoComplete",null,["/ASP.Net/FM/DataViewer/Form/JS/FM.AutoComplete.js"],a)},getText:function(){var c=this._div.getElementsByTagName("A");var b="";for(var a=0;a<c.length;a++){if(a>0){b+=", "}b+=$(c[a]).text()}return b}};FM.LookupItem=function(e,c,b,d,a){this.Value=e;this.Type=c;this.innerHtml=b;this.Text=d||b;this.IconUrl=a;this.buildHtml=function(){var f=this.innerHtml;if(!f){f=(this.IconUrl?("<img class='fm-l-img' src='"+this.IconUrl+"'/>"):"")+this.Text}return"<a class='fm-l-a' oid='"+this.Value+"' otype='"+this.Type+"'>"+f+"</a>"};this.serialize=function(){if(this.Value==null||this.Value==""){return""}return(this.Value+"|"+this.Type+"|"+this.Text)};this.getValue=function(){if(this.Value==null||this.Value==""){return""}if(this.Type==""){return this.Value}else{return this.Value+"|"+this.Type}}};FM.LookupItem.Deserialize=function(c){if(c==null||c==""){return null}if(c.indexOf("|")==-1){return new FM.LookupItem(c,"",c)}var b=c.split("|");c=b[0];var a=b[1];var d=c;if(b.length==3){d=b[2]}return new FM.LookupItem(c,a,d)};