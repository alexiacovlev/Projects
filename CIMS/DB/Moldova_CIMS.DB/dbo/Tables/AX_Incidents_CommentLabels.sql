CREATE TABLE [dbo].[AX_Incidents_CommentLabels] (
    [ID]           UNIQUEIDENTIFIER NOT NULL,
    [IncidentId]   UNIQUEIDENTIFIER NOT NULL,
    [Text]         NVARCHAR (1024)  NULL,
    [TextPosition] VARCHAR (50)     NULL,
    [Data]         VARCHAR (4096)   NOT NULL,
    [CreatedOn]    DATETIME         NOT NULL,
    [CreatedBy]    UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_AX_Incidents_CommentLabels] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_AX_Incidents_CommentLabels_AX_Incidents] FOREIGN KEY ([IncidentId]) REFERENCES [dbo].[AX_Incidents] ([id]) ON DELETE CASCADE
);

