CREATE TABLE [dbo].[AX_EventLog] (
    [ID]              UNIQUEIDENTIFIER NOT NULL,
    [EventTime]       DATETIME         NOT NULL,
    [EventCode]       INT              NOT NULL,
    [EventDetailCode] INT              NOT NULL,
    [Message]         NVARCHAR (MAX)   NOT NULL,
    [Details]         NVARCHAR (MAX)   NULL,
    [Text1]           NVARCHAR (1024)  NULL,
    [Text2]           NVARCHAR (1024)  NULL,
    [IP]              NVARCHAR (50)    NULL,
    [CreatedBy]       UNIQUEIDENTIFIER NULL,
    [ApplicationID]   UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_AX_EventLog] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

