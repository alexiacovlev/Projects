CREATE TABLE [dbo].[aspnet_Teams] (
    [Id]                UNIQUEIDENTIFIER CONSTRAINT [DF_Table_1_TeamId] DEFAULT (newid()) NOT NULL,
    [DeletionStateCode] INT              NULL,
    [OrganizationId]    UNIQUEIDENTIFIER NULL,
    [BusinessUnitId]    UNIQUEIDENTIFIER NULL,
    [Name]              VARCHAR (100)    NULL,
    [Description]       NVARCHAR (MAX)   NULL,
    [Address]           NVARCHAR (MAX)   NULL,
    [EMailAddress]      NVARCHAR (100)   NULL,
    [CreatedOn]         DATETIME         NULL,
    [CreatedBy]         UNIQUEIDENTIFIER NULL,
    [CreatedIP]         NVARCHAR (20)    NULL,
    [ModifiedOn]        DATETIME         NULL,
    [ModifiedBy]        UNIQUEIDENTIFIER NULL,
    [ModifiedIP]        NVARCHAR (20)    NULL,
    [DomainName]        NVARCHAR (255)   NULL,
    [ApplicationId]     UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_aspnet_Teams] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_aspnet_Teams_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_aspnet_Teams_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId])
);





