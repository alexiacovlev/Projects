<%@ Page Language="C#" %>
<%
	string query= @"


CREATE TABLE [dbo].[AX_WF_StateHistory](
	[ID] [uniqueidentifier] NOT NULL,
	[InstanceId] [uniqueidentifier] NOT NULL,
	[ProcessName] [varchar](50) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[KeyValue] [varchar](100) NOT NULL,
	[StateName] [varchar](100) NOT NULL,
	[StateTitle] [nvarchar](200) NULL,
	[InitiatedBy] [uniqueidentifier] NULL,
	[InitiatedOn] [datetime] NULL,
	[CompletedBy] [uniqueidentifier] NULL,
	[CompletedOn] [datetime] NULL,
 CONSTRAINT [PK_AX_WF_StateHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


";

	if (!AX.Kernel.User.IsSuperAdmin) { Response.Write("<h2>Access Denied.</h2>"); Response.End(); return; }
	Response.Write("<div>" + query.Replace("\n", "<br/>") + "</div>");
	Response.Write("<br/>");
	System.Data.SqlClient.SqlConnection conn= new System.Data.SqlClient.SqlConnection(AX.Kernel.Settings.ConnectionString);
	try {
		conn.Open();
		Response.Write("<p><b>"+ (new System.Data.SqlClient.SqlCommand(query, conn)).ExecuteScalar() +"</b></p>");
		Response.Write("<h3>Done</h3>");		
	} catch (Exception error) {
		Response.Write("<div style='color:red'>"+error.Message+"</div>");
	} finally {
		conn.Close();
	}
%>