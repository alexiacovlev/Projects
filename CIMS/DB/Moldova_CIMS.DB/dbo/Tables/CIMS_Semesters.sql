CREATE TABLE [dbo].[CIMS_Semesters] (
    [ID]             UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]      DATETIME         NULL,
    [CreatedBy]      UNIQUEIDENTIFIER NULL,
    [CreatedIP]      VARCHAR (50)     NULL,
    [ModifiedOn]     DATETIME         NULL,
    [ModifiedBy]     UNIQUEIDENTIFIER NULL,
    [ModifiedIP]     VARCHAR (50)     NULL,
    [ApplicationId]  UNIQUEIDENTIFIER NULL,
    [TeamId]         UNIQUEIDENTIFIER NULL,
    [SemesterNumber] INT              NULL,
    [StudyPlan]      UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_Semesters] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_Semesters_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Semesters_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_Semesters_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_Semesters_CIMS_StudyPlans] FOREIGN KEY ([StudyPlan]) REFERENCES [dbo].[CIMS_StudyPlans] ([ID])
);





