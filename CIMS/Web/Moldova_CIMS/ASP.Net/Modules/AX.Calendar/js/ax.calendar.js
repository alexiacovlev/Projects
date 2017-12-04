// Implementation of 
// * FullCalendar v1.5.4
// * http://arshaw.com/fullcalendar/
AX.Calendar=function(c){var b=c.children()[0];var a=b.getAttribute("cat");this.cat=a;this.$calendar=$(b);this.$calendar.fullCalendar({ignoreTimezone:true,editable:true,selectable:true,unselectAuto:false,lazyFetching:false,events:"/ASP.Net/Modules/AX.Calendar/GetEvents.aspx?mode=0"+(a?("&cat="+a):""),select:$createDelegate(this.OpenDialog_AddEvent,this),eventDrop:$createDelegate(this.eventDrop,this),eventResize:$createDelegate(this.eventResize,this),eventClick:$createDelegate(this.OpenDialog_EditEvent,this),defaultView:"month",contentHeight:this.$calendar.height()-34,header:{left:"month,agendaWeek,agendaDay",center:"prev title next",right:"today"},firstDay:parseInt(b.getAttribute("firstDay")),monthNames:b.getAttribute("monthNames").split(","),monthNamesShort:b.getAttribute("monthNamesShort").split(","),dayNames:b.getAttribute("dayNames").split(","),dayNamesShort:b.getAttribute("dayNamesShort").split(",")});this._reloadViewDlg=$createDelegate(function(){this._execCommand("refetchEvents")},this)};AX.Calendar.prototype={dispose:function(){this.$calendar.fullCalendar("destroy");this.$calendar=null},_execCommand:function(a,b){this.$calendar.fullCalendar(a,b)},OpenDialog_AddEvent:function(d,i,o,k,l){var m=$createDelegate(function(p){this._execCommand("unselect")},this);var n={start:d,end:i,title:"",allDay:o};var c=this.getPeriodText(n);var a=$("<div style='width:420px;height:120px;'><table width='100%' cellpadding='4' cellspacing='4' style='table-layout:fixed;'><tr><td style='width:130px;'>Event Period: </td><td>"+c+"</td></tr><tr><td>Text: </td><td><input class='fm'/></td></tr></table></div>");var f=$("input",a);var b=$createDelegate(this.service_addEvent,this);var e=function(){var p=f.val().trim();if(p==""){return false}n.title=p;b(n);return true};var j=new AX.WindowPanel("Add New Event",a,true);var g=$('<a class="fm-btn" style="width:80px;font-weight:bold;">OK</a>').click(function(){if(e()){j.close();m(true)}});var h=$('<a class="fm-btn" style="width:80px;margin-left:8px;">Cancel</a>').click(function(){j.close();m(false)});j.init([g,h]);j.show();f.focus()},service_addEvent:function(a){var b='{"start":"'+this.dateToISO8601(a.start)+'","start":"'+this.dateToISO8601(a.start)+'","end":"'+this.dateToISO8601(a.end)+'","title":"'+this.textToJson(a.title)+'","allDay":'+a.allDay+',"cat":"'+this.cat+'"}';ExecuteService(b,"/ASP.Net/Modules/AX.Calendar/Service.asmx/Add",this._reloadViewDlg)},OpenDialog_EditEvent:function(g,d,c){this._activeEvent=g;var h=this.getPeriodText(g);var f=$("<div style='width:420px;height:120px;'><table width='100%' cellpadding='4' cellspacing='4' style='table-layout:fixed;'><tr><td style='width:130px;'>Event Period: </td><td>"+h+"</td></tr><tr><td>Title: </td><td><input class='fm'/></td></tr></table><a style='position:absolute;bottom:80px;right:20px;' cmd='edit' class='fm-a'>more details ...</a><a style='position:absolute;bottom:14px;left:16px;' cmd='delete' class='fm-a'>delete</a></div>");var a=$("input",f);$("a",f).click($createDelegate(this.link_onclick,this));var b=$createDelegate(this.service_updateEvent,this);var e=function(){var i=a.val().trim();if(i==""){return false}g.title=i;b(g);return true};this._activeDialog=AX.Window.dialog("Modify Event",f,e);this._activeDialog.$content=f;a.val(g.title).focus()},OpenDialog_EditEvent_More:function(c,b,a){this._activeDialog.close();this._activeDialog=null;window.fmOpenHandler("CUSTOM/CALENDAR","[none]","[none]","id="+this._activeEvent.id,"700,450",$createDelegate(function(d){if(d){this._execCommand("refetchEvents")}},this))},service_updateEvent:function(b){var d=this.dateToISO8601(b.start);var a=this.dateToISO8601(b.end);if(a==""){a=d}var c='{"id":"'+b.id+'","start":"'+d+'","end":"'+a+'","title":"'+this.textToJson(b.title)+'","allDay":'+b.allDay+"}";ExecuteService(c,"/ASP.Net/Modules/AX.Calendar/Service.asmx/Update",this._reloadViewDlg)},eventDrop:function(c,b,a,d){if(!d){if(c.start==c.end||!c.end||((c.end-c.start)/3600000)>23){c.end=$.fullCalendar.cloneDate(c.start,true);c.end.setHours(c.start.getHours()+2)}}else{c.start.setHours(0);c.start.setMinutes(0);if(!c.end){c.end=$.fullCalendar.cloneDate(c.start,true)}c.end.setHours(0);c.end.setMinutes(0)}this.service_updateEvent(c)},eventResize:function(d,b,a,c){if(b>0&&!d.allDay){d.allDay=true;d.start.setHours(0);d.start.setMinutes(0);d.end.setHours(0);d.end.setMinutes(0)}this.service_updateEvent(d)},link_onclick:function(b){if(!this._activeEvent){return}if(b.target.getAttribute("cmd")=="delete"){var a='{"id":"'+this._activeEvent.id+'"}';AX.Window.confirm("Delete Event","Are you sure you want to delete this event?",function(){this._activeDialog.close();ExecuteService(a,"/ASP.Net/Modules/AX.Calendar/Service.asmx/Delete",this._reloadViewDlg)},this)}else{this.OpenDialog_EditEvent_More()}},dateToISO8601:function(a){if(!a){return""}return $.fullCalendar.dateToISO8601(a)},dateToDisplay:function(a){return a?a.toDateString():"?"},timeToDisplay:function(a){return $.fullCalendar.formatDate(a,App.Settings.ShortTimePattern)},getPeriodText:function(b){var a="";if(!b.allDay){a=this.timeToDisplay(b.start);a+=" - "+this.timeToDisplay(b.end)}else{a=this.dateToDisplay(b.start);if(b.start!=b.end&&b.end){a+=" - "+this.dateToDisplay(b.end)}}return a},textToJson:function(a){return a?a.replace(/"/g,'\\"'):""}};