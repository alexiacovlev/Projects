CREATE TABLE [dbo].[AX_Incidents_Status] (
    [id]          INT            NOT NULL,
    [Status]      NVARCHAR (50)  NULL,
    [Description] NVARCHAR (100) NULL,
    [Color]       NVARCHAR (50)  NULL,
    CONSTRAINT [PK_AX_Incidents_Status] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 90)
);

