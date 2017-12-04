CREATE TABLE [dbo].[AX_Incidents_Resolution] (
    [id]            INT              NOT NULL,
    [Resolution]    NVARCHAR (50)    NULL,
    [Description]   NVARCHAR (150)   NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_AX_Incidents_Resolution] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 90)
);

