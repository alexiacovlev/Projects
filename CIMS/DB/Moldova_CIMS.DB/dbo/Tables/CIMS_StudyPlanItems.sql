CREATE TABLE [dbo].[CIMS_StudyPlanItems] (
    [ID]                    UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]             DATETIME         NULL,
    [CreatedBy]             UNIQUEIDENTIFIER NULL,
    [CreatedIP]             VARCHAR (50)     NULL,
    [ModifiedOn]            DATETIME         NULL,
    [ModifiedBy]            UNIQUEIDENTIFIER NULL,
    [ModifiedIP]            VARCHAR (50)     NULL,
    [ApplicationId]         UNIQUEIDENTIFIER NULL,
    [StudyPlan]             UNIQUEIDENTIFIER NULL,
    [Semester]              UNIQUEIDENTIFIER NULL,
    [Subject]               INT              NULL,
    [SubjectMandatory]      INT              NULL,
    [TypeOfEvaluation]      INT              NULL,
    [TotalHoursPerWeek]     FLOAT (53)       NULL,
    [TotalHoursPerSemester] FLOAT (53)       NULL,
    [TotalHoursTheory]      FLOAT (53)       NULL,
    [TotalHoursSeminars]    FLOAT (53)       NULL,
    [TotalHoursLaboratory]  FLOAT (53)       NULL,
    [TotalHoursPractical]   FLOAT (53)       NULL,
    [TotalHoursIndividual]  FLOAT (53)       NULL,
    [NumberOfCredit]        FLOAT (53)       NULL,
    [TeamId]                UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_CIMS_StudyPlanItems] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CIMS_StudyPlanItems_aspnet_Membership] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_StudyPlanItems_aspnet_Membership1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[aspnet_Membership] ([UserId]),
    CONSTRAINT [FK_CIMS_StudyPlanItems_aspnet_Teams] FOREIGN KEY ([TeamId]) REFERENCES [dbo].[aspnet_Teams] ([Id]),
    CONSTRAINT [FK_CIMS_StudyPlanItems_CIMS_d_SubjectsToStudy] FOREIGN KEY ([Subject]) REFERENCES [dbo].[CIMS_d_SubjectsToStudy] ([ID]),
    CONSTRAINT [FK_CIMS_StudyPlanItems_CIMS_d_TypeOfEvaluation] FOREIGN KEY ([TypeOfEvaluation]) REFERENCES [dbo].[CIMS_d_TypeOfEvaluation] ([ID]),
    CONSTRAINT [FK_CIMS_StudyPlanItems_CIMS_Semesters] FOREIGN KEY ([Semester]) REFERENCES [dbo].[CIMS_Semesters] ([ID]),
    CONSTRAINT [FK_CIMS_StudyPlanItems_CIMS_StudyPlans] FOREIGN KEY ([StudyPlan]) REFERENCES [dbo].[CIMS_StudyPlans] ([ID])
);





