CREATE TABLE [dbo].[CIMS_StudyPlans] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     UNIQUEIDENTIFIER NULL,
    [CreatedIP]     VARCHAR (50)     NULL,
    [ModifiedOn]    DATETIME         NULL,
    [ModifiedBy]    UNIQUEIDENTIFIER NULL,
    [ModifiedIP]    VARCHAR (50)     NULL,
    [ApplicationId] UNIQUEIDENTIFIER NULL,
    [TeamId]        UNIQUEIDENTIFIER NULL,
    [StudyYear]     INT              NULL,
    [Section]       UNIQUEIDENTIFIER NULL,
    [Specialty]     UNIQUEIDENTIFIER NULL,
    [ApprovedBy]    NVARCHAR (100)   NULL,
    [ApprovedOn]    DATETIME         NULL,
    [Approved]      BIT              NULL,
    CONSTRAINT [PK_CIMS_StudyPlans] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_StudyPlans_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_StudyPlans_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_StudyPlans_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_StudyPlans_CIMS_d_StudyYears] FOREIGN KEY ([StudyYear]) REFERENCES [dbo].[CIMS_d_StudyYears] ([ID]),
    CONSTRAINT [FK_CIMS_StudyPlans_CIMS_Sections] FOREIGN KEY ([Section]) REFERENCES [dbo].[CIMS_Sections] ([ID]),
    CONSTRAINT [FK_CIMS_StudyPlans_CIMS_SpecialtyProfile] FOREIGN KEY ([Specialty]) REFERENCES [dbo].[CIMS_SpecialtyProfile] ([ID])
);





