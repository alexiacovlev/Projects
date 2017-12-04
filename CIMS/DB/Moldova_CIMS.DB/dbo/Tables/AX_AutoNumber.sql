CREATE TABLE [dbo].[AX_AutoNumber] (
    [ID]            BIGINT           NOT NULL,
    [Template]      NVARCHAR (450)   NOT NULL,
    [Name]          NVARCHAR (450)   NOT NULL,
    [CreatedOn]     DATETIME         NOT NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NOT NULL,
    [CreatedIP]     VARCHAR (20)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (20)     NULL,
    [Description]   NTEXT            NULL,
    [CurrentNumber] BIGINT           NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_AX_AutoNumber] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

