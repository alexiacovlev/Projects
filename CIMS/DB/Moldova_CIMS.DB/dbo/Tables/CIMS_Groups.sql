CREATE TABLE [dbo].[CIMS_Groups] (
    [ID]               UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]        DATETIME         NULL,
    [CreatedBy]        UNIQUEIDENTIFIER NULL,
    [CreatedIP]        VARCHAR (50)     NULL,
    [ModifiedOn]       DATETIME         NULL,
    [ModifiedBy]       UNIQUEIDENTIFIER NULL,
    [ModifiedIP]       VARCHAR (50)     NULL,
    [ApplicationId]    UNIQUEIDENTIFIER NULL,
    [GroupNr]          NVARCHAR (100)   NULL,
    [TeamId]           UNIQUEIDENTIFIER NULL,
    [Specialty]        UNIQUEIDENTIFIER NULL,
    [Admission]        UNIQUEIDENTIFIER NULL,
    [GroupStatus]      INT              NULL,
    [CurrentStudyYear] INT              NULL,
    [CurrentSemester]  UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_Groups] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Groups_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Groups_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Groups_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id])
);











