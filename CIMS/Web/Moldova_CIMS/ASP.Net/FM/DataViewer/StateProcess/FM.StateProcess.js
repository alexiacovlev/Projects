// Process Workflow Client Script Library
// Alfa-XP, Michael Isipciuc, 2014.
//
FM.StateProcess=function(d,a,c,b){this._window=b;this.$p=d;b.setBackground("#e0ecf7");this.inputParameters=a;var e=this.$p[0].firstChild;this.ticket=c;this.instanceId="";this.processName=e.getAttribute("process");this.tableName=e.getAttribute("t");this.outputData="";this.mainOutputData="";this.currentState="";this.form=null;this.control=null;this.transitions=null;this.transitionState=null;this.allowBack=false;this._service_RunCompleted=$.proxy(this.service_RunCompleted,this);this._window.returnValue=true;this.Run("")};FM.StateProcess.prototype={dispose:function(){if(this.workflow){this.workflow.dispose();this.workflow=null}else{if(this.form){this.form.dispose();this.form=null}else{if(this.control){if(this.control.dispose){this.control.dispose()}this.control=null}}}},Run:function(b,a){FM.ProgressBar.Show("",true);this.service_RunAsync(b,a)},service_RunAsync:function(c,a){var b='{"ticket":"'+this.ticket+'","instanceId":"'+this.instanceId+'","processName":"'+this.processName+'","tableName":"'+this.tableName+'","input":"'+jsonEncode(this.inputParameters)+'","outputData":"'+(this.outputData?jsonEncode(this.outputData):"")+'","mainOutputData":"'+this.mainOutputData+'","currentState":"'+this.currentState+'","newState":"'+c+'","transition":"'+(a||"")+'"}';fmExecuteDataService("StateProcess_Run",b,this._service_RunCompleted)},service_RunCompleted:function(a){if(this.allowBack&&this.workflow){this.workflow.process_sendComplete()}this.dispose();var b=this.res=a.d;var e=this;this.processName=b.ProcessName;this.instanceId=b.Key;this.transitions=b.Transitions;var d=b._ticket;var c=b.ui_type;if(b.Title){this._window.setHeader(b.Title)}this.currentState=b.StateName;this.processContext=(b.StateName!=null);this.allowBack=b.btn_back?true:false;if(c=="WORKFLOW"){if(typeof(FM.Workflow)=="function"){this.initWorkflow()}else{window.Runtime_Library.loadObjectType("FM.Workflow","WORKFLOW",null,$.proxy(this.initWorkflow,this))}}else{if(c=="FORM"){if(typeof(FM.DataForm)=="function"){this.initForm()}else{window.Runtime_Library.loadObjectType("FM.DataForm","FORM",null,$.proxy(this.initForm,this))}}else{if(c=="CLOSE"){FM.ProgressBar.Hide();this.Close()}else{FM.ProgressBar.Hide();this.renderTransitions(b.Html)}}}},prepareContainer:function(){this.$p.empty();if(this.processContext){var a=$("<div class='fm-pr-hdr'><label style='font-weight:bold;margin:3px 0 0 5px;display:block'>"+this.res.hdr_title+"</label><label style='font-style:italic;margin:5px 0 0 20px;display:block'>"+this.res.hdr_desc+"</label></div>");this.$p.append(a);var b=$("<div class='fm-pr-container'></div>");this.$p.append(b)}else{var b=$("<div></div>");this.$p.append(b)}return b},initWorkflow:function(){var b=this.prepareContainer();var a=this.allowBack;if(this.transitionState){a=false}this.workflow=new FM.Workflow(b,this.res.input,this.res.ui_ticket,this._window,null,null,a);if(this.processContext){this.workflow.OnComplete=$createDelegate(this.onWorkflowCompleted,this)}},onWorkflowCompleted:function(a){this.outputData=a;if(this.transitionState){this.dispose();this.Run(this.transitionState)}else{if(this.allowBack){this.renderWorkflowTransitions()}else{this.dispose();this.resolveTransitions(true)}}},initForm:function(){FM.ProgressBar.Hide();var a=this.prepareContainer();this.form=new FM.FormContainer(a,this.res.input,this.res.ui_ticket,this._window);if(this.processContext){this.form.Close=$createDelegate(this.onFormCompleted,this)}},onFormCompleted:function(b){var a=false;if(this.inputParameters==""||b){if(b||this.form.inputParameters==""||this.form.inputParameters=="id="){this.dispose();this.Close();return}a=true}this.inputParameters=this.form.inputParameters;this.dispose();this.resolveTransitions(a)},resolveTransitions:function(a){var c=this.transitions;if(!c||c.length==0){this.Close();return}if(c.length==1&&a){this.Run(c[0].Name)}else{var b="<div style='font-size:12px;text-align:center;font-weight:bold'>"+this.res.trans_hdr+"</div><div style='font-size:12px;text-align:center;margin-top:15px'>"+this.res.trans_desc+"</div>";this.renderTransitions(b)}},renderTransitions:function(e){this._window.setHeader("");var d=$("<div style='height:100%'><table height='80%' align='center'><tr><td>"+e+"</td></tr></table></div>");this.$p.empty().append(d);var a=$("<div style='position:absolute;bottom:10px;right:10px;'><a class='fm-btn' cmd='X' style='width:70px'>"+this.res.btn_close+"</a></div>");this.$p.append(a);a.addHandler("click",this.btn_click,this);var c=this.transitions;if(!c){return}this.$messagePanel=d;var g=d.find("TD:first");var f="<div style='text-align:center;margin-top:10px'>";for(var b=0;b<c.length;b++){f+="<a class='fm-btn' style='min-width:250px;width:60%;height:auto;white-space:normal;margin-top:10px;' index='"+b+"'>"+c[b].Title+"</a><br/>"}f+="</div>";this.$toolbar=$(f);$("a",this.$toolbar).addHandler("click",this.toolbar_click,this);g.append(this.$toolbar)},renderWorkflowTransitions:function(){this._window.setHeader("");var e=this.transitions;if(!e){return}var d="<div style='font-size:12px;text-align:center;font-weight:bold'>"+this.res.trans_hdr+"</div><div style='font-size:12px;text-align:center;margin-top:15px'>"+this.res.trans_desc+"</div>";var c=$("<div style='height:100%'><table height='70%' align='center'><tr><td>"+d+"</td></tr></table></div>");var a=$("<a class='fm-btn' style='width:70px;margin-right:10px;' cmd='process-back'>"+this.res.btn_back+"</a><a class='fm-btn' style='width:70px;' cmd='X'>"+this.res.btn_close+"</a>");this.workflow.process_panel(c,a);this.$messagePanel=c;var g=c.find("TD:first");var f="<div style='text-align:center;margin-top:10px'>";for(var b=0;b<e.length;b++){f+="<a class='fm-btn' style='min-width:250px;width:60%;height:auto;white-space:normal;margin-top:10px;' index='"+b+"'>"+e[b].Title+"</a><br/>"}f+="</div>";this.$toolbar=$(f);$("a",this.$toolbar).addHandler("click",this.toolbar_click,this);g.append(this.$toolbar)},toolbar_click:function(b){var a=b.target.getAttribute("index");if(!a){return}var c=this.transitions[parseInt(a)];this.transitionState=c.Name;this._window.returnValue=true;if(c.Action!=null){this.Run(this.transitionState,a)}else{this.$messagePanel.hide(200);this.Run(this.transitionState,"")}},showMessage:function(b){var a="<table style='margin-top:10%;width:300px' align='center'>";a+="<tr><td>"+b+"</td></tr>";a+="</table>";this.$p.html(a)},Redraw:function(){this.Run("")},initCustom:function(c,e){if(c=="PROFILE"){this.$p.empty().append(e)}else{this.initButtons()}this.control_container=e;var b=e.getAttribute("typeName");if(!b){return}var a=e.getAttribute("libraryName");var d=e.getAttribute("resources").split(",");this.control_ticket=e.getAttribute("ticket");this.control_data=e.getAttribute("input");window.Runtime_Library.loadObjectType(b,a,d,$createDelegate(this.onReadyCustom,this))},onReadyCustom:function(a){this.control=new a($(this.control_container),this.control_data,this.control_ticket,this._window)},buildButton:function(e,d,a,c,b){return'<a cmd="'+d+'" class="fm-btn" style="margin-left:8px;min-width:'+a+"px;"+(b?"font-weight:bold;":"")+'"><img src="'+window.FM.CommonImagePath+c+'" />'+e+"</a>"},btn_click:function(a){switch(_fm_getCommand(a)){case"X":this.Close();break}},btn_toggle:function(a){$("A",this.$buttons).each(function(){this.disabled=!a?"disabled":""})},Close:function(){if(this._window){if(!this._window.returnValue){this._window.returnValue=""}this._window.close()}}};FM.StateProcessList=function(d,a,c,b){$("A",d).click(function(){var f=this.getAttribute("process");var e=this.getAttribute("t");d.empty();d.append('<div process="'+f+'" t="'+e+'"></div>');new FM.StateProcess(d,"","",b)})};