<%@ Page Language="C#" %>
<%
	string query= @"


CREATE TABLE [dbo].[AX_PersonalTasks](
	[ID] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Type] [smallint] NOT NULL,
	[Title] [nvarchar](400) NOT NULL,
	[Status] [int] NOT NULL,
	[Handler] [varchar](50) NULL,
	[Parameters] [varchar](200) NULL,
	[Window] [varchar](20) NULL,
	[MessageText] [nvarchar](1000) NULL,
	[RegardingId] [uniqueidentifier] NULL,
	[RegardingType] [int] NULL,
	[RegardingText] [nvarchar](300) NULL,
	[ActualStart] [datetime] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[OpenedOn] [datetime] NULL,
	[CompletedOn] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedIP] [nvarchar](50) NULL,
 CONSTRAINT [PK_AX_PersonalTasks] PRIMARY KEY CLUSTERED 
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