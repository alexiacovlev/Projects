// Core Portal Schell Client Script Library
// Alfa-XP, Michael Isipciuc, 2016.
//
window.AX={};if(!$.browser){$.browser={}}$registerNamespace=function(a){if(typeof(window[a])=="undefined"){window[a]={}}};$createDelegate=function(b,a){return function(){return b.apply(a,arguments)}};$isNull=function(a){return(!a||a.length==0)};jQuery.fn.addHandlers=function(b,d){for(var a in b){var c=$.proxy(b[a],d);this.on(a,c)}};jQuery.fn.addHandler=function(a,b,c){return this.on(a,$.proxy(b,c))};jQuery.fn.addClick=function(a,b){return this.click($.proxy(a,b))};function ie_preventSelection(b){var a=b.target.tagName;if(a=="INPUT"||a=="TEXTAREA"||a=="LABEL"||b.target.className.indexOf("ro")!=-1){return true}else{return false}}jQuery.fn.preventSelection=function(){var a="none";if($.browser.msie){this.on("selectstart",ie_preventSelection)}else{this.css({MozUserSelect:a,WebkitUserSelect:a,userSelect:a})}};jQuery.fn.DragDropExtention=function(b){var d=$.extend({opacity:0.7,handler:null,onDrag:function(){},onMove:function(){},onDrop:function(){}},b);var c={drag:function(g){var f=g.data.dragData;f.target.css({left:f.left+g.pageX-f.offLeft,top:f.top+g.pageY-f.offTop});f.onMove(g)},drop:function(g){var f=g.data.dragData;f.target.css(f.oldCss);f.onDrop(g);$(window).off("mousemove",c.drag).off("mouseup",c.drop)}};var a=d.handler;if(!a){if(typeof d.handler=="undefined"||d.handler==null){a=$(this)}else{a=(typeof d.handler=="string"?$(d.handler,this):d.handle)}}a.on("mousedown",{e:this},function(f){var i=$(f.data.e);var h={};if(i.css("position")!="absolute"){try{i.position(h)}catch(e){}i.css("position","absolute")}h.opacity=i.getCssAsInt("opacity")||1;var g={left:h.left||i.getCssAsInt("left")||0,top:h.top||i.getCssAsInt("top")||0,width:i.width()||i.getCssAsInt("width"),height:i.height()||i.getCssAsInt("height"),offLeft:f.pageX,offTop:f.pageY,oldCss:h,onMove:d.onMove,onDrop:d.onDrop,handler:a,target:i};d.onDrag();i.css("opacity",d.opacity);$(window).on("mousemove",{dragData:g},c.drag).on("mouseup",{dragData:g},c.drop)});return this};jQuery.fn.getCssAsInt=function(b){var a=parseInt(this.css(b));if(isNaN(a)){return false}return a};jQuery.fn.loadASCX=function(c,b,a){this.load("/ASP.Net/System/Component.aspx?path="+c,function(){if(b){Runtime_ResourceLoader.LoadResources(b,a)}else{if(a){a()}}})};Array.removeItem=function(d,c){var a=-1;for(var b=0;b<d.length;b++){if(d[b]===c){a=b;break}}if(a!=-1){d.splice(a,1)}return(a!=-1)};Array.removeAt=function(b,a){b.splice(a,1)};if($.browser.msie&&$.browser.version<=8&&typeof(String.prototype.trim)!=="function"){String.prototype.trim=function(){return $.trim(this)}}function ExecuteService(params,url,callbackSuccess,callbackError){var onerror=function(xhr,status,thrownError){var er=xhr.responseText;if(er.indexOf("{")==0){er=(window.eval("("+er+")")).Message}if(callbackError){callbackError(er)}};$.ajax({type:"POST",url:url,contentType:"application/json; charset=utf-8",dataType:"json",data:params,success:callbackSuccess,error:onerror})}function resx_get(b,a){var c=(window.Resx)?window.Resx[b]:null;return c||a}PortalResourceLoader=function(){this._registeredResources=[];this._clientTypeName=null;this._callback=null;this._urls=null;this._$container=null;this.Init()};PortalResourceLoader.prototype={Init:function(){this._head=document.getElementsByTagName("head")[0]||document.documentElement;this.hndOnLoad=$.proxy(this.OnResLoaded,this)},LoadResources:function(a,b){this._clientTypeName=null;this._callback=b;this._urls=a;this.resIndex=-1;this.RegisterNextResource()},Register:function(c,b,a,d){this._$container=c;this._callback=d;this._clientTypeName=a;if(b!=null){this._urls=b;this.resIndex=-1;this.RegisterNextResource()}else{if(a){this.CreateClientObject()}}},RegisterNextResource:function(){this.resIndex++;if(this.resIndex>=this._urls.length){this.CreateClientObject();return}var b=this._urls[this.resIndex];if(this._registeredResources[b]){this.RegisterNextResource();return}var c=null;var a=window.Version;if(b.indexOf(".js")!=-1){c=document.createElement("script");c.setAttribute("type","text/javascript");c.setAttribute("src",b+"?"+a);this._file=c;if($.browser.msie){c.attachEvent("onreadystatechange",this.hndOnLoad)}else{c.readyState="loaded";c.addEventListener("load",this.hndOnLoad,false)}this._head.appendChild(c)}else{if(b.indexOf(".css")!=-1){c=document.createElement("link");c.setAttribute("rel","stylesheet");c.setAttribute("type","text/css");c.setAttribute("href",b+"?"+a);this._head.appendChild(c);this.RegisterNextResource()}else{this.RegisterNextResource();return}}this._registeredResources[b]=true},OnResLoaded:function(){var a=this._file.readyState;if(a=="loaded"||a=="complete"){this.RegisterNextResource()}},CreateClientObject:function(){this._urls=null;var o=null;if(this._clientTypeName){try{var classObject=eval(this._clientTypeName);o=new classObject(this._$container)}catch(e){alert(e.description)}}if(this._callback){this._callback(o)}},IsLoaded:function(a){return this._registeredResources[a]},LoadScript:function(a,c){if(this._registeredResources[a]){return}this._registeredResources[a]=true;var b=document.createElement("script");b.setAttribute("type","text/javascript");b.setAttribute("src",a+"?"+window.Version);if(c){if($.browser.msie){b.attachEvent("onreadystatechange",c)}else{b.readyState="loaded";b.addEventListener("load",c,false)}}this._head.appendChild(b)}};PortalClassLibrary=function(){this._loadedLibraries=[];this._knownLibraries=[];this._types=[];this._onLibLoad=$.proxy(this.onLibLoad,this);this._onResLoad=$.proxy(this.onResLoad,this);this._onError=$.proxy(this.onError,this)};PortalClassLibrary.prototype={getClassType:function(typeName){var t=this._types[typeName];if(!t){this._types[typeName]=t=eval(typeName)}return t},loadObjectType:function(c,b,f,e){var a=false;if(b){a=this._loadedLibraries[b]}else{if(f==null){a=true}}if(!a){this._ready_typeName=c;this._ready_libraryName=b;this._ready_oncreate=e;var d=this._knownLibraries[b];if(d){this.loadLibraryResources(b,d)}else{if(f!=null){this.loadLibraryResources(c,f)}else{}}}else{if(e){e(this.getClassType(c))}}},createObject:function(d,g,f,e,c,b,a,h){this.loadObjectType(d,null,g,function(i){var j=new i(e,c,b,a,h);if(f){f(j)}})},loadLibraryResources:function(b,a){this._loadedLibraries[b]=a;Runtime_ResourceLoader.LoadResources(a,this._onResLoad)},onLibLoad:function(a){alert("onLibLoad")},onResLoad:function(){var a=this.getClassType(this._ready_typeName);if(this._ready_oncreate){this._ready_oncreate(a)}},onError:function(xhr,status,thrownError){var s=xhr.responseText;if(s.indexOf("{")==0){var err=eval("("+s+")");alert(xhr.status+". "+thrownError+"\n\n"+err.Message)}else{alert(s)}},Add:function(b,a){this._knownLibraries[b]=a}};window.Runtime_Library=new PortalClassLibrary();window.Runtime_ResourceLoader=new PortalResourceLoader();