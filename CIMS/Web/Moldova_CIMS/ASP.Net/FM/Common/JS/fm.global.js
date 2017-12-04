// Global Client Script Library
// Alfa-XP, Michael	Isipciuc, 2012.
//
window.FM={};window.FM.Path="/ASP.Net/FM/";window.FM.CommonImagePath="/ASP.Net/FM/Common/Images/";fm_alert=function(b,a){alert(b+"\n\n"+a)};function _fmLoadScriptModule(b,d,g,c,a,f){var e=function(h){var i=h.d;if(i.Html){g.html(i.Html)}if(i.ErrorCode!=0){return}var k=i._ticket;var j=$.proxy(function(l){var m=new l(g,a,k,c);f(m)},this);window.Runtime_Library.loadObjectType(i.typeName,i.libraryName,i.resources,j)};$.ajax({type:"POST",url:FM.Path+"DataViewer/ScriptModuleService.asmx/"+b,contentType:"application/json; charset=utf-8",dataType:"json",data:d,success:e,error:_fm_onHandlerError})}function fmExecuteDataService(d,c,b,a){if(!a){a=_fm_onHandlerError}$.ajax({type:"POST",url:FM.Path+"DataViewer/DataService.asmx/"+d,contentType:"application/json; charset=utf-8",dataType:"json",data:c,success:b,error:a})}function fmExecuteService(c,d,b,a){$.ajax({type:"POST",url:FM.Path+c,contentType:"application/json; charset=utf-8",dataType:"json",data:d,success:b,error:a})}function jsonEncode(a){if(a==""){return a}return a.replace(/\\/g,"\\\\").replace(/"/g,'\\"')}function urlEncodeURI(a){var a=encodeURI(a);if(a.indexOf("#")!=-1){a=a.replace(/#/g,"%23")}return a}function jsonParam(b,a){return'"'+b+'":"'+a+'"'}function xmlEncode(a){if(a==""){return a}return a.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/\"/g,"&quot;")}fmLoadServerControlToPanel=function(g,b,f,e,a,d){var c=function(h){var i=h.d;if(i.Html){g.html(i.Html)}if(i.ErrorCode!=0){return}window.Runtime_Library.loadObjectType(i.typeName,i.libraryName,i.resources,d)};$.ajax({type:"POST",url:FM.Path+"DataViewer/ScriptModuleService.asmx/LoadServerControl",contentType:"application/json; charset=utf-8",dataType:"json",data:'{"type":"'+b+'","info":"'+f+'","ticket":"'+e+'","attributes":"'+a+'"}',success:c,error:_fm_onHandlerError})};function _fmLoadScriptModuleToPanel(g,b,d,f){var c=FM.Path+"DataViewer/ScriptModuleService.asmx/"+b;var e=function(i){var j=i.d;var h=null;if(!g){g=$("<div></div>")}g.html(j.Html);var h=$(g.children()[0]);Runtime_ResourceLoader.Register(h,j.Resources,j.ClientType,f)};var a=_fm_onHandlerError;$.ajax({type:"POST",url:c,contentType:"application/json; charset=utf-8",dataType:"json",data:d,success:e,error:a})}function _fmLoadScriptModuleToWindow(c,b,d,f){var e=$.proxy(function(i){var j=this;var k=i.d;j.loadHTML(k.Html);var h=$(j.$content.children()[0]);var g=$.proxy(function(l){this.component=l;l._window=this;f(l)},j);Runtime_ResourceLoader.Register(h,k.Resources,k.ClientType,g);if(k.Header!=""){j.setHeader(k.Header)}},c);var a=_fm_onHandlerError;$.ajax({type:"POST",url:b,contentType:"application/json; charset=utf-8",dataType:"json",data:d,success:e,error:a})}fmOpenHandler=function(a,h,c,e,g,i){this.attributes=e;this.onclose=i;var b=$.proxy(fmOpenHandler_OnComplete,this);var d=this.wnd=null;if(g!=null){d=this.wnd=new AX.Window(true);d.parseSize(g);d.show()}var f='{"source":"'+a+'","ticket":"'+h+'","cmd":"'+c+'","attributes":"'+e+'"}';fmExecuteService("DataViewer/ScriptModuleService.asmx/ResolveHandler",f,b,_fm_onHandlerError)};fmOpenHandler_OnComplete=function(a){var c=a.d;var b=this.attributes;var d=this.wnd;if(!d){d=new AX.Window(true);d.parseSize(c.wndSize);d.show()}d.setHeader("...",b);d.onclose=this.onclose;if(c.Html){d.loadHTML(c.Html)}if(!c.typeName){return}var f=c._ticket;var e=function(g){d.component=new g(d.$content,b,f,d)};window.Runtime_Library.loadObjectType(c.typeName,c.libraryName,c.resources,e)};function _fm_onHandlerError(xhr,status,thrownError){FM.ProgressBar.Hide();if(typeof(xhr)=="string"){alert(xhr);return}var s=xhr.responseText;if(s){if(s.indexOf("{")==0){var err=eval("("+s+")");alert(xhr.status+". "+thrownError+"\n\n"+err.Message)}else{alert(s)}}else{window.status="Loading Failed"}}function _fm_getCommand(a){var b=a.target;if(b.tagName!="A"){b=$(b).parent()[0]}if(b.tagName!="A"||b.disabled){return""}return $(b).attr("cmd")}FM.Tooltip=function(b,c,a){this.$pnl=$('<span class="fm-tooltip" style="position:absolute;z-index:2001;display:none"></span>');var d=b.position();this.x=d.left+c;this.y=d.top+a;b.append(this.$pnl);this.Show=function(f,e){if(FM.Tooltip._active){FM.Tooltip._active.Hide()}FM.Tooltip._active=this;this.$pnl.text(f);this.$pnl.show().css({display:"block",opacity:0,left:(this.x-8),top:(this.y+20)}).animate({left:this.x,top:this.y,opacity:1},"quick");if(e){this._timer=window.setInterval($createDelegate(function(){this.$pnl.hide("quick")},this),3000)}};this.Hide=function(){if(this._timer){window.clearInterval(this._timer)}this.$pnl.hide();FM.Tooltip._active=null}};FM.ProgressBar={Show:function(a,b){FM.ProgressBar.text=a;if(FM.ProgressBar._timer){window.clearTimeout(FM.ProgressBar._timer)}if(!b){FM.ProgressBar._timer=window.setTimeout(FM.ProgressBar._show,300)}else{FM.ProgressBar._show()}},Hide:function(){if(FM.ProgressBar._timer){window.clearTimeout(FM.ProgressBar._timer)}if(!FM.ProgressBar.visibled){return}FM.ProgressBar._timer=null;FM.ProgressBar.visibled=false;FM.ProgressBar.$p.css("display","none");FM.ProgressBar.$pb.css("display","none")},_show:function(){FM.ProgressBar.visibled=true;var d=FM.ProgressBar.$p;var c=FM.ProgressBar.$pb;var b=280;var f=55;if(!d){FM.ProgressBar.$pb=c=$("<div style='position:absolute;z-index:3001;width:100%;height:100%;opacity:0;background-color:#000'></div>");document.body.appendChild(c[0]);FM.ProgressBar.$p=d=$("<div class='fm-progress' style='position:absolute;z-index:3001;width:"+b+"px;height:"+f+"px;display:none;'><div style='margin-bottom:12px;'></div><img src='"+FM.CommonImagePath+"loading_200_10.gif'></div>");document.body.appendChild(d[0])}var i=$(window);var e=FM.ProgressBar.text;d[0].firstChild.innerHTML=((e)?(e+" ..."):"&nbsp;");var a=Math.floor((i.width()-b)/2);var g=Math.floor((i.height()-f)/2)-f;c.css("display","");d.css({left:a+"px",top:g+"px",display:""})}};FM.ListBox=function(b){this.$p=b;this.selected=null;var a=function(c){var d=c.target;if(d.tagName=="DIV"){return}if(d.tagName=="A"){if(this.selected&&this.selected!=d){$(this.selected).removeClass("fm-list-sel")}this.selected=d;$(this.selected).addClass("fm-list-sel")}};this.getValue=function(){return this.selected?this.selected.getAttribute("value"):""};this.setValue=function(d){if(this.selected){if(this.selected.getAttribute("value")==d){return}$(this.selected).removeClass("fm-list-sel");this.selected=null}var c=this.$p.children();for(var e=0;e<c.length;e++){if(c[e].getAttribute("value")==d){this.selected=c[e];$(this.selected).addClass("fm-list-sel");break}}};b.addHandler("click",a,this)};FM.resources=[];fmres=function(a,b){return FM.resources[a]||b};alertObject=function(c){var b="";if(c){for(var a in c){b+=(a+"="+c[a])+"\n"}}alert(""+c+" ("+typeof(c)+")\n\n"+b)};FM.qsToArray=function(e){var a=e.split("&");var c=[];for(var b=0;b<a.length;b++){var f=a[b].split("=");c[f[0]]=f[1]}return c};FM.ShowAdminWindow=function(c,a,d,b,f){var e=FM.ConsoleWindow;if(!FM.ConsoleWindow){e=FM.ConsoleWindow=new AX.Window(false)}e.setSize(a,d);e.refresh_callback=f;e.loadURL(FM.Path+"Explorer/#"+c+"/"+b);e.show()};function Server_ReceiveData(a){return $.ajax({url:a,async:false,dataType:"text"}).responseText}function openStdWin(b,g,a,c){if(!a){a=700}if(!c){c=500}var f=100;left=100;try{left=(screen.width-a)/2;f=(screen.availHeight-c)/2-30}catch(d){}var i="width="+a+",height="+c+",top="+f+",left="+left+",status=0,resizable=1,scrollbars=0";window.open(b,g,i)}function openStdDlg(b,d,a,c){return window.showModalDialog(b,d,"dialogWidth:"+a+"px;dialogHeight:"+c+"px;help:0;status:0;scroll:0;center:1")};