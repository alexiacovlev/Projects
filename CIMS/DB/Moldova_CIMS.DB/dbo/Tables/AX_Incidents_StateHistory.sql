CREATE TABLE [dbo].[AX_Incidents_StateHistory] (
    [id]                 UNIQUEIDENTIFIER NOT NULL,
    [IncidentId]         UNIQUEIDENTIFIER NOT NULL,
    [IncidentName]       NVARCHAR (250)   NULL,
    [StateID]            INT              NULL,
    [StateName]          NVARCHAR (50)    NULL,
    [SendNotification]   BIT              NULL,
    [SendTo]             UNIQUEIDENTIFIER NULL,
    [Reason]             NVARCHAR (MAX)   NULL,
    [CreatedOn]          DATETIME         NULL,
    [CreatedBy]          UNIQUEIDENTIFIER NULL,
    [CreatedIP]          NVARCHAR (20)    NULL,
    [ApplicationId]      UNIQUEIDENTIFIER NULL,
    [TeamId]             UNIQUEIDENTIFIER NULL,
    [SendTo_FullName]    NVARCHAR (100)   NULL,
    [SendTo_Email]       NVARCHAR (100)   NULL,
    [CreatedBy_FullName] NVARCHAR (100)   NULL,
    [RequestURL]         NVARCHAR (100)   NULL,
    CONSTRAINT [PK_AX_Incidents_StateHistory] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_AX_Incidents_StateHistory_AX_Incidents] FOREIGN KEY ([IncidentId]) REFERENCES [dbo].[AX_Incidents] ([id]) ON DELETE CASCADE
);

