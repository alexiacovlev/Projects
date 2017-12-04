CREATE TABLE [dbo].[AX_Incidents_Properties] (
    [id]               UNIQUEIDENTIFIER NOT NULL,
    [Name]             NVARCHAR (50)    NULL,
    [CopyToCC]         INT              NULL,
    [CCopyToEmail]     NVARCHAR (100)   NULL,
    [CCopyTo_FullName] NVARCHAR (100)   NULL,
    [CopyToCC_Update]  INT              NULL,
    [SendToServer]     INT              NULL,
    [ServerURL]        NVARCHAR (150)   NULL,
    [ClientURL]        NVARCHAR (150)   NULL,
    [ModifiedIP]       NVARCHAR (20)    NULL,
    [ModifiedOn]       DATETIME         NULL,
    [ModifiedBy]       UNIQUEIDENTIFIER NULL,
    [CreatedOn]        DATETIME         NULL,
    [CreatedBy]        UNIQUEIDENTIFIER NULL,
    [CreatedIP]        NVARCHAR (20)    NULL,
    [ApplicationId]    UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_AX_Incidents_Properties] PRIMARY KEY CLUSTERED ([id] ASC) WITH (FILLFACTOR = 90)
);

