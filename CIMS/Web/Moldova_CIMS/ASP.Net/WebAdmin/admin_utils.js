$registerNamespace("Portal");AX.AdminPath="/ASP.Net/WebAdmin/";Portal.ServiceRequest=function(b,c,d,a){if(!a){a=function(e){AX.Window.alert("Service Message",e)}}ExecuteService(JSON.stringify(c),b,d,a)};Portal.Validators={notify:function(a,d,c){if(!c){c="Please, enter value for "+d}var b=a[0]._tooltip;if(!b){b=new FM.Tooltip(a.parent(),5,-25);a[0]._tooltip=b}b.Show(c,true);a.focus()}};Portal.ModalDialog=function(g,f,a,e,c){var b=3000;if(c!=false){this.$bg=$("<div class='ax-dlg-modal-bg' style='z-index:"+b+"'></div>");document.body.appendChild(this.$bg[0])}this.$wnd=$("<div class='ax-dlg-modal' style='z-index:"+(b+1)+"'><div class='ax-dlg-modal-hdr'/><div class='ax-dlg-modal-desc'/><div class='ax-dlg-modal-body' style='width:"+a+"px;height:"+e+"px'/><div class='ax-dlg-modal-sep'/><div/></div>");var d=this.$wnd.children();$(d[0]).text(g);$(d[1]).text(f);this.$content=$(d[2]);this.$btn=$(d[4]);document.body.appendChild(this.$wnd[0]);this.loadASCX=function(i,h){this.$content.load(App.SystemPath+"Component.aspx?path="+i,h)};this.close=function(){this.$wnd.remove();if(this.$bg){this.$bg.remove()}};this.show=function(){var i=$(window);var h=Math.floor((i.width()-this.$wnd.width())/2);var j=Math.floor((i.height()-this.$wnd.height()-100)/2);if(this.$bg){this.$bg.css("display","").animate({opacity:0.2},200)}this.$wnd.css({left:h+"px",top:j+"px"}).show();this.$wnd.focus()}};