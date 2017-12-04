CREATE TABLE [dbo].[AX_WF_StateHistory] (
    [ID]          UNIQUEIDENTIFIER NOT NULL,
    [InstanceId]  UNIQUEIDENTIFIER NOT NULL,
    [ProcessName] VARCHAR (50)     NOT NULL,
    [TableName]   VARCHAR (50)     NOT NULL,
    [KeyValue]    VARCHAR (100)    NOT NULL,
    [StateName]   VARCHAR (100)    NOT NULL,
    [StateTitle]  NVARCHAR (200)   NULL,
    [InitiatedBy] UNIQUEIDENTIFIER NULL,
    [InitiatedOn] DATETIME         NULL,
    [StartedBy]   UNIQUEIDENTIFIER NULL,
    [StartedOn]   DATETIME         NULL,
    [CompletedBy] UNIQUEIDENTIFIER NULL,
    [CompletedOn] DATETIME         NULL,
    CONSTRAINT [PK_AX_WF_StateHistory] PRIMARY KEY CLUSTERED ([ID] ASC)
);

