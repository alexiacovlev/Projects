CREATE TABLE [dbo].[AX_WF_StateInstances] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [ProcessName]   VARCHAR (100)    NOT NULL,
    [TableName]     VARCHAR (50)     NOT NULL,
    [KeyValue]      VARCHAR (100)    NOT NULL,
    [StateName]     VARCHAR (100)    NOT NULL,
    [StateTitle]    NVARCHAR (200)   NULL,
    [KeyName]       VARCHAR (50)     NOT NULL,
    [Variables]     NVARCHAR (200)   NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NOT NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ApplicationId] UNIQUEIDENTIFIER NOT NULL,
    [ErrorMessage]  VARCHAR (200)    NULL,
    [Timeout]       DATETIME         NULL,
    CONSTRAINT [PK_AX_WF_StateInstances] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AX_WF_StateInstances]
    ON [dbo].[AX_WF_StateInstances]([TableName] ASC, [KeyValue] ASC);

