CREATE TABLE [dbo].[CIMS_Attachments] (
    [ID]              UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]       DATETIME         NULL,
    [CreatedBy]       UNIQUEIDENTIFIER NULL,
    [CreatedIP]       VARCHAR (50)     NULL,
    [ModifiedOn]      DATETIME         NULL,
    [ModifiedBy]      UNIQUEIDENTIFIER NULL,
    [ModifiedIP]      VARCHAR (50)     NULL,
    [ApplicationId]   UNIQUEIDENTIFIER NULL,
    [ParentId]        UNIQUEIDENTIFIER NULL,
    [File]            IMAGE            NULL,
    [File_FileName]   NVARCHAR (100)   NULL,
    [File_Size]       VARCHAR (20)     NULL,
    [DocumentType]    INT              NULL,
    [DocumentDetails] NVARCHAR (200)   NULL,
    [DocumentNr]      NVARCHAR (100)   NULL,
    [DocumentDate]    DATETIME         NULL,
    CONSTRAINT [PK_CIMS_Attachments] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Attachments_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Attachments_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId])
);



