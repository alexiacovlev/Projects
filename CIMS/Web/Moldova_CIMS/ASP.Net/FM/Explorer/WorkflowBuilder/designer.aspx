<%@ Page Language="C#"%>
<%@ Register TagPrefix="ui" Namespace="AX.FM.Common.UI" Assembly="AX.FM.Common" %>

<div class="fm-dlg-header" style="background-color:#d8e6f7;height:67px;">
	<div class="wf-toolbar" style="margin-top:1px;" title="Drag and drop an activity to the schema canvas">
		<div n="Invoke/Form" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/form.png" /><span>FORM</span></div>
		<div n="Invoke/Control" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/control.png" /><span>Component</span></div>
		<div class="wf-toolsep" />
		<div n="Switch" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/switch1.png" /><span>If/Else</span></div>
		<!--div n="ForeachRecord" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/foreach.png" /><span>Foreach</span></!div-->
		<div class="wf-toolsep" />
		<div n="XmlIsland" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/data_select.png" /><span>Select</span></div>
		<div n="UpdateRecord" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/data_update.png" /><span>Modify</span></div>
		<div n="ExecStoredProcedure" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/sp.png" /><span>SP</span></div>
		<div class="wf-toolsep" />
		<div n="ExecuteRequest/MailService" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/email.png" /><span>Send Mail</span></div>
		<div n="ExecuteRequest/WebService" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/service1.png" /><span>Web Service</span></div>
		<div class="wf-toolsep" />
		<div n="SubWorkflow" class="wf-toolitem"><img src="/ASP.Net/FM/Images/Workflow/Activities/sub_wf.png" /><span>SubWorkflow</span></div>
	</div>
	<div id="pnlInfo" style="position:absolute;bottom:5px;right:5px;"></div>
	<a id="btnPrint" class="fm" cmd="PRINT" style="position:absolute;top:5px;right:8px;">Print</a>
</div>

<div style="position:absolute;top:67px;bottom:34px;left:0;right:0;background-color:#FFF;border:solid 1px #9eb6ce;overflow-x:scroll;overflow-y:auto;">
	<div id="canvas" style="position:absolute;top:15%;"></div>
</div>
<div style="position:absolute;top:0;bottom:34px;left:0;right:0;border:solid 1px #9eb6ce;overflow:hidden;background-color:#FFF;display:none">
	<textarea id="code" style="width:99.9%;height:99.5%;margin:0;border-top:solid 1px #9eb6ce;border:0;outline:0;overflow:scroll;font-family:Verdana;font-size:10pt;line-height:12pt" wrap="off"></textarea>
</div>
<img id="btnTrash" style="position:absolute;bottom:70px;right:30px;display:none" src="workflowbuilder/images/trash_48.png" />

<div id="buttons" style="position:absolute;bottom:0px;width:100%;height:34px;background-color:#d8e6f7">
	<label id="lblInfo" style="font-weight:bold;color:#463474;position:absolute;bottom:10px;left:10px;display:none;"></label>
	<div style="position:absolute;bottom:4px;left:5px;">
		<a id="btnSource" class="fm-btn" style="width:85px" cmd="XML_EDITOR"><img src="/ASP.Net/FM/Common/Images/Menu/16_edit.png">View code</a>
		<a style="margin-left:4px;width:110px" class="fm-btn" cmd="PROPERTIES">Workflow Properties</a>
		<a id="btnLog" style="margin-left:4px;display:none" class="fm-btn" cmd="LOG">Trace Log</a>
	</div>
	<div style="position:absolute;bottom:4px;right:4px;">
		<a id="btnSave" style="font-weight:bold;margin-left:5px;" class="fm-btn" cmd="saveX"><img src="/ASP.Net/FM/Common/Images/16_saveClose.gif">Save and Close</a>
		<%= AX.FM.Common.UI.Button.Render("X", "margin-left:5px;", false) %>
	</div>
</div>