RMC.WFEventsDialog=function(a){this._window=a;this.$p=a.$content;this.$panelList=$("#panelList",this.$p);$("#_bottomButtons",this.$p).addHandler("click",this.btn_click,this);$("A#btnAdd",this.$p).addHandler("click",this.btn_click,this)};RMC.WFEventsDialog.prototype={loadState:function(a){this.tableName=a;this._window.show();var b='{"tableName":"'+this.tableName+'"}';ExecuteService(b,RMC.Path+"TableBuilder/SupportService.asmx/LoadWFEventsXml",$.proxy(this.onLoadState,this))},onLoadState:function(a){var c=a.d;if(c.Error!=null){AX.Window.alert("Initialization",c.Error);return}this.xmlParser=xml_createParser();var b=c.Data;if(b==""){b="<workflows />"}this.xmlDoc=xml_loadXML(this.xmlParser,b);this.$xnworkflows=$(":first",this.xmlDoc);this.redraw()},redraw:function(){this.$panelList.empty();var e=this.$xnworkflows.children();if(e.length==0){this.$panelList.html("<div style='padding:20px;font-style:italic'>No events.</div>");return}for(var b=0;b<e.length;b++){var c="<div class='wf' index='"+b+"'>";var f=e[b];var a=f.getAttribute("name");var d=f.getAttribute("event");c+="<div><label>On <b>"+d+"</b></label>";c+="<label> run workflow <b>"+a+"</b></label></div>";c+="<div style='margin:10px;'><label>when "+this.getConditionText(f)+"</label></div>";c+="<div style='text-align:right'><a class='fm' cmd='workflow'>Edit Workflow</a>&nbsp;|&nbsp;<a class='fm' cmd='properties'>Event Properties</a>&nbsp;|&nbsp;<a class='fm' cmd='conditions'>Conditions</a>&nbsp;|&nbsp;<a class='fm' cmd='delete'>Delete</a></div>";c+="</div>";var g=$(c);this.$panelList.append(g);g.addHandler("click",this.onclick,this)}},onclick:function(f){if(f.target.tagName!="A"){return}var a=parseInt($(f.currentTarget).attr("index"));var d=this.$xnworkflows.children();var c=$(d[a]);switch(f.target.getAttribute("cmd")){case"properties":var g=$($("#panelAdd",this.$p).html());$("#eventName",g).val(c.attr("name"));if(c.attr("event")=="create"){$("#eventType0",g).prop("checked",true)}else{$("#eventType1",g).prop("checked",true)}var b=$createDelegate(this.onedit,this);AX.Window.dialog("Change event properties",g,function(){var e=$("#eventName",g).val();if(e==""){AX.Window.alert("Please Enter Name");return false}var h=$("#eventType0",g).prop("checked")?"create":"update";return b(c,e,h)},this);break;case"workflow":window.parent.AX.Window.createFrameWindow("/ASP.Net/FM/Explorer/WorkflowBuilder/?w="+this.tableName+"|"+c.attr("name"),"Workflow Builder",1100,700);break;case"conditions":break;case"delete":AX.Window.confirm("Delete Event","Are you sure you want to delete this event?",function(){c.remove();this.redraw()},this);break}},onedit:function(c,a,b){c.attr("name",a).attr("event",b);this.redraw();return true},getConditionText:function(g){var f=$(g).children();if(f.length==0){return""}var c="";for(var b=0;b<f.length;b++){var g=f[b];var d=g.getAttribute("attribute");var a=g.getAttribute("operator");var e=g.getAttribute("value");if(b>0){c+=", "}c+=d+" "+a+" "+e}return c},showAddPanel:function(){var c=$($("#panelAdd",this.$p).html());var b=$createDelegate(this.onadd,this);var a="wf"+(this.$xnworkflows.children().length+1);if(this.findByName(a)!=-1){a="wf"+xml_random(100)}$("#eventName",c).val(a);AX.Window.dialog("Add event",c,function(){var d=$("#eventName",c).val();if(d==""){AX.Window.alert("Please Enter Name");return false}var e=$("#eventType0",c).prop("checked")?"create":"update";return b(d,e)},this)},onadd:function(a,b){var c=xml_appendNode(this.xmlDoc,this.$xnworkflows,"workflow");c.attr("name",a).attr("event",b);this.$xnworkflows.append(c);this.redraw();return true},findByName:function(a){var c=this.$xnworkflows.children();for(var b=0;b<c.length;b++){if(c[b].getAttribute("name")==a){return b}}return -1},btn_click:function(a){switch(_fm_getCommand(a)){case"add":this.showAddPanel();break;case"X":this._window.close();break}}};